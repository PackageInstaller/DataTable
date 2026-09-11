local SoloChallengeRewardView_1_7 = class("SoloChallengeRewardView_1_7", (import("game.views.soloChallenge.SoloChallengeRewardView")))

function SoloChallengeRewardView_1_7:UIName()
	return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeRewardUI"
end

function SoloChallengeRewardView_1_7:GetRewardItemClass()
	return SoloChallengeRewardItem_1_7
end

return SoloChallengeRewardView_1_7
