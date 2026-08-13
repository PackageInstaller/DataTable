class = var_0_10000

local var_0_0 = "MallAwardLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MallAwardUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.uiCloseBtn

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_2_1, var_2_2, var_2_3, var_1_10006)

	onButton = var_1

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.uiInputBtn

	local function var_2_6()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		MallAwardMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.INPUT_GOLD, arg_2_0.activity.id, arg_2_0.curGold)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_4, var_2_5, var_2_6, var_1_10006)

	onButton = var_1

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.uiGetAllBtn

	local function var_2_9()
		local var_5_0 = arg_2_0.ptData
		local var_5_1 = var_0.GetCurrTarget(var_5_0)
		local var_5_2 = arg_2_0
		local var_5_3 = var_1.emit

		MallAwardMediator = var_2_10004

		local var_5_4 = var_2_10004.GET_PT_AWARD
		local var_5_5 = {
			cmd = 4
		}
		local var_5_6 = arg_2_0.ptData

		var_5_5.activity_id = var_6.GetId(var_5_6)
		var_5_5.arg1 = var_5_1

		var_5_3(var_5_2, var_5_4, var_5_5)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_7, var_2_8, var_2_9, var_1_10006)

	UIItemList = var_1
	arg_2_0.storyTaskUIList = var_1.New(arg_2_0.uiStoryTaskTF, arg_2_0.uiTaskTpl)

	local var_2_10 = arg_2_0.storyTaskUIList

	var_1.make(var_2_10, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_2_0.storyTaskList[arg_6_1 + 1]
			local var_6_1 = arg_2_0

			var_4.UpdateTaskTpl(var_6_1, var_6_0, arg_6_2)
		end

		return
	end)

	UIItemList = var_1
	arg_2_0.dailyTaskUIList = var_1.New(arg_2_0.uiDailyTaskTF, arg_2_0.uiTaskTpl)

	local var_2_11 = arg_2_0.dailyTaskUIList

	var_1.make(var_2_11, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_2_0.dailyTaskList[arg_7_1 + 1]
			local var_7_1 = arg_2_0

			var_4.UpdateTaskTpl(var_7_1, var_7_0, arg_7_2)
		end

		return
	end)

	UIItemList = var_1

	local var_2_12 = var_1.New
	local var_2_13 = arg_2_0.uiAwardTF
	local var_2_14 = arg_2_0.uiAwardTF

	arg_2_0.awardUIList = var_2_12(var_2_13, var_4.Find(var_2_14, "tpl"))

	local var_2_15 = arg_2_0.awardUIList

	var_1.make(var_2_15, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_2_0

			var_3.UpdateAwardTpl(var_8_0, arg_8_1, arg_8_2)
		end

		return
	end)

	setText = var_1

	local var_2_16 = arg_2_0.uiInputHeaderText

	i18n = var_4

	var_1(var_2_16, var_4("mall_input_header"))

	setText = var_1

	local var_2_17 = arg_2_0.uiOwnHeaderText

	i18n = var_4

	var_1(var_2_17, var_4("common_already owned"))

	setText = var_1

	local var_2_18 = arg_2_0.uiGetAllBtnText

	i18n = var_4

	var_1(var_2_18, var_4("mall_get_all_btn"))

	setText = var_1

	local var_2_19 = arg_2_0.uiInputBtnText

	i18n = var_4

	var_1(var_2_19, var_4("mall_input_btn"))

	setActive = var_1

	var_1(arg_2_0.uiTaskTpl, false)

	setText = var_1

	local var_2_20 = arg_2_0.uiTaskTpl
	local var_2_21 = var_3.Find(var_2_20, "go/Text")

	i18n = var_4

	var_1(var_2_21, var_4("task_go"))

	setText = var_1

	local var_2_22 = arg_2_0.uiTaskTpl
	local var_2_23 = var_3.Find(var_2_22, "get/Text")

	i18n = var_4

	var_1(var_2_23, var_4("task_get"))

	setText = var_1

	local var_2_24 = arg_2_0.uiTaskTpl
	local var_2_25 = var_3.Find(var_2_24, "got/Text")

	i18n = var_4

	var_1(var_2_25, var_4("task_got"))

	setText = var_1

	local var_2_26 = arg_2_0.uiAwardTF
	local var_2_27 = var_3.Find(var_2_26, "tpl/target/icon/Text")

	i18n = var_4

	var_1(var_2_27, var_4("target_get_tip"))

	setText = var_1

	local var_2_28 = arg_2_0.uiAwardTF
	local var_2_29 = var_3.Find(var_2_28, "tpl/get/Text")

	i18n = var_4

	var_1(var_2_29, var_4("mall_award_can_get"))

	setText = var_1

	local var_2_30 = arg_2_0.uiAwardTF
	local var_2_31 = var_3.Find(var_2_30, "tpl/got/Text")

	i18n = var_4

	var_1(var_2_31, var_4("mall_award_got"))

	return
