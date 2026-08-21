ys = ys or {}

local var_0_1 = ys.Battle.BattleDataFunction

ys.Battle.CardPuzzleCardDetailAffix = class("CardPuzzleCardDetailAffix")
ys.Battle.CardPuzzleCardDetailAffix.__name = "CardPuzzleCardDetailAffix"

function ys.Battle.CardPuzzleCardDetailAffix.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0._nameLabel = arg_1_0._tf:Find("name/labelCN")
	arg_1_0._nameLabelEN = arg_1_0._tf:Find("name/labelEN")
	arg_1_0._desc = arg_1_0._tf:Find("Desc")

	return
end

function ys.Battle.CardPuzzleCardDetailAffix.SetActive(arg_2_0, arg_2_1)
	setActive(arg_2_0._go, arg_2_1)

	return
end

function ys.Battle.CardPuzzleCardDetailAffix.SetAffixID(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1.GetPuzzleCardAffixDataTemplate(arg_3_1)

	setText(arg_3_0._nameLabel, var_3_0.name)
	setText(arg_3_0._nameLabelEN, var_3_0.name_EN)
	setText(arg_3_0._desc, var_3_0.discript)

	return
end

function ys.Battle.CardPuzzleCardDetailAffix.Dispose(arg_4_0)
	arg_4_0._nameLabel = nil
	arg_4_0._nameLabelEN = nil
	arg_4_0._desc = nil
	arg_4_0._tf = nil
	arg_4_0._go = nil

	return
end

return
