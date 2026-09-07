local CourtYardFurnitureModule = class("CourtYardFurnitureModule", import("..CourtYardPlaceableModule"))

function CourtYardFurnitureModule:Ctor(arg_1_1, arg_1_2)
	CourtYardFurnitureModule.super.Ctor(self, arg_1_1, arg_1_2)
	self:AddListener(CourtYardEvent.FURNITURE_POSITION_CHANGE, self.OnPositionUpdate)

	return
end

function CourtYardFurnitureModule:OnInit()
	CourtYardFurnitureModule.super.OnInit(self)
	pg.ViewUtils.SetLayer(self._tf, Layer.UI)

	self.model = self._tf:Find("icon")
	self.masksTF = self._tf:Find("masks")
	self.masks = {}
	self.isMultiMask = self:GetData():IsMultiMask()

	for iter_2_0, iter_2_1 in pairs(self:GetData():GetMaskNames()) do
		local var_2_0 = self.masksTF:Find("icon_front_" .. iter_2_0)

		if self.isMultiMask then
			setParent(var_2_0, self.interactionTF)
		end

		self.masks[iter_2_0] = var_2_0
	end

	self.archMask = self.masksTF:Find("icon_front_arch")
	self.bodyMasks = {}

	for iter_2_2, iter_2_3 in pairs(self.data:GetBodyMasks()) do
		self.bodyMasks[iter_2_2] = self.interactionTF:Find("body_mask" .. iter_2_2)
	end

	self.animators = {}

	for iter_2_4, iter_2_5 in pairs(self.data:GetAnimators()) do
		self.animators[iter_2_5.key] = (self.data:GetAnimatorMask() and self.interactionTF:Find("animtor_mask") or self.interactionTF):Find("Animator" .. iter_2_5.key)
	end

	local var_2_1 = self:GetData().selectedFlag

	self:InitAttachment(var_2_1)

	if not var_2_1 then
		self:EnableTrigger(false)
	end

	if self.data:IsSpine() then
		self.animator = CourtYardFurnitureAnimatorAgent.New(self)
	end

	self.effectContainer = self._tf
	self.effectAgent = CourtYardEffectAgent.New(self)

	return
end

function CourtYardFurnitureModule:CreateWhenStoreyInit()
	CourtYardFurnitureModule.super.CreateWhenStoreyInit(self)
	self:BlocksRaycasts(false)

	return
end

function CourtYardFurnitureModule:BlocksRaycasts(arg_4_1)
	if self.data:CanClickWhenExitEditMode() or #self.data:GetUsingSlots() > 0 and arg_4_1 == false then
		return
	end

	self.cg.blocksRaycasts = arg_4_1

	return
end

function CourtYardFurnitureModule:GetSpine()
	if self.animator then
		return self.animator.spineAnimUI.gameObject.transform
	end

	return
end

function CourtYardFurnitureModule:GetCenterPoint()
	local var_6_0 = self:GetParentTF():InverseTransformPoint(self._tf.position)
	local var_6_1 = Vector2(0.5, 0.5) - self._tf.pivot
	local var_6_2 = Vector2(var_6_0.x, var_6_0.y) + Vector2(self._tf.localScale.x * self._tf.sizeDelta.x * var_6_1.x, self._tf.sizeDelta.y * var_6_1.y)

	return Vector3(var_6_2.x, var_6_2.y, 0)
end

function CourtYardFurnitureModule:GetSpinePoint()
	local var_7_0 = self:GetParentTF():InverseTransformPoint(self._tf:Find("spine_icon/spine").position)

	return Vector3(var_7_0.x, var_7_0.y, 0)
end

function CourtYardFurnitureModule:GetBodyMask(arg_8_1)
	return self.bodyMasks[arg_8_1]
end

function CourtYardFurnitureModule:GetAnimator(arg_9_1)
	return self.animators[arg_9_1]
end

