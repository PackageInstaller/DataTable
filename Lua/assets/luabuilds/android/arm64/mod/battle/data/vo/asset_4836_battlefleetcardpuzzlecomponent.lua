ys = ys or {}

local var_0_0 = ys
local var_0_3 = ys.Battle.BattleCardPuzzleEvent
local var_0_5 = ys.Battle.BattleConst
local var_0_6 = ys.Battle.BattleConfig
local var_0_7 = ys.Battle.BattleCardPuzzleConfig
local var_0_9 = ys.Battle.BattleDataFunction
local var_0_10 = ys.Battle.CardPuzzleBoardClicker
local var_0_11 = ys.Battle.BattleVariable
local BattleFleetCardPuzzleComponent = class("BattleFleetCardPuzzleComponent")

ys.Battle.BattleFleetCardPuzzleComponent = BattleFleetCardPuzzleComponent
BattleFleetCardPuzzleComponent.__name = "BattleFleetCardPuzzleComponent"
BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DISCARD = -1
BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_HAND = 0
BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DECK = 1
BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_MOVE_DECK = 2

function BattleFleetCardPuzzleComponent:Ctor(arg_1_1)
	var_0_0.EventDispatcher.AttachEventDispatcher(self)
	var_0_0.EventListener.AttachEventListener(self)

	self._fleetVO = arg_1_1

	self:init()

	return
end

function BattleFleetCardPuzzleComponent:CustomConfigID(arg_2_1)
	self._customCombatID = arg_2_1

	self._energy:CustomConfig(self._customCombatID)
	self._moveDeck:CustomConfig(self._customCombatID)

	return
end

function BattleFleetCardPuzzleComponent:Dispose()
	var_0_0.EventDispatcher.DetachEventDispatcher(self)
	var_0_0.EventListener.DetachEventListener(self)

	self._fleetVO = nil

	return
end

function BattleFleetCardPuzzleComponent:GetPuzzleDungeonID()
	return self._customCombatID
end

function BattleFleetCardPuzzleComponent:GetTotalCommonHP()
	return self._maxCommonHP
end

function BattleFleetCardPuzzleComponent:GetCurrentCommonHP()
	return self._currentCommonHP
end

function BattleFleetCardPuzzleComponent:GetEnergy()
	return self._energy
end

function BattleFleetCardPuzzleComponent:EnergyUpdate()
	self._fleetAttr:SetAttr("BaseEnergy", self._energy:GetCurrentEnergy())

	return
end

function BattleFleetCardPuzzleComponent:AppendUnit(arg_9_1)
	arg_9_1:RegisterEventListener(self, var_0_3.UPDATE_COMMON_HP, self.onUpdateCommonHP)

	self._maxCommonHP = self._maxCommonHP + arg_9_1:GetAttrByName("maxHP")
	self._currentCommonHP = self._maxCommonHP

	local var_9_0

	self._cardPuzzleAA:AppendCrewUnit(arg_9_1)

	if arg_9_1:IsMainFleetUnit() then
		self._mainUnit = arg_9_1
		var_9_0 = TeamType.TeamPos.FLAG_SHIP
	else
		self._scoutUnit = arg_9_1

		self._cardPuzzleAA:SwitchHost(arg_9_1)

		var_9_0 = TeamType.TeamPos.LEADER
	end

	self:DispatchEvent((var_0_0.Event.New(var_0_3.UPDATE_FLEET_SHIP, {
		teamType = var_9_0
	})))

	return
end

function BattleFleetCardPuzzleComponent:InitCardPuzzleData(arg_10_1)
	self._fleetVO:GetUnitBound():SwtichDBRGL()

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.relicList) do
		table.insert(self._relicList, iter_10_1)

		for iter_10_2, iter_10_3 in ipairs((iter_10_1:GetEffects())) do
			if iter_10_3.type == CardPuzzleGift.EFFECT_TYPE.BATTLE_BUFF then
				for iter_10_4, iter_10_5 in ipairs(iter_10_3.arg_list) do
					self._fleetBuff:AttachCardPuzzleBuff((var_0_0.Battle.BattleFleetBuffUnit.New(iter_10_5)))
				end
			end
		end
	end

	return
