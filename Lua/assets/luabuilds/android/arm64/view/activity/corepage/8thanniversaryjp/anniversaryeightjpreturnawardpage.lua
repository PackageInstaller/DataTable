local var_0_0 = class("AnniversaryEightJpReturnAwardPage", import("view.activity.CorePage.CoreActivityPage"))

var_0_0.INVITER = 1
var_0_0.RETURNER = 2

function var_0_0.OnFirstFlush(arg_1_0)
	assert(({
		CoreInviterPage,
		CoreReturnerPage
	})[arg_1_0.activity.data1], arg_1_0.activity.data1)

	arg_1_0.page = ({
		CoreInviterPage,
		CoreReturnerPage
	})[arg_1_0.activity.data1].New(arg_1_0._tf, arg_1_0.event)

	onButton(arg_1_0, arg_1_0.page.help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.returner_help.tip
		})

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	assert(arg_3_0.page)
	arg_3_0.page:Update(arg_3_0.activity)

	return
end

function var_0_0.OnDestroy(arg_4_0)
	assert(arg_4_0.page)
	arg_4_0.page:Dispose()

	return
end

function var_0_0.UseSecondPage(arg_5_0, arg_5_1)
	return arg_5_1.data1 > 1
end

return var_0_0
