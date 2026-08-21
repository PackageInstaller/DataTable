local var_0_0 = class("BattleRogueTeamResultDropPanel", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Activity_Roulike/item/RoguelikeResultPanel"), arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = ChallengeRogueTeamData:GetBattleResultData()
	local var_5_1 = var_5_0[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.TREASURE_CNT]

	arg_5_0.treasureCntText_.text = var_5_1

	SetActive(arg_5_0.treasureGo_, var_5_1 > 0)

	local var_5_2 = var_5_0[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.RELIC_CNT]

	arg_5_0.relicCntText_.text = var_5_2

	SetActive(arg_5_0.relicGo_, var_5_2 > 0)

	local var_5_3 = var_5_0[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.GOLD_CNT]

	arg_5_0.goldCntText_.text = var_5_3

	SetActive(arg_5_0.goldGo_, var_5_3 > 0)
end

return var_0_0
