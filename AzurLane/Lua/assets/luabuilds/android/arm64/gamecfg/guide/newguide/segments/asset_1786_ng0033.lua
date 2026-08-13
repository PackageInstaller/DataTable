return {
	id = "NG0033",
	events = {
		{
			alpha = 0.4,
			code = {
				1
			},
			ui = {
				dynamicPath = function()
					getProxy = var_1_10000
					SettingsProxy = var_1_10002

					local var_1_0 = var_1_10000(var_1_10002)

					if var_0.IsMellowStyle(var_1_0) then
						return "OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/right/activity/MainCoreActivityBtn"
					else
						return "OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/linkBtns/MainCoreActivityBtn"
					end

					return
				end,
				triggerType = {
					1
				},
				fingerPos = {
					posY = -28.54,
					posX = 66.81
				}
			},
			style = {
				text = "让我们来看看炼金工坊中其他工具配方所需素材",
				mode = 1,
				dir = 1,
				posY = 0,
				posX = 0
			}
		}
	}
}
