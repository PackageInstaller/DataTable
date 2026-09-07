ys = ys or {}
ys.Battle.CardPuzzleHandCardButton = class("CardPuzzleHandCardButton")
ys.Battle.CardPuzzleHandCardButton.__name = "CardPuzzleHandCardButton"

function ys.Battle.CardPuzzleHandCardButton:Ctor(arg_1_1)
	self._go = arg_1_1

	self:init()

	return
end

function ys.Battle.CardPuzzleHandCardButton:SetCardInfo(arg_2_1)
	self._cardInfo = arg_2_1

	self:updateCardView()

	return
end

function ys.Battle.CardPuzzleHandCardButton:UpdateTotalCost()
	if self._cardInfo then
		setText(self._costTxt, self._cardInfo:GetTotalCost())
	end

	return
end

function ys.Battle.CardPuzzleHandCardButton.ConfigCallback(arg_4_0, arg_4_1)
	arg_4_0._callback = arg_4_1

	return
end

function ys.Battle.CardPuzzleHandCardButton:init()
	self._btnTF = self._go.transform
	self._icon = self._btnTF:Find("skill_icon/unfill")
	self._costTxt = self._btnTF:Find("cost/cost_label")
	self._cardName = self._btnTF:Find("name")
	self._cardType = self._btnTF:Find("icon_bg")
	self._cardTypeList = {}

	for iter_5_0 = 1, 3 do
		table.insert(self._cardTypeList, self._cardType:Find("card_type_" .. iter_5_0))
	end

	self._cardRarity = self._btnTF:Find("bg")
	self._cardRarityList = {}

	for iter_5_1 = 0, 4 do
		table.insert(self._cardRarityList, self._cardRarity:Find("rarity_" .. iter_5_1))
	end

	self._tag = self._btnTF:Find("tag")

	GetComponent(self._btnTF, "EventTriggerListener"):AddPointUpFunc(function()
		if self._cardInfo then
			self._callback(self._cardInfo)
		end

		return
	end)

	return
end

function ys.Battle.CardPuzzleHandCardButton:updateCardView()
	if self._cardInfo then
		setActive(self._btnTF, true)
		setText(self._costTxt, self._cardInfo:GetTotalCost())
		setText(self._cardName, self._cardInfo:GetCardTemplate().name)
		setText(self._tag, "词缀功能TODO")

		local var_7_0 = self._cardInfo:GetRarity()
		local var_7_1 = self._cardInfo:GetCardType()

		for iter_7_0, iter_7_1 in ipairs(self._cardRarityList) do
			setActive(iter_7_1, iter_7_0 == var_7_0 + 1)
		end

		for iter_7_2, iter_7_3 in ipairs(self._cardTypeList) do
			setActive(iter_7_3, iter_7_2 == var_7_1)
		end

		GetImageSpriteFromAtlasAsync("skillicon/" .. self._cardInfo:GetIconID(), "", self._icon)
	else
		setActive(self._btnTF, false)
	end

	return
end

function ys.Battle.CardPuzzleHandCardButton.Dispose(arg_8_0)
	return
end

return
