ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleCardPuzzleConfig
local var_0_3 = ys.Battle.BattleCardPuzzleEvent

ys.Battle.CardPuzzleHandBoard = class("CardPuzzleHandBoard")

local var_0_4 = ys.Battle.CardPuzzleHandBoard

ys.Battle.CardPuzzleHandBoard.__name = "CardPuzzleHandBoard"
ys.Battle.CardPuzzleHandBoard.BASE_GAP = 166
ys.Battle.CardPuzzleHandBoard.BASE_SIBLING = 4

function ys.Battle.CardPuzzleHandBoard:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._areaGO = arg_1_2

	self:init()

	return
end

function ys.Battle.CardPuzzleHandBoard:SetCardPuzzleComponent(arg_2_1)
	self._cardPuzzleInfo = arg_2_1
	self._hand = self._cardPuzzleInfo:GetHand()

	self._hand:RegisterEventListener(self, var_0_3.UPDATE_CARDS, self.onUpdateCards)
	self._cardPuzzleInfo:RegisterEventListener(self, var_0_3.UPDATE_FLEET_ATTR, self.onUpdateFleetAttr)
	self:onUpdateCards()

	return
end

function ys.Battle.CardPuzzleHandBoard:Update()
	for iter_3_0, iter_3_1 in ipairs(self._activeCardList) do
		iter_3_1:Update()
	end

	for iter_3_2, iter_3_3 in ipairs(self._freeCardList) do
		iter_3_3:Update()
	end

	return
end

