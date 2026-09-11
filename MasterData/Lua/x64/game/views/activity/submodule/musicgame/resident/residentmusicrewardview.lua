local ResidentMusicRewardView = class("ResidentMusicRewardView", ReduxView)

function ResidentMusicRewardView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_MusicUI/Acitvity_MusicRewardUI"
end

function ResidentMusicRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function ResidentMusicRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ResidentMusicRewardView:InitUI()
	self:BindCfgUI()

	self.taskListModule = LimitTaskListModule.New(self.m_list, MusicTaskItem)
	self.oneClickController = self.controller_:GetController("OneClick")

	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function()
		self:RefreshReciveBtn()
		self.taskListModule:RenderView(self.activityID)
	end)
	self:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function()
		self:RefreshReciveBtn()
		self.taskListModule:RenderView(self.activityID)
	end)
end

function ResidentMusicRewardView:AddUIListener()
	self:AddBtnListener(self.m_mask, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.onegetBtn_, nil, function()
		TaskTools:GetAllCanReciveTaskByActivityID(self.activityID)
	end)
end

function ResidentMusicRewardView:OnEnter()
	self.taskListModule:OnEnter()

	self.activityID = self.params_.activity_id

	if self.activityID then
		self.taskListModule:RenderView(self.activityID)
	end

	self:RefreshReciveBtn()
end

function ResidentMusicRewardView:OnTop()
	manager.windowBar:SwitchBar({})
end

function ResidentMusicRewardView:RefreshReciveBtn()
	if #TaskTools:GetCanGetActivityTaskList(self.activityID) > 0 then
		self.oneClickController:SetSelectedState("state1")
	else
		self.oneClickController:SetSelectedState("state0")
	end
end

function ResidentMusicRewardView:OnExit()
	self.taskListModule:OnExit()
	manager.windowBar:HideBar()
end

function ResidentMusicRewardView:OnExitInput()
	JumpTools.Back()

	return true
end

function ResidentMusicRewardView:Dispose()
	self.taskListModule:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	ResidentMusicRewardView.super.Dispose(self)
end

return ResidentMusicRewardView
