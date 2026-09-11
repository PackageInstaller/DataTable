local HeroClueTaskView = class("HeroClueTaskView", ReduxView)

function HeroClueTaskView:UIName()
	return HeroClueTools.GetTaskViewUIName(self.params_.activityID)
end

function HeroClueTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function HeroClueTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroClueTaskView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, HeroClueTaskItem)
	self.taskUpdateHandler_ = handler(self, self.UpdateData)
	self.allReceiveController_ = self.controllerEx_:GetController("all")
end

function HeroClueTaskView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		TaskTools:GetAllCanReciveTaskByActivityID(self.taskActivityID_)
	end)
end

function HeroClueTaskView:OnEnter()
	self.taskActivityID_ = self.params_.activityID
	self.mainActivityID_ = self.params_.mainActivityID

	self:RefreshUI()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
end

function HeroClueTaskView:OnExit()
	self:RemoveAllEventListener()
end

function HeroClueTaskView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	HeroClueTaskView.super.Dispose(self)
end

function HeroClueTaskView:RefreshUI()
	self.taskDataList_ = TaskData2:GetActivityTaskSortList(self.taskActivityID_)

	self.scrollHelper_:StartScroll(#self.taskDataList_)

	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(self.taskDataList_) do
		if iter_11_1.progress >= AssignmentCfg[iter_11_1.id].need and TaskData2:GetTaskComplete(iter_11_1.id) then
			var_11_0 = var_11_0 + 1
		end
	end

	self.progressText_.text = string.format("%s/%s", var_11_0, #self.taskDataList_)

	self:RefreshAllReceive()
end

function HeroClueTaskView:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.taskDataList_[arg_12_1].id, self.taskActivityID_, arg_12_1)
end

function HeroClueTaskView:UpdateData()
	self:RefreshUI()
	HeroClueAction.UpdateDrawRedPoint(self.mainActivityID_)
end

function HeroClueTaskView:RefreshAllReceive()
	self.allReceiveController_:SetSelectedState(tostring(#TaskTools:GetCanGetActivityTaskList(self.taskActivityID_) > 0))
end

return HeroClueTaskView
