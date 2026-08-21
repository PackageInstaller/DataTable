local var_0_0 = class("GotoAshStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoAshBattleStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoAshBattleStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	LuaHidTools.ForceSelectKeyboard(nil)

	if isSuccess(arg_2_1) then
		arg_2_0:GotoAshBattleSuccess(arg_2_4, arg_2_1, arg_2_2, arg_2_3)
	else
		arg_2_0:GotoAshBattleFailed(arg_2_1, arg_2_2)
	end
end

function var_0_0.GotoAshBattleSuccess(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if arg_3_1 == true then
		arg_3_2 = 3
	end

	if isSuccess(arg_3_2) then
		function BattleCallLuaCallBack()
			local var_4_0 = arg_3_3:GetStageId()
			local var_4_1 = AshShootStageCfg.get_id_list_by_stage_id[var_4_0][1]
			local var_4_2 = AshSystemData:GetCacheStagePoint(var_4_1)
			local var_4_3 = GetResultReward()

			JumpTools.OpenPageByJump("/ashBattleResultView", {
				stageData = arg_3_3,
				rewardList = var_4_3,
				battleResult = arg_3_4,
				score = var_4_2
			})
			EndBattleLogic(arg_3_2)
		end
	end
end

function var_0_0.GotoAshBattleFailed(arg_5_0, arg_5_1, arg_5_2)
	function BattleCallLuaCallBack()
		local var_6_0 = arg_5_2:GetStageId()
		local var_6_1 = AshShootStageCfg.get_id_list_by_stage_id[var_6_0][1]
		local var_6_2 = AshSystemData:GetCacheStagePoint(var_6_1)

		JumpTools.OpenPageByJump("/ashBattleFailedView", {
			stageData = arg_5_2,
			scroe = var_6_2
		})
		EndBattleLogic(arg_5_1)
	end
end

return var_0_0
