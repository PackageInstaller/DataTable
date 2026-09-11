local OsirisPlayGameSectionHeroTeamHeadItem = class("OsirisPlayGameSectionHeroTeamHeadItem", (import("game.views.heroTeamInfo.SectionHeroTeamHeadItem")))

function OsirisPlayGameSectionHeroTeamHeadItem:InitProxy()
	self.super.InitProxy(self)

	self.osirisController_ = self.sectionController_:GetController("Osiris")
end

function OsirisPlayGameSectionHeroTeamHeadItem:SetOsiris(arg_2_1)
	self.osirisController_:SetSelectedIndex(arg_2_1 and 1 or 0)
end

return OsirisPlayGameSectionHeroTeamHeadItem