end

function BattleFleetCardPuzzleComponent:RemoveUnit(arg_11_1)
	arg_11_1:UnregisterEventListener(self, var_0_3.UPDATE_COMMON_HP)

	return
end

function BattleFleetCardPuzzleComponent:GetMainUnit()
	return self._mainUnit
end

function BattleFleetCardPuzzleComponent:GetScoutUnit()
	return self._scoutUnit
end

function BattleFleetCardPuzzleComponent:AttachMoveController(arg_14_1)
	self._moveController = arg_14_1

	return
end

function BattleFleetCardPuzzleComponent:TakeoverMovecontroller(arg_15_1, arg_15_2)
	self._moveController:InputTargetPoint(arg_15_1, arg_15_2)
	self._fleetVO:DispatchEvent(var_0_0.Event.New(var_0_3.FLEET_MOVE_TO, {
		pos = arg_15_1
	}))

	return
end

function BattleFleetCardPuzzleComponent:ReturnMovecontroller()
	self._fleetVO:DispatchEvent(var_0_0.Event.New(var_0_3.FLEET_MOVE_TO, {}))

	return
end

function BattleFleetCardPuzzleComponent:PlayCard(arg_17_1)
	if self:CheckCardCastable(arg_17_1) then
		arg_17_1:Precast(function()
			self._energy:ConsumeEnergy((arg_17_1:GetTotalCost()))
			self._hand:Remove(arg_17_1)
			self._hand:EnterCoolDownByType(arg_17_1:GetCardType(), arg_17_1:GetCardCD())

			if arg_17_1:GetMoveAfterCast() == BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DISCARD then
				self._discard:Add(arg_17_1)
			end

			self:TryDrawCard()

			return
		end)

		return true
	else
		return false
	end

	return
end

function BattleFleetCardPuzzleComponent:ReturnCard(arg_19_1)
	if self:CheckCardReturnable(arg_19_1) then
		arg_19_1:Retrun(function()
			self._energy:ConsumeEnergy((arg_19_1:GetReturnCost()))
			self._hand:Remove(arg_19_1)
			self:TryDrawCard()

			return
		end)

		return true
	else
		return false
	end

	return
end

function BattleFleetCardPuzzleComponent:PlayMoveCard(arg_21_1)
	arg_21_1:SetInputPoint(self._clickToScenePoint)
	arg_21_1:Precast()
	self._moveDeck:Remove(arg_21_1)

	return
end

function BattleFleetCardPuzzleComponent:CheckCardCastable(arg_22_1)
	if arg_22_1:GetTotalCost() <= self._energy:GetCurrentEnergy() and arg_22_1:GetCastCondition() ~= false then
		return true
	end

	return
end

function BattleFleetCardPuzzleComponent:CheckCardReturnable(arg_23_1)
	local var_23_0 = arg_23_1:GetReturnCost()

	if var_23_0 and var_23_0 <= self._energy:GetCurrentEnergy() then
		return true
	end

	return
end

function BattleFleetCardPuzzleComponent:SetDragingCard(arg_24_1)
	self._dragingCard = arg_24_1

	return
end

function BattleFleetCardPuzzleComponent:GetDragingCard()
	return self._dragingCard
end

function BattleFleetCardPuzzleComponent:SendUpdateAim()
	self._fleetVO:DispatchEvent(var_0_0.Event.New(var_0_3.UPDATE_CARD_TARGET_FILTER, {
		targetFilterList = (self._dragingCard or nil) and (self._dragingCard:GetCardInfo():GetCardEffectTargetFilterList() or {})
	}))

	return
end

