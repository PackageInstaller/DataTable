local TetrisGameTaskView = class("TetrisGameTaskView", ReduxView)

function TetrisGameTaskView:UIName()
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameRewardPopup"
end

function TetrisGameTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function TetrisGameTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function TetrisGameTaskView:InitUI()
	self:BindCfgUI()

	self.taskList_ = {}
	self.taskListModule = LimitTaskListModule.New(self.comTaskList_)
	self.awardController = self.controller:GetController("oneClick")
end

function TetrisGameTaskView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.allBtn, nil, function()
		TaskTools:GetAllCanReciveTaskByActivityID(self.params_.activityID)
	end)
end

function TetrisGameTaskView:OnEnter()
	self.taskListModule:OnEnter()

	local var_8_0 = self.params_.activityID

	if self.params_.activityID then
		self.taskListModule:RenderView(self.params_.activityID)
	end

	self:RefreshReciveBtn()
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshReciveBtn()
		self.taskListModule:RenderView(var_8_0)
	end)
	self:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function()
		self:RefreshReciveBtn()
		self.taskListModule:RenderView(var_8_0)
	end)
end

function TetrisGameTaskView:OnTop()
	return
end

function TetrisGameTaskView:RefreshReciveBtn()
	if #TaskTools:GetCanGetActivityTaskList(self.params_.activityID) > 0 then
		self.awardController:SetSelectedState("on")
	else
		self.awardController:SetSelectedState("off")
	end
end

function TetrisGameTaskView:OnExit()
	self.taskListModule:OnExit()
end

function TetrisGameTaskView:Dispose()
	self.taskListModule:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	TetrisGameTaskView.super.Dispose(self)
end

return TetrisGameTaskView
