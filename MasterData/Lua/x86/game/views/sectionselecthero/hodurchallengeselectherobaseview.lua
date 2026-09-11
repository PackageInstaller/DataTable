local HodurChallengeSelectHeroBaseView = class("HodurChallengeSelectHeroBaseView", (import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")))

function HodurChallengeSelectHeroBaseView:OnEnter()
	self:AddEventListener()
	self:ProcessParams()
	self:ProcessSubView()
	self:SubViewOnEnter()
	self:Refresh()
	HodurSystemData:ClearFinalHero()
end

return HodurChallengeSelectHeroBaseView