function BattleFleetCardPuzzleComponent:Start()
	self._fleetBuff:Trigger(var_0_5.BuffEffectType.ON_START_GAME)

	for iter_27_0, iter_27_1 in pairs(var_0_7.CustomAttrInitList) do
		self._fleetAttr:AddBaseAttr(iter_27_0, iter_27_1)
	end

	if self._customCombatID and var_0_9.GetPuzzleDungeonTemplate(self._customCombatID) then
		local var_27_0 = var_0_9.GetPuzzleDungeonTemplate(self._customCombatID)

		for iter_27_2, iter_27_3 in ipairs(var_27_0.deck) do
			self._deck:Add((self:GenerateCard(iter_27_3)))
		end

		local var_27_1 = 0

		while var_27_1 < var_27_0.init_move do
			self._moveDeck:Add((self:GenerateCard(var_0_7.BASE_MOVE_ID)))

			var_27_1 = var_27_1 + 1
		end

		if var_27_0.init_shuffle ~= var_0_0.Battle.BattleFleetCardPuzzleDeck.NOT_INIT_SHUFFLE then
			self._deck:Shuffle()
		end
	else
		self._deck:Shuffle()
	end

	self._energy:Start()
	self:TryDrawCard()
	self:SetClickEnable(true)

	return
end

function BattleFleetCardPuzzleComponent:Update(arg_28_1)
	self._energy:Update(arg_28_1)
	self._fleetBuff:Update(arg_28_1)
	self._cardPuzzleAA:Update(arg_28_1)
	self:updateMoveDeck(arg_28_1)
	self._hand:Update(arg_28_1)

	return
end

function BattleFleetCardPuzzleComponent:UpdateClickPos(arg_29_1, arg_29_2, arg_29_3)
	var_0_10 = var_0_10 or var_0_0.Battle.CardPuzzleBoardClicker

	if arg_29_3 == var_0_10.CLICK_STATE_CLICK then
		self._uiPoint:Set(arg_29_1, arg_29_2)
		var_0_0.Battle.BattleVariable.UIPosToScenePos(self._uiPoint, self._clickToScenePoint)
		self._fleetVO:GetUnitBound():FixCardPuzzleInput(self._clickToScenePoint)
		self._clickToScenePointCache:Copy(self._clickToScenePoint)
		self._fleetVO:DispatchEvent(var_0_0.Event.New(var_0_3.ON_BOARD_CLICK, {
			click = arg_29_3
		}))
	elseif arg_29_3 == var_0_10.CLICK_STATE_DRAG then
		self._uiPoint:Set(arg_29_1, arg_29_2)
		var_0_0.Battle.BattleVariable.UIPosToScenePos(self._uiPoint, self._clickToScenePoint)
		self._fleetVO:GetUnitBound():FixCardPuzzleInput(self._clickToScenePoint)

		if not self._clickToScenePointCache:Equals(self._clickToScenePoint) then
			self._fleetVO:DispatchEvent(var_0_0.Event.New(var_0_3.ON_BOARD_CLICK, {
				click = arg_29_3
			}))
		end

		self._clickToScenePointCache:Copy(self._clickToScenePoint)
	elseif arg_29_3 == var_0_10.CLICK_STATE_RELEASE then
		if self._clickEnable then
			local var_29_0 = self._moveDeck:TryPlayTopMoveCard()

			if var_29_0 then
				self:PlayMoveCard(var_29_0)
			end
		end

		self._fleetVO:DispatchEvent(var_0_0.Event.New(var_0_3.ON_BOARD_CLICK, {
			click = arg_29_3
		}))
	end

	return
end

function BattleFleetCardPuzzleComponent:SetClickEnable(arg_30_1)
	self._clickEnable = arg_30_1

	return
end

function BattleFleetCardPuzzleComponent:GetClickEnable()
	return self._clickEnable
end

function BattleFleetCardPuzzleComponent:BlockComponentByCard(arg_32_1)
	arg_32_1 = not arg_32_1

	self:SetClickEnable(arg_32_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_3.COMMON_BUTTON_ENABLE, {
		flag = arg_32_1
	}))

	return
end

function BattleFleetCardPuzzleComponent:LongPressCard(arg_33_1, arg_33_2)
	if arg_33_2 then
		self:DispatchEvent(var_0_0.Event.New(var_0_3.SHOW_CARD_DETAIL, {
			card = arg_33_1
		}))
		self:DispatchBulletTime(0.1)
	else
		self:DispatchEvent(var_0_0.Event.New(var_0_3.SHOW_CARD_DETAIL, {}))
		self:DispatchBulletTime()
	end

	return
end

