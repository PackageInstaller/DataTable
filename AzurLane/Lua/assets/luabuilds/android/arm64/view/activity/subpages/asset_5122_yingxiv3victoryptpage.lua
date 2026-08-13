class = var_0_10000

local var_0_0 = "YingxiV3VictoryPtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.battleBtn

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_2_1(var_2_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.ptData
	local var_3_1, var_3_2, var_3_3 = var_1.GetLevelProgress(var_3_0)
	local var_3_4 = arg_3_0.ptData
	local var_3_5, var_3_6, var_3_7 = var_4.GetResProgress(var_3_4)

	setText = var_1_10007

	var_1_10007(arg_3_0.step, var_3_1)

	setText = var_1_10007

	local var_3_8 = arg_3_0.progress

	if 1 <= var_3_7 then
		setColorStr = var_3_10

		local var_3_9 = var_3_5

		COLOR_GREEN = var_1_10013

		local var_3_10

		if not var_3_10(var_3_9, var_1_10013) then
			setColorStr = var_3_10
			var_3_10 = var_3_10(var_3_5, "#e7dfc7")
		end

		var_1_10007(var_3_8, var_3_10 .. "/" .. var_3_6)

		return
	end
end

return var_0_1
