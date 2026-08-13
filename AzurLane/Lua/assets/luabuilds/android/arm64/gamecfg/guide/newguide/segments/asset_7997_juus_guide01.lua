return {
	id = " ",
	events = {
		{
			alpha = 0,
			stories = {
				"JIUXINHUORECESHIZHONG1"
			}
		},
		{
			alpha = 0.4,
			ui = {
				pathIndex = -1,
				dynamicPath = function()
					getProxy = var_1_10000
					SettingsProxy = var_1_10002

					local var_1_0 = var_1_10000(var_1_10002)

					if var_0.IsMellowStyle(var_1_0) then
						return "/OverlayCamera/Overlay/UIMain/NewMainMellowTheme(Clone)/frame/left/MainUIInsBtn4Mellow(Clone)"
					else
						return "/OverlayCamera/Overlay/UIMain/NewMainClassicTheme(Clone)/frame/linkBtns/MainUIInsBtn(Clone)"
					end

					return
				end
			}
		}
	}
}
