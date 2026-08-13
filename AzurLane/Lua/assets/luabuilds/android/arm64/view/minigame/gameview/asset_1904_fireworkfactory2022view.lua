class = var_0_10000

local var_0_0 = "FireworkFactory2022View"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".FireworkFactoryView"))

function var_0_1.getUIName(arg_1_0)
	return "FireworkFactory2022UI"
end

function var_0_1.didEnter(arg_2_0)
	var_0_1.super.didEnter(arg_2_0)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.btn_help, function()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_3_2.type = var_2_10004
		pg = var_2_10004
		var_3_2.helps = var_2_10004.gametip.help_xinnian2022_firework.tip

		var_3_1(var_3_0, var_3_2)

		return
	end)

	return
end

return var_0_1
