local HeroClueDetailView_3_6 = class("HeroClueDetailView_3_6", (import("game.views.heroClue.HeroClueDetailView")))

function HeroClueDetailView_3_6:RefreshUI()
	self.nameText_.text = HeroClueCfg[self.clueID_].name
	self.descText_.text = HeroClueCfg[self.clueID_].desc
	self.iconImg_.sprite = pureGetSpriteWithoutAtlas(HeroClueCfg[self.clueID_].icon_path_3)
end

return HeroClueDetailView_3_6
