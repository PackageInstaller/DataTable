local var_0_0 = class("GotoEquipSeizureScoreStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoEquipSeizureScoreStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoEquipSeizureScoreStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if arg_2_5 == true then
		arg_2_1 = 3
	end

	local var_2_0, var_2_1 = GetResultReward()
	local var_2_2 = EquipSeizureData:GetResultScore()

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleScorResult", {
				stageData = arg_2_2,
				rewardList = var_2_1,
				score = var_2_2,
				battleResult = arg_2_4
			})
			EndBattleLogic(arg_2_1)
		end
	else
		function BattleCallLuaCallBack()
			gameContext:Go("/battlefailedEquipSeizure", {
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				rewardList = var_2_1,
				score = var_2_2,
				battleResult = arg_2_4
			})
			EndBattleLogic(arg_2_1)
		end
	end
end

return var_0_0
