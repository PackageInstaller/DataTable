ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleDataFunction

ys.Battle.CardPuzzleCardDetail = class("CardPuzzleCardDetail")
ys.Battle.CardPuzzleCardDetail.__name = "CardPuzzleCardDetail"

function ys.Battle.CardPuzzleCardDetail:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = self._go.transform
	self._desc = self._tf:Find("Desc")
	self._affixList = self._tf:Find("affixList")
	self._affixContainer = self._affixList:Find("container")
	self._affixTpl = self._tf:Find("tpl")
	self._affixViewList = {}
	self._bound = 960 - rtf(self._tf).rect.width * 0.5

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

function ys.Battle.CardPuzzleCardDetail:Active(arg_3_1)
	setActive(self._go, arg_3_1)

	return
end

function ys.Battle.CardPuzzleCardDetail:SetReferenceCard(arg_4_1)
	local var_4_0 = var_0_2.GetPuzzleCardDataTemplate((arg_4_1:GetCardInfo():GetCardID()))

	setText(self._desc, var_4_0.discript)

	local var_4_1 = 0

	while var_4_1 < #var_4_0.label do
		var_4_1 = var_4_1 + 1

		local var_4_2 = self._affixViewList[var_4_1]

		if self._affixViewList[var_4_1] == nil then
			var_4_2 = var_0_0.Battle.CardPuzzleCardDetailAffix.New((cloneTplTo(self._affixTpl, self._affixContainer)))

			table.insert(self._affixViewList, var_4_2)
		end

		var_4_2:SetAffixID(var_4_0.label[var_4_1])
	end

	for iter_4_0, iter_4_1 in ipairs(self._affixViewList) do
		iter_4_1:SetActive(iter_4_0 <= var_4_1)
	end

	self._pos = self._pos or Vector3.New(0, 0, 0)

	local var_4_3 = arg_4_1:GetUIPos()

	self._pos.x = var_4_3.x > self._bound and self._bound or var_4_3.x
	self._pos.y = var_4_3.y + 2
	self._tf.anchoredPosition = self._pos

	return
end

return
