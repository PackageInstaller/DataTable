local AgoraMould = class("AgoraMould", import("Mod.Island.Core.View.SceneObject.IslandSceneUnit"))

function AgoraMould:Ctor(arg_1_1, arg_1_2, arg_1_3)
	AgoraMould.super.Ctor(self, arg_1_1, arg_1_3)

	self.callbacks = {}
	self.root = arg_1_2.transform
	self.selected = arg_1_2.transform:Find("selected")
	self.conflict = arg_1_2.transform:Find("conflict")

	self:InitArea()

	return
end

function AgoraMould:InitArea()
	local var_2_0 = self.data:GetSize()

	self.selected.localScale = Vector3(var_2_0.x, 0.01, var_2_0.y)
	self.conflict.localScale = Vector3(var_2_0.x, 0.01, var_2_0.y)

	self:ShowOrHideArea(false)

	return
end

function AgoraMould:ShowOrHideArea(arg_3_1, arg_3_2)
	if arg_3_2 then
		setActive(self.conflict, arg_3_1)
		setActive(self.selected, not arg_3_1)
	else
		setActive(self.conflict, false)
		setActive(self.selected, false)
	end

	return
end

function AgoraMould:IsFullLoaded()
	return self:IsLoaded()
end

function AgoraMould:OnInit(arg_5_1, arg_5_2)
	self._go = arg_5_1

	UIUtil.SetLayerRecursively(self._go, LayerMask.NameToLayer(IslandConst.LAYER_WORLDMAP3D))

	self.builder = arg_5_2
	self.root.name = self.data.id

	setParent(self._go, self.root)
	self:UpdatePosition(self.data:GetArea())
	self:UpdateRotation(self.data:GetRotation())
	self:AddListeners()

	self.behaviourTreeOwner = self.root:GetComponent(typeof(NodeCanvas.BehaviourTrees.BehaviourTreeOwner))

	self:OnAttach(self.root)

	return
end

function AgoraMould:AddListeners()
	self:AddListener(ISLAND_AGORA_EVT.ITEM_POSITION_UPDATE, self.UpdatePosition)
	self:AddListener(ISLAND_AGORA_EVT.ITEM_DIR_UPDATE, self.UpdateRotation)

	return
end

function AgoraMould:RemoveListeners()
	self:RemoveListener(ISLAND_AGORA_EVT.ITEM_POSITION_UPDATE, self.UpdatePosition)
	self:RemoveListener(ISLAND_AGORA_EVT.ITEM_DIR_UPDATE, self.UpdateRotation)

	return
end

function AgoraMould:UpdatePosition(arg_8_1)
	local var_8_0 = AgoraCalc.GetAreaCenterPos(arg_8_1)
	local var_8_1 = Vector3(0, 0, 0)

	if self.data:IsBuildingType() then
		var_8_1 = IslandConst.AGORA_BUILDING_Y_OFFSET
	elseif self.data:IsNewTileType() then
		var_8_1 = Vector3(0, 0.01, 0)
	end

	self.root.position = var_8_0 + IslandConst.AGORA_POSITION_OFFSET + var_8_1

	return
end

function AgoraMould:UpdateRotation(arg_9_1)
	self.root.eulerAngles = arg_9_1

	return
end

function AgoraMould:AddListener(arg_10_1, arg_10_2)
	local function var_10_0(arg_11_0, ...)
		arg_10_2(self, ...)

		return
	end

	self.callbacks[arg_10_2] = var_10_0

	self.data:AddListener(arg_10_1, var_10_0)

	return
end

function AgoraMould:RemoveListener(arg_12_1, arg_12_2)
	if self.callbacks[arg_12_2] then
		self.data:RemoveListener(arg_12_1, self.callbacks[arg_12_2])

		self.callbacks[self.callbacks[arg_12_2]] = nil
	end

	return
end

function AgoraMould:Enable()
	if not self:IsLoaded() then
		return
	end

	self:SetupBt()

	return
end

function AgoraMould:Disable()
	if not self:IsLoaded() then
		return
	end

	self:PauseBt()

	return
end

function AgoraMould:Dispose()
	self:RemoveListeners()

	self.callbacks = {}

	AgoraMould.super.Dispose(self)

	return
end

function AgoraMould:OnDestroy()
	self.builder:RecycleRoot(self.root.gameObject)

	self.root = nil

	return
end

return AgoraMould
