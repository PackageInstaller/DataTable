local TaskScene = class("TaskScene", import("..base.BaseUI"))

TaskScene.PAGE_TYPE_SCENARIO = "scenario"
TaskScene.PAGE_TYPE_BRANCH = "branch"
TaskScene.PAGE_TYPE_ROUTINE = "routine"
TaskScene.PAGE_TYPE_WEEKLY = "weekly"
TaskScene.PAGE_TYPE_ALL = "all"
TaskScene.PAGE_TYPE_ACT = "activity"

local var_0_1 = {
	[TaskScene.PAGE_TYPE_SCENARIO] = {
		[1] = true
	},
	[TaskScene.PAGE_TYPE_BRANCH] = {
		nil,
		true,
		nil,
		nil,
		true,
		true
	},
	[TaskScene.PAGE_TYPE_ROUTINE] = {
		[3] = true,
		[36] = true
	},
	[TaskScene.PAGE_TYPE_WEEKLY] = {
		[4] = true,
		[13] = true
	},
	[TaskScene.PAGE_TYPE_ALL] = {
		[0] = true,
		true,
		true,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		true,
		36,
		true,
		26,
		true,
		[nil] = true,
		[true] = true
	},
	[TaskScene.PAGE_TYPE_ACT] = {
		[36] = true,
		[6] = true,
		[26] = true,
		[16] = true
	}
}

function TaskScene:getUIName()
	return "TaskScene"
end

function TaskScene:setTaskVOs(arg_2_1)
	self.contextData.taskVOsById = arg_2_1

	return
end

function TaskScene:SetWeekTaskProgressInfo(arg_3_1)
	self.contextData.weekTaskProgressInfo = arg_3_1

	return
end

function TaskScene:init()
	self._topPanel = self._tf:Find("blur_panel/adapt/top")
	self._backBtn = self._topPanel:Find("back_btn")
	self._leftLength = self._tf:Find("blur_panel/adapt/left_length")
	self._tagRoot = self._tf:Find("blur_panel/adapt/left_length/frame/tagRoot")
	self.taskIconTpl = self._tf:Find("taskTagOb/task_icon_default")
	self.weekTip = self._tagRoot:Find("weekly/tip")
	self.oneStepBtn = self._tf:Find("blur_panel/adapt/top/GetAllButton")
	self.contextData.viewComponent = self
	self.pageTF = self._tf:Find("pages")

	return
end

function TaskScene.IsNewStyleTime()
	return pg.TimeMgr.GetInstance():parseTimeFromConfig({
		{
			2021,
			6,
			14
		},
		{
			0,
			0,
			0
		}
	}) <= pg.TimeMgr.GetInstance():GetServerTime()
end

function TaskScene.IsPassScenario()
	local var_6_0 = pg.gameset.task_first_daily_pre_id.key_value
	local var_6_1 = _.select(_.values((getProxy(TaskProxy):getData())), function(arg_7_0)
		return arg_7_0:getConfig("type") == 1
	end)

	if #var_6_1 > 0 then
		table.sort(var_6_1, function(arg_8_0, arg_8_1)
			return arg_8_0.id < arg_8_1.id
		end)

		return var_6_0 < var_6_1[1].id
	else
		return true
	end

	return
end

