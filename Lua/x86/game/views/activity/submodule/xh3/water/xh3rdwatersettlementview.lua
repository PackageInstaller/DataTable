local var_0_0 = import("game.views.battleResult.BattleResultBaseView")
local var_0_1 = class("XH3rdWaterSettlementView", var_0_0)

function var_0_1.GoToBattleStatistics(arg_1_0)
	arg_1_0.toStat_ = true

	JumpTools.OpenPageByJump("xH3rdWaterBattleStatistics", {
		stageData = arg_1_0.stageData,
		battleTime = arg_1_0:GetBattleTime()
	})
end

return var_0_1
