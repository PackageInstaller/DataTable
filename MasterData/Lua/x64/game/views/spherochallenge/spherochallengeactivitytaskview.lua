local SPHeroChallengeActivityTaskView = class("SPHeroChallengeActivityTaskView", ReduxView)

function SPHeroChallengeActivityTaskView:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeActivityTaskPop"
end

function SPHeroChallengeActivityTaskView:UIParent()
	return manager.ui.uiPop.transform
end

function SPHeroChallengeActivityTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeActivityTaskView:InitUI()
	self:BindCfgUI()

	self.taskList_ = {}
	self.taskListModule = LimitTaskListModule.New(self.comTaskList_)
	self.awardController = self.controller:GetController("award")
end

function SPHeroChallengeActivityTaskView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.allBtn, nil, function()
		TaskTools:GetAllCanReciveTaskByActivityID(self.params_.activityID)
	end)
end

function SPHeroChallengeActivityTaskView:OnEnter()
	self.taskListModule:OnEnter()

	if self.params_.activityID then
		self.taskListModule:RenderView(self.params_.activityID)
	end
end

function SPHeroChallengeActivityTaskView:OnTop()
	self:RefreshReciveBtn()
end

function SPHeroChallengeActivityTaskView:RefreshReciveBtn()
	if #TaskTools:GetCanGetActivityTaskList(self.params_.activityID) > 0 then
		self.awardController:SetSelectedState("show")
	else
		self.awardController:SetSelectedState("close")
	end
end

function SPHeroChallengeActivityTaskView:OnExit()
	self.taskListModule:OnExit()
end

function SPHeroChallengeActivityTaskView:Dispose()
	self.taskListModule:Dispose()
	self:RemoveAllListeners()
	SPHeroChallengeActivityTaskView.super.Dispose(self)
end

return SPHeroChallengeActivityTaskView
