local var_0_0 = {
	"使用任务奖励<color=#ff7d36>建造新角色</color>吧",
	"建造材料准备充足！ 点击<color=#ffde38>开始建造</color>",
	"点击<color=#ff7d36>确定</color>开始建造"
}

return {
	id = "S020_1",
	events = {
		{
			alpha = 0.375,
			style = {
				mode = 2,
				dir = 1,
				posY = 0,
				posX = 0,
				text = var_0_0[1]
			},
			ui = {
				pathIndex = -1,
				dynamicPath = function()
					getProxy = var_1_10000
					SettingsProxy = var_1_10002

					local var_1_0 = var_1_10000(var_1_10002)

					if var_0.IsMellowStyle(var_1_0) then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/bottom/frame/build"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/bottom/buildButton"
					end

					return
				end,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -21.99,
					posX = 39.82
				}
			}
		},
		{
			alpha = 0.408,
			style = {
				mode = 1,
				dir = 1,
				posY = 0,
				posX = 205.91,
				text = var_0_0[2]
			},
			ui = {
				pathIndex = -1,
				path = "/UICamera/Canvas/UIMain/BuildShipUI(Clone)/BuildShipPoolsPageUI(Clone)/gallery/start_btn",
				triggerType = {
					1
				},
				fingerPos = {
					posY = -25.43,
					posX = 76.4
				}
			}
		},
		{
			alpha = 0.318,
			style = {
				mode = 2,
				dir = 1,
				posY = 0,
				posX = 0,
				text = var_0_0[3]
			},
			ui = {
				pathIndex = -1,
				path = "/OverlayCamera/Overlay/UIMain/BuildShipMsgBoxUI(Clone)/window/btns/confirm_btn",
				triggerType = {
					1
				},
				fingerPos = {
					posY = -19.57,
					posX = 61.16
				}
			}
		}
	}
}
