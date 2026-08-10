local var_0_0 = class("GotoActivityRaceStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoActivityRaceStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoActivityRaceStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0, var_2_1 = GetResultReward()
	local var_2_2 = arg_2_2:GetActivityID()
	local var_2_3 = arg_2_2:GetStageId()
	local var_2_4 = ActivityRaceCfg[var_2_2].stage_list

	if not (var_2_3 == var_2_4[#var_2_4]) then
		if isSuccess(arg_2_1) or not arg_2_5 and arg_2_4.challengedNumber >= 1 then
			CheckBattleResultNeedAddHeroExp()

			function BattleCallLuaCallBack()
				local var_3_0 = ActivityRaceData:GetDropAffixes()

				ActivityRaceData:SetCompleteStage(var_2_2, var_2_3)
				gameContext:Go("/battleActivityRaceResult", {
					stageData = arg_2_2,
					rewardList = var_2_1,
					affixList = var_3_0,
					battleResult = arg_2_4
				})
				EndBattleLogic(arg_2_1)
			end
		else
			arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		end
	elseif arg_2_1 + 1 ~= BattleConst.BATTLE_RESULT.QUIT then
		CheckBattleResultNeedAddHeroExp()

		function BattleCallLuaCallBack()
			local var_4_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime
			local var_4_1 = math.floor(var_4_0)
			local var_4_2, var_4_3, var_4_4 = BattleTools.GetBattleStatisticsData()
			local var_4_5 = var_4_3.damage
			local var_4_6 = ActivityRaceCfg[var_2_2].boss_hp[1]
			local var_4_7 = GameSetting.race_boss_point_cal.value
			local var_4_8 = 0

			if isSuccess(arg_2_1) then
				local var_4_9 = var_4_7[2] - var_4_1 * var_4_7[3]

				var_4_8 = math.max(var_4_9, 0)
			end

			local var_4_10 = math.min(tonumber(tostring(var_4_5)) / var_4_6, 1) * var_4_7[1] + var_4_8
			local var_4_11 = math.floor(var_4_10)

			ActivityRaceData:SetScore(var_2_2, var_4_11)
			ActivityRaceData:SetCompleteStage(var_2_2, var_2_3)
			gameContext:Go("/battleScorResult", {
				stageData = arg_2_2,
				battleResult = arg_2_4,
				score = var_4_11
			})
			EndBattleLogic(arg_2_1)
		end
	else
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return var_0_0
