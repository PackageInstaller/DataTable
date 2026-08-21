ys = ys or {}

local var_0_1 = class("BattleScoreBarView")

ys.Battle.BattleScoreBarView = var_0_1
var_0_1.__name = "BattleScoreBarView"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	arg_1_0:init()

	return
end

function var_0_1.init(arg_2_0)
	arg_2_0._scoreTF = arg_2_0._tf:Find("bg/Text")
	arg_2_0._comboTF = arg_2_0._tf:Find("comboMark")
	arg_2_0._comboText = arg_2_0._tf:Find("comboMark/value")

	return
end

function var_0_1.SetActive(arg_3_0, arg_3_1)
	SetActive(arg_3_0._tf, arg_3_1)

	return
end

function var_0_1.UpdateScore(arg_4_0, arg_4_1)
	setText(arg_4_0._scoreTF, arg_4_1)

	return
end

function var_0_1.UpdateCombo(arg_5_0, arg_5_1)
	if arg_5_1 > 1 then
		SetActive(arg_5_0._comboTF, true)
	else
		SetActive(arg_5_0._comboTF, false)
	end

	setText(arg_5_0._comboText, arg_5_1)

	return
end

return
