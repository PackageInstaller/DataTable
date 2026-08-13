class = var_0_10000

local var_0_0 = "IslandOrderUpgradePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandOrderUpgradeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "level")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.levelTxt = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "next_level")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nextLevelTxt = var_2_5(var_2_4, var_4(var_1_10006))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1, arg_5_2)
	var_0_1.super.Show(arg_5_0)

	arg_5_0.levelTxt.text = arg_5_1 - 1
	arg_5_0.nextLevelTxt.text = arg_5_1
	arg_5_0.callback = arg_5_2

	return
end

function var_0_1.Hide(arg_6_0)
	var_0_1.super.Hide(arg_6_0)

	if arg_6_0.callback then
		arg_6_0.callback()

		arg_6_0.callback = nil
	end

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

return var_0_1
