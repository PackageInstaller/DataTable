local GotoSequentialBattleStage = class("GotoSequentialBattleStage", BattleSettlementStrategyBase)

function GotoSequentialBattleStage:OnGotoSettlement(arg_1_1)
	self:GotoSequentialBattleStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoSequentialBattleStage:GotoSequentialBattleStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = arg_2_2:GetActivityID()

	function BattleCallLuaCallBack()
		if isSuccess(arg_2_1) then
			local var_3_0 = table.indexof(SequentialBattleChapterCfg[arg_2_2:GetActivityID()].stage_id, (arg_2_2:GetStageId()))
			local var_3_1 = arg_2_2:GetStageAffix() or {}
			local var_3_2 = "["

			for iter_3_0, iter_3_1 in ipairs(var_3_1) do
				var_3_2 = var_3_2 .. iter_3_1

				if iter_3_0 ~= #var_3_1 then
					var_3_2 = var_3_2 .. ","
				end
			end

			SDKTools.SendMessageToSDK("combat_over", {
				activity_cb_buff_list = var_3_2 .. "]"
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

return GotoSequentialBattleStage
