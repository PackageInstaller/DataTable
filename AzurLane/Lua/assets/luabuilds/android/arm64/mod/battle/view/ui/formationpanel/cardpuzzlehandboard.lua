ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleCardPuzzleConfig
local var_0_3 = var_0.Battle.BattleCardPuzzleEvent
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.CardPuzzleHandBoard = var_0_10005("CardPuzzleHandBoard")

local var_0_5 = var_0.Battle.CardPuzzleHandBoard

var_0_5.__name = "CardPuzzleHandBoard"
var_0_5.BASE_GAP = 166
var_0_5.BASE_SIBLING = 4

function var_0_5.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._areaGO = arg_1_2

	arg_1_0:init()

	return
end

function var_0_5.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._cardPuzzleInfo = arg_2_1

	local var_2_0 = arg_2_0._cardPuzzleInfo

	arg_2_0._hand = var_2.GetHand(var_2_0)

	local var_2_1 = arg_2_0._hand

	var_2.RegisterEventListener(var_2_1, arg_2_0, var_0_3.UPDATE_CARDS, arg_2_0.onUpdateCards)

	local var_2_2 = arg_2_0._cardPuzzleInfo

	var_2.RegisterEventListener(var_2_2, arg_2_0, var_0_3.UPDATE_FLEET_ATTR, arg_2_0.onUpdateFleetAttr)
	arg_2_0:onUpdateCards()

	return
end

function var_0_5.Update(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0._activeCardList) do
		iter_3_1:Update()
	end

	ipairs = var_1

	for iter_3_2, iter_3_3 in var_1(arg_3_0._freeCardList) do
		iter_3_3:Update()
	end

	return
end

