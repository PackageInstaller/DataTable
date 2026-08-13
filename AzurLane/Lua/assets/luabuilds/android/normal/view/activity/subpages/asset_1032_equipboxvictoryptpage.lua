class = var_0_10000

local var_0_0 = "EquipBoxVictoryPtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.battleBtn

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_2_1(var_2_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_0, var_1_1, var_1_2, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.ptData
	local var_3_1, var_3_2, var_3_3 = var_1.GetResProgress(var_3_0)

	setText = var_1_10004

	local var_3_4 = arg_3_0.progress

	setColorStr = var_1_10006

	var_1_10004(var_3_4, var_1_10006(var_3_1, "#bff192") .. "/" .. var_3_2)

	return
end

return var_0_1
