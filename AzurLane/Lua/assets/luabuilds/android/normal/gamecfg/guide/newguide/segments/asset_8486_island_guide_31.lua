return {
	id = "ISLAND_GUIDE_31",
	events = {
		{
			alpha = 0,
			doFunc = function()
				pg = var_1_10000

				local var_1_0 = var_1_10000.MsgboxMgr.GetInstance()
				local var_1_1 = var_0.ShowMsgBox
				local var_1_2 = {}

				MSGBOX_TYPE_HELP = var_1_10003
				var_1_2.type = var_1_10003
				pg = var_1_10003
				var_1_2.helps = var_1_10003.gametip.island_help_combo.tip

				var_1_1(var_1_0, var_1_2)

				return
			end
		}
	}
}
