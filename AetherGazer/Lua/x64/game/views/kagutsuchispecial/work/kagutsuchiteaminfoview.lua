local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("KagutsuchiTeamInfoView", var_0_0)

function var_0_1.GetHeroList(arg_1_0)
	local var_1_0 = 1158

	return (HeroTools.Sort({
		[var_1_0] = HeroData:GetHeroData(var_1_0)
	}))
end

return var_0_1
