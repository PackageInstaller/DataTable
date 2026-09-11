local OathBookLoadingView = class("OathBookLoadingView", ReduxView)

function OathBookLoadingView:UIName()
	return "Widget/System/Hero_Oath/OathCommon/HeroOathLoadingPopUI"
end

function OathBookLoadingView:UIParent()
	return manager.ui.uiPop.transform
end

function OathBookLoadingView:Init()
	self:BindCfgUI()
	self:AddUIListeners()
end

function OathBookLoadingView:AddUIListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:GotoBook()
	end)
end

function OathBookLoadingView:Dispose()
	self.super.Dispose(self)
	self:RemoveAllListeners()
end

function OathBookLoadingView:OnEnter()
	self.heroID = self.params_.heroID
	self.sprite = self.params_.sprite

	self:RefreshUI()
	self:AddAniTimer()
end

function OathBookLoadingView:RefreshUI()
	self.adminImg_.sprite = OathTools.GetOathHeadSprite(OathConst.OATH_ADMIN_ID)
	self.roleImg_.sprite = OathTools.GetOathHeadSprite(WeddingCfg[self.heroID].skin_id)
end

function OathBookLoadingView:DelAniTimer()
	if self.anitimer then
		self.anitimer:Stop()

		self.anitimer = nil
	end
end

function OathBookLoadingView:AddAniTimer()
	self:DelAniTimer()

	self.anitimer = Timer.New(function()
		if self.ani_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self:GotoBook()
		end
	end, 0.1, -1)

	self.anitimer:Start()
end

function OathBookLoadingView:GotoBook()
	self:Back()
	JumpTools.OpenPageByJump("/oathBookView", {
		heroID = self.heroID,
		sprite = self.sprite
	})
end

function OathBookLoadingView:OnExit()
	self:DelAniTimer()
end

return OathBookLoadingView
