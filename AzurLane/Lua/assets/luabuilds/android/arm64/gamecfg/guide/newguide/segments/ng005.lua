return {
	id = "NG005",
	events = {
		{
			ui = {
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
			ui = {
				dynamicPath = function()
					USE_OLD_MAIN_LIVE_AREA_UI = var_1_10000

					if var_1_10000 then
						return "/OverlayCamera/Overlay/UIMain/MainLiveAreaOldUI(Clone)/commander_btn"
					else
						return "/OverlayCamera/Overlay/UIMain/MainLiveAreaUI(Clone)/commander_btn"
					end

					return
				end
			}
		}
	}
}
