local GotoKagutsuchiStage = class("GotoKagutsuchiStage", BattleSettlementStrategyBase)

function GotoKagutsuchiStage:OnGotoSettlement(arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.battleResult

	if isSuccess(arg_1_1.num) and ActivityTools.GetActivityStatus((arg_1_1.stageData:GetActivityID())) == 1 then
		if arg_1_1.stageData:GetDay() == KagutsuchiWorkData:GetDay() then
			KagutsuchiWorkData:SetGridClear((KagutsuchiWorkData:GetIndexByStageId(arg_1_1.stageData:GetStageId())))
		end

		self:GotoStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)

		return
	end

	function BattleCallLuaCallBack()
		manager.story:CheckBattleStory(var_1_1:GetStageId(), manager.story.LOSE, function()
			gameContext:Go("/battlefailedWithButton", {
				stageData = var_1_1,
				battleResult = var_1_2
			})
			manager.story:RemovePlayer()
			EndBattleLogic(var_1_0)
		end)
	end
end

return GotoKagutsuchiStage
