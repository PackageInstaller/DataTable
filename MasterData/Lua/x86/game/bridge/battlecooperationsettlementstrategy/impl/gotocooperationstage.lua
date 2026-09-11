local GotoCooperationStage = class("GotoCooperationStage", BattleCooperationSettlementStrategyBase)

function GotoCooperationStage:OnGotoSettlement(arg_1_1)
	self:GotoCooperationResult(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

return GotoCooperationStage
