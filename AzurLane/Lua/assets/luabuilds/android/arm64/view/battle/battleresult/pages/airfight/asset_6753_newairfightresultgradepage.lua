class = var_0_10000

local var_0_0 = "NewAirFightResultGradePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..NewBattleResultGradePage"))

function var_0_1.LoadGrade(arg_1_0, arg_1_1)
	local var_1_0 = {
		"d",
		"c",
		"b",
		"a",
		"s"
	}
	local var_1_1 = arg_1_0.contextData.score

	ys = var_1_10004

	local var_1_2

	var_1_2 = var_1_1 > var_1_10004.Battle.BattleConst.BattleScore.C

	local var_1_3
	local var_1_4
	local var_1_5
	local var_1_6 = var_1_0[var_1_1 + 1]
	local var_1_7 = "battlescore/battle_score_" .. var_1_6 .. "/letter_" .. var_1_6
	local var_1_8 = "battlescore/battle_score_" .. var_1_6 .. "/label_" .. var_1_6

	LoadImageSpriteAsync = var_8

	var_8(var_1_7, arg_1_0.gradeIcon, true)

	LoadImageSpriteAsync = var_8

	var_8(var_1_8, arg_1_0.gradeTxt, true)

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function var_0_1.GetGetObjectives(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = arg_2_0.contextData.statistics._airFightStatistics

	i18n = var_1_10003

	local var_2_2 = var_1_10003("fighterplane_destroy_tip") .. var_2_1.kill

	table = var_4

	local var_2_3 = var_4.insert
	local var_2_4 = var_2_0
	local var_2_5 = {}

	setColorStr = var_1_10008
	var_2_5.text = var_1_10008(var_2_2, "#FFFFFFFF")
	setColorStr = var_8

	local var_2_6 = var_2_1.score

	COLOR_BLUE = var_11
	var_2_5.value = var_8(var_2_6, var_11)

	var_2_3(var_2_4, var_2_5)

	i18n = var_2_3

	local var_2_7 = var_2_3("fighterplane_hit_tip") .. var_2_1.hit

	table = var_5

	local var_2_8 = var_5.insert
	local var_2_9 = var_2_0
	local var_2_10 = {}

	setColorStr = var_1_10009
	var_2_10.text = var_1_10009(var_2_7, "#FFFFFFFF")
	setColorStr = var_9

	local var_2_11 = -var_2_1.lose

	COLOR_BLUE = var_12
	var_2_10.value = var_9(var_2_11, var_12)

	var_2_8(var_2_9, var_2_10)

	i18n = var_2_8

	local var_2_12 = var_2_8("fighterplane_score_tip")

	table = var_6

	local var_2_13 = var_6.insert
	local var_2_14 = var_2_0
	local var_2_15 = {}

	setColorStr = var_2_6
	var_2_15.text = var_2_6(var_2_12, "#FFFFFFFF")
	setColorStr = var_10

	local var_2_16 = var_2_1.total

	COLOR_YELLOW = var_13
	var_2_15.value = var_10(var_2_16, var_13)

	var_2_13(var_2_14, var_2_15)

	return var_2_0
end

return var_0_1
