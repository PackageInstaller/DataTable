local GotoMardukSpecialStage = class("GotoMardukSpecialStage", BattleSettlementStrategyBase)

function GotoMardukSpecialStage:OnGotoSettlement(arg_1_1)
	self:GotoMardukSpecialStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoMardukSpecialStage:GotoMardukSpecialStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if arg_2_5 then
		self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

		return
	end

	CheckBattleResultNeedAddHeroExp()

	function BattleCallLuaCallBack()
		manager.story:RemovePlayer()

		local var_3_1 = math.floor(GameSetting.activity_quick_training_point_calculate_time.value[1] / 1000)
		local var_3_2 = 0

		if isSuccess(arg_2_1) then
			var_3_2 = (var_3_1 - math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)) / var_3_1 * GameSetting.quick_training_time_param.value[1]
		end

		local var_3_3 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas
		local var_3_4 = 0

		for iter_3_0, iter_3_1 in ipairs(ActivityQuickTrainingCfg[arg_2_2:GetActivityID()].monster_id_list) do
			var_3_4 = var_3_4 + ((var_3_3:TryGetValue(iter_3_1[1], nil) or nil) and (var_3_3[iter_3_1[1]] or 0)) * (iter_3_1[2] or 0)
		end

		gameContext:Go("/battleScorResult", {
			stageData = arg_2_2,
			battleResult = arg_2_4,
			score = math.floor(var_3_4 + var_3_2)
		})
		EndBattleLogic(arg_2_1)
	end
end

return GotoMardukSpecialStage