function BattleFleetCardPuzzleComponent:DispatchBulletTime(arg_34_1)
	if arg_34_1 then
		var_0_11.AppendIFFFactor(var_0_6.FOE_CODE, "check_card", arg_34_1)
		var_0_11.AppendIFFFactor(var_0_6.FRIENDLY_CODE, "check_card", arg_34_1)
	else
		var_0_11.RemoveIFFFactor(var_0_6.FOE_CODE, "check_card")
		var_0_11.RemoveIFFFactor(var_0_6.FRIENDLY_CODE, "check_card")
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_3.LONG_PRESS_BULLET_TIME, {
		timeScale = arg_34_1
	}))

	return
end

function BattleFleetCardPuzzleComponent:dispatchClick(arg_35_1)
	if self._clickEnable then
		self._fleetVO:DispatchEvent(var_0_0.Event.New(var_0_3.ON_BOARD_CLICK, {
			click = arg_35_1
		}))
	end

	return
end

function BattleFleetCardPuzzleComponent:GetHand()
	return self._hand
end

function BattleFleetCardPuzzleComponent:GetDeck()
	return self._deck
end

function BattleFleetCardPuzzleComponent:GetRelicList()
	return self._relicList
end

function BattleFleetCardPuzzleComponent:GetTouchScreenPoint()
	return self._clickToScenePoint
end

function BattleFleetCardPuzzleComponent:GetMoveDeck()
	return self._moveDeck
end

function BattleFleetCardPuzzleComponent:GetCardPileByIndex(arg_41_1)
	return self._cardPileList[arg_41_1]
end

function BattleFleetCardPuzzleComponent:GetFleetVO()
	return self._fleetVO
end

function BattleFleetCardPuzzleComponent:GetAttrManager()
	return self._fleetAttr
end

function BattleFleetCardPuzzleComponent:GetBuffManager()
	return self._fleetBuff
end

function BattleFleetCardPuzzleComponent:GetCardPuzzleAAUnit()
	return self._cardPuzzleAA
end

function BattleFleetCardPuzzleComponent:TryDrawCard()
	while not self._hand:IsFull() and self._deck:GetLength() > 0 do
		local var_46_0 = self._deck:Pop()

		self._hand:Add(var_46_0)
		var_46_0:SetBaseEnergyFillDuration((self._energy:FillToCooldown((var_46_0:GetTotalCost()))))
	end

	return
end

function BattleFleetCardPuzzleComponent:FlushHandOverheat()
	for iter_47_0, iter_47_1 in ipairs((self._hand:GetCardList())) do
		iter_47_1:SetBaseEnergyFillDuration((self._energy:FillToCooldown((iter_47_1:GetTotalCost()))))
	end

	return
end

function BattleFleetCardPuzzleComponent:HoldForInput(arg_48_1)
	self._holdingCard = arg_48_1

	return
end

function BattleFleetCardPuzzleComponent:GenerateCard(arg_49_1)
	local var_49_0 = var_0_0.Battle.BattleCardPuzzleCard.New(self)

	var_49_0:SetCardTemplate(arg_49_1)

	return var_49_0
end

function BattleFleetCardPuzzleComponent:UpdateAttrByBuff(arg_50_1, arg_50_2)
	return
end

function BattleFleetCardPuzzleComponent:AddAttrBySkill(arg_51_1, arg_51_2)
	self._fleetAttr:AddBaseAttr(arg_51_1, arg_51_2)

	return
end

function BattleFleetCardPuzzleComponent:UpdateAttrBySet(arg_52_1, arg_52_2)
	self._fleetAttr:SetAttr(arg_52_1, arg_52_2)

	return
end

function BattleFleetCardPuzzleComponent:DispatchUpdateAttr(arg_53_1)
	self:DispatchEvent((var_0_0.Event.New(var_0_3.UPDATE_FLEET_ATTR, {
		attrName = arg_53_1
	})))

	if self._dragingCard then
		self:SendUpdateAim()
	end

	return
end

function BattleFleetCardPuzzleComponent:IsAAActive()
	return self._fleetAttr:GetCurrent("CardAntiaircraft") > 0
end

