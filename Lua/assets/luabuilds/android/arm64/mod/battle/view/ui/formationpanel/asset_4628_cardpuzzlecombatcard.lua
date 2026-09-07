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

function ys.Battle.CardPuzzleCombatCard:GetCardCost()
	return self.data:GetTotalCost()
end

function ys.Battle.CardPuzzleCombatCard:UpdateView()
	var_0_1.super.UpdateView(self)

	self._coolDown = self._tf:Find("cooldown")
	self._coolDownProgress = self._coolDown:GetComponent(typeof(Image))
	self._canvaGroup = self._tf:GetComponent(typeof(CanvasGroup))
	self._boostHint = self._tf:Find("boost_hint")

	self:UpdateTotalCost()
	self:UpdateBoostHint()

	return
end

function ys.Battle.CardPuzzleCombatCard:Update()
	self:updateCoolDown()
	self:MoveToRefPos()

	return
end

function ys.Battle.CardPuzzleCombatCard:ShowGray(arg_6_1)
	setGray(self._tf, arg_6_1, true)

	return
end

function ys.Battle.CardPuzzleCombatCard:SetCardInfo(arg_7_1)
	self._cardInfo = arg_7_1

	self:SetData(self._cardInfo)

	return
end

function ys.Battle.CardPuzzleCombatCard:GetCardInfo()
	return self._cardInfo
end

function ys.Battle.CardPuzzleCombatCard:DrawAnima(arg_9_1)
	self:drawAlphaAndScale()

	self._tf.localPosition = arg_9_1

	return
end

function ys.Battle.CardPuzzleCombatCard:GetUIPos()
	return self._tf.anchoredPosition
end

function ys.Battle.CardPuzzleCombatCard:SetSibling(arg_11_1)
	self._tf:SetSiblingIndex(arg_11_1)

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

function ys.Battle.CardPuzzleCombatCard:MoveToRefPos()
	if self._tf.localPosition:Equals(self._refPos) then
		if self._moveToPointCallback then
			self:_moveToPointCallback()

			self._moveToPointCallback = nil
		end

		return
	end

	if self._moveLerp == 1 then
		self._pos:Copy(self._refPos)
	else
		self._pos:Copy((Vector2.Lerp(self._tf.localPosition, self._refPos, self._moveLerp)))
	end

	self._tf.localPosition = self._pos

	return
end

function ys.Battle.CardPuzzleCombatCard:SetToObjPoolRecylePos()
	self._tf.localPosition = var_0_1.RECYLE_POS

	return
end

function ys.Battle.CardPuzzleCombatCard:MoveToDeck(arg_16_1, arg_16_2)
	self:shuffleBackAlphaAndScale()
	self:SetMoveLerp(0.8)

	self._refPos = arg_16_2
	self._moveToPointCallback = arg_16_1

	return
end

function ys.Battle.CardPuzzleCombatCard:GetState()
	return self._state
end

function ys.Battle.CardPuzzleCombatCard.ChangeState(arg_18_0, arg_18_1)
	arg_18_0._state = arg_18_1

	return
end

function ys.Battle.CardPuzzleCombatCard:ConfigOP(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	self._dragDelegate = GetOrAddComponent(self._go, "EventTriggerListener")

	self._dragDelegate:AddPointUpFunc(function(arg_20_0, arg_20_1)
		arg_19_6()

		return
	end)
	self._dragDelegate:AddBeginDragFunc(function(arg_21_0, arg_21_1)
		self:dragAlphaAndScale()
		arg_19_2(self._cardInfo)

		return
	end)
	self._dragDelegate:AddDragFunc(function(arg_22_0, arg_22_1)
		arg_19_3(arg_22_1.position)

		return
	end)
	self._dragDelegate:AddDragEndFunc(function(arg_23_0, arg_23_1)
		self:resetAll()
		arg_19_4()

		return
	end)

	self._longPressDelegate = GetOrAddComponent(self._go, "UILongPressTrigger")
	self._longPressDelegate.longPressThreshold = 0.5

	self._longPressDelegate.onLongPressed:AddListener(function()
		arg_19_5()

		return
	end)

	return
end

function ys.Battle.CardPuzzleCombatCard:updateCoolDown()
	if self._cardInfo:GetCastRemainRate() > 0 then
		setActive(self._coolDown, true)

		self._coolDownProgress.fillAmount = self._cardInfo:GetCastRemainRate()
	else
		setActive(self._coolDown, false)
	end

	return
end

function ys.Battle.CardPuzzleCombatCard.change2ScrPos(arg_26_0, arg_26_1)
	return (LuaHelper.ScreenToLocal(arg_26_0, arg_26_1, pg.UIMgr.GetInstance().overlayCameraComp))
end

function ys.Battle.CardPuzzleCombatCard:UpdateDragPosition(arg_27_1)
	self:SetReferencePos((self.change2ScrPos(self._tf.parent, arg_27_1)))

	return
end

function ys.Battle.CardPuzzleCombatCard:BlockRayCast(arg_28_1)
	self._canvaGroup.blocksRaycasts = arg_28_1

	return
end

function ys.Battle.CardPuzzleCombatCard:UpdateTotalCost()
	if self._cardInfo then
		setText(self.costTF, self.data:GetTotalCost())
	end

	return
end

function ys.Battle.CardPuzzleCombatCard:UpdateBoostHint()
	if self._cardInfo then
		setActive(self._boostHint, self._cardInfo:IsBoost())
	end

	return
end

function ys.Battle.CardPuzzleCombatCard:dragAlphaAndScale()
	LeanTween.cancel(self._go)
	LeanTween.scale(self._go, var_0_1.DRAG_SCALE, 0.1)
	LeanTween.alphaCanvas(self._canvaGroup, 0.7, 0.1)

	return
end

function ys.Battle.CardPuzzleCombatCard:drawAlphaAndScale()
	LeanTween.cancel(self._go)

	self._tf.localScale = var_0_1.DRAW_SCALE
	self._canvaGroup.alpha = 0.2

	LeanTween.scale(self._go, var_0_1.CARD_SCALE, 0.2)
	LeanTween.alphaCanvas(self._canvaGroup, 1, 0.2)

	return
end

function ys.Battle.CardPuzzleCombatCard:shuffleBackAlphaAndScale()
	self:resetAll()
	LeanTween.scale(self._go, var_0_1.SHUFFLE_SCALE, 0.2)
	LeanTween.alphaCanvas(self._canvaGroup, 0, 0.2)

	return
end

function ys.Battle.CardPuzzleCombatCard:resetAll()
	LeanTween.cancel(self._go)

	self._tf.localScale = var_0_1.CARD_SCALE
	self._canvaGroup.alpha = 1

	return
end

return
