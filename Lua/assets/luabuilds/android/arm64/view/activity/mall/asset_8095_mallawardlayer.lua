local MallAwardLayer = class("MallAwardLayer", import("view.base.BaseUI"))

function MallAwardLayer:getUIName()
	return "MallAwardUI"
end

function MallAwardLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiInputBtn, function()
		self:emit(MallAwardMediator.INPUT_GOLD, self.activity.id, self.curGold)

		return
	end, SFX_PANEL)
	onButton(self, self.uiGetAllBtn, function()
		self:emit(MallAwardMediator.GET_PT_AWARD, {
			cmd = 4,
			activity_id = self.ptData:GetId(),
			arg1 = self.ptData:GetCurrTarget()
		})

		return
	end, SFX_PANEL)

	self.storyTaskUIList = UIItemList.New(self.uiStoryTaskTF, self.uiTaskTpl)

	self.storyTaskUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:UpdateTaskTpl(self.storyTaskList[arg_6_1 + 1], arg_6_2)
		end

		return
	end)

	self.dailyTaskUIList = UIItemList.New(self.uiDailyTaskTF, self.uiTaskTpl)

	self.dailyTaskUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateTaskTpl(self.dailyTaskList[arg_7_1 + 1], arg_7_2)
		end

		return
	end)

	self.awardUIList = UIItemList.New(self.uiAwardTF, self.uiAwardTF:Find("tpl"))

	self.awardUIList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			self:UpdateAwardTpl(arg_8_1, arg_8_2)
		end

		return
	end)
	setText(self.uiInputHeaderText, i18n("mall_input_header"))
	setText(self.uiOwnHeaderText, i18n("common_already owned"))
	setText(self.uiGetAllBtnText, i18n("mall_get_all_btn"))
	setText(self.uiInputBtnText, i18n("mall_input_btn"))
	setActive(self.uiTaskTpl, false)
	setText(self.uiTaskTpl:Find("go/Text"), i18n("task_go"))
	setText(self.uiTaskTpl:Find("get/Text"), i18n("task_get"))
	setText(self.uiTaskTpl:Find("got/Text"), i18n("task_got"))
	setText(self.uiAwardTF:Find("tpl/target/icon/Text"), i18n("target_get_tip"))
	setText(self.uiAwardTF:Find("tpl/get/Text"), i18n("mall_award_can_get"))
	setText(self.uiAwardTF:Find("tpl/got/Text"), i18n("mall_award_got"))

	return
end

function MallAwardLayer:didEnter()
	self:UpdateView()

	return
end

function MallAwardLayer:UpdateView()
	self:UpdateData()
	self:UpdateAwardView()
	self:UpdateTaskView()

	return
end

function MallAwardLayer:UpdateData()
	local var_11_0 = getProxy(ActivityProxy)

	self.activity = var_11_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	self.curGold = self.activity:GetGold()
	self.ptActivity = var_11_0:getActivityById(self.activity:getConfig("config_id"))
	self.ptData = ActivityPtData.New(self.ptActivity)
	self.ptDataUnlockStamps = self.ptData:GetDayUnlockStamps()
	self.inputGold = self.ptData.count

	return
end

