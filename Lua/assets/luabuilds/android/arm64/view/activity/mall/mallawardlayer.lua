local var_0_0 = class("MallAwardLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MallAwardUI"
end

function var_0_0.init(arg_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiInputBtn, function()
		arg_2_0:emit(MallAwardMediator.INPUT_GOLD, arg_2_0.activity.id, arg_2_0.curGold)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiGetAllBtn, function()
		arg_2_0:emit(MallAwardMediator.GET_PT_AWARD, {
			cmd = 4,
			activity_id = arg_2_0.ptData:GetId(),
			arg1 = arg_2_0.ptData:GetCurrTarget()
		})

		return
	end, SFX_PANEL)

	arg_2_0.storyTaskUIList = UIItemList.New(arg_2_0.uiStoryTaskTF, arg_2_0.uiTaskTpl)

	arg_2_0.storyTaskUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			arg_2_0:UpdateTaskTpl(arg_2_0.storyTaskList[arg_6_1 + 1], arg_6_2)
		end

		return
	end)

	arg_2_0.dailyTaskUIList = UIItemList.New(arg_2_0.uiDailyTaskTF, arg_2_0.uiTaskTpl)

	arg_2_0.dailyTaskUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_2_0:UpdateTaskTpl(arg_2_0.dailyTaskList[arg_7_1 + 1], arg_7_2)
		end

		return
	end)

	arg_2_0.awardUIList = UIItemList.New(arg_2_0.uiAwardTF, arg_2_0.uiAwardTF:Find("tpl"))

	arg_2_0.awardUIList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			arg_2_0:UpdateAwardTpl(arg_8_1, arg_8_2)
		end

		return
	end)
	setText(arg_2_0.uiInputHeaderText, i18n("mall_input_header"))
	setText(arg_2_0.uiOwnHeaderText, i18n("common_already owned"))
	setText(arg_2_0.uiGetAllBtnText, i18n("mall_get_all_btn"))
	setText(arg_2_0.uiInputBtnText, i18n("mall_input_btn"))
	setActive(arg_2_0.uiTaskTpl, false)
	setText(arg_2_0.uiTaskTpl:Find("go/Text"), i18n("task_go"))
	setText(arg_2_0.uiTaskTpl:Find("get/Text"), i18n("task_get"))
	setText(arg_2_0.uiTaskTpl:Find("got/Text"), i18n("task_got"))
	setText(arg_2_0.uiAwardTF:Find("tpl/target/icon/Text"), i18n("target_get_tip"))
	setText(arg_2_0.uiAwardTF:Find("tpl/get/Text"), i18n("mall_award_can_get"))
	setText(arg_2_0.uiAwardTF:Find("tpl/got/Text"), i18n("mall_award_got"))

	return
end

function var_0_0.didEnter(arg_9_0)
	arg_9_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_10_0)
	arg_10_0:UpdateData()
	arg_10_0:UpdateAwardView()
	arg_10_0:UpdateTaskView()

	return
end

function var_0_0.UpdateData(arg_11_0)
	local var_11_0 = getProxy(ActivityProxy)

	arg_11_0.activity = var_11_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	arg_11_0.curGold = arg_11_0.activity:GetGold()
	arg_11_0.ptActivity = var_11_0:getActivityById(arg_11_0.activity:getConfig("config_id"))
	arg_11_0.ptData = ActivityPtData.New(arg_11_0.ptActivity)
	arg_11_0.ptDataUnlockStamps = arg_11_0.ptData:GetDayUnlockStamps()
	arg_11_0.inputGold = arg_11_0.ptData.count

	return
end

