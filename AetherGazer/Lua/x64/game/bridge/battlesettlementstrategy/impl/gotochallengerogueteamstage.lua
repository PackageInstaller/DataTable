local var_0_0 = class("GotoChallengeRogueTeamStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoChallengeRogueTeamStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoChallengeRogueTeamStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	local function var_2_2()
		local var_3_0 = {}

		manager.story:RemovePlayer()
		;(function()
			JumpTools.OpenPageByJump("/challengeRogueTeamResult", {
				result = arg_2_1,
				rewardList = var_2_0,
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
			EndBattleLogic(arg_2_1)
		end)()
	end

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			var_2_2()
		end
	else
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return var_0_0
