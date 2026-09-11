local ActivityNoobTaskView = class("ActivityNoobTaskView", ReduxView)
local var_0_1 = 601

function ActivityNoobTaskView:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Activitynewbie/NewbieTaskUI_new"), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:BindCfgUI()

	self.taskItemList_ = LuaList.New(handler(self, self.RefreshTaskItem), self.taskItemScroll_, ActivityNoobTaskItem)
	self.phaseList_ = LuaList.New(handler(self, self.RefreshPhaseItem), self.phaseItemScroll_, ActivityNoobPhaseItem)
	self.progressList_ = LuaList.New(handler(self, self.RefreshProgressItem), self.progressItemScroll_, ActivityNoobTaskProgressItem)
	self.noobTaskUpdateHandler_ = handler(self, self.NoobTaskUpdate)
	self.clickPhaseHandler_ = handler(self, self.OnClickPhase)
	self.AccumulateReceiveHandler_ = handler(self, self.OnNoobAccumulateReceive)
	self.onSubmitTaskResponseHandle_ = handler(self, self.onSubmitTaskResponse)

	manager.notify:RegistListener(NEWBIE_TASK_UPDATE, self.noobTaskUpdateHandler_)
	manager.notify:RegistListener(NOOB_ACCUMULATE_RECEIVE, self.AccumulateReceiveHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskResponseHandle_)
	self:InitUI()
	self:AddUIListener()
end

function ActivityNoobTaskView:Dispose()
	manager.notify:RemoveListener(NEWBIE_TASK_UPDATE, self.noobTaskUpdateHandler_)
	manager.notify:RemoveListener(NOOB_ACCUMULATE_RECEIVE, self.AccumulateReceiveHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.onSubmitTaskResponseHandle_)
	self.taskItemList_:Dispose()

	self.taskItemList_ = nil

	self.phaseList_:Dispose()

	self.phaseList_ = nil

	self.progressList_:Dispose()

	self.progressList_ = nil
	self.noobTaskUpdateHandler_ = nil
	self.clickPhaseHandler_ = nil
	self.AccumulateReceiveHandler_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil

	ActivityNoobTaskView.super.Dispose(self)
end

function ActivityNoobTaskView:InitUI()
	self.allReceiveController_ = ControllerUtil.GetController(self.transform_, "name")
end

function ActivityNoobTaskView:AddUIListener()
	self:AddBtnListener(self.receiveAllBtn_, nil, function()
		TaskAction:SubmitTaskList(TaskTools:GetNoobReadyList(self.taskType_, self.curPhase_), var_0_1)
	end)
end

function ActivityNoobTaskView:onSubmitTaskResponse()
	ActivityNoobAction.RefreshAccumulateRedPoint()
	manager.notify:Invoke(NEWBIE_TASK_UPDATE)
end

function ActivityNoobTaskView:SetIsBack(arg_7_1)
	self.isBack = arg_7_1
end

function ActivityNoobTaskView:SetData()
	if not self.isBack then
		self.curPhase_ = self:GetCurPhase()

		ActivityNoobData:CacheSelectedPhase(self.curPhase_)
	else
		self.curPhase_ = ActivityNoobData:GetSelectedPhase()
	end

	self.taskType_ = NoobVersionCfg[ActivityNewbieTools.GetVersionID()].noob_task_type
	self.isBack = false

	self:NoobTaskUpdate()
end

function ActivityNoobTaskView:RefreshPhase()
	self.phaseList_:StartScroll(#TaskTools:GetNoobPhaseTask(self.taskType_), self.curPhase_)
end

function ActivityNoobTaskView:GetCurPhase()
	local var_10_0 = ActivityNoobData:GetUnlockPhase()

	for iter_10_0 = 1, var_10_0 do
		for iter_10_1, iter_10_2 in pairs((TaskData2:GetSortedPhaseTaskList(self.taskType_, iter_10_0))) do
			if AssignmentCfg[iter_10_2.id].need > iter_10_2.progress or iter_10_2.complete_flag == 0 then
				return iter_10_0
			end
		end
	end

	return var_10_0
end

function ActivityNoobTaskView:RefreshPhaseItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.taskType_, arg_11_1)
	arg_11_2:SetClickHandler(self.clickPhaseHandler_)
	arg_11_2:SetSelect(self.curPhase_)
end

function ActivityNoobTaskView:OnClickPhase(arg_12_1)
	if self.curPhase_ == arg_12_1 then
		return
	end

	self.curPhase_ = arg_12_1

	ActivityNoobData:CacheSelectedPhase(self.curPhase_)
	self:RefreshTask()
	self:RefreshRecivedAll()

	for iter_12_0, iter_12_1 in pairs((self.phaseList_:GetItemList())) do
		iter_12_1:SetSelect(arg_12_1)
	end
end

function ActivityNoobTaskView:RefreshTask()
	self.taskList_ = TaskTools:GetNoobTaskSortList(self.taskType_, self.curPhase_)

	self.taskItemList_:StartScroll(#self.taskList_)
end

function ActivityNoobTaskView:RefreshTaskItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.taskList_[arg_14_1].id)
end

function ActivityNoobTaskView:RefreshProgress(arg_15_1)
	local var_15_0 = TaskTools:GetNoobCompletedList(self.taskType_)
	local var_15_1 = 0

	for iter_15_0 = 1, ActivityNoobData:GetUnlockPhase() do
		var_15_1 = var_15_1 + (var_15_0[iter_15_0] or 0)
	end

	self.progressCfg_ = ActivityNewbieTools.GetNoobPorgressRewardList()
	self.completedTaskNum_ = var_15_1
	self.progressText_.text = string.format("%s/%s", self.completedTaskNum_, self.progressCfg_[#self.progressCfg_][1])

	if arg_15_1 == true then
		self.progressList_:Refresh()
	else
		self.progressList_:StartScroll(#self.progressCfg_)
	end
end

function ActivityNoobTaskView:RefreshProgressItem(arg_16_1, arg_16_2)
	arg_16_2:SetData(arg_16_1, self.progressCfg_[arg_16_1], self.completedTaskNum_)
end

function ActivityNoobTaskView:RefreshRecivedAll()
	if #TaskTools:GetNoobReadyList(self.taskType_, self.curPhase_) > 0 then
		self.allReceiveController_:SetSelectedState("true")
	else
		self.allReceiveController_:SetSelectedState("false")
	end
end

function ActivityNoobTaskView:OnNoobAccumulateReceive()
	self:RefreshProgress(true)
end

function ActivityNoobTaskView:SetActive(arg_19_1)
	SetActive(self.gameObject_, arg_19_1)
end

function ActivityNoobTaskView:NoobTaskUpdate()
	self:RefreshTask()
	self:RefreshProgress()
	self:RefreshPhase()
	self:RefreshRecivedAll()
end

return ActivityNoobTaskView
