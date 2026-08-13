ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction

class = var_0_10002

local var_0_2 = var_0_10002("BattleScoreBarView")

var_0.Battle.BattleScoreBarView = var_0_2
var_0_2.__name = "BattleScoreBarView"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	arg_1_0:init()

	return
end

function var_0_2.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0._scoreTF = var_1.Find(var_2_0, "bg/Text")

	local var_2_1 = arg_2_0._tf

	arg_2_0._comboTF = var_1.Find(var_2_1, "comboMark")

	local var_2_2 = arg_2_0._tf

	arg_2_0._comboText = var_1.Find(var_2_2, "comboMark/value")

	return
end

function var_0_2.SetActive(arg_3_0, arg_3_1)
	SetActive = var_1_10002

	var_1_10002(arg_3_0._tf, arg_3_1)

	return
end

function var_0_2.UpdateScore(arg_4_0, arg_4_1)
	setText = var_1_10002

	var_1_10002(arg_4_0._scoreTF, arg_4_1)

	return
end

function var_0_2.UpdateCombo(arg_5_0, arg_5_1)
	if 1 < arg_5_1 then
		SetActive = var_2

		var_2(arg_5_0._comboTF, true)
	else
		SetActive = var_2

		var_2(arg_5_0._comboTF, false)
	end

	setText = var_2

	var_2(arg_5_0._comboText, arg_5_1)

	return
end

return
