class = var_0_10000

local var_0_0 = "BossSingleTotalRewardPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.worldboss.ActivityBossTotalRewardPanel"))

function var_0_1.getUIName(arg_1_0)
	return "BossSingleTotalRewardPanel"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0.window
	local var_2_1 = var_2.Find(var_2_0, "Fixed/ButtonGO/pic")

	i18n = var_2_0

	var_1(var_2_1, var_2_0("autofight_onceagain"))

	return
end

function var_0_1.UpdateView(arg_3_0)
	var_0_1.super.UpdateView(arg_3_0)

	local var_3_0 = arg_3_0.contextData

	onButton = var_2

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.window
	local var_3_3 = var_4.Find(var_3_2, "Fixed/ButtonGO")

	local function var_3_4()
		existCall = var_2_10000

		var_2_10000(var_3_0.onConfirm)

		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CONFIRM = var_6

	var_2(var_3_1, var_3_3, var_3_4, var_6)

	onButton = var_2

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.window

	var_2(var_3_5, var_4.Find(var_3_6, "Fixed/ButtonExit"), function()
		triggerButton = var_2_10000

		local var_5_0 = arg_3_0._tf

		var_2_10000(var_1.Find(var_5_0, "BG"))

		return
	end)

	return
end

return var_0_1
