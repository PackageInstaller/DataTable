local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("HeroTeamInfoAttributeArenaView", var_0_0)

function var_0_1.GetTrialHeroList(arg_1_0)
	return AttributeArenaTools.GetTrialHeroList(arg_1_0.params_.attribute_arena_id)
end

return var_0_1
