local GotoActivityRaceStage = class("GotoActivityRaceStage", BattleSettlementStrategyBase)

function GotoActivityRaceStage:OnGotoSettlement(arg_1_1)
	self:GotoActivityRaceStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoActivityRaceStage:GotoActivityRaceStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0, var_2_1 = GetResultReward()
	local var_2_2 = arg_2_2:GetActivityID()
	local var_2_3 = arg_2_2:GetStageId()

	if var_2_3 ~= ActivityRaceCfg[var_2_2].stage_list[#ActivityRaceCfg[var_2_2].stage_list] then
		if isSuccess(arg_2_1) or not arg_2_5 and arg_2_4.challengedNumber >= 1 then
			CheckBattleResultNeedAddHeroExp()

			function BattleCallLuaCallBack()
				ActivityRaceData:SetCompleteStage(var_2_2, var_2_3)
				gameContext:Go("/battleActivityRaceResult", {
					stageData = arg_2_2,
					rewardList = var_2_1,
					affixList = ActivityRaceData:GetDropAffixes(),
					battleResult = arg_2_4
				})
				EndBattleLogic(arg_2_1)
			end
		else
			self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		end
	elseif arg_2_1 + 1 ~= BattleConst.BATTLE_RESULT.QUIT then
		CheckBattleResultNeedAddHeroExp()

		function BattleCallLuaCallBack()
			local var_4_0, var_4_1, var_4_2 = BattleTools.GetBattleStatisticsData()
			local var_4_4 = math.floor(math.min(tonumber(tostring(var_4_1.damage)) / ActivityRaceCfg[var_2_2].boss_hp[1], 1) * GameSetting.race_boss_point_cal.value[1] + ((isSuccess(arg_2_1) or nil) and math.max(GameSetting.race_boss_point_cal.value[2] - math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) * GameSetting.race_boss_point_cal.value[3], 0)))

			ActivityRaceData:SetScore(var_2_2, var_4_4)
			ActivityRaceData:SetCompleteStage(var_2_2, var_2_3)
			gameContext:Go("/battleScorResult", {
				stageData = arg_2_2,
				battleResult = arg_2_4,
				score = var_4_4
			})
			EndBattleLogic(arg_2_1)
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return GotoActivityRaceStage
