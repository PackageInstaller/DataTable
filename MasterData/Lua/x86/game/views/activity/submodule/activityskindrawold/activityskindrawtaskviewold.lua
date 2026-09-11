local ActivitySkinDrawTaskViewOld = class("ActivitySkinDrawTaskViewOld", ReduxView)

function ActivitySkinDrawTaskViewOld:UIName()
	return ActivitySkinDrawToolsOld.GetTaskUIName(self.params_.activityID)
end

function ActivitySkinDrawTaskViewOld:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySkinDrawTaskViewOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawTaskViewOld:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivitySkinDrawTaskItemOld)
end

function ActivitySkinDrawTaskViewOld:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:Refresh(self.list_[arg_5_1])
end

function ActivitySkinDrawTaskViewOld:AddUIListeners()
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(self.list_) do
			if iter_7_1.complete_flag < 1 and iter_7_1.progress >= AssignmentCfg[iter_7_1.id].need then
				table.insert(var_7_0, iter_7_1.id)
			end
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
end

function ActivitySkinDrawTaskViewOld:OnEnter()
	self:RefreshUI()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshTask))
end

function ActivitySkinDrawTaskViewOld:RefreshUI()
	self:RefreshTask()
end

function ActivitySkinDrawTaskViewOld:RefreshTask()
	self.activityID_ = self.params_.activityID
	self.taskActivityID_ = self.params_.taskActivityID
	self.list_ = TaskData2:GetActivityTaskSortList(self.taskActivityID_)

	self.scrollHelper_:StartScroll(#self.list_)
end

function ActivitySkinDrawTaskViewOld:OnTop()
	local var_11_0 = {
		BACK_BAR,
		HOME_BAR
	}
	local var_11_1 = ActivitySkinDrawToolsOld.GetTaskCurrency(self.activityID_)

	table.insertto(var_11_0, var_11_1)
	manager.windowBar:SwitchBar(var_11_0)

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		manager.windowBar:SetBarCanClick(iter_11_1, true)
	end
end

function ActivitySkinDrawTaskViewOld:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function ActivitySkinDrawTaskViewOld:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivitySkinDrawTaskViewOld
