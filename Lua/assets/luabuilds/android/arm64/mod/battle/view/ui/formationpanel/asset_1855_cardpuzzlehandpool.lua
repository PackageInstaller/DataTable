ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleCardPuzzleEvent

ys.Battle.CardPuzzleHandPool = class("CardPuzzleHandPool")
ys.Battle.CardPuzzleHandPool.__name = "CardPuzzleHandPool"

function ys.Battle.CardPuzzleHandPool:Ctor(arg_1_1)
	self._go = arg_1_1

	self:init()
	pg.DelegateInfo.New(self)

	return
end

function ys.Battle.CardPuzzleHandPool:SetCardPuzzleComponent(arg_2_1)
	self._cardPuzzleInfo = arg_2_1
	self._hand = self._cardPuzzleInfo:GetHand()

	for iter_2_0 = 1, var_0_0.Battle.BattleFleetCardPuzzleHand.MAX_HAND do
		self:instCardView()
	end

	self._hand:RegisterEventListener(self, var_0_2.UPDATE_CARDS, self.onUpdateCards)
	self._cardPuzzleInfo:RegisterEventListener(self, var_0_2.UPDATE_FLEET_ATTR, self.onUpdateFleetAttr)
	self:onUpdateCards()

	return
end

function ys.Battle.CardPuzzleHandPool:onUpdateCards(arg_3_1)
	local var_3_0 = self._hand:GetCardList()

	for iter_3_0 = 1, self._hand.MAX_HAND do
		self._cardList[iter_3_0]:SetCardInfo(var_3_0[iter_3_0])
	end

	return
end

function ys.Battle.CardPuzzleHandPool:onUpdateFleetAttr(arg_4_1)
	for iter_4_0 = 1, self._hand.MAX_HAND do
		self._cardList[iter_4_0]:UpdateTotalCost()
	end

	return
end

function ys.Battle.CardPuzzleHandPool:init()
	var_0_0.EventListener.AttachEventListener(self)

	self._cardList = {}
	self._cardContainer = self._go.transform:Find("card_container")
	self._cardTpl = self._go.transform:Find("card_tpl")

	return
end

function ys.Battle.CardPuzzleHandPool:updateHandCard()
	for iter_6_0, iter_6_1 in ipairs(self._cardList) do
		iter_6_1:updateCardView()
	end

	return
end

function ys.Battle.CardPuzzleHandPool.sort(arg_7_0)
	return
end

function ys.Battle.CardPuzzleHandPool:instCardView()
	local var_8_0 = var_0_0.Battle.CardPuzzleHandCardButton.New(go((cloneTplTo(self._cardTpl, self._cardContainer))))

	table.insert(self._cardList, var_8_0)
	var_8_0:ConfigCallback(function(arg_9_0)
		self._cardPuzzleInfo:PlayCard(arg_9_0)

		return
	end)

	return var_8_0
end

function ys.Battle.CardPuzzleHandPool.test(arg_10_0, arg_10_1)
	arg_10_0._testContainer = arg_10_1

	LoadAndInstantiateAsync("UI", "CardTowerCardCombat", function(arg_11_0)
		arg_10_0._cardPool = pg.Pool.New(arg_10_0._testContainer, arg_11_0, 7, 20, false, false):InitSize()

		for iter_11_0, iter_11_1 in ipairs((arg_10_0._hand:GetCardList())) do
			local var_11_0 = arg_10_0._cardPool:GetObject()

			var_11_0.transform.localScale = Vector3(0.57, 0.57, 0)

			local var_11_1 = var_0_0.Battle.CardPuzzleCombatCard.New(var_11_0.transform)

			var_11_1:SetCardInfo(iter_11_1)
			var_11_1:UpdateView()

			arg_10_0._modelClick = GetOrAddComponent(var_11_0, "ModelDrag")
			arg_10_0._modelPress = GetOrAddComponent(var_11_0, "UILongPressTrigger")
			arg_10_0._dragDelegate = GetOrAddComponent(var_11_0, "EventTriggerListener")

			pg.DelegateInfo.Add(arg_10_0, arg_10_0._modelClick.onModelClick)
			arg_10_0._modelClick.onModelClick:AddListener(function()
				return
			end)
			pg.DelegateInfo.Add(arg_10_0, arg_10_0._modelPress.onLongPressed)

			arg_10_0._modelPress.longPressThreshold = 1

			arg_10_0._modelPress.onLongPressed:RemoveAllListeners()
			arg_10_0._modelPress.onLongPressed:AddListener(function()
				return
			end)
		end

		return
	end, true, true)

	return
end

function ys.Battle.CardPuzzleHandPool.Dispose(arg_14_0)
	arg_14_0._cardTpl = nil
	arg_14_0._cardContainer = nil
	arg_14_0._cardList = nil

	pg.DelegateInfo.Dispose(arg_14_0)

	return
end

return
