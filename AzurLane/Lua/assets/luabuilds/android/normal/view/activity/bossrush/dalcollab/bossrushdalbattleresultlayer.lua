class = var_0_10000

local var_0_0 = "BossRushDALBattleResultLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BossRushBattleResultLayer"))

function var_0_1.didEnter(arg_1_0)
	var_0_1.super.didEnter(arg_1_0)

	removeOnButton = var_1

	local var_1_0 = arg_1_0.rightBottomPanel

	var_1(var_2.Find(var_1_0, "confirmBtn"))

	onButton = var_1

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.rightBottomPanel
	local var_1_3 = var_3.Find(var_1_2, "confirmBtn")

	local function var_1_4()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		BossRushDALBattleResultMediator = var_2_10002

		var_2_1(var_2_0, var_2_10002.ON_SETTLE)

		return
	end

	SFX_PANEL = var_5

	var_1(var_1_1, var_1_3, var_1_4, var_5)

	return
end

return var_0_1