function TaskScene:didEnter()
	local var_9_0 = TaskCommonPage.New(self.pageTF, self.event, self.contextData)
	local var_9_1 = TaskScene.IsNewStyleTime() and not self.contextData.weekTaskProgressInfo:IsMaximum() and TaskWeekPage.New(self.pageTF, self.event, self.contextData) or var_9_0

	self.emptyPage = TaskEmptyListPage.New(self._tf, self.event)
	self.pages = {
		[TaskScene.PAGE_TYPE_SCENARIO] = var_9_0,
		[TaskScene.PAGE_TYPE_BRANCH] = var_9_0,
		[TaskScene.PAGE_TYPE_ROUTINE] = var_9_0,
		[TaskScene.PAGE_TYPE_WEEKLY] = var_9_1,
		[TaskScene.PAGE_TYPE_ALL] = var_9_0,
		[TaskScene.PAGE_TYPE_ACT] = var_9_0
	}
	self.contextData.ptAwardWindow = TaskPtAwardPage.New(self._tf, self.event, self.contextData)

	onButton(self, self._backBtn, function()
		self:emit(TaskScene.ON_BACK)

		return
	end, SFX_CANCEL)
	setActive(self._tf:Find("stamp"), getProxy(TaskProxy):mingshiTouchFlagEnabled())

	if LOCK_CLICK_MINGSHI then
		setActive(self._tf:Find("stamp"), false)
	end

	onButton(self, self._tf:Find("stamp"), function()
		getProxy(TaskProxy):dealMingshiTouchFlag(5)

		return
	end, SFX_CONFIRM)

	self.toggles = {}

	for iter_9_0, iter_9_1 in pairs(var_0_1) do
		local var_9_2 = self._tagRoot:Find(iter_9_0)

		onToggle(self, var_9_2, function(arg_12_0)
			if arg_12_0 then
				self:UpdatePage(iter_9_0)
			end

			return
		end, SFX_PANEL)

		self.toggles[iter_9_0] = var_9_2
	end

	local var_9_3 = self.toggles[self.contextData.page or TaskScene.PAGE_TYPE_ALL]

	if self.toggles and var_9_3 then
		triggerToggle(var_9_3, true)
	end

	self:UpdateWeekTip()

	return
end

function TaskScene:refreshPage()
	self:UpdatePage(self._currentToggleType)

	return
end

function TaskScene:UpdatePage(arg_14_1)
	local function var_14_0(arg_15_0, arg_15_1)
		if #arg_15_1 <= 0 then
			self.emptyPage:ExecuteAction("ShowOrHide", true)
		elseif #arg_15_1 > 0 and self.emptyPage:GetLoaded() then
			self.emptyPage:ExecuteAction("ShowOrHide", false)
		end

		self:updateOneStepBtn(arg_15_0)

		return
	end

	if self._currentToggleType and self._currentToggleType ~= arg_14_1 then
		self.pages[self._currentToggleType]:ExecuteAction("Hide")
	end

	local var_14_1 = self.pages[arg_14_1]

	self.pages[arg_14_1]:ExecuteAction("Update", arg_14_1, var_0_1[arg_14_1], function(arg_16_0)
		var_14_0(var_14_1, arg_16_0)

		return
	end)

	self._currentToggleType = arg_14_1
	self.contextData.page = arg_14_1

	return
end

function TaskScene:addTask(arg_17_1)
	self.contextData.taskVOsById[arg_17_1.id] = arg_17_1

	self:UpdatePage(self._currentToggleType)

	return
end

function TaskScene:removeTask(arg_18_1)
	self.contextData.taskVOsById[arg_18_1.id] = nil

	self:UpdatePage(self._currentToggleType)

	return
end

function TaskScene:updateTask(arg_19_1)
	self:addTask(arg_19_1)

	return
end

function TaskScene:ResetWeekTaskPage()
	if TaskScene.IsNewStyleTime() and isa(self.pages[TaskScene.PAGE_TYPE_WEEKLY], TaskCommonPage) then
		if self.pages[TaskScene.PAGE_TYPE_WEEKLY]:GetLoaded() and self.pages[TaskScene.PAGE_TYPE_WEEKLY]:isShowing() then
			self.pages[TaskScene.PAGE_TYPE_WEEKLY]:Hide()
		end

		self.pages[TaskScene.PAGE_TYPE_WEEKLY] = TaskWeekPage.New(self.pageTF, self.event, self.contextData)
	end

	self:RefreshWeekTaskPage()

	if self._currentToggleType ~= TaskScene.PAGE_TYPE_WEEKLY then
		self:UpdatePage(self._currentToggleType)
	end

	return
end

function TaskScene:RefreshWeekTaskPage()
	if self._currentToggleType == TaskScene.PAGE_TYPE_WEEKLY then
		self:UpdatePage(self._currentToggleType)
		self:UpdateWeekTip()
	end

	return
