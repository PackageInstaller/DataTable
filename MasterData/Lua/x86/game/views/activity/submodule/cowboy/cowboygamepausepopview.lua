local CowboyGamePausePopView = class("CowboyGamePausePopView", ReduxView)

function CowboyGamePausePopView:UIName()
	return "UI/VolumeIIIUI/VolumeXiugameSelectUI"
end

function CowboyGamePausePopView:UIParent()
	return manager.ui.uiPop.transform
end

function CowboyGamePausePopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyGamePausePopView:InitUI()
	self:BindCfgUI()
end

function CowboyGamePausePopView:AddUIListeners()
	self:AddBtnListener(self.quitBtn_, nil, function()
		manager.audio:Pause("music", false)
		manager.audio:StopEffect()
		manager.audio:Pause("effect", false)
		JumpTools.OpenPageByJump("/cowboy", {
			activityId = self.mainActivityID_
		})
	end)
	self:AddBtnListener(self.continueBtn_, nil, function()
		manager.audio:Pause("music", false)
		manager.audio:Pause("effect", false)
		manager.notify:CallUpdateFunc(COWBOY_CONTINUE)
		self:Back()
	end)
end

function CowboyGamePausePopView:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
end

function CowboyGamePausePopView:OnExit()
	return
end

function CowboyGamePausePopView:Dispose()
	self:RemoveAllListeners()
	CowboyGamePausePopView.super.Dispose(self)
end

return CowboyGamePausePopView
