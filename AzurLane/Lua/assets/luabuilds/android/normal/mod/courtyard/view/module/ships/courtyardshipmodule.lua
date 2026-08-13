class = var_0_10000

local var_0_0 = "CourtYardShipModule"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..CourtYardPlaceableModule"))
local var_0_2 = 1

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	CourtYardConst = var_1_10004
	var_0_2 = var_1_10004.SHIP_SCALE

	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._role = arg_1_3

	return
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	pg = var_1

	local var_2_0 = var_1.ViewUtils.SetLayer
	local var_2_1 = arg_2_0._tf

	Layer = var_1_10003

	var_2_0(var_2_1, var_1_10003.UI)

	local var_2_2 = arg_2_0._tf

	var_1.SetParent(var_2_2, arg_2_0.floor)

	local var_2_3 = arg_2_0._role
	local var_2_4 = var_1.SetLocalPosition

	Vector3 = var_3

	var_2_4(var_2_3, var_3(0, 25, 0))

	local var_2_5 = arg_2_0._tf

	arg_2_0.shadow = var_1.Find(var_2_5, "shadow")

	local var_2_6 = arg_2_0.shadow

	Vector3 = var_2_5
	var_2_6.localPosition = var_2_5(0, 25, 0)

	local var_2_7 = arg_2_0.shadow

	var_1.SetAsFirstSibling(var_2_7)

	local var_2_8 = arg_2_0._role

	arg_2_0.spineAnimUI = var_1.GetSpineAnimUI(var_2_8)

	local var_2_9 = arg_2_0._tf

	arg_2_0.clickTF = var_1.Find(var_2_9, "click")

	local var_2_10 = arg_2_0._tf

	arg_2_0.chatTF = var_1.Find(var_2_10, "chat")

	local var_2_11 = arg_2_0.chatTF

	Vector3 = var_2_10
	var_2_11.localScale = var_2_10.zero

	local var_2_12 = arg_2_0._tf

	arg_2_0.additionTF = var_1.Find(var_2_12, "addition")

	local var_2_13 = {}

	findTF = var_2_12
	var_2_13[1] = var_2_12(arg_2_0.additionTF, "money")
	findTF = var_2
	var_2_13[2] = var_2(arg_2_0.additionTF, "intimacy")
	findTF = var_2
	var_2_13[3] = var_2(arg_2_0.additionTF, "exp")
	arg_2_0.additionTFs = var_2_13
	Vector3 = var_2_13
	arg_2_0.additionTFPos = var_2_13(0, 250, 0)

	local var_2_14 = arg_2_0._tf

	arg_2_0.inimacyBubble = var_1.Find(var_2_14, "intimacy")

	local var_2_15 = arg_2_0._tf

	arg_2_0.moneyBubble = var_1.Find(var_2_15, "money")
	CourtYardShipAnimatorAgent = var_1
	arg_2_0.animator = var_1.New(arg_2_0)

	local var_2_16 = arg_2_0._tf

	Vector3 = var_2
	var_2_16.localScale = var_2(var_0_2, var_0_2, 1)

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "grids")

	Vector3 = var_2_17
	var_2_18.localScale = var_2_17(1 / var_0_2, 1 / var_0_2, 1)

	local var_2_19 = arg_2_0.animator
	local var_2_20 = var_1.SetState
	local var_2_21 = arg_2_0.data

	var_2_20(var_2_19, var_3.GetState(var_2_21))
	arg_2_0:UpdateBubble(arg_2_0.inimacyBubble, arg_2_0.data.inimacy)
	arg_2_0:UpdateBubble(arg_2_0.moneyBubble, arg_2_0.data.coin)
	arg_2_0:InitAttachment()

	setActive = var_1

	var_1(arg_2_0.shadow, true)

	return
end

function var_0_1.AdjustYForInteraction(arg_3_0)
	local var_3_0 = arg_3_0._role
	local var_3_1 = var_1.SetLocalPosition

	Vector3 = var_1_10003

	var_3_1(var_3_0, var_1_10003(0, 0, 0))

	return
end

function var_0_1.ResetYForInteraction(arg_4_0)
	local var_4_0 = arg_4_0._role
	local var_4_1 = var_1.SetLocalPosition

	Vector3 = var_1_10003

	var_4_1(var_4_0, var_1_10003(0, 25, 0))

	return
end

function var_0_1.GetSpine(arg_5_0)
	local var_5_0 = arg_5_0._role

	return var_1.GetRoleModel(var_5_0)
end

