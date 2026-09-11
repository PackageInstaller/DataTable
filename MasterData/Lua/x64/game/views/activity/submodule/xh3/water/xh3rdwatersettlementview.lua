local XH3rdWaterSettlementView = class("XH3rdWaterSettlementView", (import("game.views.battleResult.BattleResultBaseView")))

function XH3rdWaterSettlementView:GoToBattleStatistics()
	self.toStat_ = true

	JumpTools.OpenPageByJump("xH3rdWaterBattleStatistics", {
		stageData = self.stageData,
		battleTime = self:GetBattleTime()
	})
end

return XH3rdWaterSettlementView
