local ActivityReforgeTaskView = class("ActivityReforgeTaskView", ReduxView)

function ActivityReforgeTaskView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeTaskUI"
end

function ActivityReforgeTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityReforgeTaskView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityReforgeTaskView:InitUI()
	self:BindCfgUI()

	self.controller_ = self.controllerEx_:GetController("isShow")
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityReforgeTaskItem)
end

function ActivityReforgeTaskView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.taskList_[arg_5_1].id)
end

function ActivityReforgeTaskView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshView()
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshView()
	end)
	self:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function()
		self:RefreshView()
	end)
end

function ActivityReforgeTaskView:RefreshView()
	self.taskList_ = TaskData2:GetActivityTaskSortList(self.activityID_)

	self.list_:StartScroll(#self.taskList_)

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self.taskList_) do
		if TaskData2:GetTaskProgress(iter_9_1.id) >= AssignmentCfg[iter_9_1.id].need and not TaskData2:GetTaskComplete(iter_9_1.id) then
			table.insert(var_9_0, iter_9_1.id)
		end
	end

	if #var_9_0 > 0 then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end
end

function ActivityReforgeTaskView:OnExit()
	self:RemoveAllEventListener()
end

function ActivityReforgeTaskView:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in ipairs(self.taskList_) do
			if TaskData2:GetTaskProgress(iter_12_1.id) >= AssignmentCfg[iter_12_1.id].need and not TaskData2:GetTaskComplete(iter_12_1.id) then
				table.insert(var_12_0, iter_12_1.id)
			end
		end

		if #var_12_0 > 0 then
			TaskAction:SubmitTaskList(var_12_0)
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function ActivityReforgeTaskView:Dispose()
	self:RemoveAllEventListener()

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self.super.Dispose(self)
end

return ActivityReforgeTaskView
