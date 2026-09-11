local ActivitySkinDrawTaskView = class("ActivitySkinDrawTaskView", ReduxView)

function ActivitySkinDrawTaskView:UIName()
	return ActivitySkinDrawTools.GetTaskUIName(self.params_.activityID)
end

function ActivitySkinDrawTaskView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivitySkinDrawTaskView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinDrawTaskView:InitUI()
	self:BindCfgUI()

	self.typeCon_ = self.controller_:GetController("type")
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivitySkinDrawTaskItem)
end

function ActivitySkinDrawTaskView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:Refresh(self.list_[arg_5_1])
end

function ActivitySkinDrawTaskView:AddUIListeners()
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

function ActivitySkinDrawTaskView:OnEnter()
	self:RefreshUI()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshTask))
end

function ActivitySkinDrawTaskView:RefreshUI()
	self:RefreshTask()
end

function ActivitySkinDrawTaskView:RefreshTask()
	self.activityID_ = self.params_.activityID
	self.taskActivityID_ = self.params_.taskActivityID
	self.list_ = TaskData2:GetActivityTaskSortList(self.taskActivityID_)

	self.scrollHelper_:StartScroll(#self.list_)

	if self.list_[1] then
		if self.list_[1].complete_flag == 0 and self.list_[1].progress >= AssignmentCfg[self.list_[1].id].need then
			self.typeCon_:SetSelectedState("true")
		else
			self.typeCon_:SetSelectedState("false")
		end
	else
		self.typeCon_:SetSelectedState("false")
	end
end

function ActivitySkinDrawTaskView:OnTop()
	local var_11_0 = {
		BACK_BAR,
		HOME_BAR
	}
	local var_11_1 = {
		ActivitySkinDrawTools.GetTaskCurrency(self.activityID_)
	}

	table.insertto(var_11_0, var_11_1)
	manager.windowBar:SwitchBar(var_11_0)

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		manager.windowBar:SetBarCanClick(iter_11_1, true)
	end
end

function ActivitySkinDrawTaskView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function ActivitySkinDrawTaskView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivitySkinDrawTaskView
