local var_0_0 = class("GotoRaceTrialStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoRaceTrial(arg_1_1)
end

function var_0_0.GotoRaceTrial(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.num
	local var_2_1 = arg_2_1.stageData
	local var_2_2 = arg_2_1.starMissionData
	local var_2_3 = arg_2_1.battleResult

	if arg_2_1.isHalfWay_ == true then
		var_2_0 = 3
	end

	local var_2_4, var_2_5 = GetResultReward()

	if isSuccess(var_2_0) then
		function BattleCallLuaCallBack()
			local var_3_0 = var_2_1:GetStageId()
			local var_3_1 = RaceTrialData:GetBattleResultGoal(var_3_0)
			local var_3_2 = var_2_1:GetActivityID()
			local var_3_3 = ActivityTools.GetActivityTheme(var_3_2)

			gameContext:Go("/battleScorResult", {
				stageData = var_2_1,
				rewardList = var_2_5,
				score = var_3_1,
				battleResult = var_2_3
			})
			EndBattleLogic(var_2_0)
		end
	else
		arg_2_0:GotoBattleFaild(var_2_0, var_2_1, var_2_2, var_2_3)
	end
end

return var_0_0
