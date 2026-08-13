ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleCardPuzzleEvent
local var_0_4 = var_0.Battle.BattleFormulas
local var_0_5 = var_0.Battle.BattleConst
local var_0_6 = var_0.Battle.BattleConfig
local var_0_7 = var_0.Battle.BattleCardPuzzleConfig
local var_0_8 = var_0.Battle.BattleAttr
local var_0_9 = var_0.Battle.BattleDataFunction
local var_0_10 = var_0.Battle.CardPuzzleBoardClicker
local var_0_11 = var_0.Battle.BattleVariable

class = var_0_10012

local var_0_12 = var_0_10012("BattleFleetCardPuzzleComponent")

var_0.Battle.BattleFleetCardPuzzleComponent = var_0_12
var_0_12.__name = "BattleFleetCardPuzzleComponent"
var_0_12.CARD_PILE_INDEX_DISCARD = -1
var_0_12.CARD_PILE_INDEX_HAND = 0
var_0_12.CARD_PILE_INDEX_DECK = 1
var_0_12.CARD_PILE_INDEX_MOVE_DECK = 2

function var_0_12.Ctor(arg_1_0, arg_1_1)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._fleetVO = arg_1_1

	arg_1_0:init()

	return
end

function var_0_12.CustomConfigID(arg_2_0, arg_2_1)
	arg_2_0._customCombatID = arg_2_1

	local var_2_0 = arg_2_0._energy

	var_2.CustomConfig(var_2_0, arg_2_0._customCombatID)

	local var_2_1 = arg_2_0._moveDeck

	var_2.CustomConfig(var_2_1, arg_2_0._customCombatID)

	return
end

function var_0_12.Dispose(arg_3_0)
	var_0.EventDispatcher.DetachEventDispatcher(arg_3_0)
	var_0.EventListener.DetachEventListener(arg_3_0)

	arg_3_0._fleetVO = nil

	return
end

function var_0_12.GetPuzzleDungeonID(arg_4_0)
	return arg_4_0._customCombatID
end

function var_0_12.GetTotalCommonHP(arg_5_0)
	return arg_5_0._maxCommonHP
end

function var_0_12.GetCurrentCommonHP(arg_6_0)
	return arg_6_0._currentCommonHP
end

function var_0_12.GetEnergy(arg_7_0)
	return arg_7_0._energy
end

function var_0_12.EnergyUpdate(arg_8_0)
	local var_8_0 = arg_8_0._fleetAttr
	local var_8_1 = var_1.SetAttr
	local var_8_2 = "BaseEnergy"
	local var_8_3 = arg_8_0._energy

	var_8_1(var_8_0, var_8_2, var_4.GetCurrentEnergy(var_8_3))

	return
end

function var_0_12.AppendUnit(arg_9_0, arg_9_1)
	arg_9_1:RegisterEventListener(arg_9_0, var_0_3.UPDATE_COMMON_HP, arg_9_0.onUpdateCommonHP)

	arg_9_0._maxCommonHP = arg_9_0._maxCommonHP + arg_9_1:GetAttrByName("maxHP")
	arg_9_0._currentCommonHP = arg_9_0._maxCommonHP

	local var_9_0
	local var_9_1 = arg_9_0._cardPuzzleAA

	var_3.AppendCrewUnit(var_9_1, arg_9_1)

	if arg_9_1:IsMainFleetUnit() then
		arg_9_0._mainUnit = arg_9_1
		TeamType = var_3
		var_9_0 = var_3.TeamPos.FLAG_SHIP
	else
		arg_9_0._scoutUnit = arg_9_1

		local var_9_2 = arg_9_0._cardPuzzleAA

		var_3.SwitchHost(var_9_2, arg_9_1)

		TeamType = var_3
		var_9_0 = var_3.TeamPos.LEADER
	end

	local var_9_3 = var_0.Event.New(var_0_3.UPDATE_FLEET_SHIP, {
		teamType = var_9_0
	})

	arg_9_0:DispatchEvent(var_9_3)

	return
