local var_0_0 = class("GotoStrongHoldStage", BattleCooperationSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = LuaExchangeHelper.GetBattleStatisticsData()

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
			local var_1_1 = ActivityCfg[iter_1_1]

			if table.indexof(var_1_1.sub_activity_list, activity_id) then
				local var_1_2 = var_1_0.choosedEffectID.Count

				for iter_1_2 = 0, var_1_2 - 1 do
					local var_1_3 = var_1_0.choosedEffectID[iter_1_2]

					StrongholdAction.UpgradeAltas(iter_1_1, var_1_3)
				end
			end
		end
	end

	arg_1_0:GotoStrongholdResult(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoStrongholdResult(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = arg_2_0:GetResultReward()

	CheckBattleResultNeedAddHeroExp()

	function BattleCallLuaCallBack()
		JumpTools.OpenPageByJump("/strongholdBattleResult", {
			result = arg_2_1,
			rewardList = var_2_0,
			stageData = arg_2_2,
			starMissionData = arg_2_3,
			battleResult = arg_2_4
		})
		EndBattleLogic(arg_2_1)
	end
end

return var_0_0
