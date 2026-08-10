local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("AdvanceTestTeamInfoView", var_0_0)

function var_0_1.GetHeroList(arg_1_0)
	return AdvanceTestData:GetSortedHeroList()
end

return var_0_1
