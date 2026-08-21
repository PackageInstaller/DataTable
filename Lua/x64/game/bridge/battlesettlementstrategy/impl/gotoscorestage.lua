local var_0_0 = class("GotoScoreStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.stageData
	local var_1_1 = arg_1_1.num
	local var_1_2 = arg_1_1.starMissionData
	local var_1_3 = arg_1_1.battleResult
	local var_1_4 = arg_1_1.isHalfWay_
	local var_1_5 = var_1_0:GetType()

	if var_1_5 == BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION then
		arg_1_0:GotoScoreStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
	elseif var_1_5 == BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT then
		local var_1_6 = ActivityAffixSelectData:GetLevelScore(var_1_0:GetActivityID())

		arg_1_0:GotoScoreResult(var_1_6, var_1_1, var_1_0, var_1_2, var_1_3, var_1_4, true)
	elseif var_1_5 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD then
		local var_1_7 = ActivityPt2Data:GetHardScore()

		arg_1_0:GotoScoreResult(var_1_7, var_1_1, var_1_0, var_1_2, var_1_3, var_1_4, true)
	elseif var_1_5 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		local var_1_8 = AdvanceTestData:GetBattleResultScore()

		arg_1_0:GotoScoreResult(var_1_8, var_1_1, var_1_0, var_1_2, var_1_3, var_1_4, true)
	elseif var_1_5 == BattleConst.STAGE_TYPE_NEW.ADVANCE_MONSTER_TEST then
		local var_1_9 = var_1_0:GetStageId()
		local var_1_10 = 0

		for iter_1_0, iter_1_1 in pairs(ActivityAdvanceMonsterTestCfg.all) do
			if ActivityAdvanceMonsterTestCfg[iter_1_1].stage_id == var_1_9 then
				var_1_10 = iter_1_1

				break
			end
		end

		local var_1_11 = ActivityAdvanceMonsterTestCfg[var_1_10].base_point
		local var_1_12 = AdvanceMonsterTestData:GetCustomList(var_1_10)

		for iter_1_2, iter_1_3 in pairs(var_1_12) do
			var_1_11 = var_1_11 + ActivityAffixPoolCfg[iter_1_3].point
		end

		arg_1_0:GotoScoreResult(var_1_11, var_1_1, var_1_0, var_1_2, var_1_3, var_1_4, true)
	end
end

function var_0_0.GotoScoreStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	local function var_2_2()
		manager.story:RemovePlayer()
		gameContext:Go("/battleScorResult", {
			stageData = arg_2_2,
			rewardList = var_2_1,
			battleResult = arg_2_4
		})
		EndBattleLogic(arg_2_1)
	end

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			local var_4_0 = arg_2_2:GetStageId()

			manager.story:CheckBattleStory(var_4_0, manager.story.WIN, var_2_2)
		end
	else
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
		end
	end
end

function var_0_0.GotoScoreResult(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	if arg_6_6 == true then
		arg_6_2 = 3
	end

	local var_6_0, var_6_1 = GetResultReward()

	if isSuccess(arg_6_2) then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleScorResult", {
				stageData = arg_6_3,
				rewardList = var_6_1,
				score = arg_6_1,
				battleResult = arg_6_5
			})
			EndBattleLogic(arg_6_2)
		end
	else
		function BattleCallLuaCallBack()
			local var_8_0 = arg_6_3:GetStageId()

			manager.story:CheckBattleStory(var_8_0, manager.story.LOSE, function()
				if arg_6_7 then
					JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
						stageData = arg_6_3,
						starMissionData = arg_6_4,
						battleResult = arg_6_5,
						isHalfWay_ = arg_6_0.tempData.isHalfWay_
					})
				else
					JumpTools.OpenPageByJump("/battlefailed", {
						stageData = arg_6_3,
						starMissionData = arg_6_4,
						battleResult = arg_6_5,
						isHalfWay_ = arg_6_0.tempData.isHalfWay_
					})
				end

				manager.story:RemovePlayer()
				EndBattleLogic(arg_6_2)
			end)
		end
	end
end

return var_0_0
