local var_0_0 = class("CourtYardFurnitureModule", import("..CourtYardPlaceableModule"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:AddListener(CourtYardEvent.FURNITURE_POSITION_CHANGE, arg_1_0.OnPositionUpdate)

	return
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	pg.ViewUtils.SetLayer(arg_2_0._tf, Layer.UI)

	arg_2_0.model = arg_2_0._tf:Find("icon")
	arg_2_0.masksTF = arg_2_0._tf:Find("masks")
	arg_2_0.masks = {}
	arg_2_0.isMultiMask = arg_2_0:GetData():IsMultiMask()

	for iter_2_0, iter_2_1 in pairs(arg_2_0:GetData():GetMaskNames()) do
		local var_2_0 = arg_2_0.masksTF:Find("icon_front_" .. iter_2_0)

		if arg_2_0.isMultiMask then
			setParent(var_2_0, arg_2_0.interactionTF)
		end

		arg_2_0.masks[iter_2_0] = var_2_0
	end

	arg_2_0.archMask = arg_2_0.masksTF:Find("icon_front_arch")
	arg_2_0.bodyMasks = {}

	for iter_2_2, iter_2_3 in pairs(arg_2_0.data:GetBodyMasks()) do
		arg_2_0.bodyMasks[iter_2_2] = arg_2_0.interactionTF:Find("body_mask" .. iter_2_2)
	end

	arg_2_0.animators = {}

	for iter_2_4, iter_2_5 in pairs(arg_2_0.data:GetAnimators()) do
		arg_2_0.animators[iter_2_5.key] = (arg_2_0.data:GetAnimatorMask() and arg_2_0.interactionTF:Find("animtor_mask") or arg_2_0.interactionTF):Find("Animator" .. iter_2_5.key)
	end

	local var_2_1 = arg_2_0:GetData().selectedFlag

	arg_2_0:InitAttachment(var_2_1)

	if not var_2_1 then
		arg_2_0:EnableTrigger(false)
	end

	if arg_2_0.data:IsSpine() then
		arg_2_0.animator = CourtYardFurnitureAnimatorAgent.New(arg_2_0)
	end

	arg_2_0.effectContainer = arg_2_0._tf
	arg_2_0.effectAgent = CourtYardEffectAgent.New(arg_2_0)

	return
end

function var_0_0.CreateWhenStoreyInit(arg_3_0)
	var_0_0.super.CreateWhenStoreyInit(arg_3_0)
	arg_3_0:BlocksRaycasts(false)

	return
end

function var_0_0.BlocksRaycasts(arg_4_0, arg_4_1)
	local var_4_0 = #arg_4_0.data:GetUsingSlots() > 0

	if arg_4_0.data:CanClickWhenExitEditMode() or var_4_0 and arg_4_1 == false then
		return
	end

	arg_4_0.cg.blocksRaycasts = arg_4_1

	return
end

function var_0_0.GetSpine(arg_5_0)
	if arg_5_0.animator then
		return arg_5_0.animator.spineAnimUI.gameObject.transform
	end

	return
end

function var_0_0.GetCenterPoint(arg_6_0)
	local var_6_0 = arg_6_0:GetParentTF():InverseTransformPoint(arg_6_0._tf.position)
	local var_6_1 = Vector2(0.5, 0.5) - arg_6_0._tf.pivot
	local var_6_2 = Vector2(var_6_0.x, var_6_0.y) + Vector2(arg_6_0._tf.localScale.x * arg_6_0._tf.sizeDelta.x * var_6_1.x, arg_6_0._tf.sizeDelta.y * var_6_1.y)

	return Vector3(var_6_2.x, var_6_2.y, 0)
end

function var_0_0.GetSpinePoint(arg_7_0)
	local var_7_0 = arg_7_0:GetParentTF():InverseTransformPoint(arg_7_0._tf:Find("spine_icon/spine").position)

	return Vector3(var_7_0.x, var_7_0.y, 0)
end

function var_0_0.GetBodyMask(arg_8_0, arg_8_1)
	return arg_8_0.bodyMasks[arg_8_1]
end

function var_0_0.GetAnimator(arg_9_0, arg_9_1)
	return arg_9_0.animators[arg_9_1]
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddListener(CourtYardEvent.FURNITURE_OP_FLAG_CHANGE, arg_10_0.EnableTrigger)
	arg_10_0:AddListener(CourtYardEvent.ROTATE_FURNITURE, arg_10_0.OnDirChange)
	arg_10_0:AddListener(CourtYardEvent.FURNITURE_STATE_CHANGE, arg_10_0.OnStateChange)
	arg_10_0:AddListener(CourtYardEvent.FURNITURE_WILL_INTERACTION, arg_10_0.OnWillInterAction)
	arg_10_0:AddListener(CourtYardEvent.FURNITURE_START_INTERACTION, arg_10_0.OnStartInterAction)
	arg_10_0:AddListener(CourtYardEvent.FURNITURE_UPDATE_INTERACTION, arg_10_0.OnUpdateInteraction)
	arg_10_0:AddListener(CourtYardEvent.FURNITURE_STOP_INTERACTION, arg_10_0.OnStopInterAction)
	arg_10_0:AddListener(CourtYardEvent.FURNITURE_MOVE, arg_10_0.OnMove)
	arg_10_0:AddListener(CourtYardEvent.FURNITURE_STOP_MOVE, arg_10_0.OnStopMove)

	return
end

function var_0_0.RemoveListeners(arg_11_0)
	arg_11_0:RemoveListener(CourtYardEvent.FURNITURE_OP_FLAG_CHANGE, arg_11_0.EnableTrigger)
	arg_11_0:RemoveListener(CourtYardEvent.ROTATE_FURNITURE, arg_11_0.OnDirChange)
	arg_11_0:RemoveListener(CourtYardEvent.FURNITURE_STATE_CHANGE, arg_11_0.OnStateChange)
	arg_11_0:RemoveListener(CourtYardEvent.FURNITURE_WILL_INTERACTION, arg_11_0.OnWillInterAction)
	arg_11_0:RemoveListener(CourtYardEvent.FURNITURE_START_INTERACTION, arg_11_0.OnStartInterAction)
	arg_11_0:RemoveListener(CourtYardEvent.FURNITURE_UPDATE_INTERACTION, arg_11_0.OnUpdateInteraction)
	arg_11_0:RemoveListener(CourtYardEvent.FURNITURE_STOP_INTERACTION, arg_11_0.OnStopInterAction)
	arg_11_0:RemoveListener(CourtYardEvent.FURNITURE_MOVE, arg_11_0.OnMove)
	arg_11_0:RemoveListener(CourtYardEvent.FURNITURE_STOP_MOVE, arg_11_0.OnStopMove)

	return
end

function var_0_0.EnableTrigger(arg_12_0, arg_12_1)
	arg_12_0.dragAgent:Enable(arg_12_1)

	return
end

function var_0_0.InitAttachment(arg_13_0, arg_13_1)
	onButton(arg_13_0, arg_13_0._tf, function()
		arg_13_0:Emit("SelectFurniture", arg_13_0.data.id)

		return
	end, SFX_PANEL)

	if arg_13_1 then
		triggerButton(arg_13_0._tf)
	end

	return
end

function var_0_0.OnBeginDrag(arg_15_0)
	arg_15_0:Emit("BeginDragFurniture", arg_15_0.data.id)

	return
end

function var_0_0.OnDragging(arg_16_0, arg_16_1)
	arg_16_0:Emit("DragingFurniture", arg_16_0.data.id, arg_16_1)

	return
end

function var_0_0.OnDragEnd(arg_17_0, arg_17_1)
	arg_17_0:Emit("DragFurnitureEnd", arg_17_0.data.id, arg_17_1)

	return
end

function var_0_0.OnPositionUpdate(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:UpdatePosition(arg_18_1, arg_18_2)

	return
end

function var_0_0.OnDirChange(arg_19_0, arg_19_1)
	arg_19_0._tf.localScale = Vector3(arg_19_1 == 1 and 1 or -1, 1, 1)

	return
end

function var_0_0.OnWillInterAction(arg_20_0, arg_20_1)
	if arg_20_0.isMultiMask then
		for iter_20_0, iter_20_1 in pairs(arg_20_0.masks) do
			iter_20_1:SetAsLastSibling()
		end
	end

	return
end

function var_0_0.OnStartInterAction(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:GetUsingAnimator()

	if var_21_0 then
		setActive(arg_21_0:GetAnimator(var_21_0.key), true)
	end

	local var_21_1 = arg_21_1:GetSkew()

	if var_21_1 ~= Vector3.zero then
		arg_21_0._tf.localPosition = var_21_1
	end

	for iter_21_0, iter_21_1 in pairs(arg_21_0.masks) do
		setActive(iter_21_1, true)
	end

	if arg_21_0.isMultiMask then
		for iter_21_2, iter_21_3 in pairs(arg_21_0.masks) do
			iter_21_3:SetSiblingIndex(1 + 2 * (iter_21_2 - 1))
		end
	end

	return
end

function var_0_0.OnUpdateInteraction(arg_22_0, arg_22_1)
	if arg_22_0.animator then
		arg_22_0.animator:PlayInteractioAnim(arg_22_1.action)
	end

	local var_22_0 = arg_22_0:GetBodyMask(arg_22_1.slot.id)

	if var_22_0 then
		var_22_0:GetComponent(typeof(Image)).enabled = not arg_22_1.closeBodyMask
	end

	local var_22_1 = arg_22_1.slot:GetUsingAnimator()

	if arg_22_1.isReset and var_22_1 then
		local var_22_2 = arg_22_0:GetAnimator(var_22_1.key)

		setActive(var_22_2, false)
		setActive(var_22_2, true)
	end

	if arg_22_1.block then
		arg_22_0.cg.blocksRaycasts = false
	end

	return
end

function var_0_0.OnStopInterAction(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1:GetUsingAnimator()

	if var_23_0 then
		local var_23_1 = arg_23_0:GetAnimator(var_23_0.key)

		var_23_1.localScale = Vector3.one
		var_23_1.localEulerAngles = Vector3.zero

		setActive(var_23_1, false)
	end

	local var_23_2 = arg_23_0:GetBodyMask(arg_23_1.id)

	if var_23_2 then
		var_23_2.localScale = Vector3.one
		var_23_2.localEulerAngles = Vector3.zero
	end

	local var_23_3 = arg_23_0:GetData()

	if var_23_3:AnySlotIsUsing() and table.getCount(arg_23_0.masks) >= 1 then
		-- block empty
	else
		for iter_23_0, iter_23_1 in pairs(arg_23_0.masks) do
			setActive(iter_23_1, false)
		end
	end

	return
end

function var_0_0.OnAnimtionFinish(arg_24_0, arg_24_1)
	arg_24_0.cg.blocksRaycasts = true

	arg_24_0:Emit("FurnitureAnimtionFinish", arg_24_0.data.id, arg_24_1)

	return
end

function var_0_0.OnStateChange(arg_25_0, arg_25_1)
	if arg_25_1 == CourtYardFurniture.STATE_PLAY_MUSIC then
		arg_25_0:AddMusicEffect()
	elseif arg_25_1 == CourtYardFurniture.STATE_IDLE then
		arg_25_0:StopMusicEffect()
	end

	if arg_25_0.animator then
		arg_25_0.animator:SetState(arg_25_1)
	end

	return
end

function var_0_0.AddMusicEffect(arg_26_0)
	local var_26_0 = arg_26_0.data:GetMusicData()

	if var_26_0 and var_26_0.effect then
		arg_26_0.effectAgent:EnableEffect(var_26_0.effect)
	end

	return
end

function var_0_0.StopMusicEffect(arg_27_0)
	local var_27_0 = arg_27_0.data:GetMusicData()

	if var_27_0 and var_27_0.effect then
		arg_27_0.effectAgent:DisableEffect(var_27_0.effect)
	end

	return
end

function var_0_0.OnMove(arg_28_0, arg_28_1)
	local var_28_0 = CourtYardCalcUtil.Map2Local(arg_28_1)

	LeanTween.moveLocal(arg_28_0._go, CourtYardCalcUtil.TrPosition2LocalPos(arg_28_0:GetParentTF(), arg_28_0._tf.parent, (Vector3(var_28_0.x, var_28_0.y, 0))), (arg_28_0.data:GetMoveTime()))

	return
end

function var_0_0.OnStopMove(arg_29_0)
	if LeanTween.isTweening(arg_29_0._go) then
		LeanTween.cancel(arg_29_0._go)
	end

	return
end

function var_0_0.OnDispose(arg_30_0)
	var_0_0.super.OnDispose(arg_30_0)

	if not IsNil(arg_30_0.model) then
		Object.Destroy(arg_30_0.model.gameObject)
	end

	for iter_30_0, iter_30_1 in pairs(arg_30_0.masks) do
		Object.Destroy(iter_30_1.gameObject)
	end

	arg_30_0.masks = nil

	for iter_30_2, iter_30_3 in pairs(arg_30_0.animators) do
		Object.Destroy(iter_30_3.gameObject)
	end

	arg_30_0.animators = nil

	if not IsNil(arg_30_0.archMask) then
		Object.Destroy(arg_30_0.archMask.gameObject)
	end

	arg_30_0.archMask = nil

	if arg_30_0.animator then
		arg_30_0.animator:Dispose()

		arg_30_0.animator = nil
	end

	arg_30_0.effectAgent:Dispose()

	arg_30_0.effectAgent = nil

	for iter_30_4, iter_30_5 in pairs(arg_30_0.bodyMasks) do
		Object.Destroy(iter_30_5.gameObject)
	end

	arg_30_0.bodyMasks = nil
	arg_30_0.cg.blocksRaycasts = true

	Object.Destroy(arg_30_0._tf:GetComponent(typeof(ButtonEventExtend)))
	Object.Destroy(arg_30_0._tf:GetComponent(typeof(Button)))

	return
end

function var_0_0.OnDestroy(arg_31_0)
	arg_31_0:RemoveListener(CourtYardEvent.FURNITURE_POSITION_CHANGE, arg_31_0.OnPositionUpdate)
	arg_31_0:GetView().poolMgr:GetFurniturePool():Enqueue(arg_31_0._go)

	return
end

return var_0_0
