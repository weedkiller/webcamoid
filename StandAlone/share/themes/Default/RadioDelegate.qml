/* Webcamoid, webcam capture application.
 * Copyright (C) 2019  Gonzalo Exequiel Pedone
 *
 * Webcamoid is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Webcamoid is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
 *
 * Web-Site: http://webcamoid.github.io/
 */

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Templates 2.5 as T
import Ak 1.0
import "Private"

T.RadioDelegate {
    id: control
    icon.width: AkUnit.create(18 * ThemeSettings.controlScale, "dp").pixels
    icon.height: AkUnit.create(18 * ThemeSettings.controlScale, "dp").pixels
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + implicitIndicatorWidth
                            + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    padding: AkUnit.create(4 * ThemeSettings.controlScale, "dp").pixels
    spacing: AkUnit.create(8 * ThemeSettings.controlScale, "dp").pixels
    hoverEnabled: true
    clip: true

    readonly property int animationTime: 200

    indicator: Item {
        id: radioDelegateIndicator
        anchors.right: control.right
        anchors.rightMargin: control.rightPadding
        anchors.verticalCenter: control.verticalCenter
        implicitWidth:
            AkUnit.create(24 * ThemeSettings.controlScale, "dp").pixels
        implicitHeight:
            AkUnit.create(24 * ThemeSettings.controlScale, "dp").pixels

        Rectangle {
            id: indicatorRect
            border.width: AkUnit.create(2 * ThemeSettings.controlScale, "dp").pixels
            border.color:
                control.highlighted?
                    ThemeSettings.colorActiveHighlightedText:
                    ThemeSettings.colorActiveWindowText
            color: "transparent"
            radius: Math.min(radioDelegateIndicator.width, radioDelegateIndicator.height) / 2
            anchors.verticalCenter: radioDelegateIndicator.verticalCenter
            anchors.horizontalCenter: radioDelegateIndicator.horizontalCenter
            width: Math.min(radioDelegateIndicator.width, radioDelegateIndicator.height)
            height: width

            Rectangle {
                id: indicatorCheckedMark
                color:
                    control.highlighted?
                        ThemeSettings.colorActiveHighlightedText:
                        ThemeSettings.colorActiveWindowText
                width: AkUnit.create(15 * ThemeSettings.controlScale, "dp").pixels
                height: AkUnit.create(15 * ThemeSettings.controlScale, "dp").pixels
                radius: Math.min(width, height) / 2
                anchors.verticalCenter: indicatorRect.verticalCenter
                anchors.horizontalCenter: indicatorRect.horizontalCenter
                visible: control.checked
            }
        }
    }

    contentItem: IconLabel {
        id: iconLabel
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        iconName: control.icon.name
        iconSource: control.icon.source
        iconWidth: control.icon.width
        iconHeight: control.icon.height
        text: control.text
        font: control.font
        color: control.highlighted?
                   ThemeSettings.colorActiveHighlightedText:
                   ThemeSettings.colorActiveWindowText
        alignment: Qt.AlignLeft | Qt.AlignVCenter
        anchors.leftMargin: control.leftPadding
        anchors.left: control.left
        anchors.right: radioDelegateIndicator.left
    }

    background: Rectangle {
        id: background
        implicitWidth:
            AkUnit.create(128 * ThemeSettings.controlScale, "dp").pixels
        implicitHeight:
            AkUnit.create(48 * ThemeSettings.controlScale, "dp").pixels
        color: control.highlighted?
                   ThemeSettings.colorActiveHighlight:
                   ThemeSettings.shade(ThemeSettings.colorActiveWindow, 0, 0)
    }

    states: [
        State {
            name: "Disabled"
            when: !control.enabled

            PropertyChanges {
                target: indicatorRect
                border.color:
                    control.highlighted?
                        ThemeSettings.colorDisabledHighlightedText:
                        ThemeSettings.colorDisabledWindowText
            }
            PropertyChanges {
                target: indicatorCheckedMark
                color:
                    control.highlighted?
                        ThemeSettings.colorDisabledHighlightedText:
                        ThemeSettings.colorDisabledWindowText
            }
            PropertyChanges {
                target: iconLabel
                color:
                    control.highlighted?
                        ThemeSettings.colorDisabledHighlightedText:
                        ThemeSettings.colorDisabledWindowText
            }
            PropertyChanges {
                target: background
                color: control.highlighted?
                           ThemeSettings.colorDisabledHighlight:
                           ThemeSettings.shade(ThemeSettings.colorDisabledWindow, 0, 0)
            }
        },
        State {
            name: "Hovered"
            when: (control.hovered
                   || control.visualFocus
                   || control.activeFocus)
                  && !control.pressed

            PropertyChanges {
                target: background
                color:
                    control.highlighted?
                        ThemeSettings.constShade(ThemeSettings.colorActiveHighlight,
                                                 0.1):
                        ThemeSettings.shade(ThemeSettings.colorActiveWindow, -0.1)
            }
        },
        State {
            name: "Pressed"
            when: control.pressed

            PropertyChanges {
                target: background
                color:
                    control.highlighted?
                        ThemeSettings.constShade(ThemeSettings.colorActiveHighlight,
                                                 0.2):
                        ThemeSettings.shade(ThemeSettings.colorActiveWindow, -0.2)
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            target: indicatorRect
            properties: "border.color"
            duration: control.animationTime
        }
        ColorAnimation {
            target: indicatorCheckedMark
            duration: control.animationTime
        }
        ColorAnimation {
            target: iconLabel
            duration: control.animationTime
        }
        ColorAnimation {
            target: background
            duration: control.animationTime
        }
    }
}
