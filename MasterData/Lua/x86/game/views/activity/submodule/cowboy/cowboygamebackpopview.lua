local CowboyGameBackPopView = class("CowboyGameBackPopView", ReduxView)

function CowboyGameBackPopView:UIName()
	return "UI/VolumeIIIUI/VolumeXiugameScoreUI"
end

function CowboyGameBackPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CowboyGameBackPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyGameBackPopView:InitUI()
	self:BindCfgUI()
end

function CowboyGameBackPopView:AddUIListeners()
	self:AddBtnListener(self.okBtn_, nil, function()
		manager.audio:Pause("music", false)
		manager.audio:StopEffect()
		manager.audio:Pause("effect", false)
		JumpTools.OpenPageByJump("/cowboy", {
			activityId = self.mainActivityID_
		})
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		manager.audio:Pause("music", false)
		manager.audio:Pause("effect", false)
		manager.notify:CallUpdateFunc(COWBOY_CONTINUE)
		self:Back()
	end)
end

function CowboyGameBackPopView:OnEnter()
	self.mainActivityID_ = self.params_.mainActivityID
end

function CowboyGameBackPopView:OnExit()
	return
end

function CowboyGameBackPopView:Dispose()
	self:RemoveAllListeners()
	CowboyGameBackPopView.super.Dispose(self)
end

return CowboyGameBackPopView
