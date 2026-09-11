local GotoRaceTrialStage = class("GotoRaceTrialStage", BattleSettlementStrategyBase)

function GotoRaceTrialStage:OnGotoSettlement(arg_1_1)
	self:GotoRaceTrial(arg_1_1)
end

function GotoRaceTrialStage:GotoRaceTrial(arg_2_1)
	local var_2_0 = arg_2_1.num
	local var_2_1 = arg_2_1.stageData
	local var_2_2 = arg_2_1.battleResult

	if arg_2_1.isHalfWay_ == true then
		var_2_0 = 3
	end

	local var_2_3, var_2_4 = GetResultReward()

	if isSuccess(var_2_0) then
		function BattleCallLuaCallBack()
			local var_3_0 = ActivityTools.GetActivityTheme((var_2_1:GetActivityID()))

			gameContext:Go("/battleScorResult", {
				stageData = var_2_1,
				rewardList = var_2_4,
				score = RaceTrialData:GetBattleResultGoal((var_2_1:GetStageId())),
				battleResult = var_2_2
			})
			EndBattleLogic(var_2_0)
		end
	else
		self:GotoBattleFaild(var_2_0, arg_2_1.stageData, arg_2_1.starMissionData, arg_2_1.battleResult)
	end
end

return GotoRaceTrialStage