function ys.Battle.CardPuzzleHandBoard:onUpdateCards(arg_4_1)
	local var_4_0 = self._hand:GetCardList()

	while #self._activeCardList > 0 do
		local var_4_1 = self._activeCardList[#self._activeCardList]:GetCardInfo()

		if not table.contains(var_4_0, var_4_1) then
			if var_4_1:GetCurrentPile() == self._cardPuzzleInfo.CARD_PILE_INDEX_DECK then
				self:delayRecyleCard(self._activeCardList[#self._activeCardList])
			else
				self:recyleCard(self._activeCardList[#self._activeCardList])
			end
		end
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_3

		for iter_4_2, iter_4_3 in ipairs(self._activeCardList) do
			if iter_4_3:GetCardInfo() == iter_4_1 then
				var_4_3 = iter_4_3

				break
			end
		end

		if not var_4_3 then
			local var_4_4 = self:getCard()

			var_4_4:SetCardInfo(iter_4_1)
			var_4_4:UpdateView()
			var_4_4:DrawAnima((iter_4_1:GetFromPile() == self._cardPuzzleInfo.CARD_PILE_INDEX_DECK or nil) and (self._drawPos or self._generatePos))
			var_4_4:SetMoveLerp(0.1)
			var_4_4:ChangeState(var_4_4.STATE_FREE)
			table.insert(self._activeCardList, var_4_4)
		end
	end

	self:updateCardReferenceInHand()

	return
end

function ys.Battle.CardPuzzleHandBoard:getCard()
	local var_5_0

	if #self._idleCardList > 0 then
		var_5_0 = table.remove(self._idleCardList, 1)
	end

	local var_5_2

	do
		local var_5_1 = self._resManager:InstCardPuzzleCard().transform

		var_5_1:SetParent(self._cardContainer)

		var_5_1.localScale = Vector3(0.57, 0.57, 0)
		var_5_1.localPosition = Vector3.zero
		var_5_0 = var_0_0.Battle.CardPuzzleCombatCard.New(var_5_1)

		function var_5_2()
			var_5_0:ChangeState(var_5_0.STATE_FREE)
			self._cardPuzzleInfo:LongPressCard(var_5_0, false)

			return
		end
	end

	var_5_0:ConfigOP(function()
		return
	end, function()
		if var_5_0:GetState() == var_5_0.STATE_LONG_PRESS then
			var_5_2()
		end

		if var_5_0:GetState() ~= var_5_0.STATE_LOCK then
			self:LockCardInHand()
			self:UnlockCardInHand(var_5_0)
			self:setDragingCard(var_5_0)

			self._holdingCard = var_5_0

			self:activeHighlight(true)
			self._cardPuzzleInfo:BlockComponentByCard(true)
			self:SetAllCardBlockRayCast(false)
			var_5_0:SetSibling(#self._activeCardList + var_0_4.BASE_SIBLING)
			var_5_0:SetMoveLerp(0.5)
			var_5_0:ChangeState(var_5_0.STATE_DRAG)
		end

		return
	end, function(arg_9_0)
		var_5_0:UpdateDragPosition(arg_9_0)

		return
	end, function()
		self:setDragingCard()

		if not (self._cardEnterDeck and self:TryPlayReturnCard(var_5_0) or (self._cardEnterHand ~= true or false) and self:TryPlayCard(var_5_0)) then
			var_5_0:SetMoveLerp()
			self:updateCardReferenceInHand()
		end

		self._cardEnterHand = nil
		self._cardEnterDeck = nil

		self:UnlockCardInHand()
		self:activeHighlight(false)
		self:SetAllCardBlockRayCast(true)
		onDelayTick(function()
			self._cardPuzzleInfo:BlockComponentByCard(false)

			return
		end, 0.06)

		return
	end, function()
		var_5_0:ChangeState(var_5_0.STATE_LONG_PRESS)
		self._cardPuzzleInfo:LongPressCard(var_5_0, true)

		return
	end, var_5_2)

	return var_5_0
end

function ys.Battle.CardPuzzleHandBoard:recyleCard(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self._activeCardList) do
		if iter_13_1 == arg_13_1 then
			arg_13_1:SetToObjPoolRecylePos()
			table.remove(self._activeCardList, iter_13_0)

			break
		end
	end

	table.insert(self._idleCardList, arg_13_1)

	return
end

function ys.Battle.CardPuzzleHandBoard:delayRecyleCard(arg_14_1)
	arg_14_1:ChangeState(arg_14_1.STATE_LOCK)

	for iter_14_0, iter_14_1 in ipairs(self._activeCardList) do
		if iter_14_1 == arg_14_1 then
			table.remove(self._activeCardList, iter_14_0)

			break
		end
	end

	table.insert(self._freeCardList, arg_14_1)
	arg_14_1:MoveToDeck(function()
		for iter_15_0, iter_15_1 in ipairs(self._freeCardList) do
			if iter_15_1 == arg_14_1 then
				arg_14_1:SetToObjPoolRecylePos()
				table.remove(self._freeCardList, iter_15_0)

				break
			end
		end

		table.insert(self._idleCardList, arg_14_1)

		return
	end, self._drawPos)

	return
end

function ys.Battle.CardPuzzleHandBoard:onUpdateFleetAttr(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(self._activeCardList) do
		iter_16_1:UpdateTotalCost()
		iter_16_1:UpdateBoostHint()

		local var_16_0 = iter_16_1:GetCardInfo()
	end

	return
end

function ys.Battle.CardPuzzleHandBoard:init()
	var_0_0.EventListener.AttachEventListener(self)

	self._cardContainer = self._go.transform
	self._resManager = var_0_0.Battle.BattleResourceManager.GetInstance()
	self._activeCardList = {}
	self._idleCardList = {}
	self._freeCardList = {}
	self._startPos = self._cardContainer:Find("handStart").localPosition
	self._generatePos = self._cardContainer:Find("generateStart").localPosition
	self._drawPos = self._cardContainer:Find("drawStart").localPosition
	self._cancelArea = self._cardContainer:Find("cancel_area")
	self._returnArea = self._cardContainer:Find("return_area")
	self._handDelegate = GetOrAddComponent(self._cancelArea, "EventTriggerListener")
	self._deckDelegate = GetOrAddComponent(self._returnArea, "EventTriggerListener")
	self._area = self._areaGO.transform
	self._cancelHint = self._area:Find("hand_hint")
	self._returnHint = self._area:Find("deck_hint")
	self._readyHint = self._area:Find("cast_hint")

	return
end

function ys.Battle.CardPuzzleHandBoard:updateCardReferenceInHand()
	for iter_18_0, iter_18_1 in ipairs(self._activeCardList) do
		iter_18_1:SetReferencePos((Vector3.New(self._startPos.x + (iter_18_0 - 1) * self:getcardGap(), self._startPos.y, 0)))
		iter_18_1:SetSibling(iter_18_0 + var_0_4.BASE_SIBLING)
	end

	return
end

function ys.Battle.CardPuzzleHandBoard:getcardGap()
	if #self._activeCardList <= var_0_2.BASE_MAX_HAND then
		return var_0_4.BASE_GAP
	else
		return 830 / (#self._activeCardList - 1)
	end

	return
end

function ys.Battle.CardPuzzleHandBoard:setDragingCard(arg_20_1)
	self._cardPuzzleInfo:SetDragingCard(arg_20_1)
	self._cardPuzzleInfo:SendUpdateAim()

	return
end

function ys.Battle.CardPuzzleHandBoard.sort(arg_21_0)
	return
end

function ys.Battle.CardPuzzleHandBoard:activeHighlight(arg_22_1)
	if arg_22_1 then
		self._handDelegate:AddPointEnterFunc(function()
			self._cardEnterHand = true

			setActive(self._cancelHint, true)
			setActive(self._returnHint, false)
			setActive(self._readyHint, false)

			return
		end)
		self._handDelegate:AddPointExitFunc(function()
			self._cardEnterHand = false

			setActive(self._cancelHint, false)
			setActive(self._readyHint, true)

			return
		end)
		self._deckDelegate:AddPointEnterFunc(function()
			self._cardEnterDeck = true

			setActive(self._readyHint, false)

			local var_25_0 = self._holdingCard:GetCardInfo():GetReturnCost() ~= nil

			setActive(self._cancelHint, not var_25_0)
			setActive(self._returnHint, var_25_0)

			return
		end)
		self._deckDelegate:AddPointExitFunc(function()
			self._cardEnterDeck = false

			setActive(self._cancelHint, false)
			setActive(self._readyHint, true)

			return
		end)
	else
		setActive(self._cancelHint, false)
		setActive(self._returnHint, false)
		setActive(self._readyHint, false)
		self._handDelegate:RemovePointEnterFunc()
		self._handDelegate:RemovePointExitFunc()
		self._deckDelegate:RemovePointEnterFunc()
		self._deckDelegate:RemovePointExitFunc()
	end

	setActive(self._cancelArea, arg_22_1)
	setActive(self._returnArea, arg_22_1)

	return
end

function ys.Battle.CardPuzzleHandBoard:LockCardInHand()
	for iter_27_0, iter_27_1 in ipairs(self._activeCardList) do
		iter_27_1:ChangeState(iter_27_1.STATE_LOCK)
	end

	return
end

function ys.Battle.CardPuzzleHandBoard:SetAllCardBlockRayCast(arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(self._activeCardList) do
		iter_28_1:BlockRayCast(arg_28_1)
	end

	return
end

function ys.Battle.CardPuzzleHandBoard:UnlockCardInHand(arg_29_1)
	if arg_29_1 then
		arg_29_1:ChangeState(var_0_0.Battle.CardPuzzleCombatCard.STATE_FREE)
	else
		for iter_29_0, iter_29_1 in ipairs(self._activeCardList) do
			iter_29_1:ChangeState(var_0_0.Battle.CardPuzzleCombatCard.STATE_FREE)
		end
	end

	return
end

function ys.Battle.CardPuzzleHandBoard:TryPlayCard(arg_30_1)
	return (self._cardPuzzleInfo:PlayCard((arg_30_1:GetCardInfo())))
end

function ys.Battle.CardPuzzleHandBoard:TryPlayReturnCard(arg_31_1)
	return (self._cardPuzzleInfo:ReturnCard((arg_31_1:GetCardInfo())))
end

function ys.Battle.CardPuzzleHandBoard.Dispose(arg_32_0)
	return
end

return
