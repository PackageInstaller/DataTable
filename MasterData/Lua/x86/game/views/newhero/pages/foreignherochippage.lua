local ForeignHeroChipPage = class("ForeignHeroChipPage", (import("game.views.newHero.pages.HeroChipPage")))

function ForeignHeroChipPage:GetChipIDList()
	return ForeignInfoData:GetHeroData(self.heroInfo_.id).using_hero_chip
end

return ForeignHeroChipPage