function var_0_1.AddListeners(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.AddListener

	CourtYardEvent = var_1_10003

	var_6_1(var_6_0, var_1_10003.SHIP_STATE_CHANGE, arg_6_0.OnStateChange)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.AddListener

	CourtYardEvent = var_3

	var_6_3(var_6_2, var_3.SHIP_MOVE, arg_6_0.OnMove)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.AddListener

	CourtYardEvent = var_3

	var_6_5(var_6_4, var_3.SHIP_POSITION_CHANGE, arg_6_0.OnUpdatePosition)

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.AddListener

	CourtYardEvent = var_3

	var_6_7(var_6_6, var_3.SHIP_GET_AWARD, arg_6_0.OnAddAward)

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.AddListener

	CourtYardEvent = var_3

	var_6_9(var_6_8, var_3.SHIP_INIMACY_CHANGE, arg_6_0.OnInimacyChange)

	local var_6_10 = arg_6_0
	local var_6_11 = arg_6_0.AddListener

	CourtYardEvent = var_3

	var_6_11(var_6_10, var_3.SHIP_COIN_CHANGE, arg_6_0.OnCoinChange)

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.AddListener

	CourtYardEvent = var_3

	var_6_13(var_6_12, var_3.SHIP_UPDATE_INTERACTION, arg_6_0.OnUpdateInteraction)

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.AddListener

	CourtYardEvent = var_3

	var_6_15(var_6_14, var_3.SHIP_WILL_INTERACTION, arg_6_0.WillInterAction)

	local var_6_16 = arg_6_0
	local var_6_17 = arg_6_0.AddListener

	CourtYardEvent = var_3

	var_6_17(var_6_16, var_3.SHIP_START_INTERACTION, arg_6_0.StartInterAction)

	local var_6_18 = arg_6_0
	local var_6_19 = arg_6_0.AddListener

	CourtYardEvent = var_3

	var_6_19(var_6_18, var_3.SHIP_STOP_INTERACTION, arg_6_0.StopInterAction)

	return
end

function var_0_1.RemoveListeners(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.RemoveListener

	CourtYardEvent = var_1_10003

	var_7_1(var_7_0, var_1_10003.SHIP_STATE_CHANGE, arg_7_0.OnStateChange)

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.RemoveListener

	CourtYardEvent = var_3

	var_7_3(var_7_2, var_3.SHIP_MOVE, arg_7_0.OnMove)

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.RemoveListener

	CourtYardEvent = var_3

	var_7_5(var_7_4, var_3.SHIP_POSITION_CHANGE, arg_7_0.OnUpdatePosition)

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.RemoveListener

	CourtYardEvent = var_3

	var_7_7(var_7_6, var_3.SHIP_GET_AWARD, arg_7_0.OnAddAward)

	local var_7_8 = arg_7_0
	local var_7_9 = arg_7_0.RemoveListener

	CourtYardEvent = var_3

	var_7_9(var_7_8, var_3.SHIP_INIMACY_CHANGE, arg_7_0.OnInimacyChange)

	local var_7_10 = arg_7_0
	local var_7_11 = arg_7_0.RemoveListener

	CourtYardEvent = var_3

	var_7_11(var_7_10, var_3.SHIP_COIN_CHANGE, arg_7_0.OnCoinChange)

	local var_7_12 = arg_7_0
	local var_7_13 = arg_7_0.RemoveListener

	CourtYardEvent = var_3

	var_7_13(var_7_12, var_3.SHIP_UPDATE_INTERACTION, arg_7_0.OnUpdateInteraction)

	local var_7_14 = arg_7_0
	local var_7_15 = arg_7_0.RemoveListener

	CourtYardEvent = var_3

	var_7_15(var_7_14, var_3.SHIP_WILL_INTERACTION, arg_7_0.WillInterAction)

	local var_7_16 = arg_7_0
	local var_7_17 = arg_7_0.RemoveListener

	CourtYardEvent = var_3

	var_7_17(var_7_16, var_3.SHIP_START_INTERACTION, arg_7_0.StartInterAction)

	local var_7_18 = arg_7_0
	local var_7_19 = arg_7_0.RemoveListener

	CourtYardEvent = var_3

	var_7_19(var_7_18, var_3.SHIP_STOP_INTERACTION, arg_7_0.StopInterAction)

	return
end

function var_0_1.InitAttachment(arg_8_0)
	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.clickTF, function()
		local var_9_0 = arg_8_0

		var_0.Emit(var_9_0, "TouchShip", arg_8_0.data.id)

		pg = var_0

		local var_9_1 = var_0.CriMgr.GetInstance()
		local var_9_2 = var_0.PlaySoundEffect_V3

		SFX_BOAT_CLICK = var_2

		var_9_2(var_9_1, var_2)

		return
	end)

	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.inimacyBubble

	local function var_8_2()
		local var_10_0 = arg_8_0

		var_0.Emit(var_10_0, "GetShipInimacy", arg_8_0.data.id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10005)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.moneyBubble

	local function var_8_5()
		local var_11_0 = arg_8_0

		var_0.Emit(var_11_0, "GetShipCoin", arg_8_0.data.id)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10005)

	return