end

function var_0_12.InitCardPuzzleData(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._fleetVO
	local var_10_1 = var_2.GetUnitBound(var_10_0)

	var_2.SwtichDBRGL(var_10_1)

	local var_10_2 = arg_10_1.relicList

	ipairs = var_10_1

	for iter_10_0, iter_10_1 in var_10_1(var_10_2) do
		table = var_1_10008

		var_1_10008.insert(arg_10_0._relicList, iter_10_1)

		local var_10_3 = iter_10_1

		var_1_10008 = iter_10_1.GetEffects(var_10_3)
		ipairs = var_10_3

		for iter_10_2, iter_10_3 in var_10_3(var_1_10008) do
			local var_10_4 = iter_10_3.type

			CardPuzzleGift = var_1_10015

			if var_10_4 == var_1_10015.EFFECT_TYPE.BATTLE_BUFF then
				ipairs = var_10_4

				for iter_10_4, iter_10_5 in var_10_4(iter_10_3.arg_list) do
					local var_10_5 = var_0.Battle.BattleFleetBuffUnit.New(iter_10_5)
					local var_10_6 = arg_10_0._fleetBuff

					var_20.AttachCardPuzzleBuff(var_10_6, var_10_5)
				end
			end
		end
	end

	return
end

function var_0_12.RemoveUnit(arg_11_0, arg_11_1)
	arg_11_1:UnregisterEventListener(arg_11_0, var_0_3.UPDATE_COMMON_HP)

	return
end

function var_0_12.GetMainUnit(arg_12_0)
	return arg_12_0._mainUnit
end

function var_0_12.GetScoutUnit(arg_13_0)
	return arg_13_0._scoutUnit
end

function var_0_12.AttachMoveController(arg_14_0, arg_14_1)
	arg_14_0._moveController = arg_14_1

	return
end

function var_0_12.TakeoverMovecontroller(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._moveController

	var_3.InputTargetPoint(var_15_0, arg_15_1, arg_15_2)

	local var_15_1 = arg_15_0._fleetVO

	var_3.DispatchEvent(var_15_1, var_0.Event.New(var_0_3.FLEET_MOVE_TO, {
		pos = arg_15_1
	}))

	return
end

function var_0_12.ReturnMovecontroller(arg_16_0)
	local var_16_0 = arg_16_0._fleetVO

	var_1.DispatchEvent(var_16_0, var_0.Event.New(var_0_3.FLEET_MOVE_TO, {}))

	return
end

function var_0_12.PlayCard(arg_17_0, arg_17_1)
	if arg_17_0:CheckCardCastable(arg_17_1) then
		local function var_17_0()
			local var_18_0 = arg_17_1
			local var_18_1 = var_0.GetTotalCost(var_18_0)
			local var_18_2 = arg_17_0._energy

			var_1.ConsumeEnergy(var_18_2, var_18_1)

			local var_18_3 = arg_17_0._hand

			var_1.Remove(var_18_3, arg_17_1)

			local var_18_4 = arg_17_0._hand
			local var_18_5 = var_1.EnterCoolDownByType
			local var_18_6 = arg_17_1
			local var_18_7 = var_3.GetCardType(var_18_6)
			local var_18_8 = arg_17_1

			var_18_5(var_18_4, var_18_7, var_4.GetCardCD(var_18_8))

			local var_18_9 = arg_17_1

			if var_1.GetMoveAfterCast(var_18_9) == var_0_12.CARD_PILE_INDEX_DISCARD then
				local var_18_10 = arg_17_0._discard

				var_1.Add(var_18_10, arg_17_1)
			end

			local var_18_11 = arg_17_0

			var_1.TryDrawCard(var_18_11)

			return
		end

		arg_17_1:Precast(var_17_0)

		return true
	else
		return false
	end

	return
end

function var_0_12.ReturnCard(arg_19_0, arg_19_1)
	if arg_19_0:CheckCardReturnable(arg_19_1) then
		local function var_19_0()
			local var_20_0 = arg_19_1
			local var_20_1 = var_0.GetReturnCost(var_20_0)
			local var_20_2 = arg_19_0._energy

			var_1.ConsumeEnergy(var_20_2, var_20_1)

			local var_20_3 = arg_19_0._hand

			var_1.Remove(var_20_3, arg_19_1)

			local var_20_4 = arg_19_0

			var_1.TryDrawCard(var_20_4)

			return
		end

		arg_19_1:Retrun(var_19_0)

		return true
	else
		return false
	end

	return
end

function var_0_12.PlayMoveCard(arg_21_0, arg_21_1)
	arg_21_1:SetInputPoint(arg_21_0._clickToScenePoint)
	arg_21_1:Precast()

	local var_21_0 = arg_21_0._moveDeck

	var_2.Remove(var_21_0, arg_21_1)

	return
end

function var_0_12.CheckCardCastable(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1:GetTotalCost()
	local var_22_1 = arg_22_1:GetCastCondition() ~= false
	local var_22_2 = arg_22_0._energy

	if var_22_0 <= var_4.GetCurrentEnergy(var_22_2) and var_22_1 then
		return true
	end

	return
end

function var_0_12.CheckCardReturnable(arg_23_0, arg_23_1)
	if arg_23_1:GetReturnCost() then
		local var_23_0 = arg_23_0._energy

		if var_2 <= var_3.GetCurrentEnergy(var_23_0) then
			return true
		end
	end

	return
end

function var_0_12.SetDragingCard(arg_24_0, arg_24_1)
	arg_24_0._dragingCard = arg_24_1

	return
end

function var_0_12.GetDragingCard(arg_25_0)
	return arg_25_0._dragingCard
end

function var_0_12.SendUpdateAim(arg_26_0)
	if arg_26_0._dragingCard then
		local var_26_0 = arg_26_0._dragingCard
		local var_26_1 = var_1.GetCardInfo(var_26_0)
		local var_26_2

		if not var_1.GetCardEffectTargetFilterList(var_26_1) then
			var_26_2 = {}
		end

		local var_26_3 = arg_26_0._fleetVO

		var_2.DispatchEvent(var_26_3, var_0.Event.New(var_0_3.UPDATE_CARD_TARGET_FILTER, {
			targetFilterList = var_26_2
		}))

		return
	end
end

function var_0_12.Start(arg_27_0)
	local var_27_0 = arg_27_0._fleetBuff

	var_1.Trigger(var_27_0, var_0_5.BuffEffectType.ON_START_GAME)

	pairs = var_1

	for iter_27_0, iter_27_1 in var_1(var_0_7.CustomAttrInitList) do
		local var_27_1 = arg_27_0._fleetAttr

		var_6.AddBaseAttr(var_27_1, iter_27_0, iter_27_1)
	end

	if arg_27_0._customCombatID and var_0_9.GetPuzzleDungeonTemplate(arg_27_0._customCombatID) then
		local var_27_2 = var_0_9.GetPuzzleDungeonTemplate(arg_27_0._customCombatID).deck

		ipairs = var_3

		for iter_27_2, iter_27_3 in var_3(var_27_2) do
			local var_27_3 = arg_27_0:GenerateCard(iter_27_3)
			local var_27_4 = arg_27_0._deck

			var_9.Add(var_27_4, var_27_3)
		end

		local var_27_5 = var_1.init_move
		local var_27_6 = 0

		while var_27_6 < var_27_5 do
			local var_27_7 = arg_27_0:GenerateCard(var_0_7.BASE_MOVE_ID)
			local var_27_8 = arg_27_0._moveDeck

			var_6.Add(var_27_8, var_27_7)

			var_27_6 = var_27_6 + 1
		end

		if var_1.init_shuffle ~= var_0.Battle.BattleFleetCardPuzzleDeck.NOT_INIT_SHUFFLE then
			local var_27_9 = arg_27_0._deck

			var_5.Shuffle(var_27_9)
		end
	else
		local var_27_10 = arg_27_0._deck

		var_1.Shuffle(var_27_10)
	end

	local var_27_11 = arg_27_0._energy

	var_1.Start(var_27_11)
	arg_27_0:TryDrawCard()
	arg_27_0:SetClickEnable(true)

	return
end

function var_0_12.Update(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._energy

	var_2.Update(var_28_0, arg_28_1)

	local var_28_1 = arg_28_0._fleetBuff

	var_2.Update(var_28_1, arg_28_1)

	local var_28_2 = arg_28_0._cardPuzzleAA

	var_2.Update(var_28_2, arg_28_1)
	arg_28_0:updateMoveDeck(arg_28_1)

	local var_28_3 = arg_28_0._hand

	var_2.Update(var_28_3, arg_28_1)

	return
end

function var_0_12.UpdateClickPos(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0

	if not var_0_10 then
		var_29_0 = var_0.Battle.CardPuzzleBoardClicker
	end

	var_0_10 = var_29_0

	if arg_29_3 == var_0_10.CLICK_STATE_CLICK then
		local var_29_1 = arg_29_0._uiPoint

		var_4.Set(var_29_1, arg_29_1, arg_29_2)
		var_0.Battle.BattleVariable.UIPosToScenePos(arg_29_0._uiPoint, arg_29_0._clickToScenePoint)

		local var_29_2 = arg_29_0._fleetVO
		local var_29_3 = var_4.GetUnitBound(var_29_2)

		var_4.FixCardPuzzleInput(var_29_3, arg_29_0._clickToScenePoint)

		local var_29_4 = arg_29_0._clickToScenePointCache

		var_4.Copy(var_29_4, arg_29_0._clickToScenePoint)

		local var_29_5 = arg_29_0._fleetVO

		var_4.DispatchEvent(var_29_5, var_0.Event.New(var_0_3.ON_BOARD_CLICK, {
			click = arg_29_3
		}))
	elseif arg_29_3 == var_0_10.CLICK_STATE_DRAG then
		local var_29_6 = arg_29_0._uiPoint

		var_4.Set(var_29_6, arg_29_1, arg_29_2)
		var_0.Battle.BattleVariable.UIPosToScenePos(arg_29_0._uiPoint, arg_29_0._clickToScenePoint)

		local var_29_7 = arg_29_0._fleetVO
		local var_29_8 = var_4.GetUnitBound(var_29_7)

		var_4.FixCardPuzzleInput(var_29_8, arg_29_0._clickToScenePoint)

		local var_29_9 = arg_29_0._clickToScenePointCache

		if not var_4.Equals(var_29_9, arg_29_0._clickToScenePoint) then
			local var_29_10 = arg_29_0._fleetVO

			var_4.DispatchEvent(var_29_10, var_0.Event.New(var_0_3.ON_BOARD_CLICK, {
				click = arg_29_3
			}))
		end

		local var_29_11 = arg_29_0._clickToScenePointCache

		var_4.Copy(var_29_11, arg_29_0._clickToScenePoint)
	elseif arg_29_3 == var_0_10.CLICK_STATE_RELEASE then
		if arg_29_0._clickEnable then
			local var_29_12 = arg_29_0._moveDeck

			if var_4.TryPlayTopMoveCard(var_29_12) then
				arg_29_0:PlayMoveCard(var_4)
			end
		end

		local var_29_13 = arg_29_0._fleetVO

		var_4.DispatchEvent(var_29_13, var_0.Event.New(var_0_3.ON_BOARD_CLICK, {
			click = arg_29_3
		}))
	end

	return
end

function var_0_12.SetClickEnable(arg_30_0, arg_30_1)
	arg_30_0._clickEnable = arg_30_1

	return
end

function var_0_12.GetClickEnable(arg_31_0)
	return arg_31_0._clickEnable
end

function var_0_12.BlockComponentByCard(arg_32_0, arg_32_1)
	arg_32_1 = not arg_32_1

	arg_32_0:SetClickEnable(arg_32_1)
	arg_32_0:DispatchEvent(var_0.Event.New(var_0_3.COMMON_BUTTON_ENABLE, {
		flag = arg_32_1
	}))

	return
end

function var_0_12.LongPressCard(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_2 then
		arg_33_0:DispatchEvent(var_0.Event.New(var_0_3.SHOW_CARD_DETAIL, {
			card = arg_33_1
		}))
		arg_33_0:DispatchBulletTime(0.1)
	else
		arg_33_0:DispatchEvent(var_0.Event.New(var_0_3.SHOW_CARD_DETAIL, {}))
		arg_33_0:DispatchBulletTime()
	end

	return
end

function var_0_12.DispatchBulletTime(arg_34_0, arg_34_1)
	if arg_34_1 then
		var_0_11.AppendIFFFactor(var_0_6.FOE_CODE, "check_card", arg_34_1)
		var_0_11.AppendIFFFactor(var_0_6.FRIENDLY_CODE, "check_card", arg_34_1)
	else
		var_0_11.RemoveIFFFactor(var_0_6.FOE_CODE, "check_card")
		var_0_11.RemoveIFFFactor(var_0_6.FRIENDLY_CODE, "check_card")
	end

	arg_34_0:DispatchEvent(var_0.Event.New(var_0_3.LONG_PRESS_BULLET_TIME, {
		timeScale = arg_34_1
	}))

	return
end

function var_0_12.dispatchClick(arg_35_0, arg_35_1)
	if arg_35_0._clickEnable then
		local var_35_0 = arg_35_0._fleetVO

		var_2.DispatchEvent(var_35_0, var_0.Event.New(var_0_3.ON_BOARD_CLICK, {
			click = arg_35_1
		}))
	end

	return
end

function var_0_12.GetHand(arg_36_0)
	return arg_36_0._hand
end

function var_0_12.GetDeck(arg_37_0)
	return arg_37_0._deck
end

function var_0_12.GetRelicList(arg_38_0)
	return arg_38_0._relicList
end

function var_0_12.GetTouchScreenPoint(arg_39_0)
	return arg_39_0._clickToScenePoint
end

function var_0_12.GetMoveDeck(arg_40_0)
	return arg_40_0._moveDeck
end

function var_0_12.GetCardPileByIndex(arg_41_0, arg_41_1)
	return arg_41_0._cardPileList[arg_41_1]
end

function var_0_12.GetFleetVO(arg_42_0)
	return arg_42_0._fleetVO
end

function var_0_12.GetAttrManager(arg_43_0)
	return arg_43_0._fleetAttr
end

function var_0_12.GetBuffManager(arg_44_0)
	return arg_44_0._fleetBuff
end

function var_0_12.GetCardPuzzleAAUnit(arg_45_0)
	return arg_45_0._cardPuzzleAA
end

function var_0_12.TryDrawCard(arg_46_0)
	::label_46_0::

	local var_46_0 = arg_46_0._hand

	if not var_1.IsFull(var_46_0) then
		local var_46_1 = arg_46_0._deck

		if var_1.GetLength(var_46_1) > 0 then
			repeat
				local var_46_2 = arg_46_0._deck
				local var_46_3 = var_1.Pop(var_46_2)
				local var_46_4 = arg_46_0._hand

				var_2.Add(var_46_4, var_46_3)

				local var_46_5 = var_46_3:GetTotalCost()
				local var_46_6 = arg_46_0._energy
				local var_46_7 = var_3.FillToCooldown(var_46_6, var_46_5)

				var_46_3:SetBaseEnergyFillDuration(var_46_7)

				goto label_46_0
			until true
		end
	end

	return
end

function var_0_12.FlushHandOverheat(arg_47_0)
	local var_47_0 = arg_47_0._hand
	local var_47_1 = var_1.GetCardList(var_47_0)

	ipairs = var_47_0

	for iter_47_0, iter_47_1 in var_47_0(var_47_1) do
		local var_47_2 = iter_47_1:GetTotalCost()
		local var_47_3 = arg_47_0._energy
		local var_47_4 = var_8.FillToCooldown(var_47_3, var_47_2)

		iter_47_1:SetBaseEnergyFillDuration(var_47_4)
	end

	return
end

function var_0_12.HoldForInput(arg_48_0, arg_48_1)
	arg_48_0._holdingCard = arg_48_1

	return
end

function var_0_12.GenerateCard(arg_49_0, arg_49_1)
	local var_49_0 = var_0.Battle.BattleCardPuzzleCard.New(arg_49_0)

	var_2.SetCardTemplate(var_49_0, arg_49_1)

	return var_2
end

function var_0_12.UpdateAttrByBuff(arg_50_0, arg_50_1, arg_50_2)
	return
end

function var_0_12.AddAttrBySkill(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = arg_51_0._fleetAttr

	var_3.AddBaseAttr(var_51_0, arg_51_1, arg_51_2)

	return
end

function var_0_12.UpdateAttrBySet(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_0._fleetAttr

	var_3.SetAttr(var_52_0, arg_52_1, arg_52_2)

	return
end

function var_0_12.DispatchUpdateAttr(arg_53_0, arg_53_1)
	local var_53_0 = var_0.Event.New(var_0_3.UPDATE_FLEET_ATTR, {
		attrName = arg_53_1
	})

	arg_53_0:DispatchEvent(var_53_0)

	if arg_53_0._dragingCard then
		arg_53_0:SendUpdateAim()
	end

	return
end

function var_0_12.IsAAActive(arg_54_0)
	local var_54_0 = arg_54_0._fleetAttr

	return var_1.GetCurrent(var_54_0, "CardAntiaircraft") > 0
end

function var_0_12.ConsumeAACounter(arg_55_0, arg_55_1)
	local var_55_0 = (arg_55_1 or 1) * -1
	local var_55_1 = arg_55_0._fleetAttr

	var_3.AddBaseAttr(var_55_1, "CardAntiaircraft", var_55_0)

	return
end

function var_0_12.init(arg_56_0)
	arg_56_0._maxCommonHP = 0
	arg_56_0._currentCommonHP = 0
	arg_56_0._fleetAttr = var_0.Battle.BattleFleetCardPuzzleAttribute.New(arg_56_0)
	arg_56_0._fleetBuff = var_0.Battle.BattleFleetCardPuzzleFleetBuffManager.New(arg_56_0)
	arg_56_0._energy = var_0.Battle.BattleFleetCardPuzzleEnergy.New(arg_56_0)
	arg_56_0._deck = var_0.Battle.BattleFleetCardPuzzleDeck.New(arg_56_0, var_0_12.CARD_PILE_INDEX_DECK)
	arg_56_0._hand = var_0.Battle.BattleFleetCardPuzzleHand.New(arg_56_0, var_0_12.CARD_PILE_INDEX_HAND)
	arg_56_0._discard = var_0.Battle.BattleFleetCardPuzzleDiscard.New(arg_56_0, var_0_12.CARD_PILE_INDEX_DISCARD)
	arg_56_0._moveDeck = var_0.Battle.BattleFleetCardPuzzleMoveDeck.New(arg_56_0, var_0_12.CARD_PILE_INDEX_MOVE_DECK)
	arg_56_0._cardPileList = {
		[var_0_12.CARD_PILE_INDEX_DISCARD] = arg_56_0._discard,
		[var_0_12.CARD_PILE_INDEX_HAND] = arg_56_0._hand,
		[var_0_12.CARD_PILE_INDEX_DECK] = arg_56_0._deck,
		[var_0_12.CARD_PILE_INDEX_MOVE_DECK] = arg_56_0._moveDeck
	}
	Vector2 = var_1
	arg_56_0._uiPoint = var_1.New(0, 0)
	Vector3 = var_1
	arg_56_0._clickToScenePoint = var_1.New(0, 0, 0)
	Vector3 = var_1
	arg_56_0._clickToScenePointCache = var_1.New(0, 0, 0)
	arg_56_0._scoutUnit = nil
	arg_56_0._mainUnit = nil
	arg_56_0._relicList = {}
	arg_56_0._cardPuzzleAA = var_0.Battle.BattleFleetCardPuzzleAntiAirUnit.New(arg_56_0)

	function arg_56_0._fleetVO.GetFleetAntiAirWeapon()
		return arg_56_0._cardPuzzleAA
	end

	arg_56_0:initEvent()

	return
end

function var_0_12.initEvent(arg_58_0)
	local var_58_0 = arg_58_0._hand

	var_1.RegisterEventListener(var_58_0, arg_58_0, var_0_3.UPDATE_CARDS, arg_58_0.onUpdateHands)

	local var_58_1 = arg_58_0._deck

	var_1.RegisterEventListener(var_58_1, arg_58_0, var_0_3.UPDATE_CARDS, arg_58_0.onUpdateDeck)

	return
end

function var_0_12.onUpdateHands(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0._hand
	local var_59_1 = var_2.GetCardList(var_59_0)
	local var_59_2 = {}

	ipairs = var_1_10004

	for iter_59_0, iter_59_1 in var_1_10004(var_59_1) do
		local var_59_3 = iter_59_1
		local var_59_4 = iter_59_1.GetLabels(var_59_3)

		ipairs = var_59_3

		for iter_59_2, iter_59_3 in var_59_3(var_59_4) do
			local var_59_5

			if not var_59_2[iter_59_3] then
				var_59_5 = 0
			end

			var_59_2[iter_59_3] = var_59_5 + 1
		end
	end

	local var_59_6 = arg_59_0._fleetAttr

	var_4.SetAttr(var_59_6, "HandCount", #var_59_1)

	pairs = var_4

	for iter_59_4, iter_59_5 in var_4(var_59_2) do
		local var_59_7 = arg_59_0._fleetAttr

		var_9.SetAttr(var_59_7, iter_59_4 .. "LabelInHand", iter_59_5)
	end

	local var_59_8 = var_0.Event.New(var_0_3.UPDATE_FLEET_ATTR, {})

	arg_59_0:DispatchEvent(var_59_8)

	return
end

function var_0_12.onUpdateDeck(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0._deck
	local var_60_1 = var_2.GetCardList(var_60_0)
	local var_60_2 = arg_60_0._fleetAttr

	var_3.SetAttr(var_60_2, "DeckCount", #var_60_1)

	if arg_60_1.Data.type == var_0.Battle.BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_ADD or var_3.type == var_0.Battle.BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_BOTTOM then
		arg_60_0:TryDrawCard()
	end

	return
end

function var_0_12.updateMoveDeck(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0._moveDeck

	var_2.Update(var_61_0, arg_61_1)

	local var_61_1 = arg_61_0._moveDeck

	if var_2.GetGeneratePorcess(var_61_1) >= 1 then
		local var_61_2 = arg_61_0._moveDeck

		var_2.RestartGenrate(var_61_2)

		local var_61_3 = arg_61_0:GenerateCard(var_0_7.BASE_MOVE_ID)
		local var_61_4 = arg_61_0._moveDeck

		var_3.Add(var_61_4, var_61_3)
	end

	return
end

function var_0_12.onUpdateCommonHP(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_1.Data.dHP

	math = var_1_10004
	arg_62_0._currentCommonHP = var_1_10004.clamp(arg_62_0._currentCommonHP + var_62_0, 0, arg_62_0._maxCommonHP)

	return
end

return
