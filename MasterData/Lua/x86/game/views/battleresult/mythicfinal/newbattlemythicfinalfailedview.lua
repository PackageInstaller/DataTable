NewBattleChallengeFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleChallengeFailedView")

local NewBattleMythicFinalFailedView = class("NewBattleMythicFinalFailedView", NewBattleChallengeFailedView)

function NewBattleMythicFinalFailedView:GetRecommendTeam()
	return (MythicData:GetRecommendTeam())
end

return NewBattleMythicFinalFailedView
