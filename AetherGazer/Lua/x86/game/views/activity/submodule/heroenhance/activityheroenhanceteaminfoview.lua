local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("ActivityHeroEnhanceTeamInfoView", var_0_0)

function var_0_1.GetHeroList(arg_1_0)
	local var_1_0 = arg_1_0.params_.heroEnhance_CfgID
	local var_1_1 = ActivityHeroEnhanceCfg[var_1_0].hero_id

	return (HeroTools.Sort({
		[var_1_1] = HeroData:GetHeroData(var_1_1)
	}))
end

return var_0_1
