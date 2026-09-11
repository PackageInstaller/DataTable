local MatrixBattleSettlementMissionModule = class("MatrixBattleSettlementMissionModule", (import("game.views.battleResult.newBattleSettlement.module.BattleSettlementMissionModule")))

function MatrixBattleSettlementMissionModule:OnCtor(arg_1_1)
	self.gameObject_ = self:InstView(arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function MatrixBattleSettlementMissionModule:InstView(arg_2_1)
	return (Object.Instantiate(Asset.Load("Widget/System/MatrixlUI/BattleResultMatrixContent"), arg_2_1))
end

return MatrixBattleSettlementMissionModule
