local var_0_0 = class("GotoKagutsuchiStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.starMissionData
	local var_1_3 = arg_1_1.battleResult
	local var_1_4 = var_1_1:GetActivityID()

	if isSuccess(var_1_0) and ActivityTools.GetActivityStatus(var_1_4) == 1 then
		if var_1_1:GetDay() == KagutsuchiWorkData:GetDay() then
			local var_1_5 = KagutsuchiWorkData:GetIndexByStageId(var_1_1:GetStageId())

			KagutsuchiWorkData:SetGridClear(var_1_5)
		end

		arg_1_0:GotoStage(var_1_0, var_1_1, var_1_2, var_1_3)

		return
	end

	function BattleCallLuaCallBack()
		local var_2_0 = var_1_1:GetStageId()

		manager.story:CheckBattleStory(var_2_0, manager.story.LOSE, function()
			gameContext:Go("/battlefailedWithButton", {
				stageData = var_1_1,
				battleResult = var_1_3
			})
			manager.story:RemovePlayer()
			EndBattleLogic(var_1_0)
		end)
	end
end

return var_0_0
