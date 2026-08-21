ys = ys or {}

local var_0_2 = ys.Battle.BattleCardPuzzleEvent
local var_0_4 = ys.Battle.BattleConst
local var_0_5 = ys.Battle.BattleConfig
local var_0_6 = ys.Battle.BattleCardPuzzleConfig
local var_0_8 = ys.Battle.BattleDataFunction
local var_0_9 = ys.Battle.CardPuzzleBoardClicker
local var_0_10 = ys.Battle.BattleVariable
local var_0_11 = class("BattleFleetCardPuzzleComponent")

ys.Battle.BattleFleetCardPuzzleComponent = var_0_11
var_0_11.__name = "BattleFleetCardPuzzleComponent"
var_0_11.CARD_PILE_INDEX_DISCARD = -1
var_0_11.CARD_PILE_INDEX_HAND = 0
var_0_11.CARD_PILE_INDEX_DECK = 1
var_0_11.CARD_PILE_INDEX_MOVE_DECK = 2

function var_0_11.Ctor(arg_1_0, arg_1_1)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._fleetVO = arg_1_1

	arg_1_0:init()

	return
end

function var_0_11.CustomConfigID(arg_2_0, arg_2_1)
	arg_2_0._customCombatID = arg_2_1

	arg_2_0._energy:CustomConfig(arg_2_0._customCombatID)
	arg_2_0._moveDeck:CustomConfig(arg_2_0._customCombatID)

	return
end

function var_0_11.Dispose(arg_3_0)
	var_0.EventDispatcher.DetachEventDispatcher(arg_3_0)
	var_0.EventListener.DetachEventListener(arg_3_0)

	arg_3_0._fleetVO = nil

	return
end

function var_0_11.GetPuzzleDungeonID(arg_4_0)
	return arg_4_0._customCombatID
end

function var_0_11.GetTotalCommonHP(arg_5_0)
	return arg_5_0._maxCommonHP
end

function var_0_11.GetCurrentCommonHP(arg_6_0)
	return arg_6_0._currentCommonHP
end

function var_0_11.GetEnergy(arg_7_0)
	return arg_7_0._energy
end

function var_0_11.EnergyUpdate(arg_8_0)
	arg_8_0._fleetAttr:SetAttr("BaseEnergy", arg_8_0._energy:GetCurrentEnergy())

	return
end

function var_0_11.AppendUnit(arg_9_0, arg_9_1)
	arg_9_1:RegisterEventListener(arg_9_0, var_0_2.UPDATE_COMMON_HP, arg_9_0.onUpdateCommonHP)

	arg_9_0._maxCommonHP = arg_9_0._maxCommonHP + arg_9_1:GetAttrByName("maxHP")
	arg_9_0._currentCommonHP = arg_9_0._maxCommonHP

	local var_9_0

	arg_9_0._cardPuzzleAA:AppendCrewUnit(arg_9_1)

	if arg_9_1:IsMainFleetUnit() then
		arg_9_0._mainUnit = arg_9_1
		var_9_0 = TeamType.TeamPos.FLAG_SHIP
	else
		arg_9_0._scoutUnit = arg_9_1

		arg_9_0._cardPuzzleAA:SwitchHost(arg_9_1)

		var_9_0 = TeamType.TeamPos.LEADER
	end

	arg_9_0:DispatchEvent((var_0.Event.New(var_0_2.UPDATE_FLEET_SHIP, {
		teamType = var_9_0
	})))

	return
end

function var_0_11.InitCardPuzzleData(arg_10_0, arg_10_1)
	arg_10_0._fleetVO:GetUnitBound():SwtichDBRGL()

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.relicList) do
		table.insert(arg_10_0._relicList, iter_10_1)

		for iter_10_2, iter_10_3 in ipairs((iter_10_1:GetEffects())) do
			if iter_10_3.type == CardPuzzleGift.EFFECT_TYPE.BATTLE_BUFF then
				for iter_10_4, iter_10_5 in ipairs(iter_10_3.arg_list) do
					arg_10_0._fleetBuff:AttachCardPuzzleBuff((var_0.Battle.BattleFleetBuffUnit.New(iter_10_5)))
				end
			end
		end
	end

	return
end

function var_0_11.RemoveUnit(arg_11_0, arg_11_1)
	arg_11_1:UnregisterEventListener(arg_11_0, var_0_2.UPDATE_COMMON_HP)

	return
