return {
	id = "ISLAND_GUIDE_13",
	events = {
		{
			is3dDorm = false,
			alpha = 0,
			style = {
				text = "点击切换每日计划",
				mode = 2,
				char = 1,
				posY = 0,
				dir = -1,
				posX = 0,
				uiset = {}
			},
			ui = {
				pathIndex = -1,
				path = "/OverlayCamera/Overlay/UIMain/Island3dTaskUI(Clone)/adapt/toggles/content/3",
				triggerType = {
					2,
					true
				}
			}
		},
		{
			is3dDorm = false,
			alpha = 0,
			style = {
				text = "完成每日计划可获得宝贵的岛屿经验",
				mode = 2,
				char = 1,
				posY = 100,
				dir = 1,
				posX = -350,
				uiset = {}
			}
		},
		{
			is3dDorm = false,
			alpha = 0,
			style = {
				text = "点击返回",
				mode = 2,
				char = 1,
				posY = 100,
				dir = 1,
				posX = -350,
				uiset = {}
			},
			ui = {
				pathIndex = -1,
				path = "/OverlayCamera/Overlay/UIMain/Island3dTaskUI(Clone)/top/back"
			}
		},
		{
			alpha = 0,
			doFunc = function()
				pg = var_1_10000

				local var_1_0 = var_1_10000.MsgboxMgr.GetInstance()
				local var_1_1 = var_0.ShowMsgBox
				local var_1_2 = {}

				MSGBOX_TYPE_HELP = var_1_10004
				var_1_2.type = var_1_10004
				pg = var_1_10004
				var_1_2.helps = var_1_10004.gametip.island_help_greet.tip

				var_1_1(var_1_0, var_1_2)

				return
			end
		}
	}
}
