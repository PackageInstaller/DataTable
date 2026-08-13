class = var_0_10000

local var_0_0 = "BossRushEscapeManorFleetSelectView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.BossRush.BossRushFleetSelectView"))

function var_0_1.GetTextColor(arg_1_0)
	Color = var_1_10001

	local var_1_0 = var_1_10001.NewHex("272727")

	Color = var_2

	local var_1_1 = var_2.NewHex("FFFFFF")
end

function var_0_1.getUIName(arg_2_0)
	return "BossRushEscapeManorFleetSelectUI"
end

function var_0_1.tempCache(arg_3_0)
	return true
end

function var_0_1.didEnter(arg_4_0)
	var_0_1.super.didEnter(arg_4_0)

	removeOnButton = var_1

	local var_4_0 = arg_4_0._tf

	var_1(var_2.Find(var_4_0, "BG"))

	setText = var_1

	local var_4_1 = arg_4_0.btnGo
	local var_4_2 = var_2.Find(var_4_1, "Text")

	i18n = var_4_1

	var_1(var_4_2, var_4_1("zengke_series_confirm"))

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_3.Find(var_4_4, "BG/close")

	local function var_4_6()
		local var_5_0 = arg_4_0

		var_0.onCancelHard(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_4_3, var_4_5, var_4_6, var_5)

	return
end

return var_0_1