function MallAwardLayer:UpdateAwardView()
	setActive(self.uiGetAllBtn, self.ptData:CanGetAward())
	setActive(self.uiInputBtn, self.curGold > 0)
	setActive(self.uiInputTip, MallAwardLayer.IsInputTip())
	setText(self.uiOwnText, self.curGold)
	setText(self.uiInputText, self.inputGold)
	self.awardUIList:align(#self.ptData.dropList)

	if self.ptData.level > 0 then
		scrollToIndex(self.awardUIList.container.parent, self.ptData.level)
	end

	return
end

function MallAwardLayer:UpdateAwardTpl(arg_13_1, arg_13_2)
	local var_13_0 = self.ptData.targets[arg_13_1 + 1]

	setText(arg_13_2:Find("target/Text"), self.ptData.targets[arg_13_1 + 1])

	local var_13_1 = Drop.Create(self.ptData.dropList[arg_13_1 + 1])

	updateDrop(arg_13_2:Find("award"), var_13_1)
	onButton(self, arg_13_2:Find("award"), function()
		self:emit(BaseUI.ON_DROP, var_13_1)

		return
	end, SFX_PANEL)

	local var_13_2 = arg_13_1 + 1 <= self.ptData.level

	setActive(arg_13_2:Find("got"), arg_13_1 + 1 <= self.ptData.level)
	setActive(arg_13_2:Find("get"), not var_13_2 and var_13_0 <= self.inputGold)

	local var_13_3 = self.ptDataUnlockStamps[arg_13_1 + 1]

	setActive(arg_13_2:Find("lock"), self.ptDataUnlockStamps[arg_13_1 + 1])

	if var_13_3 then
		local var_13_4 = pg.TimeMgr.GetInstance()

		setActive(arg_13_2:Find("lock"), var_13_3 > var_13_4:GetServerTime())
		setText(arg_13_2:Find("lock/Text"), i18n("mall_unlock_date_tip2", var_13_4:STimeDescS(var_13_3, "%m"), (var_13_4:STimeDescS(var_13_3, "%d"))))
	end

	return
end

function MallAwardLayer:UpdateTaskView()
	self.storyTaskList, self.dailyTaskList = {}, {}

	local var_15_0 = getProxy(TaskProxy)

	for iter_15_0, iter_15_1 in ipairs(self.activity:getConfig("config_client").story_task) do
		table.insert(self.storyTaskList, (var_15_0:getTaskVO(iter_15_1)))
	end

	for iter_15_2, iter_15_3 in ipairs(self.activity:getConfig("config_client").daily_task) do
		table.insert(self.dailyTaskList, (var_15_0:getTaskVO(iter_15_3)))
	end

	self:SortTaskList(self.storyTaskList)
	self:SortTaskList(self.dailyTaskList)
	self.storyTaskUIList:align(#self.storyTaskList)
	self.dailyTaskUIList:align(#self.dailyTaskList)

	return
end

function MallAwardLayer:SortTaskList(arg_16_1)
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

function MallAwardLayer:UpdateTaskTpl(arg_20_1, arg_20_2)
	setText(arg_20_2:Find("slider/desc"), arg_20_1:getConfig("desc"))

	local var_20_0 = arg_20_1:getProgress()
	local var_20_1 = arg_20_1:getConfig("target_num")

	setText(arg_20_2:Find("slider/progress"), var_20_0 .. "/" .. var_20_1)
	setSlider(arg_20_2:Find("slider"), 0, 1, var_20_0 / var_20_1)
	onButton(self, arg_20_2:Find("go"), function()
		self:emit(MallAwardMediator.TASK_GO, arg_20_1)

		return
	end, SFX_PANEL)
	onButton(self, arg_20_2:Find("get"), function()
		self:emit(MallAwardMediator.SUBMIT_TASK, arg_20_1)

		return
	end, SFX_PANEL)

	local var_20_2 = arg_20_1:getTaskStatus()

	setActive(arg_20_2:Find("go"), var_20_2 == 0)
	setActive(arg_20_2:Find("get"), var_20_2 == 1)
	setActive(arg_20_2:Find("got"), var_20_2 == 2)

	local var_20_3 = arg_20_1:getConfig("award_display")[1]

	setActive(arg_20_2:Find("award"), var_20_3)

	if var_20_3 then
		local var_20_4 = Drop.Create(var_20_3)

		updateDrop(arg_20_2:Find("award"), var_20_4)
		onButton(self, arg_20_2:Find("award"), function()
			self:emit(BaseUI.ON_DROP, var_20_4)

			return
		end, SFX_PANEL)
	end

	return
end

function MallAwardLayer:willExit()
	existCall(self.contextData.onExit)

	self.contextData.onExit = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function MallAwardLayer.IsAwardTip()
	local var_25_0 = getProxy(ActivityProxy)

	return Activity.IsActivityReady((var_25_0:getActivityById(var_25_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL):getConfig("config_id"))))
end

function MallAwardLayer.IsInputTip()
	local var_26_0 = getProxy(ActivityProxy)
	local var_26_1 = var_26_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	local var_26_2 = ActivityPtData.New((var_26_0:getActivityById(var_26_1:getConfig("config_id"))))
	local var_26_3 = var_26_1:GetGold()

	return var_26_2:CanGetNextAward() and (function()
		local var_27_0, var_27_1, var_27_2 = var_26_2:GetResProgress()

		return var_27_1 <= var_27_0 + var_26_3
	end)()
end

function MallAwardLayer.IsTaskTip()
	local var_28_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	local var_28_1 = getProxy(TaskProxy)

	return underscore.any(table.mergeArray(var_28_0:getConfig("config_client").story_task, var_28_0:getConfig("config_client").daily_task), function(arg_29_0)
		local var_29_0 = var_28_1:getTaskById(arg_29_0)

		return var_29_0 and var_29_0:isFinish() and not var_29_0:isReceive()
	end)
end

return MallAwardLayer