function CourtYardFurnitureModule:AddListeners()
	self:AddListener(CourtYardEvent.FURNITURE_OP_FLAG_CHANGE, self.EnableTrigger)
	self:AddListener(CourtYardEvent.ROTATE_FURNITURE, self.OnDirChange)
	self:AddListener(CourtYardEvent.FURNITURE_STATE_CHANGE, self.OnStateChange)
	self:AddListener(CourtYardEvent.FURNITURE_WILL_INTERACTION, self.OnWillInterAction)
	self:AddListener(CourtYardEvent.FURNITURE_START_INTERACTION, self.OnStartInterAction)
	self:AddListener(CourtYardEvent.FURNITURE_UPDATE_INTERACTION, self.OnUpdateInteraction)
	self:AddListener(CourtYardEvent.FURNITURE_STOP_INTERACTION, self.OnStopInterAction)
	self:AddListener(CourtYardEvent.FURNITURE_MOVE, self.OnMove)
	self:AddListener(CourtYardEvent.FURNITURE_STOP_MOVE, self.OnStopMove)

	return
end

function CourtYardFurnitureModule:RemoveListeners()
	self:RemoveListener(CourtYardEvent.FURNITURE_OP_FLAG_CHANGE, self.EnableTrigger)
	self:RemoveListener(CourtYardEvent.ROTATE_FURNITURE, self.OnDirChange)
	self:RemoveListener(CourtYardEvent.FURNITURE_STATE_CHANGE, self.OnStateChange)
	self:RemoveListener(CourtYardEvent.FURNITURE_WILL_INTERACTION, self.OnWillInterAction)
	self:RemoveListener(CourtYardEvent.FURNITURE_START_INTERACTION, self.OnStartInterAction)
	self:RemoveListener(CourtYardEvent.FURNITURE_UPDATE_INTERACTION, self.OnUpdateInteraction)
	self:RemoveListener(CourtYardEvent.FURNITURE_STOP_INTERACTION, self.OnStopInterAction)
	self:RemoveListener(CourtYardEvent.FURNITURE_MOVE, self.OnMove)
	self:RemoveListener(CourtYardEvent.FURNITURE_STOP_MOVE, self.OnStopMove)

	return
end

function CourtYardFurnitureModule:EnableTrigger(arg_12_1)
	self.dragAgent:Enable(arg_12_1)

	return
end

function CourtYardFurnitureModule:InitAttachment(arg_13_1)
	onButton(self, self._tf, function()
		self:Emit("SelectFurniture", self.data.id)

		return
	end, SFX_PANEL)

	if arg_13_1 then
		triggerButton(self._tf)
	end

	return
end

function CourtYardFurnitureModule:OnBeginDrag()
	self:Emit("BeginDragFurniture", self.data.id)

	return
end

function CourtYardFurnitureModule:OnDragging(arg_16_1)
	self:Emit("DragingFurniture", self.data.id, arg_16_1)

	return
end

function CourtYardFurnitureModule:OnDragEnd(arg_17_1)
	self:Emit("DragFurnitureEnd", self.data.id, arg_17_1)

	return
end

function CourtYardFurnitureModule:OnPositionUpdate(arg_18_1, arg_18_2)
	self:UpdatePosition(arg_18_1, arg_18_2)

	return
end

function CourtYardFurnitureModule:OnDirChange(arg_19_1)
	self._tf.localScale = Vector3(arg_19_1 == 1 and 1 or -1, 1, 1)

	return
end

function CourtYardFurnitureModule:OnWillInterAction(arg_20_1)
	if self.isMultiMask then
		for iter_20_0, iter_20_1 in pairs(self.masks) do
			iter_20_1:SetAsLastSibling()
		end
	end

	return
end

function CourtYardFurnitureModule:OnStartInterAction(arg_21_1)
	local var_21_0 = arg_21_1:GetUsingAnimator()

	if var_21_0 then
		setActive(self:GetAnimator(var_21_0.key), true)
	end

	local var_21_1 = arg_21_1:GetSkew()

	if var_21_1 ~= Vector3.zero then
		self._tf.localPosition = var_21_1
	end

	for iter_21_0, iter_21_1 in pairs(self.masks) do
		setActive(iter_21_1, true)
	end

	if self.isMultiMask then
		for iter_21_2, iter_21_3 in pairs(self.masks) do
			iter_21_3:SetSiblingIndex(1 + 2 * (iter_21_2 - 1))
		end
	end

	return
end

function CourtYardFurnitureModule:OnUpdateInteraction(arg_22_1)
	if self.animator then
		self.animator:PlayInteractioAnim(arg_22_1.action)
	end

	local var_22_0 = self:GetBodyMask(arg_22_1.slot.id)

	if var_22_0 then
		var_22_0:GetComponent(typeof(Image)).enabled = not arg_22_1.closeBodyMask
	end

	local var_22_1 = arg_22_1.slot:GetUsingAnimator()

	if arg_22_1.isReset and var_22_1 then
		local var_22_2 = self:GetAnimator(var_22_1.key)

		setActive(var_22_2, false)
		setActive(var_22_2, true)
	end

	if arg_22_1.block then
		self.cg.blocksRaycasts = false
	end

	return
