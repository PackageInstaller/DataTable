class = var_0_10000

local var_0_0 = "HMSHunterPTPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_0, "help")
	onButton = var_1

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.helpBtn

	local function var_1_3()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_2_2.type = var_2_10003
		i18n = var_2_10003
		var_2_2.helps = var_2_10003("hunter_npc")

		var_2_1(var_2_0, var_2_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_1, var_1_2, var_1_3, var_1_10005)

	return
end

return var_0_1