function var_0_5.onUpdateCards(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._hand
	local var_4_1 = var_2.GetCardList(var_4_0)
	local var_4_2 = #arg_4_0._activeCardList

	while 0 < var_4_2 do
		local var_4_3 = arg_4_0._activeCardList[var_4_2]
		local var_4_4 = var_4.GetCardInfo(var_4_3)

		table = var_1_10006

		if not var_1_10006.contains(var_4_1, var_4_4) then
			if var_4_4:GetCurrentPile() == arg_4_0._cardPuzzleInfo.CARD_PILE_INDEX_DECK then
				arg_4_0:delayRecyleCard(var_4)
			else
				arg_4_0:recyleCard(var_4)
			end
		end

		var_4_2 = var_4_2 - 1
	end

	ipairs = var_4

	for iter_4_0, iter_4_1 in var_4(var_4_1) do
		local var_4_5

		ipairs = var_1_10010

		for iter_4_2, iter_4_3 in var_1_10010(arg_4_0._activeCardList) do
			if iter_4_3:GetCardInfo() == iter_4_1 then
				var_4_5 = iter_4_3

				break
			end
		end

		if not var_4_5 then
			local var_4_6 = arg_4_0:getCard()

			var_9.SetCardInfo(var_4_6, iter_4_1)
			var_9:UpdateView()

			if iter_4_1:GetFromPile() ~= arg_4_0._cardPuzzleInfo.CARD_PILE_INDEX_DECK or not arg_4_0._drawPos then
				var_1_10010 = arg_4_0._generatePos
			end

			var_9:DrawAnima(var_1_10010)
			var_9:SetMoveLerp(0.1)
			var_9:ChangeState(var_9.STATE_FREE)

			table = var_11

			var_11.insert(arg_4_0._activeCardList, var_9)
		end
	end

	arg_4_0:updateCardReferenceInHand()

	return
end

function var_0_5.getCard(arg_5_0)
	local var_5_0

	if #arg_5_0._idleCardList > 0 then
		table = var_2
		var_5_0 = var_2.remove(arg_5_0._idleCardList, 1)
	else
		local var_5_1 = arg_5_0._resManager
		local var_5_2 = var_2.InstCardPuzzleCard(var_5_1).transform

		var_3.SetParent(var_5_2, arg_5_0._cardContainer)

		Vector3 = var_4
		var_3.localScale = var_4(0.57, 0.57, 0)
		Vector3 = var_4
		var_3.localPosition = var_4.zero
		var_5_0 = var_0.Battle.CardPuzzleCombatCard.New(var_3)
	end

	local function var_5_3()
		return
	end

	local function var_5_4()
		local var_7_0 = var_5_0

		var_0.ChangeState(var_7_0, var_5_0.STATE_FREE)

		local var_7_1 = arg_5_0._cardPuzzleInfo

		var_0.LongPressCard(var_7_1, var_5_0, false)

		return
	end

	local function var_5_5()
		local var_8_0 = var_5_0

		if var_0.GetState(var_8_0) == var_5_0.STATE_LONG_PRESS then
			var_5_4()
		end

		local var_8_1 = var_5_0

		if var_0.GetState(var_8_1) ~= var_5_0.STATE_LOCK then
			local var_8_2 = arg_5_0

			var_0.LockCardInHand(var_8_2)

			local var_8_3 = arg_5_0

			var_0.UnlockCardInHand(var_8_3, var_5_0)

			local var_8_4 = arg_5_0

			var_0.setDragingCard(var_8_4, var_5_0)

			arg_5_0._holdingCard = var_5_0

			local var_8_5 = arg_5_0

			var_0.activeHighlight(var_8_5, true)

			local var_8_6 = arg_5_0._cardPuzzleInfo

			var_0.BlockComponentByCard(var_8_6, true)

			local var_8_7 = arg_5_0

			var_0.SetAllCardBlockRayCast(var_8_7, false)

			local var_8_8 = var_5_0

			var_0.SetSibling(var_8_8, #arg_5_0._activeCardList + var_0_5.BASE_SIBLING)

			local var_8_9 = var_5_0

			var_0.SetMoveLerp(var_8_9, 0.5)

			local var_8_10 = var_5_0

			var_0.ChangeState(var_8_10, var_5_0.STATE_DRAG)
		end

		return
	end

	local function var_5_6(arg_9_0)
		local var_9_0 = var_5_0

		var_1.UpdateDragPosition(var_9_0, arg_9_0)

		return
	end

	local function var_5_7()
		local var_10_0 = true
		local var_10_1 = arg_5_0

		var_1.setDragingCard(var_10_1)

		if arg_5_0._cardEnterDeck then
			local var_10_2 = arg_5_0

			var_10_0 = var_1.TryPlayReturnCard(var_10_2, var_5_0)
		elseif arg_5_0._cardEnterHand == true then
			var_10_0 = false
		else
			local var_10_3 = arg_5_0

			var_10_0 = var_1.TryPlayCard(var_10_3, var_5_0)
		end

		if not var_10_0 then
			local var_10_4 = var_5_0

			var_1.SetMoveLerp(var_10_4)

			local var_10_5 = arg_5_0

			var_1.updateCardReferenceInHand(var_10_5)
		end

		arg_5_0._cardEnterHand = nil
		arg_5_0._cardEnterDeck = nil

		local var_10_6 = arg_5_0

		var_1.UnlockCardInHand(var_10_6)

		local var_10_7 = arg_5_0

		var_1.activeHighlight(var_10_7, false)

		local var_10_8 = arg_5_0

		var_1.SetAllCardBlockRayCast(var_10_8, true)

		onDelayTick = var_1

		var_1(function()
			local var_11_0 = arg_5_0._cardPuzzleInfo

			var_0.BlockComponentByCard(var_11_0, false)

			return
		end, 0.06)

		return
	end

	local function var_5_8()
		local var_12_0 = var_5_0

		var_0.ChangeState(var_12_0, var_5_0.STATE_LONG_PRESS)

		local var_12_1 = arg_5_0._cardPuzzleInfo

		var_0.LongPressCard(var_12_1, var_5_0, true)

		return
	end

	var_5_0:ConfigOP(var_5_3, var_5_5, var_5_6, var_5_7, var_5_8, var_5_4)

	return var_5_0
end

function var_0_5.recyleCard(arg_13_0, arg_13_1)
	ipairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0._activeCardList) do
		if iter_13_1 == arg_13_1 then
			arg_13_1:SetToObjPoolRecylePos()

			table = var_7

			var_7.remove(arg_13_0._activeCardList, iter_13_0)

			break
		end
	end

	table = var_2

	var_2.insert(arg_13_0._idleCardList, arg_13_1)

	return
end

function var_0_5.delayRecyleCard(arg_14_0, arg_14_1)
	arg_14_1:ChangeState(arg_14_1.STATE_LOCK)

	ipairs = var_2

	for iter_14_0, iter_14_1 in var_2(arg_14_0._activeCardList) do
		if iter_14_1 == arg_14_1 then
			table = var_1_10007

			var_1_10007.remove(arg_14_0._activeCardList, iter_14_0)

			break
		end
	end

	table = var_2

	var_2.insert(arg_14_0._freeCardList, arg_14_1)
	arg_14_1:MoveToDeck(function()
		ipairs = var_2_10000

		for iter_15_0, iter_15_1 in var_2_10000(arg_14_0._freeCardList) do
			if iter_15_1 == arg_14_1 then
				local var_15_0 = arg_14_1

				var_5.SetToObjPoolRecylePos(var_15_0)

				table = var_5

				var_5.remove(arg_14_0._freeCardList, iter_15_0)

				break
			end
		end

		table = var_0

		var_0.insert(arg_14_0._idleCardList, arg_14_1)

		return
	end, arg_14_0._drawPos)

	return
end

function var_0_5.onUpdateFleetAttr(arg_16_0, arg_16_1)
	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0._activeCardList) do
		iter_16_1:UpdateTotalCost()
		iter_16_1:UpdateBoostHint()

		local var_16_0 = iter_16_1:GetCardInfo()
	end

	return
