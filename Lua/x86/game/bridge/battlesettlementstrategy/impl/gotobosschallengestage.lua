local var_0_0 = class("GotoBossChallengeStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.stageData:GetType()

	if var_1_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
		arg_1_0:GotoNormalBossChallenge(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
	elseif var_1_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
		arg_1_0:GotoAdvanceBossChallenge(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
	end
end

function var_0_0.GotoNormalBossChallenge(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	function BattleCallLuaCallBack()
		if isSuccess(arg_2_1) then
			JumpTools.OpenPageByJump("/battleBossChallengeResult", {
				result = arg_2_1,
				rewardList = {},
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
		else
			JumpTools.OpenPageByJump("/battlefailedBossChallengeStage", {
				stageData = arg_2_2,
				battleResult = arg_2_4
			})
		end

		EndBattleLogic(arg_2_1)
	end
end

function var_0_0.GotoAdvanceBossChallenge(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0, var_4_1 = GetResultReward()

	function BattleCallLuaCallBack()
		if isSuccess(arg_4_1) then
			gameContext:Go("/battleScorResult", {
				stageData = arg_4_2,
				rewardList = var_4_1,
				battleResult = arg_4_4
			})
		else
			JumpTools.OpenPageByJump("/battlefailedBossChallengeStage", {
				stageData = arg_4_2,
				battleResult = arg_4_4
			})
		end

		EndBattleLogic(arg_4_1)
	end
end

return var_0_0
