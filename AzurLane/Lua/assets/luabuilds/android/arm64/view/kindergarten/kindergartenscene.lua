local var_0_0 = class("KindergartenScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "KindergartenUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.mainAnim = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.topUI = arg_2_0._tf:Find("ui/top")

	local var_2_0 = arg_2_0.topUI:Find("title/title_kinder")

	var_2_0:GetComponent(typeof(Image)):SetNativeSize()

	var_2_0:Find("FX/textmask").localScale = {
		x = var_2_0.rect.width,
		y = var_2_0.rect.height
	}
	arg_2_0.bottomUI = arg_2_0._tf:Find("ui/bottom")
	arg_2_0.paradiseBtn = arg_2_0.bottomUI:Find("paradise")
	arg_2_0.paradiseValue = arg_2_0.paradiseBtn:Find("value/Text")
	arg_2_0.adventureBtn = arg_2_0.bottomUI:Find("adventure")
	arg_2_0.rightUI = arg_2_0._tf:Find("ui/right")
	arg_2_0.ptBtn = arg_2_0.rightUI:Find("pt")
	arg_2_0.ptValue = arg_2_0.ptBtn:Find("value/Text")
	arg_2_0.ptTip = arg_2_0.ptBtn:Find("tip")
	arg_2_0.rankBtn = arg_2_0.rightUI:Find("rank")
	arg_2_0.taskBtn = arg_2_0.rightUI:Find("task")
	arg_2_0.taskTip = arg_2_0.taskBtn:Find("tip")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.topUI:Find("back"), function()
		arg_3_0:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.topUI:Find("home"), function()
		arg_3_0:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.topUI:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip["202406_main_help"].tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.paradiseBtn, function()
		arg_3_0:emit(KindergartenMediator.GO_SUBLAYER, Context.New({
			mediator = TongXinSpringMediator,
			viewComponent = TongXinSpringLayer
		}))

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.adventureBtn, function()
		arg_3_0:emit(KindergartenMediator.GO_SCENE, SCENE.BOSSRUSH_MAIN)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.ptBtn, function()
		arg_3_0:emit(KindergartenMediator.GO_SUBLAYER, Context.New({
			mediator = ChildishnessSchoolPtMediator,
			viewComponent = ChildishnessSchoolPtPage
		}))

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.rankBtn, function()
		arg_3_0:emit(KindergartenMediator.ON_EXTRA_RANK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.taskBtn, function()
		arg_3_0:emit(KindergartenMediator.GO_SUBLAYER, Context.New({
			mediator = ChildishnessSchoolTaskMediator,
			viewComponent = ChildishnessSchoolTaskPage
		}))

		return
	end, SFX_PANEL)
	arg_3_0.mainAnim:Play(arg_3_0.contextData.isBack and "anim_kinder_main_show" or "anim_kinder_main_in")
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_12_0)
	arg_12_0:UpdatePt()
	arg_12_0:UpdateTask()

	return
end

function var_0_0.UpdatePt(arg_13_0)
	local var_13_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_PT_ACT_ID)

	if var_13_0 and not var_13_0:isEnd() then
		setActive(arg_13_0.ptBtn, true)
		setActive(arg_13_0.ptTip, var_0_0.ShowPtTip(var_13_0))
		setText(arg_13_0.ptValue, var_13_0.data1)
	else
		setActive(arg_13_0.ptBtn, false)
	end

	return
end

function var_0_0.UpdateTask(arg_14_0)
	local var_14_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_TASK_ACT_ID)

	if var_14_0 and not var_14_0:isEnd() then
		setActive(arg_14_0.taskBtn, true)
		setActive(arg_14_0.taskTip, var_0_0.ShowTaskTip(var_14_0))
	else
		setActive(arg_14_0.taskBtn, false)
	end

	return
end

function var_0_0.UpdateParadise(arg_15_0)
	local var_15_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)

	if var_15_0 and not var_15_0:isEnd() then
		setActive(arg_15_0.paradiseBtn, true)
		setText(arg_15_0.paradiseValue, string.format("(%d/%d)", #var_15_0:GetAvaliableShipIds(), (var_15_0:GetTotalSlotCount())))
	else
		setActive(arg_15_0.paradiseBtn, false)
	end

	return
end

function var_0_0.onBackPressed(arg_16_0)
	arg_16_0:quickExitFunc()

	return
end

function var_0_0.ShowPtTip(arg_17_0)
	local var_17_0 = arg_17_0 or getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_PT_ACT_ID)

	return Activity.IsActivityReady(var_17_0)
end

function var_0_0.ShowTaskTip(arg_18_0)
	local var_18_0 = arg_18_0 or getProxy(ActivityProxy):getActivityById(ActivityConst.ALVIT_TASK_ACT_ID)

	return Activity.IsActivityReady(var_18_0)
end

function var_0_0.IsShowMainTip()
	return var_0_0.ShowPtTip() or var_0_0.ShowTaskTip()
end

return var_0_0
