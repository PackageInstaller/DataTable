local var_0_0 = class("GotoSequentialBattleStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoSequentialBattleStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoSequentialBattleStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = arg_2_2:GetActivityID()

	function BattleCallLuaCallBack()
		if isSuccess(arg_2_1) then
			local var_3_0 = arg_2_2:GetActivityID()
			local var_3_1 = arg_2_2:GetStageId()
			local var_3_2 = SequentialBattleChapterCfg[var_3_0].stage_id
			local var_3_3 = table.indexof(var_3_2, var_3_1)
			local var_3_4 = arg_2_2:GetStageAffix() or {}
			local var_3_5 = "["

			for iter_3_0, iter_3_1 in ipairs(var_3_4) do
				var_3_5 = var_3_5 .. iter_3_1

				if iter_3_0 ~= #var_3_4 then
					var_3_5 = var_3_5 .. ","
				end
			end

			local var_3_6 = var_3_5 .. "]"

			SDKTools.SendMessageToSDK("combat_over", {
				activity_cb_buff_list = var_3_6
			})
			SequentialBattleData:ClearStage(arg_2_2:GetActivityID())
			gameContext:Go("/sequentialBattleResult", {
				stageData = arg_2_2,
				rewardList = {},
				battleResult = arg_2_4
			})
		else
			gameContext:Go("/sequentialBattleFailed", {
				stageData = arg_2_2,
				battleResult = arg_2_4
			})
		end

		EndBattleLogic(arg_2_1)
	end
end

return var_0_0