end

function var_0_5.init(arg_17_0)
	var_0.EventListener.AttachEventListener(arg_17_0)

	arg_17_0._cardContainer = arg_17_0._go.transform
	arg_17_0._resManager = var_0.Battle.BattleResourceManager.GetInstance()
	arg_17_0._activeCardList = {}
	arg_17_0._idleCardList = {}
	arg_17_0._freeCardList = {}

	local var_17_0 = arg_17_0._cardContainer

	arg_17_0._startPos = var_1.Find(var_17_0, "handStart").localPosition

	local var_17_1 = arg_17_0._cardContainer

	arg_17_0._generatePos = var_1.Find(var_17_1, "generateStart").localPosition

	local var_17_2 = arg_17_0._cardContainer

	arg_17_0._drawPos = var_1.Find(var_17_2, "drawStart").localPosition

	local var_17_3 = arg_17_0._cardContainer

	arg_17_0._cancelArea = var_1.Find(var_17_3, "cancel_area")

	local var_17_4 = arg_17_0._cardContainer

	arg_17_0._returnArea = var_1.Find(var_17_4, "return_area")
	GetOrAddComponent = var_1
	arg_17_0._handDelegate = var_1(arg_17_0._cancelArea, "EventTriggerListener")
	GetOrAddComponent = var_1
	arg_17_0._deckDelegate = var_1(arg_17_0._returnArea, "EventTriggerListener")
	arg_17_0._area = arg_17_0._areaGO.transform

	local var_17_5 = arg_17_0._area

	arg_17_0._cancelHint = var_1.Find(var_17_5, "hand_hint")

	local var_17_6 = arg_17_0._area

	arg_17_0._returnHint = var_1.Find(var_17_6, "deck_hint")

	local var_17_7 = arg_17_0._area

	arg_17_0._readyHint = var_1.Find(var_17_7, "cast_hint")

	return
end

function var_0_5.updateCardReferenceInHand(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0._activeCardList) do
		local var_18_0 = arg_18_0:getcardGap()

		Vector3 = var_1_10007
		var_1_10007 = var_1_10007.New(arg_18_0._startPos.x + (iter_18_0 - 1) * var_18_0, arg_18_0._startPos.y, 0)

		iter_18_1:SetReferencePos(var_1_10007)
		iter_18_1:SetSibling(iter_18_0 + var_0_5.BASE_SIBLING)
	end

	return
end

function var_0_5.getcardGap(arg_19_0)
	local var_19_0 = #arg_19_0._activeCardList

	if #arg_19_0._activeCardList <= var_0_2.BASE_MAX_HAND then
		return var_0_5.BASE_GAP
	else
		return 830 / (var_19_0 - 1)
	end

	return
end

