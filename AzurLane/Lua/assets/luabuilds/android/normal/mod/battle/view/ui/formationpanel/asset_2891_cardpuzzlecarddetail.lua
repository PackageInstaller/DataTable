ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleDataFunction
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.CardPuzzleCardDetail = var_0_10004("CardPuzzleCardDetail")

local var_0_4 = var_0.Battle.CardPuzzleCardDetail

var_0_4.__name = "CardPuzzleCardDetail"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0._desc = var_2.Find(var_1_0, "Desc")

	local var_1_1 = arg_1_0._tf

	arg_1_0._affixList = var_2.Find(var_1_1, "affixList")

	local var_1_2 = arg_1_0._affixList

	arg_1_0._affixContainer = var_2.Find(var_1_2, "container")

	local var_1_3 = arg_1_0._tf

	arg_1_0._affixTpl = var_2.Find(var_1_3, "tpl")
	arg_1_0._affixViewList = {}
	rtf = var_2
	arg_1_0._bound = 960 - var_2(arg_1_0._tf).rect.width * 0.5

	return
end

function var_0_4.Dispose(arg_2_0)
	arg_2_0._affixList = nil
	arg_2_0._affixContainer = nil
	arg_2_0._affixTpl = nil
	arg_2_0._desc = nil
	arg_2_0._tf = nil
	arg_2_0._go = nil

	return
end

function var_0_4.Active(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0._go, arg_3_1)

	return
end

function var_0_4.SetReferenceCard(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetCardInfo()
	local var_4_1 = var_2.GetCardID(var_4_0)
	local var_4_2 = var_0_2.GetPuzzleCardDataTemplate(var_4_1)

	setText = var_4

	var_4(arg_4_0._desc, var_4_2.discript)

	local var_4_3 = #var_4_2.label
	local var_4_4 = 0

	while var_4_4 < var_4_3 do
		var_4_4 = var_4_4 + 1

		local var_4_5

		if arg_4_0._affixViewList[var_4_4] == nil then
			cloneTplTo = var_1_10007
			var_1_10007 = var_1_10007(arg_4_0._affixTpl, arg_4_0._affixContainer)
			var_4_5 = var_0.Battle.CardPuzzleCardDetailAffix.New(var_1_10007)
			table = var_8

			var_8.insert(arg_4_0._affixViewList, var_4_5)
		end

		var_4_5:SetAffixID(var_4_2.label[var_4_4])
	end

	ipairs = var_4_5

	for iter_4_0, iter_4_1 in var_4_5(arg_4_0._affixViewList) do
		local var_4_6 = iter_4_0 <= var_4_4

		iter_4_1:SetActive(var_4_6)
	end

	local var_4_7

	if not arg_4_0._pos then
		Vector3 = var_4_7
		var_4_7 = var_4_7.New(0, 0, 0)
	end

	arg_4_0._pos = var_4_7

	if arg_4_1:GetUIPos().x > arg_4_0._bound then
		arg_4_0._pos.x = arg_4_0._bound
	else
		arg_4_0._pos.x = var_6.x
	end

	arg_4_0._pos.y = var_6.y + 2
	arg_4_0._tf.anchoredPosition = arg_4_0._pos

	return
end

return
