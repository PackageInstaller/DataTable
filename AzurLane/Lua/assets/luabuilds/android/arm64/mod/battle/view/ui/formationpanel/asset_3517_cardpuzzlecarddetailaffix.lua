ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleDataFunction
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.CardPuzzleCardDetailAffix = var_0_10004("CardPuzzleCardDetailAffix")

local var_0_4 = var_0.Battle.CardPuzzleCardDetailAffix

var_0_4.__name = "CardPuzzleCardDetailAffix"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0._nameLabel = var_2.Find(var_1_0, "name/labelCN")

	local var_1_1 = arg_1_0._tf

	arg_1_0._nameLabelEN = var_2.Find(var_1_1, "name/labelEN")

	local var_1_2 = arg_1_0._tf

	arg_1_0._desc = var_2.Find(var_1_2, "Desc")

	return
end

function var_0_4.SetActive(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._go, arg_2_1)

	return
end

function var_0_4.SetAffixID(arg_3_0, arg_3_1)
	local var_3_0 = var_0_2.GetPuzzleCardAffixDataTemplate(arg_3_1)

	setText = var_1_10003

	var_1_10003(arg_3_0._nameLabel, var_3_0.name)

	setText = var_1_10003

	var_1_10003(arg_3_0._nameLabelEN, var_3_0.name_EN)

	setText = var_1_10003

	var_1_10003(arg_3_0._desc, var_3_0.discript)

	return
end

function var_0_4.Dispose(arg_4_0)
	arg_4_0._nameLabel = nil
	arg_4_0._nameLabelEN = nil
	arg_4_0._desc = nil
	arg_4_0._tf = nil
	arg_4_0._go = nil

	return
end

return
