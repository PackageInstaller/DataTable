local var_0_0 = class("SecondAnniversaryPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.btnShop = arg_1_0._tf:Find("BtnShop")
	arg_1_0.btnContainer = arg_1_0._tf:Find("BtnList/Viewport/Content")
	arg_1_0.btn1 = arg_1_0.btnContainer:Find("1")
	arg_1_0.btn2 = arg_1_0.btnContainer:Find("2")
	arg_1_0.btn3 = arg_1_0.btnContainer:Find("3")
	arg_1_0.btn4 = arg_1_0.btnContainer:Find("4")
	arg_1_0.btn5 = arg_1_0.btnContainer:Find("5")
	arg_1_0.btn6 = arg_1_0.btnContainer:Find("6")
	arg_1_0.btn7 = arg_1_0.btnContainer:Find("7")
	arg_1_0.btn8 = arg_1_0.btnContainer:Find("8")
	arg_1_0.btn9 = arg_1_0.btnContainer:Find("9")
	arg_1_0.btnList1 = {
		arg_1_0.btn1,
		arg_1_0.btn2,
		arg_1_0.btn3,
		arg_1_0.btn4,
		arg_1_0.btn5,
		arg_1_0.btn6,
		arg_1_0.btn7,
		arg_1_0.btn8,
		arg_1_0.btn9
	}
	arg_1_0.btn11 = arg_1_0.btnContainer:Find("11")
	arg_1_0.btn12 = arg_1_0.btnContainer:Find("12")
	arg_1_0.btn13 = arg_1_0.btnContainer:Find("13")
	arg_1_0.btn14 = arg_1_0.btnContainer:Find("14")
	arg_1_0.btn15 = arg_1_0.btnContainer:Find("15")
	arg_1_0.btn16 = arg_1_0.btnContainer:Find("16")
	arg_1_0.btn17 = arg_1_0.btnContainer:Find("17")
	arg_1_0.btn18 = arg_1_0.btnContainer:Find("18")
	arg_1_0.btn19 = arg_1_0.btnContainer:Find("19")
	arg_1_0.btnList2 = {
		arg_1_0.btn11,
		arg_1_0.btn12,
		arg_1_0.btn13,
		arg_1_0.btn14,
		arg_1_0.btn15,
		arg_1_0.btn16,
		arg_1_0.btn17,
		arg_1_0.btn18,
		arg_1_0.btn19
	}

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.btnShop, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	arg_2_0:initBtn(arg_2_0.btnList1)
	arg_2_0:initBtn(arg_2_0.btnList2)

	return
end

function var_0_0.initBtn(arg_4_0, arg_4_1)
	onButton(arg_4_0, arg_4_1[1], function()
		arg_4_0:emit(ActivityMediator.GO_PRAY_POOL)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_1[2], function()
		arg_4_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SUMMARY)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_1[3], function()
		arg_4_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ACTIVITY_TYPE_RETURN_AWARD_ID)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_1[4], function()
		arg_4_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.XIMU_LOGIN_ID)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_1[5], function()
		arg_4_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = ChargeScene.TYPE_DIAMOND
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_1[6], function()
		arg_4_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			projectName = "light"
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_1[7], function()
		arg_4_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.SANDIEGO_PT_ID)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_1[8], function()
		arg_4_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.SKIN_U73)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_1[9], function()
		pg.TipsMgr.GetInstance():ShowTips("即将开放，敬请期待！")

		return
	end, SFX_PANEL)

	return
end

return var_0_0
