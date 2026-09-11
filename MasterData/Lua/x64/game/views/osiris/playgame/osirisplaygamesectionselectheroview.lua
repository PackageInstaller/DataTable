local OsirisPlayGameSectionSelectHeroView = class("OsirisPlayGameSectionSelectHeroView", (import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")))

function OsirisPlayGameSectionSelectHeroView:UIName()
	return "Widget/System/Formation/Activity_Osiris/Activity_Osiris_FormationMainUI"
end

function OsirisPlayGameSectionSelectHeroView:OnEnter()
	OsirisPlayGameSectionSelectHeroView.super.OnEnter(self)
end

function OsirisPlayGameSectionSelectHeroView:OnSectionClickHero(arg_3_1)
	OsirisPlayGameData:SetHeroDataTypeByPos(arg_3_1 == 1 and 1 or 2)
	self.sectionProxy_:GotoHeroInfoUI(arg_3_1)
end

return OsirisPlayGameSectionSelectHeroView
