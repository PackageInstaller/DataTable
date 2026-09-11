local PolyhedronHeroPropertyPage = class("PolyhedronHeroPropertyPage", HeroPropertyPage)

function PolyhedronHeroPropertyPage:InitUI()
	self:BindCfgUI()

	self.lockController_ = self.controller_:GetController("lock")
	self.favoriteController_ = self.favorBtnController_:GetController("follow")
	self.favoriteShowController_ = self.favorBtnController_:GetController("favor")
	self.detailController_ = self.heroInfoController_:GetController("detail")
	self.heroInfoView_ = PolyhedronHeroInfoView.New(self, self.infoViewGo_)
end

function PolyhedronHeroPropertyPage:CheckLocked()
	self.lockController_:SetSelectedState("true")
end

return PolyhedronHeroPropertyPage
