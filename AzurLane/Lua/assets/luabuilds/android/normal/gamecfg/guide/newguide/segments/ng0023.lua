local var_0_0 = {
	"进入科研界面",
	"现在解锁了META研究室功能",
	"通过与信标作战可以获取其同步值,累计同步值获取丰厚奖励",
	"奖励领取存在时间限制，过期后将消失，请指挥官注意时间"
}

return {
	id = "NG0023",
	events = {
		{
			alpha = 0.4,
			style = {
				mode = 2,
				dir = 1,
				posY = -308.7,
				posX = 199.3,
				text = var_0_0[1]
			},
			ui = {
				dynamicPath = function()
					getProxy = var_1_10000
					SettingsProxy = var_1_10001

					local var_1_0 = var_1_10000(var_1_10001)

					if var_0.IsMellowStyle(var_1_0) then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/bottom/frame/tech"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/bottom/technologyButton"
					end

					return
				end,
				triggerType = {
					1
				},
				fingerPos = {
					rotateY = 0,
					posY = -32.1,
					rotateX = 0,
					rotateZ = 0,
					posX = 98.8
				}
			}
		},
		{
			alpha = 0.4,
			style = {
				mode = 1,
				dir = 1,
				posY = 0,
				posX = 286.9,
				text = var_0_0[2]
			},
			ui = {
				path = "OverlayCamera/Overlay/UIMain/SelectTechnologyUI(Clone)/frame/bg/meta_btn",
				triggerType = {
					1
				},
				fingerPos = {
					rotateY = 0,
					posY = -50.43,
					rotateX = 0,
					rotateZ = 0,
					posX = 93.07
				}
			}
		},
		{
			alpha = 0.4,
			waitScene = "MetaCharacterScene",
			style = {
				mode = 1,
				dir = 1,
				posY = -236.99,
				posX = -419.8,
				text = var_0_0[3]
			}
		},
		{
			alpha = 0.4,
			style = {
				mode = 2,
				dir = 1,
				posY = -236.99,
				posX = -419.8,
				text = var_0_0[4],
				ui = {
					path = "UICamera/Canvas/UIMain/MetaCharacterUI(Clone)/HidePanel/ActTimeTip"
				}
			}
		}
	}
}
