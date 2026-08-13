ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.CardPuzzleHandCardButton = var_0_10003("CardPuzzleHandCardButton")

local var_0_3 = var_0.Battle.CardPuzzleHandCardButton

var_0_3.__name = "CardPuzzleHandCardButton"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function var_0_3.SetCardInfo(arg_2_0, arg_2_1)
	arg_2_0._cardInfo = arg_2_1

	arg_2_0:updateCardView()

	return
end

function var_0_3.UpdateTotalCost(arg_3_0)
	if arg_3_0._cardInfo then
		setText = var_1

		local var_3_0 = arg_3_0._costTxt
		local var_3_1 = arg_3_0._cardInfo

		var_1(var_3_0, var_3.GetTotalCost(var_3_1))
	end

	return
end

function var_0_3.ConfigCallback(arg_4_0, arg_4_1)
	arg_4_0._callback = arg_4_1

	return
end

function var_0_3.init(arg_5_0)
	arg_5_0._btnTF = arg_5_0._go.transform

	local var_5_0 = arg_5_0._btnTF

	arg_5_0._icon = var_1.Find(var_5_0, "skill_icon/unfill")

	local var_5_1 = arg_5_0._btnTF

	arg_5_0._costTxt = var_1.Find(var_5_1, "cost/cost_label")

	local var_5_2 = arg_5_0._btnTF

	arg_5_0._cardName = var_1.Find(var_5_2, "name")

	local var_5_3 = arg_5_0._btnTF

	arg_5_0._cardType = var_1.Find(var_5_3, "icon_bg")
	arg_5_0._cardTypeList = {}

	for iter_5_0 = 1, 3 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_5_4 = arg_5_0._cardTypeList
		local var_5_5 = arg_5_0._cardType

		var_1_10005(var_5_4, var_7.Find(var_5_5, "card_type_" .. iter_5_0))
	end

	local var_5_6 = arg_5_0._btnTF

	arg_5_0._cardRarity = var_1.Find(var_5_6, "bg")
	arg_5_0._cardRarityList = {}

	for iter_5_1 = 0, 4 do
		table = var_1_10005
		var_1_10005 = var_1_10005.insert

		local var_5_7 = arg_5_0._cardRarityList
		local var_5_8 = arg_5_0._cardRarity

		var_1_10005(var_5_7, var_7.Find(var_5_8, "rarity_" .. iter_5_1))
	end

	local var_5_9 = arg_5_0._btnTF

	arg_5_0._tag = var_1.Find(var_5_9, "tag")
	GetComponent = var_1

	local var_5_10 = var_1(arg_5_0._btnTF, "EventTriggerListener")

	var_1.AddPointUpFunc(var_5_10, function()
		if arg_5_0._cardInfo then
			arg_5_0._callback(arg_5_0._cardInfo)
		end

		return
	end)

	return
end

function var_0_3.updateCardView(arg_7_0)
	local var_7_5

	if arg_7_0._cardInfo then
		setActive = var_7_5

		var_7_5(arg_7_0._btnTF, true)

		setText = var_7_5

		local var_7_0 = arg_7_0._costTxt
		local var_7_1 = arg_7_0._cardInfo

		var_7_5(var_7_0, var_3.GetTotalCost(var_7_1))

		setText = var_7_5

		local var_7_2 = arg_7_0._cardName
		local var_7_3 = arg_7_0._cardInfo

		var_7_5(var_7_2, var_3.GetCardTemplate(var_7_3).name)

		setText = var_7_5

		var_7_5(arg_7_0._tag, "词缀功能TODO")

		local var_7_4 = arg_7_0._cardInfo

		var_7_5 = var_7_5.GetRarity(var_7_4)

		local var_7_6 = arg_7_0._cardInfo
		local var_7_7 = var_2.GetCardType(var_7_6)

		ipairs = var_7_6

		for iter_7_0, iter_7_1 in var_7_6(arg_7_0._cardRarityList) do
			setActive = var_1_10008

			var_1_10008(iter_7_1, iter_7_0 == var_7_5 + 1)
		end

		ipairs = var_3

		for iter_7_2, iter_7_3 in var_3(arg_7_0._cardTypeList) do
			setActive = var_1_10008

			var_1_10008(iter_7_3, iter_7_2 == var_7_7)
		end

		GetImageSpriteFromAtlasAsync = var_3

		local var_7_8 = "skillicon/"
		local var_7_9 = arg_7_0._cardInfo

		var_3(var_7_8 .. var_5.GetIconID(var_7_9), "", arg_7_0._icon)
	else
		setActive = var_7_5

		var_7_5(arg_7_0._btnTF, false)
	end

	return
end

function var_0_3.Dispose(arg_8_0)
	return
end

return