function var_0_0.UpdateAwardView(arg_12_0)
	setActive(arg_12_0.uiGetAllBtn, arg_12_0.ptData:CanGetAward())
	setActive(arg_12_0.uiInputBtn, arg_12_0.curGold > 0)
	setActive(arg_12_0.uiInputTip, var_0_0.IsInputTip())
	setText(arg_12_0.uiOwnText, arg_12_0.curGold)
	setText(arg_12_0.uiInputText, arg_12_0.inputGold)
	arg_12_0.awardUIList:align(#arg_12_0.ptData.dropList)

	if arg_12_0.ptData.level > 0 then
		scrollToIndex(arg_12_0.awardUIList.container.parent, arg_12_0.ptData.level)
	end

	return
end

function var_0_0.UpdateAwardTpl(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.ptData.targets[arg_13_1 + 1]

	setText(arg_13_2:Find("target/Text"), arg_13_0.ptData.targets[arg_13_1 + 1])
	updateDrop(arg_13_2:Find("award"), (Drop.Create(arg_13_0.ptData.dropList[arg_13_1 + 1])))
	onButton(arg_13_0, arg_13_2:Find("award"), function()
		arg_13_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_13_1 = arg_13_1 + 1 <= arg_13_0.ptData.level

	setActive(arg_13_2:Find("got"), arg_13_1 + 1 <= arg_13_0.ptData.level)
	setActive(arg_13_2:Find("get"), not var_13_1 and var_13_0 <= arg_13_0.inputGold)

	local var_13_2 = arg_13_0.ptDataUnlockStamps[arg_13_1 + 1]

	setActive(arg_13_2:Find("lock"), arg_13_0.ptDataUnlockStamps[arg_13_1 + 1])

	if var_13_2 then
		local var_13_3 = pg.TimeMgr.GetInstance()

		setActive(arg_13_2:Find("lock"), var_13_2 > var_13_3:GetServerTime())
		setText(arg_13_2:Find("lock/Text"), i18n("mall_unlock_date_tip2", var_13_3:STimeDescS(var_13_2, "%m"), (var_13_3:STimeDescS(var_13_2, "%d"))))
	end

	return
end

function var_0_0.UpdateTaskView(arg_15_0)
	arg_15_0.storyTaskList, arg_15_0.dailyTaskList = {}, {}

	local var_15_0 = getProxy(TaskProxy)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.activity:getConfig("config_client").story_task) do
		table.insert(arg_15_0.storyTaskList, (var_15_0:getTaskVO(iter_15_1)))
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0.activity:getConfig("config_client").daily_task) do
		table.insert(arg_15_0.dailyTaskList, (var_15_0:getTaskVO(iter_15_3)))
	end

	arg_15_0:SortTaskList(arg_15_0.storyTaskList)
	arg_15_0:SortTaskList(arg_15_0.dailyTaskList)
	arg_15_0.storyTaskUIList:align(#arg_15_0.storyTaskList)
	arg_15_0.dailyTaskUIList:align(#arg_15_0.dailyTaskList)

	return
end

function var_0_0.SortTaskList(arg_16_0, arg_16_1)
	table.sort(arg_16_1, CompareFuncs({
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

function var_0_0.UpdateTaskTpl(arg_20_0, arg_20_1, arg_20_2)
	setText(arg_20_2:Find("slider/desc"), arg_20_1:getConfig("desc"))

	local var_20_0 = arg_20_1:getProgress()
	local var_20_1 = arg_20_1:getConfig("target_num")

	setText(arg_20_2:Find("slider/progress"), var_20_0 .. "/" .. var_20_1)
	setSlider(arg_20_2:Find("slider"), 0, 1, var_20_0 / var_20_1)
	onButton(arg_20_0, arg_20_2:Find("go"), function()
		arg_20_0:emit(MallAwardMediator.TASK_GO, arg_20_1)

		return
	end, SFX_PANEL)
	onButton(arg_20_0, arg_20_2:Find("get"), function()
		arg_20_0:emit(MallAwardMediator.SUBMIT_TASK, arg_20_1)

		return
	end, SFX_PANEL)

	local var_20_2 = arg_20_1:getTaskStatus()

	setActive(arg_20_2:Find("go"), var_20_2 == 0)
	setActive(arg_20_2:Find("get"), var_20_2 == 1)
	setActive(arg_20_2:Find("got"), var_20_2 == 2)

	local var_20_3 = arg_20_1:getConfig("award_display")[1]

	setActive(arg_20_2:Find("award"), var_20_3)

	if var_20_3 then
		updateDrop(arg_20_2:Find("award"), (Drop.Create(var_20_3)))
		onButton(arg_20_0, arg_20_2:Find("award"), function()
			arg_20_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.willExit(arg_24_0)
	existCall(arg_24_0.contextData.onExit)

	arg_24_0.contextData.onExit = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_24_0._tf)

	return
end

function var_0_0.IsAwardTip()
	local var_25_0 = getProxy(ActivityProxy)

	return Activity.IsActivityReady((var_25_0:getActivityById(var_25_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL):getConfig("config_id"))))
end

function var_0_0.IsInputTip()
	local var_26_0 = getProxy(ActivityProxy)
	local var_26_1 = var_26_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	local var_26_2 = ActivityPtData.New((var_26_0:getActivityById(var_26_1:getConfig("config_id"))))
	local var_26_3 = var_26_1:GetGold()

	return ActivityPtData.New((var_26_0:getActivityById(var_26_1:getConfig("config_id")))):CanGetNextAward() and (function()
		local var_27_0, var_27_1, var_27_2 = var_26_2:GetResProgress()

		return var_27_1 <= var_27_0 + var_26_3
	end)()
end

function var_0_0.IsTaskTip()
	local var_28_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	local var_28_1 = getProxy(TaskProxy)

	return underscore.any(table.mergeArray(var_28_0:getConfig("config_client").story_task, var_28_0:getConfig("config_client").daily_task), function(arg_29_0)
		local var_29_0 = var_28_1:getTaskById(arg_29_0)

		return var_29_0 and var_29_0:isFinish() and not var_29_0:isReceive()
	end)
end

return var_0_0
