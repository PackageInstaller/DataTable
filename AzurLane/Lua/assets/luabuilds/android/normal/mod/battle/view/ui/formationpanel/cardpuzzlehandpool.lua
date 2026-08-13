ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleCardPuzzleEvent
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.CardPuzzleHandPool = var_0_10004("CardPuzzleHandPool")

local var_0_4 = var_0.Battle.CardPuzzleHandPool

var_0_4.__name = "CardPuzzleHandPool"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	pg = var_2

	var_2.DelegateInfo.New(arg_1_0)

	return
end

function var_0_4.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._cardPuzzleInfo = arg_2_1

	local var_2_0 = arg_2_0._cardPuzzleInfo

	arg_2_0._hand = var_2.GetHand(var_2_0)

	for iter_2_0 = 1, var_0.Battle.BattleFleetCardPuzzleHand.MAX_HAND do
		arg_2_0:instCardView()
	end

	local var_2_1 = arg_2_0._hand

	var_2.RegisterEventListener(var_2_1, arg_2_0, var_0_2.UPDATE_CARDS, arg_2_0.onUpdateCards)

	local var_2_2 = arg_2_0._cardPuzzleInfo

	var_2.RegisterEventListener(var_2_2, arg_2_0, var_0_2.UPDATE_FLEET_ATTR, arg_2_0.onUpdateFleetAttr)
	arg_2_0:onUpdateCards()

	return
end

function var_0_4.onUpdateCards(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._hand
	local var_3_1 = var_2.GetCardList(var_3_0)

	for iter_3_0 = 1, arg_3_0._hand.MAX_HAND do
		local var_3_2 = arg_3_0._cardList[iter_3_0]

		var_7.SetCardInfo(var_3_2, var_3_1[iter_3_0])
	end

	return
end

function var_0_4.onUpdateFleetAttr(arg_4_0, arg_4_1)
	for iter_4_0 = 1, arg_4_0._hand.MAX_HAND do
		local var_4_0 = arg_4_0._cardList[iter_4_0]

		var_6.UpdateTotalCost(var_4_0)
	end

	return
end

function var_0_4.init(arg_5_0)
	var_0.EventListener.AttachEventListener(arg_5_0)

	arg_5_0._cardList = {}

	local var_5_0 = arg_5_0._go.transform

	arg_5_0._cardContainer = var_1.Find(var_5_0, "card_container")

	local var_5_1 = arg_5_0._go.transform

	arg_5_0._cardTpl = var_1.Find(var_5_1, "card_tpl")

	return
end

function var_0_4.updateHandCard(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0._cardList) do
		iter_6_1:updateCardView()
	end

	return
end

function var_0_4.sort(arg_7_0)
	return
end

function var_0_4.instCardView(arg_8_0)
	cloneTplTo = var_1_10001

	local var_8_0 = var_1_10001(arg_8_0._cardTpl, arg_8_0._cardContainer)
	local var_8_1 = var_0.Battle.CardPuzzleHandCardButton.New

	go = var_3

	local var_8_2 = var_8_1(var_3(var_8_0))

	table = var_3

	var_3.insert(arg_8_0._cardList, var_8_2)
	var_8_2:ConfigCallback(function(arg_9_0)
		local var_9_0 = arg_8_0._cardPuzzleInfo

		var_1.PlayCard(var_9_0, arg_9_0)

		return
	end)

	return var_8_2
end

function var_0_4.test(arg_10_0, arg_10_1)
	arg_10_0._testContainer = arg_10_1
	LoadAndInstantiateAsync = var_1_10002

	var_1_10002("UI", "CardTowerCardCombat", function(arg_11_0)
		local var_11_0 = arg_10_0

		pg = var_2_10002

		local var_11_1 = var_2_10002.Pool.New(arg_10_0._testContainer, arg_11_0, 7, 20, false, false)

		var_11_0._cardPool = var_2.InitSize(var_11_1)

		local var_11_2 = arg_10_0._hand
		local var_11_3 = var_1.GetCardList(var_11_2)

		ipairs = var_11_2

		for iter_11_0, iter_11_1 in var_11_2(var_11_3) do
			local var_11_4 = arg_10_0._cardPool
			local var_11_5 = var_7.GetObject(var_11_4).transform

			Vector3 = var_2_10009
			var_11_5.localScale = var_2_10009(0.57, 0.57, 0)

			local var_11_6 = var_0.Battle.CardPuzzleCombatCard.New(var_11_5)

			var_2_10009.SetCardInfo(var_11_6, iter_11_1)

			local var_11_7 = var_2_10009

			var_2_10009.UpdateView(var_11_7)

			local var_11_8 = arg_10_0

			GetOrAddComponent = var_11_7
			var_11_8._modelClick = var_11_7(var_7, "ModelDrag")

			local var_11_9 = arg_10_0

			GetOrAddComponent = var_11
			var_11_9._modelPress = var_11(var_7, "UILongPressTrigger")

			local var_11_10 = arg_10_0

			GetOrAddComponent = var_11
			var_11_10._dragDelegate = var_11(var_7, "EventTriggerListener")
			pg = var_11_10

			var_11_10.DelegateInfo.Add(arg_10_0, arg_10_0._modelClick.onModelClick)

			local var_11_11 = arg_10_0._modelClick.onModelClick

			var_10.AddListener(var_11_11, function()
				return
			end)

			pg = var_10

			var_10.DelegateInfo.Add(arg_10_0, arg_10_0._modelPress.onLongPressed)

			arg_10_0._modelPress.longPressThreshold = 1

			local var_11_12 = arg_10_0._modelPress.onLongPressed

			var_10.RemoveAllListeners(var_11_12)

			local var_11_13 = arg_10_0._modelPress.onLongPressed

			var_10.AddListener(var_11_13, function()
				return
			end)
		end

		return
	end, true, true)

	return
end

function var_0_4.Dispose(arg_14_0)
	arg_14_0._cardTpl = nil
	arg_14_0._cardContainer = nil
	arg_14_0._cardList = nil
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_14_0)

	return
end

return
