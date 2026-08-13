return {
	id = "DORM3D_GUIDE_01",
	events = {
		{
			alpha = 0,
			stories = {
				"SUSHEHUANXINJIHUA1"
			}
		},
		{
			alpha = 0.4,
			style = {
				text = "点击生活区",
				mode = 4,
				char = "char",
				posY = -383,
				dir = 1,
				posX = -72,
				uiset = {}
			},
			ui = {
				pathIndex = -1,
				dynamicPath = function()
					getProxy = var_1_10000
					SettingsProxy = var_1_10002

					local var_1_0 = var_1_10000(var_1_10002)

					if var_0.IsMellowStyle(var_1_0) then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/bottom/frame/live"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/bottom/liveButton"
					end

					return
				end
			}
		},
		{
			alpha = 0.4,
			style = {
				text = "点击宿舍计划",
				mode = 4,
				char = "char",
				posY = -326,
				dir = 1,
				posX = 338,
				uiset = {}
			},
			ui = {
				pathIndex = -1,
				path = "OverlayCamera/Overlay/UIMain/MainLiveAreaUI(Clone)/dorm_btn"
			}
		},
		{
			delay = 1.5,
			alpha = 0.4,
			style = {
				text = "点击宿舍",
				mode = 4,
				char = "char",
				posY = -136,
				dir = 1,
				posX = 238,
				uiset = {}
			},
			ui = {
				pathIndex = -1,
				path = "UICamera/Canvas/UIMain/SelectDorm3DUI(Clone)/Map/floor_1/Tianlangxing"
			}
		},
		{
			delay = 0.5,
			alpha = 0.4,
			style = {
				text = "下载所需资源后即可进入对应角色宿舍",
				mode = 4,
				char = "char",
				posY = -135,
				dir = 1,
				posX = 0,
				uiset = {
					{
						pathIndex = -1,
						lineMode = 1,
						path = "UICamera/Canvas/UIMain/SelectDorm3DUI(Clone)/Map/tip/window"
					}
				}
			}
		}
	}
}
