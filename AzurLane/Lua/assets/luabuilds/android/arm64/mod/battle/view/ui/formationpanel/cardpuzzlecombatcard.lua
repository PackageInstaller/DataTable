ys = ys or {}
ys.Battle.CardPuzzleCombatCard = class("CardPuzzleCombatCard", CardPuzzleCardView)

local var_0_1 = ys.Battle.CardPuzzleCombatCard

ys.Battle.CardPuzzleCombatCard.__name = "CardPuzzleCombatCard"
ys.Battle.CardPuzzleCombatCard.CARD_SCALE = Vector3(0.57, 0.57, 0)
ys.Battle.CardPuzzleCombatCard.DRAG_SCALE = Vector3(0.65, 0.65, 0)
ys.Battle.CardPuzzleCombatCard.DRAW_SCALE = Vector3(0.2, 0.2, 0)
ys.Battle.CardPuzzleCombatCard.SHUFFLE_SCALE = Vector3(0.1, 0.1, 0)
ys.Battle.CardPuzzleCombatCard.RECYLE_POS = Vector3(10000, 10000, 0)
ys.Battle.CardPuzzleCombatCard.STATE_LOCK = "STATE_LOCK"
ys.Battle.CardPuzzleCombatCard.STATE_FREE = "STATE_FREE"
ys.Battle.CardPuzzleCombatCard.STATE_DRAG = "STATE_DRAG"
ys.Battle.CardPuzzleCombatCard.STATE_LONG_PRESS = "STATE_LONG_PRESS"
ys.Battle.CardPuzzleCombatCard.BASE_LERP = 0.2

function ys.Battle.CardPuzzleCombatCard.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._go = arg_1_1.gameObject
	arg_1_1.localScale = var_0_1.CARD_SCALE
	arg_1_0._moveLerp = 0.2
	arg_1_0._pos = Vector3.zero

	return
end

function ys.Battle.CardPuzzleCombatCard.GetRarityBG(arg_2_0, arg_2_1)
	return "battle_card_bg_" .. arg_2_1
end

function ys.Battle.CardPuzzleCombatCard.GetCardCost(arg_3_0)
	return arg_3_0.data:GetTotalCost()
end

function ys.Battle.CardPuzzleCombatCard.UpdateView(arg_4_0)
	var_0_1.super.UpdateView(arg_4_0)

	arg_4_0._coolDown = arg_4_0._tf:Find("cooldown")
	arg_4_0._coolDownProgress = arg_4_0._coolDown:GetComponent(typeof(Image))
	arg_4_0._canvaGroup = arg_4_0._tf:GetComponent(typeof(CanvasGroup))
	arg_4_0._boostHint = arg_4_0._tf:Find("boost_hint")

	arg_4_0:UpdateTotalCost()
	arg_4_0:UpdateBoostHint()

	return
end

function ys.Battle.CardPuzzleCombatCard.Update(arg_5_0)
	arg_5_0:updateCoolDown()
	arg_5_0:MoveToRefPos()

	return
end

function ys.Battle.CardPuzzleCombatCard.ShowGray(arg_6_0, arg_6_1)
	setGray(arg_6_0._tf, arg_6_1, true)

	return
end

function ys.Battle.CardPuzzleCombatCard.SetCardInfo(arg_7_0, arg_7_1)
	arg_7_0._cardInfo = arg_7_1

	arg_7_0:SetData(arg_7_0._cardInfo)

	return
end

function ys.Battle.CardPuzzleCombatCard.GetCardInfo(arg_8_0)
	return arg_8_0._cardInfo
end

function ys.Battle.CardPuzzleCombatCard.DrawAnima(arg_9_0, arg_9_1)
	arg_9_0:drawAlphaAndScale()

	arg_9_0._tf.localPosition = arg_9_1

	return
end

function ys.Battle.CardPuzzleCombatCard.GetUIPos(arg_10_0)
	return arg_10_0._tf.anchoredPosition
end

function ys.Battle.CardPuzzleCombatCard.SetSibling(arg_11_0, arg_11_1)
	arg_11_0._tf:SetSiblingIndex(arg_11_1)

	return
end

function ys.Battle.CardPuzzleCombatCard.SetReferencePos(arg_12_0, arg_12_1)
	arg_12_0._refPos = arg_12_1

	return
end

function ys.Battle.CardPuzzleCombatCard.SetMoveLerp(arg_13_0, arg_13_1)
	arg_13_0._moveLerp = arg_13_1 or var_0_1.BASE_LERP

	return
end

function ys.Battle.CardPuzzleCombatCard.MoveToRefPos(arg_14_0)
	if arg_14_0._tf.localPosition:Equals(arg_14_0._refPos) then
		if arg_14_0._moveToPointCallback then
			arg_14_0:_moveToPointCallback()

			arg_14_0._moveToPointCallback = nil
		end

		return
	end

	if arg_14_0._moveLerp == 1 then
		arg_14_0._pos:Copy(arg_14_0._refPos)
	else
		arg_14_0._pos:Copy((Vector2.Lerp(arg_14_0._tf.localPosition, arg_14_0._refPos, arg_14_0._moveLerp)))
	end

	arg_14_0._tf.localPosition = arg_14_0._pos

	return