end

function var_0_1.didEnter(arg_9_0)
	arg_9_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_10_0)
	arg_10_0:UpdateData()
	arg_10_0:UpdateAwardView()
	arg_10_0:UpdateTaskView()

	return
end

function var_0_1.UpdateData(arg_11_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1 = var_1.getActivityByType

	ActivityConst = var_1_10005
	arg_11_0.activity = var_11_1(var_11_0, var_1_10005.ACTIVITY_TYPE_MALL)

	local var_11_2 = arg_11_0.activity

	arg_11_0.curGold = var_2.GetGold(var_11_2)

	local var_11_3 = var_1
	local var_11_4 = var_1.getActivityById
	local var_11_5 = arg_11_0.activity

	arg_11_0.ptActivity = var_11_4(var_11_3, var_5.getConfig(var_11_5, "config_id"))
	ActivityPtData = var_2
	arg_11_0.ptData = var_2.New(arg_11_0.ptActivity)

	local var_11_6 = arg_11_0.ptData

	arg_11_0.ptDataUnlockStamps = var_2.GetDayUnlockStamps(var_11_6)
	arg_11_0.inputGold = arg_11_0.ptData.count

	return
end

function var_0_1.UpdateAwardView(arg_12_0)
	setActive = var_1_10001

	local var_12_0 = arg_12_0.uiGetAllBtn
	local var_12_1 = arg_12_0.ptData

	var_1_10001(var_12_0, var_4.CanGetAward(var_12_1))

	setActive = var_1_10001

	var_1_10001(arg_12_0.uiInputBtn, arg_12_0.curGold > 0)

	setActive = var_1_10001

	var_1_10001(arg_12_0.uiInputTip, var_0_1.IsInputTip())

	setText = var_1_10001

	var_1_10001(arg_12_0.uiOwnText, arg_12_0.curGold)

	setText = var_1_10001

	var_1_10001(arg_12_0.uiInputText, arg_12_0.inputGold)

	local var_12_2 = arg_12_0.awardUIList

	var_1.align(var_12_2, #arg_12_0.ptData.dropList)

	if arg_12_0.ptData.level > 0 then
		scrollToIndex = var_1

		var_1(arg_12_0.awardUIList.container.parent, arg_12_0.ptData.level)
	end

	return
end

function var_0_1.UpdateAwardTpl(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1 + 1
	local var_13_1 = arg_13_0.ptData.dropList[var_13_0]
	local var_13_2 = arg_13_0.ptData.targets[var_13_0]

	setText = var_1_10006

	var_1_10006(arg_13_2:Find("target/Text"), var_13_2)

	Drop = var_1_10006

	local var_13_3 = var_1_10006.Create(var_13_1)

	updateDrop = var_1_10007

	var_1_10007(arg_13_2:Find("award"), var_13_3)

	onButton = var_1_10007

	local var_13_4 = arg_13_0
	local var_13_5 = arg_13_2
	local var_13_6 = arg_13_2.Find(var_13_5, "award")

	local function var_13_7()
		local var_14_0 = arg_13_0
		local var_14_1 = var_0.emit

		BaseUI = var_2_10003

		var_14_1(var_14_0, var_2_10003.ON_DROP, var_13_3)

		return
	end

	SFX_PANEL = var_13_5

	var_1_10007(var_13_4, var_13_6, var_13_7, var_13_5)

	local var_13_8 = var_13_0 <= arg_13_0.ptData.level

	setActive = var_8

	var_8(arg_13_2:Find("got"), var_13_8)

	setActive = var_8

	var_8(arg_13_2:Find("get"), not var_13_8 and var_13_2 <= arg_13_0.inputGold)

	local var_13_9 = arg_13_0.ptDataUnlockStamps[var_13_0]

	setActive = var_13_4

	var_13_4(arg_13_2:Find("lock"), var_13_9)

	if var_13_9 then
		pg = var_13_4

		local var_13_10 = var_13_4.TimeMgr.GetInstance()

		setActive = var_10

		var_10(arg_13_2:Find("lock"), var_13_9 > var_13_10:GetServerTime())

		local var_13_11 = var_13_10
		local var_13_12 = var_13_10.STimeDescS(var_13_11, var_13_9, "%m")
		local var_13_13 = var_13_10:STimeDescS(var_13_9, "%d")

		setText = var_13_11

		local var_13_14 = arg_13_2:Find("lock/Text")

		i18n = var_15

		var_13_11(var_13_14, var_15("mall_unlock_date_tip2", var_13_12, var_13_13))
	end

	return
end

function var_0_1.UpdateTaskView(arg_15_0)
	local var_15_0 = {}

	arg_15_0.dailyTaskList = {}
	arg_15_0.storyTaskList = var_15_0
	getProxy = var_15_0
	TaskProxy = var_1_10003

	local var_15_1 = var_15_0(var_1_10003)

	ipairs = var_2

	local var_15_2 = arg_15_0.activity

	for iter_15_0, iter_15_1 in var_2(var_4.getConfig(var_15_2, "config_client").story_task) do
		local var_15_3 = var_15_1:getTaskVO(iter_15_1)

		table = var_1_10008

		var_1_10008.insert(arg_15_0.storyTaskList, var_15_3)
	end

	ipairs = var_2

	local var_15_4 = arg_15_0.activity

	for iter_15_2, iter_15_3 in var_2(var_4.getConfig(var_15_4, "config_client").daily_task) do
		local var_15_5 = var_15_1:getTaskVO(iter_15_3)

		table = var_1_10008

		var_1_10008.insert(arg_15_0.dailyTaskList, var_15_5)
	end

	arg_15_0:SortTaskList(arg_15_0.storyTaskList)
	arg_15_0:SortTaskList(arg_15_0.dailyTaskList)

	local var_15_6 = arg_15_0.storyTaskUIList

	var_2.align(var_15_6, #arg_15_0.storyTaskList)

	local var_15_7 = arg_15_0.dailyTaskUIList

	var_2.align(var_15_7, #arg_15_0.dailyTaskList)

	return
end

function var_0_1.SortTaskList(arg_16_0, arg_16_1)
	table = var_1_10002

	local var_16_0 = var_1_10002.sort
	local var_16_1 = arg_16_1

	CompareFuncs = var_1_10005

	var_16_0(var_16_1, var_1_10005({
		function(arg_17_0)
			return arg_17_0:isReceive() and 1 or 0
		end,
		function(arg_18_0)
			return arg_18_0:isFinish() and 0 or 1
		end,
		function(arg_19_0)
			return arg_19_0.id
		end
	}))

	return
end

function var_0_1.UpdateTaskTpl(arg_20_0, arg_20_1, arg_20_2)
	setText = var_1_10003

	var_1_10003(arg_20_2:Find("slider/desc"), arg_20_1:getConfig("desc"))

	local var_20_0 = arg_20_1
	local var_20_1 = arg_20_1.getProgress(var_20_0)
	local var_20_2 = arg_20_1
	local var_20_3 = arg_20_1.getConfig(var_20_2, "target_num")

	setText = var_20_0

	var_20_0(arg_20_2:Find("slider/progress"), var_20_1 .. "/" .. var_20_3)

	setSlider = var_20_0

	var_20_0(arg_20_2:Find("slider"), 0, 1, var_20_1 / var_20_3)

	onButton = var_20_0

	local var_20_4 = arg_20_0
	local var_20_5 = arg_20_2
	local var_20_6 = arg_20_2.Find(var_20_5, "go")

	local function var_20_7()
		local var_21_0 = arg_20_0
		local var_21_1 = var_0.emit

		MallAwardMediator = var_2_10003

		var_21_1(var_21_0, var_2_10003.TASK_GO, arg_20_1)

		return
	end

	SFX_PANEL = var_20_5

	var_20_0(var_20_4, var_20_6, var_20_7, var_20_5)

	onButton = var_20_0

	local var_20_8 = arg_20_0
	local var_20_9 = arg_20_2
	local var_20_10 = arg_20_2.Find(var_20_9, "get")

	local function var_20_11()
		local var_22_0 = arg_20_0
		local var_22_1 = var_0.emit

		MallAwardMediator = var_2_10003

		var_22_1(var_22_0, var_2_10003.SUBMIT_TASK, arg_20_1)

		return
	end

	SFX_PANEL = var_20_9

	var_20_0(var_20_8, var_20_10, var_20_11, var_20_9)

	local var_20_12 = arg_20_1
	local var_20_13 = arg_20_1.getTaskStatus(var_20_12)

	setActive = var_20_2

	var_20_2(arg_20_2:Find("go"), var_20_13 == 0)

	setActive = var_20_2

	var_20_2(arg_20_2:Find("get"), var_20_13 == 1)

	setActive = var_20_2

	var_20_2(arg_20_2:Find("got"), var_20_13 == 2)

	local var_20_14 = arg_20_1
	local var_20_15 = arg_20_1.getConfig(var_20_14, "award_display")[1]

	setActive = var_20_12

	var_20_12(arg_20_2:Find("award"), var_20_15)

	if var_20_15 then
		Drop = var_20_12

		local var_20_16 = var_20_12.Create(var_20_15)

		updateDrop = var_20_14

		var_20_14(arg_20_2:Find("award"), var_20_16)

		onButton = var_20_14

		local var_20_17 = arg_20_0
		local var_20_18 = arg_20_2
		local var_20_19 = arg_20_2.Find(var_20_18, "award")

		local function var_20_20()
			local var_23_0 = arg_20_0
			local var_23_1 = var_0.emit

			BaseUI = var_2_10003

			var_23_1(var_23_0, var_2_10003.ON_DROP, var_20_16)

			return
		end

		SFX_PANEL = var_20_18

		var_20_14(var_20_17, var_20_19, var_20_20, var_20_18)
	end

	return
end

function var_0_1.willExit(arg_24_0)
	existCall = var_1_10001

	var_1_10001(arg_24_0.contextData.onExit)

	local var_24_0 = arg_24_0.contextData

	var_24_0.onExit = nil
	pg = var_24_0

	local var_24_1 = var_24_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_24_1, arg_24_0._tf)

	return
end

function var_0_1.IsAwardTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_25_0 = var_1_10000(var_1_10002)
	local var_25_1 = var_0.getActivityByType

	ActivityConst = var_1_10004

	local var_25_2 = var_25_1(var_25_0, var_1_10004.ACTIVITY_TYPE_MALL)
	local var_25_3 = var_0:getActivityById(var_25_2:getConfig("config_id"))

	Activity = var_25_0

	return var_25_0.IsActivityReady(var_25_3)
end

function var_0_1.IsInputTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_26_0 = var_1_10000(var_1_10002)
	local var_26_1 = var_0.getActivityByType

	ActivityConst = var_1_10004

	local var_26_2 = var_26_1(var_26_0, var_1_10004.ACTIVITY_TYPE_MALL)
	local var_26_3 = var_0:getActivityById(var_26_2:getConfig("config_id"))

	ActivityPtData = var_26_0

	local var_26_4 = var_26_0.New(var_26_3)
	local var_26_5 = var_26_2:GetGold()

	local function var_26_6()
		local var_27_0 = var_26_4
		local var_27_1, var_27_2, var_27_3 = var_0.GetResProgress(var_27_0)

		return var_27_2 <= var_27_1 + var_26_5
	end

	local var_26_7

	if var_26_4:CanGetNextAward() then
		var_26_7 = var_26_6()
	end

	return var_26_7
end

function var_0_1.IsTaskTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_28_0 = var_1_10000(var_1_10002)
	local var_28_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_28_2 = var_28_1(var_28_0, var_1_10003.ACTIVITY_TYPE_MALL)

	table = var_1_10001

	local var_28_3 = var_1_10001.mergeArray(var_28_2:getConfig("config_client").story_task, var_28_2:getConfig("config_client").daily_task)

	getProxy = var_28_0
	TaskProxy = var_4

	local var_28_4 = var_28_0(var_4)

	underscore = var_3

	return var_3.any(var_28_3, function(arg_29_0)
		local var_29_0 = var_28_4
		local var_29_1

		if var_1.getTaskById(var_29_0, arg_29_0) and var_1:isFinish() then
			var_29_1 = not var_1:isReceive()
		end

		return var_29_1
	end)
end

return var_0_1
