ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003

local var_0_3 = "CardPuzzleCombatCard"

CardPuzzleCardView = var_0_10005
var_0_2.CardPuzzleCombatCard = var_0_10003(var_0_3, var_0_10005)

local var_0_4 = var_0.Battle.CardPuzzleCombatCard

var_0_4.__name = "CardPuzzleCombatCard"
Vector3 = var_3
var_0_4.CARD_SCALE = var_3(0.57, 0.57, 0)
Vector3 = var_3
var_0_4.DRAG_SCALE = var_3(0.65, 0.65, 0)
Vector3 = var_3
var_0_4.DRAW_SCALE = var_3(0.2, 0.2, 0)
Vector3 = var_3
var_0_4.SHUFFLE_SCALE = var_3(0.1, 0.1, 0)
Vector3 = var_3
var_0_4.RECYLE_POS = var_3(10000, 10000, 0)
var_0_4.STATE_LOCK = "STATE_LOCK"
var_0_4.STATE_FREE = "STATE_FREE"
var_0_4.STATE_DRAG = "STATE_DRAG"
var_0_4.STATE_LONG_PRESS = "STATE_LONG_PRESS"
var_0_4.BASE_LERP = 0.2

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._go = arg_1_1.gameObject
	arg_1_1.localScale = var_0_4.CARD_SCALE
	arg_1_0._moveLerp = 0.2
	Vector3 = var_2
	arg_1_0._pos = var_2.zero

	return
end

function var_0_4.GetRarityBG(arg_2_0, arg_2_1)
	return "battle_card_bg_" .. arg_2_1
end

function var_0_4.GetCardCost(arg_3_0)
	local var_3_0 = arg_3_0.data

	return var_1.GetTotalCost(var_3_0)
end

function var_0_4.UpdateView(arg_4_0)
	var_0_4.super.UpdateView(arg_4_0)

	local var_4_0 = arg_4_0._tf

	arg_4_0._coolDown = var_1.Find(var_4_0, "cooldown")

	local var_4_1 = arg_4_0._coolDown
	local var_4_2 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_4_0._coolDownProgress = var_4_2(var_4_1, var_3(var_1_10004))

	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_1.GetComponent

	typeof = var_3
	CanvasGroup = var_1_10004
	arg_4_0._canvaGroup = var_4_4(var_4_3, var_3(var_1_10004))

	local var_4_5 = arg_4_0._tf

	arg_4_0._boostHint = var_1.Find(var_4_5, "boost_hint")

	arg_4_0:UpdateTotalCost()
	arg_4_0:UpdateBoostHint()

	return
end

function var_0_4.Update(arg_5_0)
	arg_5_0:updateCoolDown()
	arg_5_0:MoveToRefPos()

	return
end

function var_0_4.ShowGray(arg_6_0, arg_6_1)
	setGray = var_1_10002

	var_1_10002(arg_6_0._tf, arg_6_1, true)

	return
end

function var_0_4.SetCardInfo(arg_7_0, arg_7_1)
	arg_7_0._cardInfo = arg_7_1

	arg_7_0:SetData(arg_7_0._cardInfo)

	return
end

function var_0_4.GetCardInfo(arg_8_0)
	return arg_8_0._cardInfo
end

function var_0_4.DrawAnima(arg_9_0, arg_9_1)
	arg_9_0:drawAlphaAndScale()

	arg_9_0._tf.localPosition = arg_9_1

	return
end

function var_0_4.GetUIPos(arg_10_0)
	return arg_10_0._tf.anchoredPosition
end

