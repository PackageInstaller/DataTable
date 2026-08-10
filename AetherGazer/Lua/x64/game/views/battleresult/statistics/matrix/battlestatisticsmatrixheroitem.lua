local var_0_0 = import("..BattleStatisticsHeroItem")
local var_0_1 = class("BattleStatisticsMatrixHeroItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)
	SetActive(arg_1_0.LVGo_, false)
end

return var_0_1
