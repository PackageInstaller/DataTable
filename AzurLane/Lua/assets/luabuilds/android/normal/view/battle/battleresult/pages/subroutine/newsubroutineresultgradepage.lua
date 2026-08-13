class = var_0_10000

local var_0_0 = "NewSubRoutineResultGradePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..NewBattleResultGradePage"))

function var_0_1.GetGetObjectives(arg_1_0)
	local var_1_0 = arg_1_0.contextData
	local var_1_1 = {}
	local var_1_2 = var_1_0.statistics.subRunResult

	i18n = var_1_10004

	local var_1_3 = var_1_10004("battle_result_base_score")

	table = var_5

	local var_1_4 = var_5.insert
	local var_1_5 = var_1_1
	local var_1_6 = {
		icon = "check_mark"
	}

	setColorStr = var_1_10008
	var_1_6.text = var_1_10008(var_1_3, "#FFFFFFFF")
	setColorStr = var_8

	local var_1_7 = "+" .. var_1_2.basePoint

	COLOR_BLUE = var_10
	var_1_6.value = var_8(var_1_7, var_10)

	var_1_4(var_1_5, var_1_6)

	i18n = var_1_4

	local var_1_8 = var_1_4("battle_result_dead_score", var_1_2.deadCount)

	table = var_6

	local var_1_9 = var_6.insert
	local var_1_10 = var_1_1
	local var_1_11 = {
		icon = "check_mark"
	}

	setColorStr = var_1_7
	var_1_11.text = var_1_7(var_1_8, "#FFFFFFFF")
	setColorStr = var_9

	local var_1_12 = "-" .. var_1_2.losePoint

	COLOR_BLUE = var_11
	var_1_11.value = var_9(var_1_12, var_11)

	var_1_9(var_1_10, var_1_11)

	i18n = var_1_9

	local var_1_13 = var_1_9("battle_result_score", var_1_2.score)

	table = var_7

	local var_1_14 = var_7.insert
	local var_1_15 = var_1_1
	local var_1_16 = {
		icon = "check_mark"
	}

	setColorStr = var_1_12
	var_1_16.text = var_1_12(var_1_13, "#FFFFFFFF")
	setColorStr = var_10

	local var_1_17 = "+" .. var_1_2.point

	COLOR_BLUE = var_12
	var_1_16.value = var_10(var_1_17, var_12)

	var_1_14(var_1_15, var_1_16)

	i18n = var_1_14

	local var_1_18 = var_1_14("battle_result_score_total")

	table = var_8

	local var_1_19 = var_8.insert
	local var_1_20 = var_1_1
	local var_1_21 = {}

	setColorStr = var_1_17
	var_1_21.text = var_1_17(var_1_18, "#FFFFFFFF")
	setColorStr = var_11

	local var_1_22 = var_1_2.total

	COLOR_YELLOW = var_13
	var_1_21.value = var_11(var_1_22, var_13)

	var_1_19(var_1_20, var_1_21)

	return var_1_1
end

return var_0_1
