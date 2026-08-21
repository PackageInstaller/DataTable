ys = ys or {}
ys.Battle.CardPuzzleHandCardButton = class("CardPuzzleHandCardButton")
ys.Battle.CardPuzzleHandCardButton.__name = "CardPuzzleHandCardButton"

function ys.Battle.CardPuzzleHandCardButton.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function ys.Battle.CardPuzzleHandCardButton.SetCardInfo(arg_2_0, arg_2_1)
	arg_2_0._cardInfo = arg_2_1

	arg_2_0:updateCardView()

	return
end

function ys.Battle.CardPuzzleHandCardButton.UpdateTotalCost(arg_3_0)
	if arg_3_0._cardInfo then
		setText(arg_3_0._costTxt, arg_3_0._cardInfo:GetTotalCost())
	end

	return
end

function ys.Battle.CardPuzzleHandCardButton.ConfigCallback(arg_4_0, arg_4_1)
	arg_4_0._callback = arg_4_1

	return
end

function ys.Battle.CardPuzzleHandCardButton.init(arg_5_0)
	arg_5_0._btnTF = arg_5_0._go.transform
	arg_5_0._icon = arg_5_0._btnTF:Find("skill_icon/unfill")
	arg_5_0._costTxt = arg_5_0._btnTF:Find("cost/cost_label")
	arg_5_0._cardName = arg_5_0._btnTF:Find("name")
	arg_5_0._cardType = arg_5_0._btnTF:Find("icon_bg")
	arg_5_0._cardTypeList = {}

	for iter_5_0 = 1, 3 do
		table.insert(arg_5_0._cardTypeList, arg_5_0._cardType:Find("card_type_" .. iter_5_0))
	end

	arg_5_0._cardRarity = arg_5_0._btnTF:Find("bg")
	arg_5_0._cardRarityList = {}

	for iter_5_1 = 0, 4 do
		table.insert(arg_5_0._cardRarityList, arg_5_0._cardRarity:Find("rarity_" .. iter_5_1))
	end

	arg_5_0._tag = arg_5_0._btnTF:Find("tag")

	GetComponent(arg_5_0._btnTF, "EventTriggerListener"):AddPointUpFunc(function()
		if arg_5_0._cardInfo then
			arg_5_0._callback(arg_5_0._cardInfo)
		end

		return
	end)

	return
end

function ys.Battle.CardPuzzleHandCardButton.updateCardView(arg_7_0)
	if arg_7_0._cardInfo then
		setActive(arg_7_0._btnTF, true)
		setText(arg_7_0._costTxt, arg_7_0._cardInfo:GetTotalCost())
		setText(arg_7_0._cardName, arg_7_0._cardInfo:GetCardTemplate().name)
		setText(arg_7_0._tag, "词缀功能TODO")

		local var_7_0 = arg_7_0._cardInfo:GetRarity()
		local var_7_1 = arg_7_0._cardInfo:GetCardType()

		for iter_7_0, iter_7_1 in ipairs(arg_7_0._cardRarityList) do
			setActive(iter_7_1, iter_7_0 == var_7_0 + 1)
		end

		for iter_7_2, iter_7_3 in ipairs(arg_7_0._cardTypeList) do
			setActive(iter_7_3, iter_7_2 == var_7_1)
		end

		GetImageSpriteFromAtlasAsync("skillicon/" .. arg_7_0._cardInfo:GetIconID(), "", arg_7_0._icon)
	else
		setActive(arg_7_0._btnTF, false)
	end

	return
end

function ys.Battle.CardPuzzleHandCardButton.Dispose(arg_8_0)
	return
end

return
