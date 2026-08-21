local var_0_0 = import("game.views.heroTeamInfo.SectionHeroTeamHeadItem")
local var_0_1 = class("OsirisPlayGameSectionHeroTeamHeadItem", var_0_0)

function var_0_1.InitProxy(arg_1_0)
	arg_1_0.super.InitProxy(arg_1_0)

	arg_1_0.osirisController_ = arg_1_0.sectionController_:GetController("Osiris")
end

function var_0_1.SetOsiris(arg_2_0, arg_2_1)
	arg_2_0.osirisController_:SetSelectedIndex(arg_2_1 and 1 or 0)
end

return var_0_1