end

function TaskScene:RefreshWeekTaskPageBefore(arg_22_1)
	if self._currentToggleType == TaskScene.PAGE_TYPE_WEEKLY then
		self.pages[self._currentToggleType]:RefreshWeekTaskPageBefore(arg_22_1)
	end

	return
end

function TaskScene:RefreshWeekTaskProgress()
	if isa(self.pages[self._currentToggleType], TaskWeekPage) and self.contextData.weekTaskProgressInfo:IsMaximum() then
		self.pages[self._currentToggleType]:Destroy()

		self.pages[TaskScene.PAGE_TYPE_WEEKLY] = self.pages[TaskScene.PAGE_TYPE_SCENARIO]

		self:UpdatePage(TaskScene.PAGE_TYPE_WEEKLY)
	elseif self._currentToggleType == TaskScene.PAGE_TYPE_WEEKLY and isa(self.pages[self._currentToggleType], TaskWeekPage) then
		self.pages[self._currentToggleType]:ExecuteAction("RefreshWeekProgress")
		self:UpdateWeekTip()
	end

	return
end

function TaskScene:UpdateWeekTip()
	local var_24_0 = false

	if TaskScene.IsPassScenario() and TaskScene.IsNewStyleTime() then
		for iter_24_0, iter_24_1 in pairs(self.contextData.taskVOsById) do
			if (iter_24_1:getConfig("type") == 4 or iter_24_1:getConfig("type") == 13) and iter_24_1:isFinish() and not iter_24_1:isReceive() and iter_24_1:ShowOnTaskScene() then
				var_24_0 = true

				break
			end
		end

		if not var_24_0 then
			if self.contextData.weekTaskProgressInfo:CanUpgrade() or self.contextData.weekTaskProgressInfo:AnySubTaskCanSubmit() then
				var_24_0 = true
			end
		end
	end

	setActive(self.weekTip, var_24_0)

	return
end

function TaskScene:GoToFilter(arg_25_1)
	triggerToggle(self._tagRoot:Find(arg_25_1), true)

	return
end

function TaskScene:onSubmit(arg_26_1)
	if self.onShowAwards then
		return
	end

	self:emit(TaskMediator.ON_TASK_SUBMIT, arg_26_1)

	return
end

function TaskScene:onSubmitForWeek(arg_27_1)
	if self.onShowAwards then
		return
	end

	self:emit(TaskMediator.ON_SUBMIT_WEEK_TASK, arg_27_1)

	return
end

function TaskScene:onSubmitForAvatar(arg_28_1)
	if self.onShowAwards then
		return
	end

	self:emit(TaskMediator.ON_SUBMIT_AVATAR_TASK, arg_28_1)

	return
end

function TaskScene:onGo(arg_29_1)
	if self.onShowAwards then
		return
	end

	if isa(arg_29_1, AvatarFrameTask) and arg_29_1:IsActEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	self:emit(TaskMediator.ON_TASK_GO, arg_29_1)

	return
end

function TaskScene:willExit()
	for iter_30_0, iter_30_1 in pairs(self.pages) do
		iter_30_1:Destroy()
	end

	if self.emptyPage then
		self.emptyPage:Destroy()

		self.emptyPage = nil
	end

	self.pages = nil

	self.contextData.ptAwardWindow:Destroy()

	self.contextData.ptAwardWindow = nil
	self.contextData.taskVOsById = nil
	self.contextData.weekTaskProgressInfo = nil
	self.contextData.viewComponent = nil

	return
end

function TaskScene:updateOneStepBtn(arg_31_1)
	arg_31_1 = arg_31_1 or self.pages[self._currentToggleType]

	local var_31_0 = #arg_31_1:GetWaitToCheckList() >= 2

	if var_31_0 then
		onButton(self, self.oneStepBtn, function()
			arg_31_1:ExecuteOneStepSubmit()

			return
		end, SFX_PANEL)
	else
		removeOnButton(self.oneStepBtn)
	end

	setActive(self.oneStepBtn, var_31_0)

	return
end

return TaskScene
