local GotoMatrixStage = class("GotoMatrixStage", BattleSettlementStrategyBase)

function GotoMatrixStage:OnGotoSettlement(arg_1_1)
	if isSuccess(arg_1_1.num) then
		MatrixAction.DoAfterEvnet((MatrixData:GetBattleTier()))
	end

	self:GotoMatrix(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoMatrixStage:GotoMatrix(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	BattleCallLuaCallBack = isSuccess(arg_2_1) and function()
		gameContext:Go("/battleMatrixResultNew", {
			multiple = 1,
			stageData = arg_2_2,
			rewardList = var_2_0,
			battleResult = arg_2_4
		})
		EndBattleLogic(arg_2_1)
	end or function()
		gameContext:Go("/battleMatrixFailed", {
			stageData = arg_2_2,
			starMissionData = arg_2_3,
			battleResult = arg_2_4
		})
		manager.story:RemovePlayer()
		EndBattleLogic(arg_2_1)
	end
end

return GotoMatrixStage
