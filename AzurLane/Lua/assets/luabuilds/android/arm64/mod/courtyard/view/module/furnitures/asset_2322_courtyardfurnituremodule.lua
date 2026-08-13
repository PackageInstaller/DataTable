class = var_0_10000

local var_0_0 = "CourtYardFurnitureModule"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..CourtYardPlaceableModule"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.AddListener

	CourtYardEvent = var_6

	var_1_1(var_1_0, var_6.FURNITURE_POSITION_CHANGE, arg_1_0.OnPositionUpdate)

	return
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	pg = var_1

	local var_2_0 = var_1.ViewUtils.SetLayer
	local var_2_1 = arg_2_0._tf

	Layer = var_1_10004

	var_2_0(var_2_1, var_1_10004.UI)

	local var_2_2 = arg_2_0._tf

	arg_2_0.model = var_1.Find(var_2_2, "icon")

	local var_2_3 = arg_2_0._tf

	arg_2_0.masksTF = var_1.Find(var_2_3, "masks")
	arg_2_0.masks = {}

	local var_2_4 = arg_2_0:GetData()

	arg_2_0.isMultiMask = var_1.IsMultiMask(var_2_4)
	pairs = var_1

	local var_2_5 = arg_2_0:GetData()

	for iter_2_0, iter_2_1 in var_1(var_3.GetMaskNames(var_2_5)) do
		local var_2_6 = arg_2_0.masksTF
		local var_2_7 = var_6.Find(var_2_6, "icon_front_" .. iter_2_0)

		if arg_2_0.isMultiMask then
			setParent = var_7

			var_7(var_2_7, arg_2_0.interactionTF)
		end

		arg_2_0.masks[iter_2_0] = var_2_7
	end

	local var_2_8 = arg_2_0.masksTF

	arg_2_0.archMask = var_1.Find(var_2_8, "icon_front_arch")
	arg_2_0.bodyMasks = {}
	pairs = var_1

	local var_2_9 = arg_2_0.data

	for iter_2_2, iter_2_3 in var_1(var_3.GetBodyMasks(var_2_9)) do
		local var_2_10 = arg_2_0.bodyMasks
		local var_2_11 = arg_2_0.interactionTF

		var_2_10[iter_2_2] = var_7.Find(var_2_11, "body_mask" .. iter_2_2)
	end

	arg_2_0.animators = {}
	pairs = var_1

	local var_2_12 = arg_2_0.data

	for iter_2_4, iter_2_5 in var_1(var_3.GetAnimators(var_2_12)) do
		local var_2_13 = arg_2_0.data

		if var_6.GetAnimatorMask(var_2_13) then
			local var_2_14 = arg_2_0.interactionTF
			local var_2_15

			if not var_7.Find(var_2_14, "animtor_mask") then
				var_2_15 = arg_2_0.interactionTF
			end

			arg_2_0.animators[iter_2_5.key] = var_2_15:Find("Animator" .. iter_2_5.key)
		end
	end

	local var_2_16 = arg_2_0:GetData().selectedFlag

	arg_2_0:InitAttachment(var_2_16)

	if not var_2_16 then
		arg_2_0:EnableTrigger(false)
	end

	local var_2_17 = arg_2_0.data

	if var_2.IsSpine(var_2_17) then
		CourtYardFurnitureAnimatorAgent = var_2
		arg_2_0.animator = var_2.New(arg_2_0)
	end

	arg_2_0.effectContainer = arg_2_0._tf
	CourtYardEffectAgent = var_2
	arg_2_0.effectAgent = var_2.New(arg_2_0)

	return
end

function var_0_1.CreateWhenStoreyInit(arg_3_0)
	var_0_1.super.CreateWhenStoreyInit(arg_3_0)
	arg_3_0:BlocksRaycasts(false)

	return
end

