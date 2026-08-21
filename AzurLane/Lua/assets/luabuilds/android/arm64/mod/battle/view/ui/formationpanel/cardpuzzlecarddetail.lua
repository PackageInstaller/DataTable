ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleDataFunction

ys.Battle.CardPuzzleCardDetail = class("CardPuzzleCardDetail")
ys.Battle.CardPuzzleCardDetail.__name = "CardPuzzleCardDetail"

function ys.Battle.CardPuzzleCardDetail.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0._desc = arg_1_0._tf:Find("Desc")
	arg_1_0._affixList = arg_1_0._tf:Find("affixList")
	arg_1_0._affixContainer = arg_1_0._affixList:Find("container")
	arg_1_0._affixTpl = arg_1_0._tf:Find("tpl")
	arg_1_0._affixViewList = {}
	arg_1_0._bound = 960 - rtf(arg_1_0._tf).rect.width * 0.5

	return
end

function ys.Battle.CardPuzzleCardDetail.Dispose(arg_2_0)
	arg_2_0._affixList = nil
	arg_2_0._affixContainer = nil
	arg_2_0._affixTpl = nil
	arg_2_0._desc = nil
	arg_2_0._tf = nil
	arg_2_0._go = nil

	return
end

function ys.Battle.CardPuzzleCardDetail.Active(arg_3_0, arg_3_1)
	setActive(arg_3_0._go, arg_3_1)

	return
end

function ys.Battle.CardPuzzleCardDetail.SetReferenceCard(arg_4_0, arg_4_1)
	local var_4_0 = var_0_2.GetPuzzleCardDataTemplate((arg_4_1:GetCardInfo():GetCardID()))

	setText(arg_4_0._desc, var_4_0.discript)

	local var_4_1 = 0

	while var_4_1 < #var_4_0.label do
		var_4_1 = var_4_1 + 1

		local var_4_2 = arg_4_0._affixViewList[var_4_1]

		if arg_4_0._affixViewList[var_4_1] == nil then
			var_4_2 = var_0_0.Battle.CardPuzzleCardDetailAffix.New((cloneTplTo(arg_4_0._affixTpl, arg_4_0._affixContainer)))

			table.insert(arg_4_0._affixViewList, var_4_2)
		end

		var_4_2:SetAffixID(var_4_0.label[var_4_1])
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._affixViewList) do
		iter_4_1:SetActive(iter_4_0 <= var_4_1)
	end

	arg_4_0._pos = arg_4_0._pos or Vector3.New(0, 0, 0)

	local var_4_3 = arg_4_1:GetUIPos()

	arg_4_0._pos.x = var_4_3.x > arg_4_0._bound and arg_4_0._bound or var_4_3.x
	arg_4_0._pos.y = var_4_3.y + 2
	arg_4_0._tf.anchoredPosition = arg_4_0._pos

	return
end

return
