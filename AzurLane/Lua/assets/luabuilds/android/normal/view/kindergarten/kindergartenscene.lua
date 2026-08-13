class = var_0_10000

local var_0_0 = "KindergartenScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "KindergartenUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	Animation = var_1_10004
	arg_2_0.mainAnim = var_2_1(var_2_0, var_1_10003(var_1_10004))

	local var_2_2 = arg_2_0._tf

	arg_2_0.topUI = var_1.Find(var_2_2, "ui/top")

	local var_2_3 = arg_2_0.topUI
	local var_2_4 = var_1.Find(var_2_3, "title/title_kinder")
	local var_2_5 = var_1.GetComponent

	typeof = var_1_10004
	Image = var_1_10005

	local var_2_6 = var_2_5(var_2_4, var_1_10004(var_1_10005))

	var_2.SetNativeSize(var_2_6)

	var_1:Find("FX/textmask").localScale = {
		x = var_1.rect.width,
		y = var_1.rect.height
	}

	local var_2_7 = arg_2_0._tf

	arg_2_0.bottomUI = var_2.Find(var_2_7, "ui/bottom")

	local var_2_8 = arg_2_0.bottomUI

	arg_2_0.paradiseBtn = var_2.Find(var_2_8, "paradise")

	local var_2_9 = arg_2_0.paradiseBtn

	arg_2_0.paradiseValue = var_2.Find(var_2_9, "value/Text")

	local var_2_10 = arg_2_0.bottomUI

	arg_2_0.adventureBtn = var_2.Find(var_2_10, "adventure")

	local var_2_11 = arg_2_0._tf

	arg_2_0.rightUI = var_2.Find(var_2_11, "ui/right")

	local var_2_12 = arg_2_0.rightUI

	arg_2_0.ptBtn = var_2.Find(var_2_12, "pt")

	local var_2_13 = arg_2_0.ptBtn

	arg_2_0.ptValue = var_2.Find(var_2_13, "value/Text")

	local var_2_14 = arg_2_0.ptBtn

	arg_2_0.ptTip = var_2.Find(var_2_14, "tip")

	local var_2_15 = arg_2_0.rightUI

	arg_2_0.rankBtn = var_2.Find(var_2_15, "rank")

	local var_2_16 = arg_2_0.rightUI

	arg_2_0.taskBtn = var_2.Find(var_2_16, "task")

	local var_2_17 = arg_2_0.taskBtn

	arg_2_0.taskTip = var_2.Find(var_2_17, "tip")

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.topUI
	local var_3_2 = var_3.Find(var_3_1, "back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.topUI
	local var_3_6 = var_3.Find(var_3_5, "home")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.quickExitFunc(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.topUI
	local var_3_10 = var_3.Find(var_3_9, "help")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip["202406_main_help"].tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_8, var_3_10, var_3_11, var_5)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.paradiseBtn

	local function var_3_14()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		KindergartenMediator = var_2_10002

		local var_7_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_7_3 = var_2_10003.New
		local var_7_4 = {}

		TongXinSpringMediator = var_2_10005
		var_7_4.mediator = var_2_10005
		TongXinSpringLayer = var_2_10005
		var_7_4.viewComponent = var_2_10005

		var_7_1(var_7_0, var_7_2, var_7_3(var_7_4))

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_12, var_3_13, var_3_14, var_5)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.adventureBtn

	local function var_3_17()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		KindergartenMediator = var_2_10002

		local var_8_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.BOSSRUSH_MAIN)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_15, var_3_16, var_3_17, var_5)

	onButton = var_1_10001

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.ptBtn

	local function var_3_20()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		KindergartenMediator = var_2_10002

		local var_9_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_9_3 = var_2_10003.New
		local var_9_4 = {}

		ChildishnessSchoolPtMediator = var_2_10005
		var_9_4.mediator = var_2_10005
		ChildishnessSchoolPtPage = var_2_10005
		var_9_4.viewComponent = var_2_10005

		var_9_1(var_9_0, var_9_2, var_9_3(var_9_4))

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_18, var_3_19, var_3_20, var_5)

	onButton = var_1_10001

	local var_3_21 = arg_3_0
	local var_3_22 = arg_3_0.rankBtn

	local function var_3_23()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		KindergartenMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.ON_EXTRA_RANK)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_21, var_3_22, var_3_23, var_5)

	onButton = var_1_10001

	local var_3_24 = arg_3_0
	local var_3_25 = arg_3_0.taskBtn

	local function var_3_26()
		local var_11_0 = arg_3_0
		local var_11_1 = var_0.emit

		KindergartenMediator = var_2_10002

		local var_11_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_11_3 = var_2_10003.New
		local var_11_4 = {}

		ChildishnessSchoolTaskMediator = var_2_10005
		var_11_4.mediator = var_2_10005
		ChildishnessSchoolTaskPage = var_2_10005
		var_11_4.viewComponent = var_2_10005

		var_11_1(var_11_0, var_11_2, var_11_3(var_11_4))

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_24, var_3_25, var_3_26, var_5)

	local var_3_27 = arg_3_0.contextData.isBack and "anim_kinder_main_show" or "anim_kinder_main_in"
	local var_3_28 = arg_3_0.mainAnim

	var_2.Play(var_3_28, var_3_27)
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_12_0)
	arg_12_0:UpdatePt()
	arg_12_0:UpdateTask()

	return
