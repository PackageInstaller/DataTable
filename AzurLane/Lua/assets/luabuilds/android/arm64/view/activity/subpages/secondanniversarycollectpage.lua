local var_0_0 = class("SecondAnniversaryCollectPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.btnContainer = arg_1_0._tf:Find("BtnList")
	arg_1_0.btn1 = arg_1_0.btnContainer:Find("1")
	arg_1_0.btn2 = arg_1_0.btnContainer:Find("2")
	arg_1_0.btn3 = arg_1_0.btnContainer:Find("3")
	arg_1_0.btn4 = arg_1_0.btnContainer:Find("4")
	arg_1_0.btn5 = arg_1_0.btnContainer:Find("5")
	arg_1_0.btn6 = arg_1_0.btnContainer:Find("6")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.btn1, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btn2, function()
		arg_2_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ACTIVITY_TYPE_RETURN_AWARD_ID2)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btn3, function()
		arg_2_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.YIDALI_MAIN_ID)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btn4, function()
		arg_2_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ANNIVERSARY_LOGIN_ID)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btn5, function()
		arg_2_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.CARDPAIR_ZQ)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.btn6, function()
		arg_2_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.DACHAOLIFU_SKIN)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
