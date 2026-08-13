class = var_0_10000

local var_0_0 = "SanDiegoPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.battleBtn

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_2_1(var_2_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_0, var_1_1, var_1_2, var_1_10005)

	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.bg
	local var_1_5 = var_3.Find(var_1_4, "help_btn")

	local function var_1_6()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_3_2.type = var_2_10003
		i18n = var_2_10003
		var_3_2.helps = var_2_10003("littleSanDiego_npc")

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_3, var_1_5, var_1_6, var_5)

	return
end

return var_0_1
