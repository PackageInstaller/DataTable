local CowboyReadyView = class("CowboyReadyView", ReduxView)

function CowboyReadyView:UIName()
	return "UI/VolumeIIIUI/VolumeSignXiuGmaeUI"
end

function CowboyReadyView:UIParent()
	return manager.ui.uiPop.transform
end

function CowboyReadyView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyReadyView:InitUI()
	self:BindCfgUI()
end

function CowboyReadyView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		CowboyData:SetLastLevel(self.mainActivityID_, self.activityID_)
		JumpTools.OpenPageByJump("/cowboyGame", {
			mainActivityID = self.mainActivityID_,
			activityID = self.activityID_
		})
	end)
end

function CowboyReadyView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.mainActivityID_ = self.params_.mainActivityID

	self:RefreshUI()
end

function CowboyReadyView:RefreshUI()
	self.title_.text = string.format(GetTips("ACTIVITY_COWBOY_ROUND"), self.params_.index)
end

function CowboyReadyView:OnExit()
	return
end

function CowboyReadyView:Dispose()
	self:RemoveAllListeners()
	CowboyReadyView.super.Dispose(self)
end

return CowboyReadyView
