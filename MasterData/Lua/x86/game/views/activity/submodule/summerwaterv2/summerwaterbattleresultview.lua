NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local SummerWaterBattleResultView = class("SummerWaterBattleResultView", NewBattleSettlementView)

function SummerWaterBattleResultView:InitUI()
	SummerWaterBattleResultView.super.InitUI(self)
end

function SummerWaterBattleResultView:GoToBattleStatistics()
	self.toStat_ = true

	JumpTools.OpenPageByJump("summerWaterBattleStatistics", {
		stageData = self.stageData,
		battleTime = self:GetBattleTime()
	})
end

return SummerWaterBattleResultView