function BattleFleetCardPuzzleComponent:ConsumeAACounter(arg_55_1)
	self._fleetAttr:AddBaseAttr("CardAntiaircraft", (arg_55_1 or 1) * -1)

	return
end

function BattleFleetCardPuzzleComponent:init()
	self._maxCommonHP = 0
	self._currentCommonHP = 0
	self._fleetAttr = var_0_0.Battle.BattleFleetCardPuzzleAttribute.New(self)
	self._fleetBuff = var_0_0.Battle.BattleFleetCardPuzzleFleetBuffManager.New(self)
	self._energy = var_0_0.Battle.BattleFleetCardPuzzleEnergy.New(self)
	self._deck = var_0_0.Battle.BattleFleetCardPuzzleDeck.New(self, BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DECK)
	self._hand = var_0_0.Battle.BattleFleetCardPuzzleHand.New(self, BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_HAND)
	self._discard = var_0_0.Battle.BattleFleetCardPuzzleDiscard.New(self, BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DISCARD)
	self._moveDeck = var_0_0.Battle.BattleFleetCardPuzzleMoveDeck.New(self, BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_MOVE_DECK)
	self._cardPileList = {
		[BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DISCARD] = self._discard,
		[BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_HAND] = self._hand,
		[BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_DECK] = self._deck,
		[BattleFleetCardPuzzleComponent.CARD_PILE_INDEX_MOVE_DECK] = self._moveDeck
	}
	self._uiPoint = Vector2.New(0, 0)
	self._clickToScenePoint = Vector3.New(0, 0, 0)
	self._clickToScenePointCache = Vector3.New(0, 0, 0)
	self._scoutUnit = nil
	self._mainUnit = nil
	self._relicList = {}
	self._cardPuzzleAA = var_0_0.Battle.BattleFleetCardPuzzleAntiAirUnit.New(self)

	function self._fleetVO.GetFleetAntiAirWeapon()
		return self._cardPuzzleAA
	end

	self:initEvent()

	return
end

function BattleFleetCardPuzzleComponent:initEvent()
	self._hand:RegisterEventListener(self, var_0_3.UPDATE_CARDS, self.onUpdateHands)
	self._deck:RegisterEventListener(self, var_0_3.UPDATE_CARDS, self.onUpdateDeck)

	return
end

function BattleFleetCardPuzzleComponent:onUpdateHands(arg_59_1)
	local var_59_0 = self._hand:GetCardList()
	local var_59_1 = {}

	for iter_59_0, iter_59_1 in ipairs(var_59_0) do
		for iter_59_2, iter_59_3 in ipairs((iter_59_1:GetLabels())) do
			var_59_1[iter_59_3] = (var_59_1[iter_59_3] or 0) + 1
		end
	end

	self._fleetAttr:SetAttr("HandCount", #var_59_0)

	for iter_59_4, iter_59_5 in pairs(var_59_1) do
		self._fleetAttr:SetAttr(iter_59_4 .. "LabelInHand", iter_59_5)
	end

	self:DispatchEvent((var_0_0.Event.New(var_0_3.UPDATE_FLEET_ATTR, {})))

	return
end

function BattleFleetCardPuzzleComponent:onUpdateDeck(arg_60_1)
	self._fleetAttr:SetAttr("DeckCount", #self._deck:GetCardList())

	if arg_60_1.Data.type == var_0_0.Battle.BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_ADD or arg_60_1.Data.type == var_0_0.Battle.BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_BOTTOM then
		self:TryDrawCard()
	end

	return
end

function BattleFleetCardPuzzleComponent:updateMoveDeck(arg_61_1)
	self._moveDeck:Update(arg_61_1)

	if self._moveDeck:GetGeneratePorcess() >= 1 then
		self._moveDeck:RestartGenrate()
		self._moveDeck:Add((self:GenerateCard(var_0_7.BASE_MOVE_ID)))
	end

	return
end

function BattleFleetCardPuzzleComponent:onUpdateCommonHP(arg_62_1)
	self._currentCommonHP = math.clamp(self._currentCommonHP + arg_62_1.Data.dHP, 0, self._maxCommonHP)

	return
end

return