function var_0_5.setDragingCard(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._cardPuzzleInfo

	var_2.SetDragingCard(var_20_0, arg_20_1)

	local var_20_1 = arg_20_0._cardPuzzleInfo

	var_2.SendUpdateAim(var_20_1)

	return
end

function var_0_5.sort(arg_21_0)
	return
end

function var_0_5.activeHighlight(arg_22_0, arg_22_1)
	if arg_22_1 then
		local var_22_0 = arg_22_0._handDelegate

		var_1_10002.AddPointEnterFunc(var_22_0, function()
			local var_23_0 = arg_22_0

			var_23_0._cardEnterHand = true
			setActive = var_23_0

			var_23_0(arg_22_0._cancelHint, true)

			setActive = var_23_0

			var_23_0(arg_22_0._returnHint, false)

			setActive = var_23_0

			var_23_0(arg_22_0._readyHint, false)

			return
		end)

		local var_22_1 = arg_22_0._handDelegate

		var_1_10002.AddPointExitFunc(var_22_1, function()
			local var_24_0 = arg_22_0

			var_24_0._cardEnterHand = false
			setActive = var_24_0

			var_24_0(arg_22_0._cancelHint, false)

			setActive = var_24_0

			var_24_0(arg_22_0._readyHint, true)

			return
		end)

		local var_22_2 = arg_22_0._deckDelegate

		var_1_10002.AddPointEnterFunc(var_22_2, function()
			local var_25_0 = arg_22_0

			var_25_0._cardEnterDeck = true
			setActive = var_25_0

			var_25_0(arg_22_0._readyHint, false)

			local var_25_1 = arg_22_0._holdingCard
			local var_25_2 = var_0.GetCardInfo(var_25_1)
			local var_25_3 = var_0.GetReturnCost(var_25_2) ~= nil

			setActive = var_25_1

			var_25_1(arg_22_0._cancelHint, not var_25_3)

			setActive = var_25_1

			var_25_1(arg_22_0._returnHint, var_25_3)

			return
		end)

		local var_22_3 = arg_22_0._deckDelegate

		var_1_10002.AddPointExitFunc(var_22_3, function()
			local var_26_0 = arg_22_0

			var_26_0._cardEnterDeck = false
			setActive = var_26_0

			var_26_0(arg_22_0._cancelHint, false)

			setActive = var_26_0

			var_26_0(arg_22_0._readyHint, true)

			return
		end)
	else
		setActive = var_1_10002

		var_1_10002(arg_22_0._cancelHint, false)

		setActive = var_1_10002

		var_1_10002(arg_22_0._returnHint, false)

		setActive = var_1_10002

		var_1_10002(arg_22_0._readyHint, false)

		local var_22_4 = arg_22_0._handDelegate

		var_1_10002.RemovePointEnterFunc(var_22_4)

		local var_22_5 = arg_22_0._handDelegate

		var_1_10002.RemovePointExitFunc(var_22_5)

		local var_22_6 = arg_22_0._deckDelegate

		var_1_10002.RemovePointEnterFunc(var_22_6)

		local var_22_7 = arg_22_0._deckDelegate

		var_1_10002.RemovePointExitFunc(var_22_7)
	end

	setActive = var_1_10002

	var_1_10002(arg_22_0._cancelArea, arg_22_1)

	setActive = var_1_10002

	var_1_10002(arg_22_0._returnArea, arg_22_1)

	return
end

function var_0_5.LockCardInHand(arg_27_0)
	ipairs = var_1_10001

	for iter_27_0, iter_27_1 in var_1_10001(arg_27_0._activeCardList) do
		iter_27_1:ChangeState(iter_27_1.STATE_LOCK)
	end

	return
end

function var_0_5.SetAllCardBlockRayCast(arg_28_0, arg_28_1)
	ipairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0._activeCardList) do
		iter_28_1:BlockRayCast(arg_28_1)
	end

	return
end

function var_0_5.UnlockCardInHand(arg_29_0, arg_29_1)
	if arg_29_1 then
		arg_29_1:ChangeState(var_0.Battle.CardPuzzleCombatCard.STATE_FREE)
	else
		ipairs = var_1_10002

		for iter_29_0, iter_29_1 in var_1_10002(arg_29_0._activeCardList) do
			iter_29_1:ChangeState(var_0.Battle.CardPuzzleCombatCard.STATE_FREE)
		end
	end

	return
end

function var_0_5.TryPlayCard(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1:GetCardInfo()
	local var_30_1 = arg_30_0._cardPuzzleInfo

	return (var_3.PlayCard(var_30_1, var_30_0))
end

function var_0_5.TryPlayReturnCard(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1:GetCardInfo()
	local var_31_1 = arg_31_0._cardPuzzleInfo

	return (var_3.ReturnCard(var_31_1, var_31_0))
end

function var_0_5.Dispose(arg_32_0)
	return
end

return
