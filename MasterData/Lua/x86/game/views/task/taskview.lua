local TaskView = class("TaskView", ReduxView)
local TaskConst = import("game.const.TaskConst")
local TaskTools = import("game.tools.TaskTools")

function TaskView:UIName()
	return "Widget/System/Quest/UIQuest"
end

function TaskView:UIParent()
	return manager.ui.uiMain.transform
end

function TaskView:Init()
	self:BindCfgUI()

	self.taskSwitchView_ = {}
	self.taskContentView_ = {}
	self.taskSwitchView_[TaskConst.TASK_TYPE.DAILY] = TaskSwitchView.New(self.dailyTask_, TaskConst.TASK_TYPE.DAILY)
	self.taskSwitchView_[TaskConst.TASK_TYPE.PLOT] = TaskSwitchView.New(self.plotTask_, TaskConst.TASK_TYPE.PLOT)
	self.taskSwitchView_[TaskConst.TASK_TYPE.WEEK] = TaskSwitchView.New(self.weekTask_, TaskConst.TASK_TYPE.WEEK)

	self.taskSwitchView_[TaskConst.TASK_TYPE.DAILY]:SetBtnFunc(handler(self, self.RefreshSelect))
	self.taskSwitchView_[TaskConst.TASK_TYPE.PLOT]:SetBtnFunc(handler(self, self.RefreshSelect))
	self.taskSwitchView_[TaskConst.TASK_TYPE.WEEK]:SetBtnFunc(handler(self, self.RefreshSelect))

	self.taskViewObj = {
		[TaskConst.TASK_TYPE.DAILY] = "Widget/System/Quest/TaskDailyContentView",
		[TaskConst.TASK_TYPE.WEEK] = "Widget/System/Quest/TaskWeekContentView",
		[TaskConst.TASK_TYPE.PLOT] = "Widget/System/Quest/TaskPlotContentView"
	}
	self.refreshBtnStateHandle = handler(self, self.RefreshOnceBtnState)
	self.oneKeyCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("onekey")

	self:AddBtnListener(self.exploreBtn_, nil, function()
		JumpTools.OpenPageByJump("/adminCatExploreView", nil, ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE)
	end)
	self:AddBtnListener(self.onceBtn_, nil, function()
		self:OnClickOnceBtn()
	end)
end

function TaskView:OnTop()
	self:ShowDefaultBar()
	self:RefreshSelect(self.params_.taskIndex)
end

function TaskView:OnEnter()
	self:AddEventListeners()
	self:RefreshSelect(self.params_.taskIndex)

	for iter_7_0, iter_7_1 in pairs(self.taskSwitchView_) do
		iter_7_1:OnEnter()
	end

	self:BindRedPoint()
end

function TaskView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.noticeContainer_, RedPointConst.EXPLORE_MAIN)
end

function TaskView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.noticeContainer_, RedPointConst.EXPLORE_MAIN)
end

function TaskView:OnMainHomeViewTop()
	for iter_10_0, iter_10_1 in pairs(self.taskContentView_) do
		iter_10_1:ClearCache()
	end
end

function TaskView:OnExit()
	self.selectIndex_ = nil

	self:RemoveAllEventListener()
	self:UnbindRedPoint()

	for iter_11_0, iter_11_1 in pairs(self.taskContentView_) do
		iter_11_1:OnExit()
	end

	for iter_11_2, iter_11_3 in pairs(self.taskSwitchView_) do
		iter_11_3:OnExit()
	end

	manager.windowBar:HideBar()
	self:RecordStay(self.params_.taskIndex)
end

function TaskView:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.taskSwitchView_) do
		iter_12_1:Dispose()
	end

	self.taskSwitchView_ = nil

	for iter_12_2, iter_12_3 in pairs(self.taskContentView_) do
		iter_12_3:Dispose()
	end

	self.taskContentView_ = nil

	TaskView.super.Dispose(self)
end

function TaskView:OnTaskListChange()
	for iter_13_0, iter_13_1 in pairs(self.taskContentView_) do
		if iter_13_1.OnTaskListChange then
			iter_13_1:OnTaskListChange()
		end
	end