function var_0_4.SetSibling(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._tf

	var_2.SetSiblingIndex(var_11_0, arg_11_1)

	return
end

function var_0_4.SetReferencePos(arg_12_0, arg_12_1)
	arg_12_0._refPos = arg_12_1

	return
end

function var_0_4.SetMoveLerp(arg_13_0, arg_13_1)
	arg_13_0._moveLerp = arg_13_1 or var_0_4.BASE_LERP

	return
end

function var_0_4.MoveToRefPos(arg_14_0)
	local var_14_0 = arg_14_0._tf.localPosition

	if var_1.Equals(var_14_0, arg_14_0._refPos) then
		if arg_14_0._moveToPointCallback then
			var_14_0 = arg_14_0

			arg_14_0._moveToPointCallback(var_14_0)

			arg_14_0._moveToPointCallback = nil
		end

		return
	end

	if arg_14_0._moveLerp == 1 then
		var_14_0 = arg_14_0._pos

		var_1.Copy(var_14_0, arg_14_0._refPos)
	else
		local var_14_1 = arg_14_0._tf.localPosition

		Vector2 = var_14_0

		local var_14_2 = var_14_0.Lerp(var_14_1, arg_14_0._refPos, arg_14_0._moveLerp)
		local var_14_3 = arg_14_0._pos

		var_3.Copy(var_14_3, var_14_2)
	end

	arg_14_0._tf.localPosition = arg_14_0._pos

	return
end

function var_0_4.SetToObjPoolRecylePos(arg_15_0)
	arg_15_0._tf.localPosition = var_0_4.RECYLE_POS

	return
end

function var_0_4.MoveToDeck(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:shuffleBackAlphaAndScale()
	arg_16_0:SetMoveLerp(0.8)

	arg_16_0._refPos = arg_16_2
	arg_16_0._moveToPointCallback = arg_16_1

	return
end

function var_0_4.GetState(arg_17_0)
	return arg_17_0._state
end

function var_0_4.ChangeState(arg_18_0, arg_18_1)
	arg_18_0._state = arg_18_1

	return
end

function var_0_4.ConfigOP(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	GetOrAddComponent = var_1_10007
	arg_19_0._dragDelegate = var_1_10007(arg_19_0._go, "EventTriggerListener")

	local var_19_0 = arg_19_0._dragDelegate

	var_7.AddPointUpFunc(var_19_0, function(arg_20_0, arg_20_1)
		arg_19_6()

		return
	end)

	local var_19_1 = arg_19_0._dragDelegate

	var_7.AddBeginDragFunc(var_19_1, function(arg_21_0, arg_21_1)
		local var_21_0 = arg_19_0

		var_2.dragAlphaAndScale(var_21_0)
		arg_19_2(arg_19_0._cardInfo)

		return
	end)

	local var_19_2 = arg_19_0._dragDelegate

	var_7.AddDragFunc(var_19_2, function(arg_22_0, arg_22_1)
		arg_19_3(arg_22_1.position)

		return
	end)

	local var_19_3 = arg_19_0._dragDelegate

	var_7.AddDragEndFunc(var_19_3, function(arg_23_0, arg_23_1)
		local var_23_0 = arg_19_0

		var_2.resetAll(var_23_0)
		arg_19_4()

		return
	end)

	GetOrAddComponent = var_7
	arg_19_0._longPressDelegate = var_7(arg_19_0._go, "UILongPressTrigger")
	arg_19_0._longPressDelegate.longPressThreshold = 0.5

	local var_19_4 = arg_19_0._longPressDelegate.onLongPressed

	var_7.AddListener(var_19_4, function()
		arg_19_5()

		return
	end)

	return
end

function var_0_4.updateCoolDown(arg_25_0)
	local var_25_0 = arg_25_0._cardInfo
	local var_25_1

	if var_1.GetCastRemainRate(var_25_0) > 0 then
		setActive = var_25_1

		var_25_1(arg_25_0._coolDown, true)

		var_25_1 = arg_25_0._coolDownProgress

		local var_25_2 = arg_25_0._cardInfo

		var_25_1.fillAmount = var_2.GetCastRemainRate(var_25_2)
	else
		setActive = var_25_1

		var_25_1(arg_25_0._coolDown, false)
	end

	return
end

function var_0_4.change2ScrPos(arg_26_0, arg_26_1)
	pg = var_1_10002

	local var_26_0 = var_1_10002.UIMgr.GetInstance().overlayCameraComp

	LuaHelper = var_1_10003

	return (var_1_10003.ScreenToLocal(arg_26_0, arg_26_1, var_26_0))
end

function var_0_4.UpdateDragPosition(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.change2ScrPos(arg_27_0._tf.parent, arg_27_1)

	arg_27_0:SetReferencePos(var_27_0)

	return
end

function var_0_4.BlockRayCast(arg_28_0, arg_28_1)
	arg_28_0._canvaGroup.blocksRaycasts = arg_28_1

	return
end

function var_0_4.UpdateTotalCost(arg_29_0)
	if arg_29_0._cardInfo then
		setText = var_1

		local var_29_0 = arg_29_0.costTF
		local var_29_1 = arg_29_0.data

		var_1(var_29_0, var_3.GetTotalCost(var_29_1))
	end

	return
end

function var_0_4.UpdateBoostHint(arg_30_0)
	if arg_30_0._cardInfo then
		setActive = var_1

		local var_30_0 = arg_30_0._boostHint
		local var_30_1 = arg_30_0._cardInfo

		var_1(var_30_0, var_3.IsBoost(var_30_1))
	end

	return
end

function var_0_4.dragAlphaAndScale(arg_31_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_31_0._go)

	LeanTween = var_1

	var_1.scale(arg_31_0._go, var_0_4.DRAG_SCALE, 0.1)

	LeanTween = var_1

	var_1.alphaCanvas(arg_31_0._canvaGroup, 0.7, 0.1)

	return
end

function var_0_4.drawAlphaAndScale(arg_32_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_32_0._go)

	arg_32_0._tf.localScale = var_0_4.DRAW_SCALE

	local var_32_0 = arg_32_0._canvaGroup

	var_32_0.alpha = 0.2
	LeanTween = var_32_0

	var_32_0.scale(arg_32_0._go, var_0_4.CARD_SCALE, 0.2)

	LeanTween = var_1

	var_1.alphaCanvas(arg_32_0._canvaGroup, 1, 0.2)

	return
end

function var_0_4.shuffleBackAlphaAndScale(arg_33_0)
	arg_33_0:resetAll()

	LeanTween = var_1

	var_1.scale(arg_33_0._go, var_0_4.SHUFFLE_SCALE, 0.2)

	LeanTween = var_1

	var_1.alphaCanvas(arg_33_0._canvaGroup, 0, 0.2)

	return
end

function var_0_4.resetAll(arg_34_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_34_0._go)

	arg_34_0._tf.localScale = var_0_4.CARD_SCALE
	arg_34_0._canvaGroup.alpha = 1

	return
end

return
