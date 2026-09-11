local SectionHeroInfoView = class("SectionHeroInfoView", (import("game.views.newHero.HeroInfoView")))

function SectionHeroInfoView:UpdateModuleView()
	SetActive(self.moduleView_.gameObject, false)
end

function SectionHeroInfoView:UpdateUnlockBtnState()
	self.levelStateController_:SetSelectedState("maxLevel")
end

return SectionHeroInfoView