function var_0_1.BlocksRaycasts(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.data
	local var_4_1 = var_2.CanClickWhenExitEditMode(var_4_0)
	local var_4_2 = arg_4_0.data
	local var_4_3 = #var_3.GetUsingSlots(var_4_2) > 0

	if var_4_1 or var_4_3 and arg_4_1 == false then
		return
	end

	arg_4_0.cg.blocksRaycasts = arg_4_1

	return
end

function var_0_1.GetSpine(arg_5_0)
	if arg_5_0.animator then
		return arg_5_0.animator.spineAnimUI.gameObject.transform
	end

	return
end

function var_0_1.GetCenterPoint(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetParentTF(var_6_0)
	local var_6_2 = var_1.InverseTransformPoint(var_6_1, arg_6_0._tf.position)

	Vector2 = var_6_0

	local var_6_3 = var_6_0(var_6_2.x, var_6_2.y)
	local var_6_4 = arg_6_0._tf.sizeDelta

	Vector2 = var_5

	local var_6_5 = var_5(0.5, 0.5) - arg_6_0._tf.pivot
	local var_6_6 = arg_6_0._tf.localScale.x

	Vector2 = var_7

	local var_6_7 = var_6_3 + var_7(var_6_6 * var_6_4.x * var_6_5.x, var_6_4.y * var_6_5.y)

	Vector3 = var_7

	return var_7(var_6_7.x, var_6_7.y, 0)
end

function var_0_1.GetSpinePoint(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.GetParentTF(var_7_0)
	local var_7_2 = var_1.InverseTransformPoint
	local var_7_3 = arg_7_0._tf
	local var_7_4 = var_7_2(var_7_1, var_5.Find(var_7_3, "spine_icon/spine").position)

	Vector3 = var_7_0

	return var_7_0(var_7_4.x, var_7_4.y, 0)
end

function var_0_1.GetBodyMask(arg_8_0, arg_8_1)
	return arg_8_0.bodyMasks[arg_8_1]
end

function var_0_1.GetAnimator(arg_9_0, arg_9_1)
	return arg_9_0.animators[arg_9_1]
end

function var_0_1.AddListeners(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.AddListener

	CourtYardEvent = var_1_10004

	var_10_1(var_10_0, var_1_10004.FURNITURE_OP_FLAG_CHANGE, arg_10_0.EnableTrigger)

	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.AddListener

	CourtYardEvent = var_4

	var_10_3(var_10_2, var_4.ROTATE_FURNITURE, arg_10_0.OnDirChange)

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.AddListener

	CourtYardEvent = var_4

	var_10_5(var_10_4, var_4.FURNITURE_STATE_CHANGE, arg_10_0.OnStateChange)

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.AddListener

	CourtYardEvent = var_4

	var_10_7(var_10_6, var_4.FURNITURE_WILL_INTERACTION, arg_10_0.OnWillInterAction)

	local var_10_8 = arg_10_0
	local var_10_9 = arg_10_0.AddListener

	CourtYardEvent = var_4

	var_10_9(var_10_8, var_4.FURNITURE_START_INTERACTION, arg_10_0.OnStartInterAction)

	local var_10_10 = arg_10_0
	local var_10_11 = arg_10_0.AddListener

	CourtYardEvent = var_4

	var_10_11(var_10_10, var_4.FURNITURE_UPDATE_INTERACTION, arg_10_0.OnUpdateInteraction)

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0.AddListener

	CourtYardEvent = var_4

	var_10_13(var_10_12, var_4.FURNITURE_STOP_INTERACTION, arg_10_0.OnStopInterAction)

	local var_10_14 = arg_10_0
	local var_10_15 = arg_10_0.AddListener

	CourtYardEvent = var_4

	var_10_15(var_10_14, var_4.FURNITURE_MOVE, arg_10_0.OnMove)

	local var_10_16 = arg_10_0
	local var_10_17 = arg_10_0.AddListener

	CourtYardEvent = var_4

	var_10_17(var_10_16, var_4.FURNITURE_STOP_MOVE, arg_10_0.OnStopMove)

	return
end

function var_0_1.RemoveListeners(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.RemoveListener

	CourtYardEvent = var_1_10004

	var_11_1(var_11_0, var_1_10004.FURNITURE_OP_FLAG_CHANGE, arg_11_0.EnableTrigger)

	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.RemoveListener

	CourtYardEvent = var_4

	var_11_3(var_11_2, var_4.ROTATE_FURNITURE, arg_11_0.OnDirChange)

	local var_11_4 = arg_11_0
	local var_11_5 = arg_11_0.RemoveListener

	CourtYardEvent = var_4

	var_11_5(var_11_4, var_4.FURNITURE_STATE_CHANGE, arg_11_0.OnStateChange)

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.RemoveListener

	CourtYardEvent = var_4

	var_11_7(var_11_6, var_4.FURNITURE_WILL_INTERACTION, arg_11_0.OnWillInterAction)

	local var_11_8 = arg_11_0
	local var_11_9 = arg_11_0.RemoveListener

	CourtYardEvent = var_4

	var_11_9(var_11_8, var_4.FURNITURE_START_INTERACTION, arg_11_0.OnStartInterAction)

	local var_11_10 = arg_11_0
	local var_11_11 = arg_11_0.RemoveListener

	CourtYardEvent = var_4

	var_11_11(var_11_10, var_4.FURNITURE_UPDATE_INTERACTION, arg_11_0.OnUpdateInteraction)

	local var_11_12 = arg_11_0
	local var_11_13 = arg_11_0.RemoveListener

	CourtYardEvent = var_4

	var_11_13(var_11_12, var_4.FURNITURE_STOP_INTERACTION, arg_11_0.OnStopInterAction)

	local var_11_14 = arg_11_0
	local var_11_15 = arg_11_0.RemoveListener

	CourtYardEvent = var_4

	var_11_15(var_11_14, var_4.FURNITURE_MOVE, arg_11_0.OnMove)

	local var_11_16 = arg_11_0
	local var_11_17 = arg_11_0.RemoveListener

	CourtYardEvent = var_4

	var_11_17(var_11_16, var_4.FURNITURE_STOP_MOVE, arg_11_0.OnStopMove)

	return
end

function var_0_1.EnableTrigger(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.dragAgent

	var_2.Enable(var_12_0, arg_12_1)

	return
end

function var_0_1.InitAttachment(arg_13_0, arg_13_1)
	onButton = var_1_10002

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0._tf

	local function var_13_2()
		local var_14_0 = arg_13_0

		var_0.Emit(var_14_0, "SelectFurniture", arg_13_0.data.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_13_0, var_13_1, var_13_2, var_1_10007)

	if arg_13_1 then
		triggerButton = var_1_10002

		var_1_10002(arg_13_0._tf)
	end

	return
end

function var_0_1.OnBeginDrag(arg_15_0)
	arg_15_0:Emit("BeginDragFurniture", arg_15_0.data.id)

	return
end

function var_0_1.OnDragging(arg_16_0, arg_16_1)
	arg_16_0:Emit("DragingFurniture", arg_16_0.data.id, arg_16_1)

	return
end

function var_0_1.OnDragEnd(arg_17_0, arg_17_1)
	arg_17_0:Emit("DragFurnitureEnd", arg_17_0.data.id, arg_17_1)

	return
end

function var_0_1.OnPositionUpdate(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:UpdatePosition(arg_18_1, arg_18_2)

	return
end

function var_0_1.OnDirChange(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._tf

	Vector3 = var_1_10003
	var_19_0.localScale = var_1_10003(arg_19_1 == 1 and 1 or -1, 1, 1)

	return
end

function var_0_1.OnWillInterAction(arg_20_0, arg_20_1)
	if arg_20_0.isMultiMask then
		pairs = var_2

		for iter_20_0, iter_20_1 in var_2(arg_20_0.masks) do
			iter_20_1:SetAsLastSibling()
		end
	end

	return
end

function var_0_1.OnStartInterAction(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1

	if arg_21_1.GetUsingAnimator(var_21_0) then
		setActive = var_1_10003

		var_1_10003(arg_21_0:GetAnimator(var_2.key), true)
	end

	local var_21_1 = arg_21_1:GetSkew()

	Vector3 = var_21_0

	local var_21_2

	if var_21_1 ~= var_21_0.zero then
		var_21_2 = arg_21_0._tf
		var_21_2.localPosition = var_21_1
	end

	pairs = var_21_2

	for iter_21_0, iter_21_1 in var_21_2(arg_21_0.masks) do
		setActive = var_1_10009

		var_1_10009(iter_21_1, true)
	end

	if arg_21_0.isMultiMask then
		pairs = var_4

		for iter_21_2, iter_21_3 in var_4(arg_21_0.masks) do
			iter_21_3:SetSiblingIndex(1 + 2 * (iter_21_2 - 1))
		end
	end

	return
end

function var_0_1.OnUpdateInteraction(arg_22_0, arg_22_1)
	if arg_22_0.animator then
		local var_22_0 = arg_22_0.animator

		var_2.PlayInteractioAnim(var_22_0, arg_22_1.action)
	end

	if arg_22_0:GetBodyMask(arg_22_1.slot.id) then
		local var_22_1 = var_2
		local var_22_2 = var_2.GetComponent

		typeof = var_1_10006
		Image = var_1_10008
		var_22_2(var_22_1, var_1_10006(var_1_10008)).enabled = not arg_22_1.closeBodyMask
	end

	local var_22_3 = arg_22_1.slot
	local var_22_4 = var_3.GetUsingAnimator(var_22_3)

	if arg_22_1.isReset and var_22_4 then
		local var_22_5 = arg_22_0:GetAnimator(var_22_4.key)

		setActive = var_22_3

		var_22_3(var_22_5, false)

		setActive = var_22_3

		var_22_3(var_22_5, true)
	end

	if arg_22_1.block then
		arg_22_0.cg.blocksRaycasts = false
	end

	return
end

function var_0_1.OnStopInterAction(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1

	if arg_23_1.GetUsingAnimator(var_23_0) then
		local var_23_1 = arg_23_0:GetAnimator(var_2.key)

		Vector3 = var_23_0
		var_23_1.localScale = var_23_0.one
		Vector3 = var_23_0
		var_23_1.localEulerAngles = var_23_0.zero
		setActive = var_23_0

		var_23_0(var_23_1, false)
	end

	local var_23_2 = arg_23_0

	if arg_23_0.GetBodyMask(var_23_2, arg_23_1.id) then
		Vector3 = var_23_0
		var_3.localScale = var_23_0.one
		Vector3 = var_4
		var_3.localEulerAngles = var_4.zero
	end

	local var_23_3 = arg_23_0:GetData()

	if var_4.AnySlotIsUsing(var_23_3) then
		table = var_23_2

		if var_23_2.getCount(arg_23_0.masks) >= 1 then
			goto label_23_0
		end
	end

	pairs = var_23_2

	for iter_23_0, iter_23_1 in var_23_2(arg_23_0.masks) do
		setActive = var_1_10010

		var_1_10010(iter_23_1, false)
	end

	::label_23_0::

	return
end

function var_0_1.OnAnimtionFinish(arg_24_0, arg_24_1)
	arg_24_0.cg.blocksRaycasts = true

	arg_24_0:Emit("FurnitureAnimtionFinish", arg_24_0.data.id, arg_24_1)

	return
end

function var_0_1.OnStateChange(arg_25_0, arg_25_1)
	CourtYardFurniture = var_1_10002

	if arg_25_1 == var_1_10002.STATE_PLAY_MUSIC then
		arg_25_0:AddMusicEffect()
	else
		CourtYardFurniture = var_2

		if arg_25_1 == var_2.STATE_IDLE then
			arg_25_0:StopMusicEffect()
		end
	end

	if arg_25_0.animator then
		local var_25_0 = arg_25_0.animator

		var_2.SetState(var_25_0, arg_25_1)
	end

	return
end

function var_0_1.AddMusicEffect(arg_26_0)
	local var_26_0 = arg_26_0.data

	if var_1.GetMusicData(var_26_0) and var_1.effect then
		local var_26_1 = arg_26_0.effectAgent

		var_2.EnableEffect(var_26_1, var_1.effect)
	end

	return
end

function var_0_1.StopMusicEffect(arg_27_0)
	local var_27_0 = arg_27_0.data

	if var_1.GetMusicData(var_27_0) and var_1.effect then
		local var_27_1 = arg_27_0.effectAgent

		var_2.DisableEffect(var_27_1, var_1.effect)
	end

	return
end

function var_0_1.OnMove(arg_28_0, arg_28_1)
	CourtYardCalcUtil = var_1_10002

	local var_28_0 = var_1_10002.Map2Local(arg_28_1)
	local var_28_1 = arg_28_0.data
	local var_28_2 = var_3.GetMoveTime(var_28_1)

	Vector3 = var_4

	local var_28_3 = var_4(var_28_0.x, var_28_0.y, 0)

	CourtYardCalcUtil = var_28_1

	local var_28_4 = var_28_1.TrPosition2LocalPos(arg_28_0:GetParentTF(), arg_28_0._tf.parent, var_28_3)

	LeanTween = var_6

	var_6.moveLocal(arg_28_0._go, var_28_4, var_28_2)

	return
end

function var_0_1.OnStopMove(arg_29_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_29_0._go) then
		LeanTween = var_1

		var_1.cancel(arg_29_0._go)
	end

	return
end

function var_0_1.OnDispose(arg_30_0)
	var_0_1.super.OnDispose(arg_30_0)

	IsNil = var_1

	if not var_1(arg_30_0.model) then
		Object = var_1

		var_1.Destroy(arg_30_0.model.gameObject)
	end

	pairs = var_1

	for iter_30_0, iter_30_1 in var_1(arg_30_0.masks) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_30_1.gameObject)
	end

	arg_30_0.masks = nil
	pairs = var_1

	for iter_30_2, iter_30_3 in var_1(arg_30_0.animators) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_30_3.gameObject)
	end

	arg_30_0.animators = nil
	IsNil = var_1

	if not var_1(arg_30_0.archMask) then
		Object = var_1

		var_1.Destroy(arg_30_0.archMask.gameObject)
	end

	arg_30_0.archMask = nil

	if arg_30_0.animator then
		local var_30_0 = arg_30_0.animator

		var_1.Dispose(var_30_0)

		arg_30_0.animator = nil
	end

	local var_30_1 = arg_30_0.effectAgent

	var_1.Dispose(var_30_1)

	arg_30_0.effectAgent = nil
	pairs = var_1

	for iter_30_4, iter_30_5 in var_1(arg_30_0.bodyMasks) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_30_5.gameObject)
	end

	arg_30_0.bodyMasks = nil

	local var_30_2 = arg_30_0.cg

	var_30_2.blocksRaycasts = true
	Object = var_30_2

	local var_30_3 = var_30_2.Destroy
	local var_30_4 = arg_30_0._tf
	local var_30_5 = var_3.GetComponent

	typeof = var_1_10006
	ButtonEventExtend = var_1_10008

	var_30_3(var_30_5(var_30_4, var_1_10006(var_1_10008)))

	Object = var_30_3

	local var_30_6 = var_30_3.Destroy
	local var_30_7 = arg_30_0._tf
	local var_30_8 = var_3.GetComponent

	typeof = var_6
	Button = var_1_10008

	var_30_6(var_30_8(var_30_7, var_6(var_1_10008)))

	return
end

function var_0_1.OnDestroy(arg_31_0)
	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.RemoveListener

	CourtYardEvent = var_1_10004

	var_31_1(var_31_0, var_1_10004.FURNITURE_POSITION_CHANGE, arg_31_0.OnPositionUpdate)

	local var_31_2 = arg_31_0:GetView().poolMgr
	local var_31_3 = var_1.GetFurniturePool(var_31_2)

	var_1.Enqueue(var_31_3, arg_31_0._go)

	return
end

return var_0_1