end

function var_0_1.UpdatePt(arg_13_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_13_0 = var_1_10001(var_1_10002)
	local var_13_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	if var_13_1(var_13_0, var_1_10003.ALVIT_PT_ACT_ID) and not var_1:isEnd() then
		setActive = var_13_0

		var_13_0(arg_13_0.ptBtn, true)

		setActive = var_13_0

		var_13_0(arg_13_0.ptTip, var_0_1.ShowPtTip(var_1))

		setText = var_13_0

		var_13_0(arg_13_0.ptValue, var_1.data1)
	else
		setActive = var_13_0

		var_13_0(arg_13_0.ptBtn, false)
	end

	return
end

function var_0_1.UpdateTask(arg_14_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_14_0 = var_1_10001(var_1_10002)
	local var_14_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	if var_14_1(var_14_0, var_1_10003.ALVIT_TASK_ACT_ID) and not var_1:isEnd() then
		setActive = var_14_0

		var_14_0(arg_14_0.taskBtn, true)

		setActive = var_14_0

		var_14_0(arg_14_0.taskTip, var_0_1.ShowTaskTip(var_1))
	else
		setActive = var_14_0

		var_14_0(arg_14_0.taskBtn, false)
	end

	return
end

function var_0_1.UpdateParadise(arg_15_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if var_15_1(var_15_0, var_1_10003.ACTIVITY_TYPE_HOTSPRING) and not var_1:isEnd() then
		setActive = var_15_0

		var_15_0(arg_15_0.paradiseBtn, true)

		var_15_0 = #var_1:GetAvaliableShipIds()

		local var_15_2 = var_1
		local var_15_3 = var_1.GetTotalSlotCount(var_15_2)

		setText = var_15_2

		local var_15_4 = arg_15_0.paradiseValue

		string = var_1_10006

		var_15_2(var_15_4, var_1_10006.format("(%d/%d)", var_15_0, var_15_3))
	else
		setActive = var_15_0

		var_15_0(arg_15_0.paradiseBtn, false)
	end

	return
end

function var_0_1.onBackPressed(arg_16_0)
	arg_16_0:quickExitFunc()

	return
end

function var_0_1.ShowPtTip(arg_17_0)
	local var_17_0

	if not arg_17_0 then
		::label_17_0::

		getProxy = var_17_0
		ActivityProxy = var_1_10002
		var_1_10002 = var_17_0(var_1_10002)
		var_17_0 = var_17_0.getActivityById
		ActivityConst = var_1_10003
		var_17_0 = var_17_0(var_1_10002, var_1_10003.ALVIT_PT_ACT_ID)
	end

	Activity = var_1_10002

	return var_1_10002.IsActivityReady(var_17_0)
end

function var_0_1.ShowTaskTip(arg_18_0)
	local var_18_0

	if not arg_18_0 then
		::label_18_0::

		getProxy = var_18_0
		ActivityProxy = var_1_10002
		var_1_10002 = var_18_0(var_1_10002)
		var_18_0 = var_18_0.getActivityById
		ActivityConst = var_1_10003
		var_18_0 = var_18_0(var_1_10002, var_1_10003.ALVIT_TASK_ACT_ID)
	end

	Activity = var_1_10002

	return var_1_10002.IsActivityReady(var_18_0)
end

function var_0_1.IsShowMainTip()
	local var_19_0

	if not var_0_1.ShowPtTip() then
		var_19_0 = var_0_1.ShowTaskTip()
	end

	return var_19_0
end

return var_0_1
