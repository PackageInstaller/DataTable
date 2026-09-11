local SummerRaceChallengeView = class("SummerRaceChallengeView", (import("game.views.activity.Submodule.SummerRace.Pages.SummerRaceModifyView")))
local var_0_1 = "challenge"

function SummerRaceChallengeView:GetForcedEntryPanelType()
	return var_0_1
end

function SummerRaceChallengeView:BuildChallengePanelModel()
	return SummerRaceData:GetChallengePageModel()
end

function SummerRaceChallengeView:BuildInfoPanelModel()
	return self:BuildChallengePanelModel()
end

function SummerRaceChallengeView:ApplyInfoPanelModel(arg_4_1)
	self.battleInfoView_:ApplyChallengeModel(arg_4_1)
end

function SummerRaceChallengeView:HandleChallengeBattleStart()
	SummerRaceAction.EnterChallengeBattle(var_0_1)
end

return SummerRaceChallengeView
