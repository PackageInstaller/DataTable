local CourtYardPlaceableModule = class("CourtYardPlaceableModule", import(".CourtYardBaseModule"))

function CourtYardPlaceableModule:Ctor(arg_1_1, arg_1_2)
	self.state = 0

	pg.DelegateInfo.New(self)

	self._go = arg_1_2
	self._tf = arg_1_2.transform
	self.data = arg_1_1
	self.callbacks = {}
	self.iconLoaded = false
	self.pudding = false
	self.completion = false
	self.cg = self._tf:GetComponent(typeof(CanvasGroup))
	self.rect = self:GetView():GetRect()
	self.floor = self.rect:Find("floor")
	self.wall = self.rect:Find("wall")
	self.mat = self.rect:Find("carpet")
	self.gridsTF = self._tf:Find("grids")
	self.childsTF = self._tf:Find("childs")
	self.interactionTF = self._tf:Find("interaction")

	self.mat:SetAsFirstSibling()

	self.bones = {}
	self._tf.localScale = Vector3(self.data:GetDirection() == 1 and 1 or -1, 1, 1)

	setParent(self._tf, self:GetParentTF())
	self:UpdatePosition(self.data:GetPosition(), Vector3.zero)

	return
end

function CourtYardPlaceableModule:IsCompletion()
	return self.completion and not self.doPuddingAniming
end

function CourtYardPlaceableModule:OnIconLoaed()
	self.iconLoaded = true

	if self.pudding then
		self:PuddingAnim()
	end

	return
end

function CourtYardPlaceableModule:OnInit()
	self.dragAgent = CourtYardDragAgent.New(self, self:GetView():GetRect())
	self.completion = true

	return
end

function CourtYardPlaceableModule:CreateWhenStoreyInit()
	self:PuddingAnim()

	return
end

function CourtYardPlaceableModule:BlocksRaycasts(arg_6_1)
	return
end

local var_0_1 = "follower_"

function CourtYardPlaceableModule:NewBoneFollower(arg_7_1)
	local var_7_0 = GameObject.New(var_0_1 .. arg_7_1, typeof(RectTransform))

	var_7_0.transform:SetParent(self.interactionTF, false)

	local var_7_1 = GetOrAddComponent(var_7_0, typeof(Spine.Unity.BoneFollowerGraphic))

	var_7_1.followLocalScale = true
	var_7_1.skeletonGraphic = self:GetSpine():GetComponent("Spine.Unity.SkeletonGraphic")

	var_7_1:SetBone(arg_7_1)

	self.bones[var_0_1 .. arg_7_1] = var_7_0.transform

	return var_7_0.transform.transform
end

function CourtYardPlaceableModule:FindBoneFollower(arg_8_1)
	return self.bones[var_0_1 .. arg_8_1]
end

function CourtYardPlaceableModule:PuddingAnim()
	if not self.iconLoaded then
		self.pudding = true

		return
	end

	self.doPuddingAniming = true

	local var_9_0 = self._tf.localScale.x
	local var_9_1 = self._tf.localScale.y

	self.normalX, self.normalY = self._tf.localScale.x, self._tf.localScale.y

	LeanTween.scale(rtf(self._tf), Vector3(self._tf.localScale.x + 0.2, self._tf.localScale.y + 0.2, 1), 0.2):setFrom(0):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self._tf), Vector3(var_9_0, var_9_1, 1), 0.1):setOnComplete(System.Action(function()
			self.doPuddingAniming = false

			return
		end))

		return
	end))

	self.pudding = false

	return
end

function CourtYardPlaceableModule:CancelPuddingAnim()
	if self.doPuddingAniming then
		LeanTween.cancel(self._tf.gameObject)

		self._tf.localScale = Vector3(self.normalX, self.normalY, 1)
		self.doPuddingAniming = nil
	end

	return
end

function CourtYardPlaceableModule:GetParentTF()
	if self.data:GetDeathType() == CourtYardConst.DEPTH_TYPE_MAT then
		return self.mat
	else
		return self.floor
	end

	return
end

function CourtYardPlaceableModule:GetSpine()
	assert(false)

	return
end

function CourtYardPlaceableModule:GetData()
	return self.data
end

function CourtYardPlaceableModule:SetSiblingIndex(arg_16_1)
	if arg_16_1 ~= self._tf:GetSiblingIndex() then
		self._tf:SetSiblingIndex(arg_16_1)
	end

	self._go.name = self.data.id .. "_" .. arg_16_1

	return
end

function CourtYardPlaceableModule:SetAsLastSibling()
	self._go.name = self.data.id

	self._tf:SetAsLastSibling()

	return
end

function CourtYardPlaceableModule:SetActive(arg_18_1)
	setActive(self._tf, arg_18_1)

	return
end

function CourtYardPlaceableModule:UpdatePosition(arg_19_1, arg_19_2)
	self._tf.localPosition = CourtYardCalcUtil.TrPosition2LocalPos(self:GetParentTF(), self._tf.parent, CourtYardCalcUtil.Map2Local(arg_19_1) + (arg_19_2 or Vector3.zero))

	return
end

function CourtYardPlaceableModule:OnDispose()
	for iter_20_0, iter_20_1 in pairs(self.bones) do
		if not IsNil(iter_20_1) then
			Object.Destroy(iter_20_1.gameObject)
		end
	end

	self.bones = {}

	if self.dragAgent then
		self.dragAgent:Dispose()

		self.dragAgent = nil
	end

	if LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	return
end

function CourtYardPlaceableModule:OnDestroy()
	return
end

function CourtYardPlaceableModule:OnBeginDrag()
	return
end

function CourtYardPlaceableModule:OnDragging(arg_23_1)
	return
end

function CourtYardPlaceableModule:OnDragEnd(arg_24_1)
	return
end

return CourtYardPlaceableModule
