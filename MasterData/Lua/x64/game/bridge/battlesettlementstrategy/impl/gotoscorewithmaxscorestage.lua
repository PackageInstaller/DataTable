local GotoScoreWithMaxScoreStage = class("GotoScoreWithMaxScoreStage", BattleSettlementStrategyBase)

function GotoScoreWithMaxScoreStage:OnGotoSettlement(arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.starMissionData
	local var_1_3 = arg_1_1.battleResult

	if arg_1_1.isHalfWay_ == true then
		var_1_0 = 3
	end

	local var_1_4 = DestroyBoxGameCfg.get_id_list_by_activity_id[var_1_1:GetActivityID()][1]
	local var_1_5 = DestroyBoxGameData:GetStageData((var_1_1:GetDest()))
	local var_1_6

	if var_1_5 then
		var_1_6 = var_1_5.score or 0

		local var_1_7

		if var_1_5 then
			var_1_7 = var_1_5.historyMaxScore or 0
		end
	end

	self:GotoScoreWithMaxScoreResult(var_1_6, var_1_7, var_1_0, var_1_1, var_1_2, var_1_3, true)
end

function GotoScoreWithMaxScoreStage:GotoScoreWithMaxScoreResult(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	local var_2_0, var_2_1 = GetResultReward()

	BattleCallLuaCallBack = isSuccess(arg_2_3) and function()
		gameContext:Go("/battleScorWithMaxScoreResult", {
			stageData = arg_2_4,
			rewardList = var_2_1,
			score = arg_2_1,
			maxScore = arg_2_2,
			battleResult = arg_2_6
		})
		EndBattleLogic(arg_2_3)
	end or function()
		if arg_2_7 then
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = arg_2_4,
				starMissionData = arg_2_5,
				battleResult = arg_2_6,
				isHalfWay_ = self.tempData.isHalfWay_
			})
		else
			JumpTools.OpenPageByJump("/battlefailed", {
				stageData = arg_2_4,
				starMissionData = arg_2_5,
				battleResult = arg_2_6,
				isHalfWay_ = self.tempData.isHalfWay_
			})
		end

		manager.story:RemovePlayer()
		EndBattleLogic(arg_2_3)
	end
end

return GotoScoreWithMaxScoreStage
