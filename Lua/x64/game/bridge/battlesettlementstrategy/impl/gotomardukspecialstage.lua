local var_0_0 = class("GotoMardukSpecialStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoMardukSpecialStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoMardukSpecialStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if arg_2_5 then
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

		return
	end

	CheckBattleResultNeedAddHeroExp()

	function BattleCallLuaCallBack()
		manager.story:RemovePlayer()

		local var_3_0 = 1
		local var_3_1 = math.floor(GameSetting.activity_quick_training_point_calculate_time.value[1] / 1000)
		local var_3_2 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime
		local var_3_3 = math.floor(var_3_2)
		local var_3_4 = GameSetting.quick_training_time_param.value[1]
		local var_3_5 = 0

		if isSuccess(arg_2_1) then
			var_3_5 = (var_3_1 - var_3_3) / var_3_1 * var_3_4
		end

		local var_3_6 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas
		local var_3_7 = 0
		local var_3_8 = ActivityQuickTrainingCfg[arg_2_2:GetActivityID()].monster_id_list

		for iter_3_0, iter_3_1 in ipairs(var_3_8) do
			local var_3_9
			local var_3_10 = 0

			if var_3_6:TryGetValue(iter_3_1[1], var_3_9) then
				var_3_10 = var_3_6[iter_3_1[1]] or 0
			end

			var_3_7 = var_3_7 + var_3_10 * (iter_3_1[2] or 0)
		end

		local var_3_11 = var_3_7 + var_3_5
		local var_3_12 = math.floor(var_3_11)

		gameContext:Go("/battleScorResult", {
			stageData = arg_2_2,
			battleResult = arg_2_4,
			score = var_3_12
		})
		EndBattleLogic(arg_2_1)
	end
end

return var_0_0