end

function CourtYardFurnitureModule:OnStopInterAction(arg_23_1)
	local var_23_0 = arg_23_1:GetUsingAnimator()

	if var_23_0 then
		local var_23_1 = self:GetAnimator(var_23_0.key)

		var_23_1.localScale = Vector3.one
		var_23_1.localEulerAngles = Vector3.zero

		setActive(var_23_1, false)
	end

	local var_23_2 = self:GetBodyMask(arg_23_1.id)

	if var_23_2 then
		var_23_2.localScale = Vector3.one
		var_23_2.localEulerAngles = Vector3.zero
	end

	if self:GetData():AnySlotIsUsing() and table.getCount(self.masks) >= 1 then
		-- block empty
	else
		for iter_23_0, iter_23_1 in pairs(self.masks) do
			setActive(iter_23_1, false)
		end
	end

	return
end

function CourtYardFurnitureModule:OnAnimtionFinish(arg_24_1)
	self.cg.blocksRaycasts = true

	self:Emit("FurnitureAnimtionFinish", self.data.id, arg_24_1)

	return
end

function CourtYardFurnitureModule:OnStateChange(arg_25_1)
	if arg_25_1 == CourtYardFurniture.STATE_PLAY_MUSIC then
		self:AddMusicEffect()
	elseif arg_25_1 == CourtYardFurniture.STATE_IDLE then
		self:StopMusicEffect()
	end

	if self.animator then
		self.animator:SetState(arg_25_1)
	end

	return
end

function CourtYardFurnitureModule:AddMusicEffect()
	local var_26_0 = self.data:GetMusicData()

	if var_26_0 and var_26_0.effect then
		self.effectAgent:EnableEffect(var_26_0.effect)
	end

	return
end

function CourtYardFurnitureModule:StopMusicEffect()
	local var_27_0 = self.data:GetMusicData()

	if var_27_0 and var_27_0.effect then
		self.effectAgent:DisableEffect(var_27_0.effect)
	end

	return
end

function CourtYardFurnitureModule:OnMove(arg_28_1)
	local var_28_0 = CourtYardCalcUtil.Map2Local(arg_28_1)

	LeanTween.moveLocal(self._go, CourtYardCalcUtil.TrPosition2LocalPos(self:GetParentTF(), self._tf.parent, (Vector3(var_28_0.x, var_28_0.y, 0))), (self.data:GetMoveTime()))

	return
end

function CourtYardFurnitureModule:OnStopMove()
	if LeanTween.isTweening(self._go) then
		LeanTween.cancel(self._go)
	end

	return
end

function CourtYardFurnitureModule:OnDispose()
	CourtYardFurnitureModule.super.OnDispose(self)

	if not IsNil(self.model) then
		Object.Destroy(self.model.gameObject)
	end

	for iter_30_0, iter_30_1 in pairs(self.masks) do
		Object.Destroy(iter_30_1.gameObject)
	end

	self.masks = nil

	for iter_30_2, iter_30_3 in pairs(self.animators) do
		Object.Destroy(iter_30_3.gameObject)
	end

	self.animators = nil

	if not IsNil(self.archMask) then
		Object.Destroy(self.archMask.gameObject)
	end

	self.archMask = nil

	if self.animator then
		self.animator:Dispose()

		self.animator = nil
	end

	self.effectAgent:Dispose()

	self.effectAgent = nil

	for iter_30_4, iter_30_5 in pairs(self.bodyMasks) do
		Object.Destroy(iter_30_5.gameObject)
	end

	self.bodyMasks = nil
	self.cg.blocksRaycasts = true

	Object.Destroy(self._tf:GetComponent(typeof(ButtonEventExtend)))
	Object.Destroy(self._tf:GetComponent(typeof(Button)))

	return
end

function CourtYardFurnitureModule:OnDestroy()
	self:RemoveListener(CourtYardEvent.FURNITURE_POSITION_CHANGE, self.OnPositionUpdate)
	self:GetView().poolMgr:GetFurniturePool():Enqueue(self._go)

	return
end

return CourtYardFurnitureModule
