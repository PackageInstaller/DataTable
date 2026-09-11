local EatSnakesTaskView = class("EatSnakesTaskView", ReduxView)

function EatSnakesTaskView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_3_10_SnakegameUI/SandPlay_3_10_SnakegameRewardPopUI"
end

function EatSnakesTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function EatSnakesTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EatSnakesTaskView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.taskList_, EatSnakeTaskItem)
	self.controller = self.controllers_:GetController("oneclick")
end

function EatSnakesTaskView:AddUIListener()
	self:AddBtnListener(self.oneClickBtn_, nil, function()
		local var_6_0 = TaskTools:GetCanGetActivityTaskList(self.activityId)

		if #var_6_0 <= 0 then
			return
		end

		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			table.insert(var_6_1, iter_6_1.id)
		end

		TaskAction:SubmitTaskList(var_6_1)
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function EatSnakesTaskView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.normalTaskList[arg_8_1], arg_8_1, self.activityId)
end

function EatSnakesTaskView:OnEnter()
	self:UpdateData()
	self:UpdateView()
end

function EatSnakesTaskView:UpdateData()
	self.stageData = EatSnakeData:GetDataByPara("stageList")
	self.activityId = self.params_.activityId

	self:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		self:UpdateView()
		EatSnakeAction.UpdateRewardRedPoint()
	end)
end

function EatSnakesTaskView:UpdateView()
	self.normalTaskList = TaskData2:GetActivityTaskSortList(self.activityId)

	self.controller:SetSelectedState(self:GetControllerState())
	self.list:StartScroll(#self.normalTaskList)
end

function EatSnakesTaskView:GetControllerState()
	for iter_13_0, iter_13_1 in pairs((TaskTools:GetActivityTaskList(self.activityId))) do
		if TaskData2:GetTaskProgress(iter_13_0) >= AssignmentCfg[iter_13_0].need and not TaskData2:GetTaskComplete(iter_13_0) then
			return "show"
		end
	end

	return "hide"
end

function EatSnakesTaskView:OnExit()
	self:RemoveAllEventListener()
end

function EatSnakesTaskView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function EatSnakesTaskView:Dispose()
	EatSnakesTaskView.super.Dispose(self)

	if self.list then
		self.list:Dispose()

		self.list = nil
	end
end

return EatSnakesTaskView