end

function TaskView:OnActivityPtUpdate()
	for iter_14_0, iter_14_1 in pairs(self.taskContentView_) do
		if iter_14_1.OnSubActivityPtUpdate then
			iter_14_1:OnSubActivityPtUpdate()
		end
	end
end

function TaskView:RefreshSelect(arg_15_1, arg_15_2)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_DAILY) then
		arg_15_1 = TaskConst.TASK_TYPE.PLOT
	end

	for iter_15_0, iter_15_1 in pairs(self.taskSwitchView_) do
		iter_15_1:SwitchButton(arg_15_1)
	end

	if self.taskContentView_[arg_15_1] == nil and self.taskViewObj[arg_15_1] then
		local var_15_0 = self:InstView(arg_15_1)

		if arg_15_1 == TaskConst.TASK_TYPE.DAILY then
			self.taskContentView_[arg_15_1] = TaskDailyContentView.New(var_15_0, TaskConst.TASK_TYPE.DAILY, ActivityPtConst.TASK_DAILY_ACTIVITY_PT)
		elseif arg_15_1 == TaskConst.TASK_TYPE.PLOT then
			self.taskContentView_[arg_15_1] = TaskPlotContentView.New(var_15_0)
		elseif arg_15_1 == TaskConst.TASK_TYPE.WEEK then
			self.taskContentView_[arg_15_1] = TaskWeekContentView.New(var_15_0, TaskConst.TASK_TYPE.WEEK, ActivityPtConst.TASK_WEEK_ACTIVITY_PT)
		end

		self.taskContentView_[arg_15_1]:RegisterRefreshOnceStateCallback(self.refreshBtnStateHandle)
	end

	if self.selectIndex_ == arg_15_1 then
		return
	end

	self.selectIndex_ = arg_15_1

	for iter_15_2, iter_15_3 in pairs(self.taskContentView_) do
		if iter_15_2 == arg_15_1 then
			self.params_.taskIndex = arg_15_1
		else
			self:RecordStay(iter_15_2)
		end

		if iter_15_3 then
			iter_15_3:Show(iter_15_2 == arg_15_1, arg_15_2)
		end
	end
end

function TaskView:AddEventListeners()
	self:RegistEventListener(PLAYER_LEVEL_UP, handler(self, self.OnLevelUp))
end

function TaskView:OnLevelUp()
	local var_17_0 = PlayerData:GetlevelUpInfos()

	if var_17_0 and #var_17_0 > 0 then
		self.levelUpTimer_ = self.levelUpTimer_ or Timer.New(function()
			PlayerAction.LevelUpFinish()
			JumpTools.OpenPageByJump("levelUp", {
				levelUpInfoList = var_17_0
			})

			self.levelUpTimer_ = nil
		end, 0.2, 0)

		self.levelUpTimer_:Start()
	end
end

function TaskView:RecordStay(arg_19_1)
	local var_19_0 = self:GetStayTime()

	if var_19_0 == 0 then
		return
	end

	local var_19_1 = 0

	if arg_19_1 == TaskConst.TASK_TYPE.DAILY then
		var_19_1 = 10801
	elseif arg_19_1 == TaskConst.TASK_TYPE.PLOT then
		var_19_1 = 10802
	end

	OperationRecorder.RecordStayView("STAY_VIEW_TASK", var_19_0, var_19_1)
	self:UpdateLastOpenTime()
end

function TaskView:InstView(arg_20_1)
	return Object.Instantiate(Asset.Load(self.taskViewObj[arg_20_1]), self.pageContainer_)
end

function TaskView:OnClickOnceBtn()
	if self.taskContentView_[self.selectIndex_] then
		self.taskContentView_[self.selectIndex_]:OnOnceClick()
	end
end

function TaskView:RefreshOnceBtnState(arg_22_1)
	self.oneKeyCon_:SetSelectedState(arg_22_1 and "true" or "false")
end

return TaskView
