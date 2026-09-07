local CourtyardFurnitureState = class("CourtyardFurnitureState")

function CourtyardFurnitureState:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self._tf = arg_1_1.transform
	self.rectTF = arg_1_2
	self.rootTF = self._tf.parent
	self.furnitureStateImg = self._tf:GetComponent(typeof(Image))
	self.furnitureStateAnim = self._tf:GetComponent(typeof(Animation))
	self.selectedMat = arg_1_3
	self.canPlaceMat = arg_1_4
	self.cantPlaceMat = arg_1_5

	return
end

function CourtyardFurnitureState:Init(arg_2_1, arg_2_2)
	pg.UIMgr.GetInstance():LoadingOn(false)
	setActive(self._tf, false)
	ResourceMgr.Inst:getAssetAsync("furnitrues/" .. arg_2_2:GetPicture(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if self.exited then
			return
		end

		setActive(self._tf, true)

		self.furnitureStateImg.sprite = arg_3_0:GetComponent(typeof(Image)).sprite
		self._tf.sizeDelta = arg_3_0.transform.sizeDelta
		self._tf.localPosition = arg_2_1:GetCenterPoint()

		self:OnUpdateScale(arg_2_1)
		self:OnReset()

		return
	end), true, true)

	return
end

function CourtyardFurnitureState:OnInit(arg_4_1, arg_4_2)
	self:Init(arg_4_1, arg_4_2)
	setParent(self._tf, self.rectTF)

	return
end

function CourtyardFurnitureState:OnUpdateScale(arg_5_1)
	self._tf.localScale = Vector3(CourtYardCalcUtil.GetSign(arg_5_1._tf.localScale.x), 1, 1)

	return
end

function CourtyardFurnitureState:OnUpdate(arg_6_1)
	self._tf.localPosition = arg_6_1:GetCenterPoint()

	return
end

function CourtyardFurnitureState:OnCantPlace()
	if self.furnitureStateImg.material ~= self.cantPlaceMat then
		self.furnitureStateImg.material = self.cantPlaceMat

		self.furnitureStateAnim:Play("anim_courtyard_iconred")
	end

	return
end

function CourtyardFurnitureState:OnCanPlace()
	if self.furnitureStateImg.material ~= self.canPlaceMat then
		self.furnitureStateImg.material = self.canPlaceMat

		self.furnitureStateAnim:Play("anim_courtyard_icongreen")
	end

	return
end

function CourtyardFurnitureState:OnReset()
	if self.furnitureStateImg.material ~= self.selectedMat then
		self.furnitureStateImg.material = self.selectedMat

		self.furnitureStateAnim:Play("anim_courtyard_iconwhite")
	end

	return
end

function CourtyardFurnitureState:OnClear()
	self.furnitureStateAnim:Stop()

	self.furnitureStateImg.sprite = nil
	self.furnitureStateImg.material = nil

	setParent(self._tf, self.rootTF)

	return
end

return CourtyardFurnitureState
