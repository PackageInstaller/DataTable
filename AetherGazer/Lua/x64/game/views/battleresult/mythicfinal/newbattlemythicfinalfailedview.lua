NewBattleChallengeFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleChallengeFailedView")

local var_0_0 = class("NewBattleMythicFinalFailedView", NewBattleChallengeFailedView)

function var_0_0.GetRecommendTeam(arg_1_0)
	return (MythicData:GetRecommendTeam())
end

return var_0_0