end

function var_0_11.GetMainUnit(arg_12_0)
	return arg_12_0._mainUnit
end

function var_0_11.GetScoutUnit(arg_13_0)
	return arg_13_0._scoutUnit
end

function var_0_11.AttachMoveController(arg_14_0, arg_14_1)
	arg_14_0._moveController = arg_14_1

	return
end

function var_0_11.TakeoverMovecontroller(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._moveController:InputTargetPoint(arg_15_1, arg_15_2)
	arg_15_0._fleetVO:DispatchEvent(var_0.Event.New(var_0_2.FLEET_MOVE_TO, {
		pos = arg_15_1
	}))

	return
end

function var_0_11.ReturnMovecontroller(arg_16_0)
	arg_16_0._fleetVO:DispatchEvent(var_0.Event.New(var_0_2.FLEET_MOVE_TO, {}))

	return
end

function var_0_11.PlayCard(arg_17_0, arg_17_1)
	if arg_17_0:CheckCardCastable(arg_17_1) then
		arg_17_1:Precast(function()
			arg_17_0._energy:ConsumeEnergy((arg_17_1:GetTotalCost()))
			arg_17_0._hand:Remove(arg_17_1)
			arg_17_0._hand:EnterCoolDownByType(arg_17_1:GetCardType(), arg_17_1:GetCardCD())

			if arg_17_1:GetMoveAfterCast() == var_0_11.CARD_PILE_INDEX_DISCARD then
				arg_17_0._discard:Add(arg_17_1)
			end

			arg_17_0:TryDrawCard()

			return
		end)

		return true
	else
		return false
	end

	return
end

function var_0_11.ReturnCard(arg_19_0, arg_19_1)
	if arg_19_0:CheckCardReturnable(arg_19_1) then
		arg_19_1:Retrun(function()
			arg_19_0._energy:ConsumeEnergy((arg_19_1:GetReturnCost()))
			arg_19_0._hand:Remove(arg_19_1)
			arg_19_0:TryDrawCard()

			return
		end)

		return true
	else
		return false
	end

	return
end

function var_0_11.PlayMoveCard(arg_21_0, arg_21_1)
	arg_21_1:SetInputPoint(arg_21_0._clickToScenePoint)
	arg_21_1:Precast()
	arg_21_0._moveDeck:Remove(arg_21_1)

	return
end

function var_0_11.CheckCardCastable(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1:GetCastCondition() ~= false

	if arg_22_1:GetTotalCost() <= arg_22_0._energy:GetCurrentEnergy() and var_22_0 then
		return true
	end

	return
end

function var_0_11.CheckCardReturnable(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1:GetReturnCost()

	if var_23_0 and var_23_0 <= arg_23_0._energy:GetCurrentEnergy() then
		return true
	end

	return
end

function var_0_11.SetDragingCard(arg_24_0, arg_24_1)
	arg_24_0._dragingCard = arg_24_1

	return
end

function var_0_11.GetDragingCard(arg_25_0)
	return arg_25_0._dragingCard
end

function var_0_11.SendUpdateAim(arg_26_0)
	if arg_26_0._dragingCard then
		local var_26_0 = arg_26_0._dragingCard:GetCardInfo():GetCardEffectTargetFilterList() or {}

		arg_26_0._fleetVO:DispatchEvent(var_0.Event.New(var_0_2.UPDATE_CARD_TARGET_FILTER, {
			targetFilterList = var_26_0
		}))

		return
	end
end

function var_0_11.Start(arg_27_0)
	arg_27_0._fleetBuff:Trigger(var_0_4.BuffEffectType.ON_START_GAME)

	for iter_27_0, iter_27_1 in pairs(var_0_6.CustomAttrInitList) do
		arg_27_0._fleetAttr:AddBaseAttr(iter_27_0, iter_27_1)
	end

	if arg_27_0._customCombatID and var_0_8.GetPuzzleDungeonTemplate(arg_27_0._customCombatID) then
		local var_27_0 = var_0_8.GetPuzzleDungeonTemplate(arg_27_0._customCombatID)

		for iter_27_2, iter_27_3 in ipairs(var_27_0.deck) do
			arg_27_0._deck:Add((arg_27_0:GenerateCard(iter_27_3)))
		end

		local var_27_1 = 0

		while var_27_1 < var_27_0.init_move do
			arg_27_0._moveDeck:Add((arg_27_0:GenerateCard(var_0_6.BASE_MOVE_ID)))

			var_27_1 = var_27_1 + 1
		end

		if var_27_0.init_shuffle ~= var_0.Battle.BattleFleetCardPuzzleDeck.NOT_INIT_SHUFFLE then
			arg_27_0._deck:Shuffle()
		end
	else
		arg_27_0._deck:Shuffle()
	end

	arg_27_0._energy:Start()
	arg_27_0:TryDrawCard()
	arg_27_0:SetClickEnable(true)

	return
end

function var_0_11.Update(arg_28_0, arg_28_1)
	arg_28_0._energy:Update(arg_28_1)
	arg_28_0._fleetBuff:Update(arg_28_1)
	arg_28_0._cardPuzzleAA:Update(arg_28_1)
	arg_28_0:updateMoveDeck(arg_28_1)
	arg_28_0._hand:Update(arg_28_1)

	return
end

function var_0_11.UpdateClickPos(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	var_0_9 = var_0_9 or var_0.Battle.CardPuzzleBoardClicker

	if arg_29_3 == var_0_9.CLICK_STATE_CLICK then
		arg_29_0._uiPoint:Set(arg_29_1, arg_29_2)
		var_0.Battle.BattleVariable.UIPosToScenePos(arg_29_0._uiPoint, arg_29_0._clickToScenePoint)
		arg_29_0._fleetVO:GetUnitBound():FixCardPuzzleInput(arg_29_0._clickToScenePoint)
		arg_29_0._clickToScenePointCache:Copy(arg_29_0._clickToScenePoint)
		arg_29_0._fleetVO:DispatchEvent(var_0.Event.New(var_0_2.ON_BOARD_CLICK, {
			click = arg_29_3
		}))
	elseif arg_29_3 == var_0_9.CLICK_STATE_DRAG then
		arg_29_0._uiPoint:Set(arg_29_1, arg_29_2)
		var_0.Battle.BattleVariable.UIPosToScenePos(arg_29_0._uiPoint, arg_29_0._clickToScenePoint)
		arg_29_0._fleetVO:GetUnitBound():FixCardPuzzleInput(arg_29_0._clickToScenePoint)

		if not arg_29_0._clickToScenePointCache:Equals(arg_29_0._clickToScenePoint) then
			arg_29_0._fleetVO:DispatchEvent(var_0.Event.New(var_0_2.ON_BOARD_CLICK, {
				click = arg_29_3
			}))
		end

		arg_29_0._clickToScenePointCache:Copy(arg_29_0._clickToScenePoint)
	elseif arg_29_3 == var_0_9.CLICK_STATE_RELEASE then
		if arg_29_0._clickEnable then
			local var_29_0 = arg_29_0._moveDeck:TryPlayTopMoveCard()

			if var_29_0 then
				arg_29_0:PlayMoveCard(var_29_0)
			end
		end

		arg_29_0._fleetVO:DispatchEvent(var_0.Event.New(var_0_2.ON_BOARD_CLICK, {
			click = arg_29_3
		}))
	end

	return
end

function var_0_11.SetClickEnable(arg_30_0, arg_30_1)
	arg_30_0._clickEnable = arg_30_1

	return
end

function var_0_11.GetClickEnable(arg_31_0)
	return arg_31_0._clickEnable
end

function var_0_11.BlockComponentByCard(arg_32_0, arg_32_1)
	arg_32_1 = not arg_32_1

	arg_32_0:SetClickEnable(arg_32_1)
	arg_32_0:DispatchEvent(var_0.Event.New(var_0_2.COMMON_BUTTON_ENABLE, {
		flag = arg_32_1
	}))

	return
end

function var_0_11.LongPressCard(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_2 then
		arg_33_0:DispatchEvent(var_0.Event.New(var_0_2.SHOW_CARD_DETAIL, {
			card = arg_33_1
		}))
		arg_33_0:DispatchBulletTime(0.1)
	else
		arg_33_0:DispatchEvent(var_0.Event.New(var_0_2.SHOW_CARD_DETAIL, {}))
		arg_33_0:DispatchBulletTime()
	end

	return
end

function var_0_11.DispatchBulletTime(arg_34_0, arg_34_1)
	if arg_34_1 then
		var_0_10.AppendIFFFactor(var_0_5.FOE_CODE, "check_card", arg_34_1)
		var_0_10.AppendIFFFactor(var_0_5.FRIENDLY_CODE, "check_card", arg_34_1)
	else
		var_0_10.RemoveIFFFactor(var_0_5.FOE_CODE, "check_card")
		var_0_10.RemoveIFFFactor(var_0_5.FRIENDLY_CODE, "check_card")
	end

	arg_34_0:DispatchEvent(var_0.Event.New(var_0_2.LONG_PRESS_BULLET_TIME, {
		timeScale = arg_34_1
	}))

	return
end

function var_0_11.dispatchClick(arg_35_0, arg_35_1)
	if arg_35_0._clickEnable then
		arg_35_0._fleetVO:DispatchEvent(var_0.Event.New(var_0_2.ON_BOARD_CLICK, {
			click = arg_35_1
		}))
	end

	return
end

function var_0_11.GetHand(arg_36_0)
	return arg_36_0._hand
end

function var_0_11.GetDeck(arg_37_0)
	return arg_37_0._deck
end

function var_0_11.GetRelicList(arg_38_0)
	return arg_38_0._relicList
end

function var_0_11.GetTouchScreenPoint(arg_39_0)
	return arg_39_0._clickToScenePoint
end

function var_0_11.GetMoveDeck(arg_40_0)
	return arg_40_0._moveDeck
end

function var_0_11.GetCardPileByIndex(arg_41_0, arg_41_1)
	return arg_41_0._cardPileList[arg_41_1]
end

function var_0_11.GetFleetVO(arg_42_0)
	return arg_42_0._fleetVO
end

function var_0_11.GetAttrManager(arg_43_0)
	return arg_43_0._fleetAttr
end

function var_0_11.GetBuffManager(arg_44_0)
	return arg_44_0._fleetBuff
end

function var_0_11.GetCardPuzzleAAUnit(arg_45_0)
	return arg_45_0._cardPuzzleAA
end

function var_0_11.TryDrawCard(arg_46_0)
	while not arg_46_0._hand:IsFull() and arg_46_0._deck:GetLength() > 0 do
		local var_46_0 = arg_46_0._deck:Pop()

		arg_46_0._hand:Add(var_46_0)
		var_46_0:SetBaseEnergyFillDuration((arg_46_0._energy:FillToCooldown((var_46_0:GetTotalCost()))))
	end

	return
end

function var_0_11.FlushHandOverheat(arg_47_0)
	for iter_47_0, iter_47_1 in ipairs((arg_47_0._hand:GetCardList())) do
		iter_47_1:SetBaseEnergyFillDuration((arg_47_0._energy:FillToCooldown((iter_47_1:GetTotalCost()))))
	end

	return
end

function var_0_11.HoldForInput(arg_48_0, arg_48_1)
	arg_48_0._holdingCard = arg_48_1

	return
end

function var_0_11.GenerateCard(arg_49_0, arg_49_1)
	local var_49_0 = var_0.Battle.BattleCardPuzzleCard.New(arg_49_0)

	var_49_0:SetCardTemplate(arg_49_1)

	return var_49_0
end

function var_0_11.UpdateAttrByBuff(arg_50_0, arg_50_1, arg_50_2)
	return
end

function var_0_11.AddAttrBySkill(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0._fleetAttr:AddBaseAttr(arg_51_1, arg_51_2)

	return
end

function var_0_11.UpdateAttrBySet(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0._fleetAttr:SetAttr(arg_52_1, arg_52_2)

	return
end

function var_0_11.DispatchUpdateAttr(arg_53_0, arg_53_1)
	arg_53_0:DispatchEvent((var_0.Event.New(var_0_2.UPDATE_FLEET_ATTR, {
		attrName = arg_53_1
	})))

	if arg_53_0._dragingCard then
		arg_53_0:SendUpdateAim()
	end

	return
end

function var_0_11.IsAAActive(arg_54_0)
	return arg_54_0._fleetAttr:GetCurrent("CardAntiaircraft") > 0
end

function var_0_11.ConsumeAACounter(arg_55_0, arg_55_1)
	arg_55_0._fleetAttr:AddBaseAttr("CardAntiaircraft", (arg_55_1 or 1) * -1)

	return
end

function var_0_11.init(arg_56_0)
	arg_56_0._maxCommonHP = 0
	arg_56_0._currentCommonHP = 0
	arg_56_0._fleetAttr = var_0.Battle.BattleFleetCardPuzzleAttribute.New(arg_56_0)
	arg_56_0._fleetBuff = var_0.Battle.BattleFleetCardPuzzleFleetBuffManager.New(arg_56_0)
	arg_56_0._energy = var_0.Battle.BattleFleetCardPuzzleEnergy.New(arg_56_0)
	arg_56_0._deck = var_0.Battle.BattleFleetCardPuzzleDeck.New(arg_56_0, var_0_11.CARD_PILE_INDEX_DECK)
	arg_56_0._hand = var_0.Battle.BattleFleetCardPuzzleHand.New(arg_56_0, var_0_11.CARD_PILE_INDEX_HAND)
	arg_56_0._discard = var_0.Battle.BattleFleetCardPuzzleDiscard.New(arg_56_0, var_0_11.CARD_PILE_INDEX_DISCARD)
	arg_56_0._moveDeck = var_0.Battle.BattleFleetCardPuzzleMoveDeck.New(arg_56_0, var_0_11.CARD_PILE_INDEX_MOVE_DECK)
	arg_56_0._cardPileList = {
		[var_0_11.CARD_PILE_INDEX_DISCARD] = arg_56_0._discard,
		[var_0_11.CARD_PILE_INDEX_HAND] = arg_56_0._hand,
		[var_0_11.CARD_PILE_INDEX_DECK] = arg_56_0._deck,
		[var_0_11.CARD_PILE_INDEX_MOVE_DECK] = arg_56_0._moveDeck
	}
	arg_56_0._uiPoint = Vector2.New(0, 0)
	arg_56_0._clickToScenePoint = Vector3.New(0, 0, 0)
	arg_56_0._clickToScenePointCache = Vector3.New(0, 0, 0)
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

function var_0_11.initEvent(arg_58_0)
	arg_58_0._hand:RegisterEventListener(arg_58_0, var_0_2.UPDATE_CARDS, arg_58_0.onUpdateHands)
	arg_58_0._deck:RegisterEventListener(arg_58_0, var_0_2.UPDATE_CARDS, arg_58_0.onUpdateDeck)

	return
end

function var_0_11.onUpdateHands(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0._hand:GetCardList()

	for iter_59_0, iter_59_1 in ipairs(var_59_0) do
		for iter_59_2, iter_59_3 in ipairs((iter_59_1:GetLabels())) do
			local var_59_1 = ({})[iter_59_3]

			if not ({})[iter_59_3] then
				var_59_1 = 0
			end

			;({})[iter_59_3] = var_59_1 + 1
		end
	end

	arg_59_0._fleetAttr:SetAttr("HandCount", #var_59_0)

	for iter_59_4, iter_59_5 in pairs({}) do
		arg_59_0._fleetAttr:SetAttr(iter_59_4 .. "LabelInHand", iter_59_5)
	end

	arg_59_0:DispatchEvent((var_0.Event.New(var_0_2.UPDATE_FLEET_ATTR, {})))

	return
end

function var_0_11.onUpdateDeck(arg_60_0, arg_60_1)
	arg_60_0._fleetAttr:SetAttr("DeckCount", #arg_60_0._deck:GetCardList())

	if arg_60_1.Data.type == var_0.Battle.BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_ADD or arg_60_1.Data.type == var_0.Battle.BattleFleetCardPuzzleCardManageComponent.FUNC_NAME_BOTTOM then
		arg_60_0:TryDrawCard()
	end

	return
end

function var_0_11.updateMoveDeck(arg_61_0, arg_61_1)
	arg_61_0._moveDeck:Update(arg_61_1)

	if arg_61_0._moveDeck:GetGeneratePorcess() >= 1 then
		arg_61_0._moveDeck:RestartGenrate()
		arg_61_0._moveDeck:Add((arg_61_0:GenerateCard(var_0_6.BASE_MOVE_ID)))
	end

	return
end

function var_0_11.onUpdateCommonHP(arg_62_0, arg_62_1)
	arg_62_0._currentCommonHP = math.clamp(arg_62_0._currentCommonHP + arg_62_1.Data.dHP, 0, arg_62_0._maxCommonHP)

	return
end

return
