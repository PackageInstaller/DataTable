local CourtyardSpineFurnitureState = class("CourtyardSpineFurnitureState")

function CourtyardSpineFurnitureState:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self._tf = arg_1_1.transform
	self.rectTF = arg_1_2
	self.rootTF = self._tf.parent
	self.furnitureSpineStateSkeletonGraphic = self._tf:GetComponent("Spine.Unity.SkeletonGraphic")
	self.furnitureSpineStateAnim = self._tf:GetComponent(typeof(Animation))
	self.selectedMat = arg_1_3
	self.canPlaceMat = arg_1_4
	self.cantPlaceMat = arg_1_5

	return
end

function CourtyardSpineFurnitureState:Init(arg_2_1, arg_2_2)
	pg.UIMgr.GetInstance():LoadingOn(false)
	setActive(self._tf, false)
	ResourceMgr.Inst:getAssetAsync("sfurniture/" .. arg_2_2:GetFirstSlot():GetName(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if self.exited then
			return
		end

		self._tf.pivot = arg_3_0.transform.pivot
		self._tf.sizeDelta = arg_3_0.transform.sizeDelta
		self._tf.localPosition = arg_2_1:GetSpinePoint()
		self.furnitureSpineStateSkeletonGraphic.skeletonDataAsset = arg_3_0.transform:Find("spine"):GetComponent("Spine.Unity.SkeletonGraphic").skeletonDataAsset

		self.furnitureSpineStateSkeletonGraphic:Initialize(true)
		setActive(self._tf, true)

		self.furnitureSpineStateAnimUI = GetOrAddComponent(self._tf, typeof(SpineAnimUI))

		self:OnUpdateScale(arg_2_1)
		self:OnReset(arg_2_1)

		return
	end), true, true)

	return
end

function CourtyardSpineFurnitureState:OnInit(arg_4_1, arg_4_2)
	self:Init(arg_4_1, arg_4_2)
	setParent(self._tf, self.rectTF)

	return
end

function CourtyardSpineFurnitureState:OnUpdateScale(arg_5_1)
	self._tf.localScale = Vector3(CourtYardCalcUtil.GetSign(arg_5_1._tf.localScale.x), 1, 1)

	return
end

function CourtyardSpineFurnitureState:OnUpdate(arg_6_1)
	self._tf.localPosition = arg_6_1:GetSpinePoint()

	return
end

function CourtyardSpineFurnitureState:OnCantPlace()
	if self.furnitureSpineStateSkeletonGraphic.material ~= self.cantPlaceMat then
		self.furnitureSpineStateSkeletonGraphic.material = self.cantPlaceMat

		self.furnitureSpineStateAnim:Play("anim_courtyard_spinered")
	end

	return
end

function CourtyardSpineFurnitureState:OnCanPlace()
	if self.furnitureSpineStateSkeletonGraphic.material ~= self.canPlaceMat then
		self.furnitureSpineStateSkeletonGraphic.material = self.canPlaceMat

		self.furnitureSpineStateAnim:Play("anim_courtyard_spinegreen")
	end

	return
end

function CourtyardSpineFurnitureState:OnReset(arg_9_1)
	if not self.furnitureSpineStateAnimUI then
		return
	end

	if self.furnitureSpineStateSkeletonGraphic.material ~= self.selectedMat then
		self.furnitureSpineStateSkeletonGraphic.material = self.selectedMat

		self.furnitureSpineStateAnim:Play("anim_courtyard_spinewhite")
	end

	local var_9_0 = arg_9_1.animator:GetNormalAnimationName()

	if var_9_0 then
		arg_9_1.animator:RestartAnimation(var_9_0)
		self.furnitureSpineStateAnimUI:SetAction(var_9_0, 0)
	end

	return
end

function CourtyardSpineFurnitureState:OnClear()
	if self.furnitureSpineStateAnimUI then
		Object.Destroy(self.furnitureSpineStateAnimUI)

		self.furnitureSpineStateAnimUI = nil
	end

	setParent(self._tf, self.rootTF)

	return
end

return CourtyardSpineFurnitureState
