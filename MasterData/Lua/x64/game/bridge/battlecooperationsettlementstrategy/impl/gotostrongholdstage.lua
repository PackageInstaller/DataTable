local GotoStrongHoldStage = class("GotoStrongHoldStage", BattleCooperationSettlementStrategyBase)

function GotoStrongHoldStage:OnGotoSettlement(arg_1_1)
	local var_1_0 = LuaExchangeHelper.GetBattleStatisticsData()

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
			if table.indexof(ActivityCfg[iter_1_1].sub_activity_list, activity_id) then
				for iter_1_2 = 0, var_1_0.choosedEffectID.Count - 1 do
					StrongholdAction.UpgradeAltas(iter_1_1, var_1_0.choosedEffectID[iter_1_2])
				end
			end
		end
	end

	self:GotoStrongholdResult(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoStrongHoldStage:GotoStrongholdResult(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = self:GetResultReward()

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

return GotoStrongHoldStage
