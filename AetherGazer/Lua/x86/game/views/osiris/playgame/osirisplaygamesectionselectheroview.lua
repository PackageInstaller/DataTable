local var_0_0 = import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")
local var_0_1 = class("OsirisPlayGameSectionSelectHeroView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Formation/Activity_Osiris/Activity_Osiris_FormationMainUI"
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)
end

function var_0_1.OnSectionClickHero(arg_3_0, arg_3_1)
	OsirisPlayGameData:SetHeroDataTypeByPos(arg_3_1 == 1 and 1 or 2)
	arg_3_0.sectionProxy_:GotoHeroInfoUI(arg_3_1)
end

return var_0_1
