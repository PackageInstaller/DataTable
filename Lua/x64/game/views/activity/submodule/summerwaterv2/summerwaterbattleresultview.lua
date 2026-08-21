NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("SummerWaterBattleResultView", NewBattleSettlementView)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)
end

function var_0_0.GoToBattleStatistics(arg_2_0)
	arg_2_0.toStat_ = true

	JumpTools.OpenPageByJump("summerWaterBattleStatistics", {
		stageData = arg_2_0.stageData,
		battleTime = arg_2_0:GetBattleTime()
	})
end

return var_0_0