end

function ys.Battle.CardPuzzleCombatCard.SetToObjPoolRecylePos(arg_15_0)
	arg_15_0._tf.localPosition = var_0_1.RECYLE_POS

	return
end

function ys.Battle.CardPuzzleCombatCard.MoveToDeck(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:shuffleBackAlphaAndScale()
	arg_16_0:SetMoveLerp(0.8)

	arg_16_0._refPos = arg_16_2
	arg_16_0._moveToPointCallback = arg_16_1

	return
end

function ys.Battle.CardPuzzleCombatCard.GetState(arg_17_0)
	return arg_17_0._state
end

function ys.Battle.CardPuzzleCombatCard.ChangeState(arg_18_0, arg_18_1)
	arg_18_0._state = arg_18_1

	return
end

function ys.Battle.CardPuzzleCombatCard.ConfigOP(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	arg_19_0._dragDelegate = GetOrAddComponent(arg_19_0._go, "EventTriggerListener")

	arg_19_0._dragDelegate:AddPointUpFunc(function(arg_20_0, arg_20_1)
		arg_19_6()

		return
	end)
	arg_19_0._dragDelegate:AddBeginDragFunc(function(arg_21_0, arg_21_1)
		arg_19_0:dragAlphaAndScale()
		arg_19_2(arg_19_0._cardInfo)

		return
	end)
	arg_19_0._dragDelegate:AddDragFunc(function(arg_22_0, arg_22_1)
		arg_19_3(arg_22_1.position)

		return
	end)
	arg_19_0._dragDelegate:AddDragEndFunc(function(arg_23_0, arg_23_1)
		arg_19_0:resetAll()
		arg_19_4()

		return
	end)

	arg_19_0._longPressDelegate = GetOrAddComponent(arg_19_0._go, "UILongPressTrigger")
	arg_19_0._longPressDelegate.longPressThreshold = 0.5

	arg_19_0._longPressDelegate.onLongPressed:AddListener(function()
		arg_19_5()

		return
	end)

	return
end

function ys.Battle.CardPuzzleCombatCard.updateCoolDown(arg_25_0)
	if arg_25_0._cardInfo:GetCastRemainRate() > 0 then
		setActive(arg_25_0._coolDown, true)

		arg_25_0._coolDownProgress.fillAmount = arg_25_0._cardInfo:GetCastRemainRate()
	else
		setActive(arg_25_0._coolDown, false)
	end

	return
end

function ys.Battle.CardPuzzleCombatCard.change2ScrPos(arg_26_0, arg_26_1)
	return (LuaHelper.ScreenToLocal(arg_26_0, arg_26_1, pg.UIMgr.GetInstance().overlayCameraComp))
end

function ys.Battle.CardPuzzleCombatCard.UpdateDragPosition(arg_27_0, arg_27_1)
	arg_27_0:SetReferencePos((arg_27_0.change2ScrPos(arg_27_0._tf.parent, arg_27_1)))

	return
end

function ys.Battle.CardPuzzleCombatCard.BlockRayCast(arg_28_0, arg_28_1)
	arg_28_0._canvaGroup.blocksRaycasts = arg_28_1

	return
end

function ys.Battle.CardPuzzleCombatCard.UpdateTotalCost(arg_29_0)
	if arg_29_0._cardInfo then
		setText(arg_29_0.costTF, arg_29_0.data:GetTotalCost())
	end

	return
end

function ys.Battle.CardPuzzleCombatCard.UpdateBoostHint(arg_30_0)
	if arg_30_0._cardInfo then
		setActive(arg_30_0._boostHint, arg_30_0._cardInfo:IsBoost())
	end

	return
end

function ys.Battle.CardPuzzleCombatCard.dragAlphaAndScale(arg_31_0)
	LeanTween.cancel(arg_31_0._go)
	LeanTween.scale(arg_31_0._go, var_0_1.DRAG_SCALE, 0.1)
	LeanTween.alphaCanvas(arg_31_0._canvaGroup, 0.7, 0.1)

	return
end

function ys.Battle.CardPuzzleCombatCard.drawAlphaAndScale(arg_32_0)
	LeanTween.cancel(arg_32_0._go)

	arg_32_0._tf.localScale = var_0_1.DRAW_SCALE
	arg_32_0._canvaGroup.alpha = 0.2

	LeanTween.scale(arg_32_0._go, var_0_1.CARD_SCALE, 0.2)
	LeanTween.alphaCanvas(arg_32_0._canvaGroup, 1, 0.2)

	return
end

function ys.Battle.CardPuzzleCombatCard.shuffleBackAlphaAndScale(arg_33_0)
	arg_33_0:resetAll()
	LeanTween.scale(arg_33_0._go, var_0_1.SHUFFLE_SCALE, 0.2)
	LeanTween.alphaCanvas(arg_33_0._canvaGroup, 0, 0.2)

	return
end

function ys.Battle.CardPuzzleCombatCard.resetAll(arg_34_0)
	LeanTween.cancel(arg_34_0._go)

	arg_34_0._tf.localScale = var_0_1.CARD_SCALE
	arg_34_0._canvaGroup.alpha = 1

	return
end

return
