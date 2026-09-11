local SummerWaterSelectHeroView = class("SummerWaterSelectHeroView", (import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")))

function SummerWaterSelectHeroView:OnWaterResult()
	ShowTips("TIME_OVER")
	self:Back()
end

return SummerWaterSelectHeroView
