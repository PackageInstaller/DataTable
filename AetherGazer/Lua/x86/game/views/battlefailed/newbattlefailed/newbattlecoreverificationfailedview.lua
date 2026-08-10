NewBattleChallengeFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleChallengeFailedWithButtonView")

local var_0_0 = class("NewBattleCoreVerificationFailedView", NewBattleChallengeFailedWithButtonView)

function var_0_0.GetRecommendTeam(arg_1_0)
	local var_1_0 = arg_1_0.stageData_.infoID

	return CoreVerificationInfoCfg[var_1_0].recommend_team
end

return var_0_0
