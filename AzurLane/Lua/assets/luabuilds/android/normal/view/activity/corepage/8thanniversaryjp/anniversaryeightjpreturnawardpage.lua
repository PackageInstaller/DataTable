class = var_0_10000

local var_0_0 = "AnniversaryEightJpReturnAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

var_0_1.INVITER = 1
var_0_1.RETURNER = 2

function var_0_1.OnFirstFlush(arg_1_0)
	local var_1_0 = {}

	CoreInviterPage = var_1_10002
	var_1_0[1] = var_1_10002
	CoreReturnerPage = var_1_10002
	var_1_0[2] = var_1_10002

	local var_1_1 = arg_1_0.activity

	assert = var_1_10003

	var_1_10003(var_1_0[var_1_1.data1], var_1_1.data1)

	arg_1_0.page = var_1_0[var_1_1.data1].New(arg_1_0._tf, arg_1_0.event)
	onButton = var_3

	var_3(arg_1_0, arg_1_0.page.help, function()
		pg = var_2_10000

		local var_2_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_2_1 = var_0.ShowMsgBox
		local var_2_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_2_2.type = var_2_10003
		pg = var_2_10003
		var_2_2.helps = var_2_10003.gametip.returner_help.tip

		var_2_1(var_2_0, var_2_2)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	local var_3_0 = arg_3_0.activity

	assert = var_1_10002

	var_1_10002(arg_3_0.page)

	local var_3_1 = arg_3_0.page

	var_2.Update(var_3_1, var_3_0)

	return
end

function var_0_1.OnDestroy(arg_4_0)
	assert = var_1_10001

	var_1_10001(arg_4_0.page)

	local var_4_0 = arg_4_0.page

	var_1.Dispose(var_4_0)

	return
end

function var_0_1.UseSecondPage(arg_5_0, arg_5_1)
	return arg_5_1.data1 > 1
end

return var_0_1
