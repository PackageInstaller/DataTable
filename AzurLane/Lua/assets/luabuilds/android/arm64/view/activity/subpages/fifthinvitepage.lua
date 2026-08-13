class = var_0_10000

local var_0_0 = "FifthInvitePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".FourthInvitePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.helpBtn

	local function var_1_2()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_2_2.type = var_2_10004
		pg = var_2_10004
		var_2_2.helps = var_2_10004.gametip.five_qingdian.tip

		var_2_1(var_2_0, var_2_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

return var_0_1