end

function var_0_1.OnBeginDrag(arg_12_0)
	local var_12_0 = arg_12_0:GetView()
	local var_12_1 = var_1.GetCurrStorey(var_12_0)

	if not var_1.AllModulesAreCompletion(var_12_1) then
		return
	end

	arg_12_0:Emit("DragShip", arg_12_0.data.id)

	pg = var_1

	local var_12_2 = var_1.CriMgr.GetInstance()
	local var_12_3 = var_1.PlaySoundEffect_V3

	SFX_BOAT_DRAG = var_3

	var_12_3(var_12_2, var_3)

	return
end

function var_0_1.OnDragging(arg_13_0, arg_13_1)
	arg_13_0:Emit("DragingShip", arg_13_0.data.id, arg_13_1)

	return
end

function var_0_1.OnDragEnd(arg_14_0, arg_14_1)
	arg_14_0:Emit("DragShipEnd", arg_14_0.data.id, arg_14_1)

	return
end

function var_0_1.OnUpdatePosition(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:UpdatePosition(arg_15_1, arg_15_2)

	return
end

function var_0_1.OnStateChange(arg_16_0, arg_16_1, arg_16_2)
	CourtYardShip = var_1_10003

	if arg_16_1 ~= var_1_10003.STATE_MOVING_ZERO then
		CourtYardShip = var_3

		if arg_16_1 ~= var_3.STATE_MOVING_HALF then
			CourtYardShip = var_3

			if arg_16_1 ~= var_3.STATE_MOVING_ONE then
				arg_16_0:ClearMove()
			end
		end
	end

	local var_16_0 = arg_16_0.animator

	var_3.SetState(var_16_0, arg_16_1)

	CourtYardShip = var_3

	if arg_16_1 == var_3.STATE_TOUCH then
		arg_16_0:ClearChatAnimation()
		arg_16_0:PlayChatAnim()
	end

	return
end

function var_0_1.PlayChatAnim(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	defaultValue = var_1_10004
	arg_17_3 = var_1_10004(arg_17_3, true)
	defaultValue = var_4
	arg_17_2 = var_4(arg_17_2, 0)
	defaultValue = var_4

	local var_17_0 = arg_17_1

	Vector3 = var_6
	arg_17_1 = var_4(var_17_0, var_6(2, 2, 2))
	LeanTween = var_4

	local var_17_1 = var_4.scale

	go = var_17_0

	local var_17_2 = var_17_1(var_17_0(arg_17_0.chatTF), arg_17_1, 0.5)
	local var_17_3 = var_4.setEase

	LeanTweenType = var_6

	local var_17_4 = var_17_3(var_17_2, var_6.easeOutBack)
	local var_17_5 = var_4.setDelay(var_17_4, arg_17_2)

	if not arg_17_3 then
		return
	end

	local var_17_6 = var_17_5
	local var_17_7 = var_17_5.setOnComplete

	System = var_7

	var_17_7(var_17_6, var_7.Action(function()
		local var_18_0 = arg_17_0
		local var_18_1 = var_0.PlayChatAnim

		Vector3 = var_2_10002

		var_18_1(var_18_0, var_2_10002(0, 0, 0), 2, false)

		return
	end))

	return
end

function var_0_1.ClearChatAnimation(arg_19_0)
	LeanTween = var_1_10001

	local var_19_0 = var_1_10001.isTweening

	go = var_1_10002

	if var_19_0(var_1_10002(arg_19_0.chatTF)) then
		LeanTween = var_1

		local var_19_1 = var_1.cancel

		go = var_2

		var_19_1(var_2(arg_19_0.chatTF))
	end

	local var_19_2 = arg_19_0.chatTF

	Vector3 = var_2
	var_19_2.localScale = var_2.zero

	return
end

function var_0_1.OnUpdateInteraction(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.action
	local var_20_1 = arg_20_0.animator

	var_3.PlayInteractioAnim(var_20_1, var_20_0)

	return
end

function var_0_1.OnAnimtionFinish(arg_21_0, arg_21_1)
	arg_21_0:Emit("ShipAnimtionFinish", arg_21_0.data.id, arg_21_1)

	return
end

function var_0_1.OnMove(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:ClearMove()

	local var_22_0 = arg_22_0.data
	local var_22_1 = var_3.GetPosition(var_22_0)

	CourtYardCalcUtil = var_22_0

	local var_22_2 = var_22_0.Map2Local(arg_22_1)
	local var_22_3 = arg_22_0.data
	local var_22_4 = var_5.GetMoveTime(var_22_3)
	local var_22_5 = arg_22_1.x < var_22_1.x and arg_22_1.y == var_22_1.y or arg_22_1.x == var_22_1.x and arg_22_1.y > var_22_1.y
	local var_22_6 = arg_22_0._role
	local var_22_7 = var_7.SetLocalScale

	Vector3 = var_1_10009

	var_22_7(var_22_6, var_1_10009(var_22_5 == false and 1 or -1, 1, 1))

	Vector3 = var_22_7

	local var_22_8 = var_22_7(var_22_2.x, var_22_2.y, 0) + arg_22_2

	CourtYardCalcUtil = var_8

	local var_22_9 = var_8.TrPosition2LocalPos(arg_22_0:GetParentTF(), arg_22_0._tf.parent, var_22_8)

	LeanTween = var_9

	var_9.moveLocal(arg_22_0._go, var_22_9, var_22_4)

	for iter_22_0 = 1, arg_22_0.interactionTF.childCount do
		local var_22_10 = arg_22_0.interactionTF
		local var_22_11 = var_13.GetChild(var_22_10, iter_22_0 - 1)

		Vector3 = var_22_10
		math = var_15
		var_22_11.localScale = var_22_10(var_15.abs(var_22_11.localScale.x), var_22_11.localScale.y, var_22_11.localScale.z)
	end

	local var_22_12 = arg_22_0.interactionTF
	local var_22_13 = arg_22_0._role

	var_22_12.localScale = var_10.GetLocalScale(var_22_13)

	return
end

function var_0_1.OnAddAward(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_2 == 3 and arg_23_1 <= 0 then
		return
	end

	pairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(arg_23_0.additionTFs) do
		setActive = var_1_10008

		var_1_10008(iter_23_1, arg_23_2 == iter_23_0)
	end

	local var_23_0 = arg_23_0.additionTFs[arg_23_2]

	if arg_23_2 ~= 1 then
		arg_23_1 = ""
	end

	setText = var_4

	var_4(var_23_0:Find("Text"), arg_23_1 or "")

	local var_23_1

	if arg_23_2 == 2 then
		var_23_1 = arg_23_0
		var_23_1 = arg_23_0.GetView(var_23_1).poolMgr

		if var_4.GetHeartPool(var_23_1) then
			var_23_1 = arg_23_0
			var_23_1 = arg_23_0.GetView(var_23_1).poolMgr
			var_23_1 = var_4.GetHeartPool(var_23_1)

			local var_23_2 = var_4.Dequeue(var_23_1).transform

			var_23_1.SetParent(var_23_2, arg_23_0._tf, false)

			tf = var_23_1
			var_23_1 = var_23_1(var_4)
			Vector3 = var_6
			var_23_1.localPosition = var_6(0, 200, -100)
			tf = var_23_1
			var_23_1 = var_23_1(var_4)
			Vector3 = var_6
			var_23_1.localScale = var_6(100, 100, 100)
		end
	end

	local var_23_3 = 1 / var_0_2

	CourtYardCalcUtil = var_23_1

	local var_23_4

	if var_23_1.GetTransformSign(arg_23_0._tf, arg_23_0.rect) < 0 then
		var_23_4 = arg_23_0.additionTF
		Vector3 = var_6
		var_23_4.localScale = var_6(-var_23_3, var_23_3, var_23_3)
	end

	LeanTween = var_23_4

	var_23_4.cancel(arg_23_0.additionTF.gameObject)

	local var_23_5 = arg_23_0.additionTF.transform

	var_23_5.localPosition = arg_23_0.additionTFPos
	LeanTween = var_23_5

	local var_23_6 = var_23_5.moveY

	rtf = var_6

	local var_23_7 = var_23_6(var_6(arg_23_0.additionTF), arg_23_0.additionTFPos.y + 110, 1.2)
	local var_23_8 = var_5.setOnComplete

	System = var_7

	var_23_8(var_23_7, var_7.Action(function()
		local var_24_0 = arg_23_0.additionTF

		Vector3 = var_2_10001
		var_24_0.localScale = var_2_10001(var_23_3, var_23_3, var_23_3)
		setActive = var_24_0

		var_24_0(var_23_0, false)

		return
	end))

	return
end

function var_0_1.UpdateBubble(arg_25_0, arg_25_1, arg_25_2)
	setActive = var_1_10003

	var_1_10003(arg_25_1, arg_25_2 ~= 0)

	LeanTween = var_1_10003

	if var_1_10003.isTweening(arg_25_1.gameObject) then
		LeanTween = var_3

		var_3.cancel(arg_25_1.gameObject)
	end

	if arg_25_2 ~= 0 then
		Vector3 = var_3
		arg_25_1.localScale = var_3(2, 2, 0)
	end

	if arg_25_2 ~= 0 then
		floatAni = var_3

		var_3(arg_25_1, 20, 1)
	end

	return
end

function var_0_1.OnInimacyChange(arg_26_0, arg_26_1)
	arg_26_0:UpdateBubble(arg_26_0.inimacyBubble, arg_26_1)

	return
end

function var_0_1.OnCoinChange(arg_27_0, arg_27_1)
	arg_27_0:UpdateBubble(arg_27_0.moneyBubble, arg_27_1)

	return
end

function var_0_1.ClearMove(arg_28_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_28_0._go)

	return
end

function var_0_1.WillInterAction(arg_29_0, arg_29_1)
	return
end

function var_0_1.StartInterAction(arg_30_0, arg_30_1)
	setActive = var_1_10002

	var_1_10002(arg_30_0.shadow, false)

	local var_30_0 = arg_30_1
	local var_30_1 = arg_30_1.GetOffset(var_30_0)

	setAnchoredPosition = var_30_0

	var_30_0(arg_30_0._tf, var_30_1)

	local var_30_2 = arg_30_1:GetOwner()
	local var_30_3 = var_3.GetNormalDirection(var_30_2)
	local var_30_4 = arg_30_1:GetScale()
	local var_30_5 = arg_30_0._role
	local var_30_6 = var_6.SetLocalScale

	Vector3 = var_1_10008

	var_30_6(var_30_5, var_1_10008(var_30_3 * var_30_4.x, var_30_4.y, var_30_4.z))
	arg_30_0:AdjustYForInteraction()

	return
end

function var_0_1.StopInterAction(arg_31_0)
	setActive = var_1_10001

	var_1_10001(arg_31_0.shadow, true)
	arg_31_0:ResetTransform()
	arg_31_0:ResetYForInteraction()

	return
end

function var_0_1.ResetTransform(arg_32_0)
	local var_32_0 = arg_32_0._tf

	Vector3 = var_1_10002
	var_32_0.localScale = var_1_10002(var_0_2, var_0_2, 1)

	local var_32_1 = arg_32_0._tf

	Vector3 = var_2
	var_32_1.localEulerAngles = var_2.zero

	return
end

function var_0_1.HideAttachment(arg_33_0, arg_33_1)
	if arg_33_0._role then
		local var_33_0 = arg_33_0._role

		var_2.SetOrbitVisible(var_33_0, not arg_33_1)
	end

	return
end

function var_0_1.OnDispose(arg_34_0)
	var_0_1.super.OnDispose(arg_34_0)
	arg_34_0:ClearChatAnimation()
	arg_34_0:ResetTransform()

	if arg_34_0.animator then
		local var_34_0 = arg_34_0.animator

		var_1.Dispose(var_34_0)

		arg_34_0.animator = nil
	end

	if arg_34_0.spineAnimUI then
		local var_34_1 = arg_34_0.spineAnimUI

		var_1.SetActionCallBack(var_34_1, nil)

		arg_34_0.spineAnimUI = nil
	end

	arg_34_0:ClearMove()

	if arg_34_0._role then
		local var_34_2 = arg_34_0._role

		var_1.Dispose(var_34_2)

		arg_34_0._role = nil
	end

	return
end

function var_0_1.OnDestroy(arg_35_0)
	local var_35_0 = arg_35_0:GetView().poolMgr
	local var_35_1 = var_1.GetShipPool(var_35_0)

	var_1.Enqueue(var_35_1, arg_35_0._go)

	return
end

return var_0_1
