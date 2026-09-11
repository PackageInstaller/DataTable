NewBattleChallengeFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleChallengeFailedView")

local NewBattleMythicOmegaFailedView = class("NewBattleMythicOmegaFailedView", NewBattleChallengeFailedWithButtonView)

function NewBattleMythicOmegaFailedView:GetRecommendTeam()
	return (MythicData:GetRecommendTeam())
end

return NewBattleMythicOmegaFailedView
