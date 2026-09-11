local CowboyGameOverView = class("CowboyGameOverView", ReduxView)

function CowboyGameOverView:UIName()
	return "UI/VolumeIIIUI/VolumeXiuGameSettlementUI"
end

function CowboyGameOverView:UIParent()
	return manager.ui.uiPop.transform
end

function CowboyGameOverView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyGameOverView:InitUI()
	self:BindCfgUI()

	self.scoreCon_ = ControllerUtil.GetController(self.transform_, "score")
end

function CowboyGameOverView:AddUIListeners()
	self:AddBtnListener(self.leaveBtn_, nil, function()
		JumpTools.OpenPageByJump("/cowboy", {
			activityId = self.mainActivityID_
		})
	end)
	self:AddBtnListener(self.onceMoreBtn_, nil, function()
		JumpTools.OpenPageByJump("/cowboyGame", {
			mainActivityID = self.mainActivityID_,
			activityID = self.activityID_
		})
		manager.notify:CallUpdateFunc(COWBOY_RESTART)
	end)
end

function CowboyGameOverView:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function CowboyGameOverView:RefreshUI()
	local var_9_0 = CowboyData:GetHistoryScore(self.activityID_)

	if var_9_0 >= self.params_.score then
		self.highest_.text = var_9_0

		self.scoreCon_:SetSelectedState("normal")
	else
		CowboyData:SetScore(self.activityID_, self.params_.score)

		self.highest_.text = self.params_.score

		self.scoreCon_:SetSelectedState("new")
	end

	self.score_.text = self.params_.score
end

function CowboyGameOverView:OnExit()
	manager.audio:Pause("music", false)
	manager.audio:Stop("music", true)
end

function CowboyGameOverView:Dispose()
	self:RemoveAllListeners()
	CowboyGameOverView.super.Dispose(self)
end

return CowboyGameOverView
