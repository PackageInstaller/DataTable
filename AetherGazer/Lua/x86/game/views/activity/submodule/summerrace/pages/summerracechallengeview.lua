local var_0_0 = import("game.views.activity.Submodule.SummerRace.Pages.SummerRaceModifyView")
local var_0_1 = class("SummerRaceChallengeView", var_0_0)
local var_0_2 = "challenge"

function var_0_1.GetForcedEntryPanelType(arg_1_0)
	return var_0_2
end

function var_0_1.BuildChallengePanelModel(arg_2_0)
	return SummerRaceData:GetChallengePageModel()
end

function var_0_1.BuildInfoPanelModel(arg_3_0)
	return arg_3_0:BuildChallengePanelModel()
end

function var_0_1.ApplyInfoPanelModel(arg_4_0, arg_4_1)
	arg_4_0.battleInfoView_:ApplyChallengeModel(arg_4_1)
end

function var_0_1.HandleChallengeBattleStart(arg_5_0)
	SummerRaceAction.EnterChallengeBattle(var_0_2)
end

return var_0_1
