local IslandDisplayShipUnit = class("IslandDisplayShipUnit")
local var_0_1 = 2

function IslandDisplayShipUnit:OnAttach(arg_1_1, arg_1_2)
	self.toolContainer = arg_1_2
	self._go = arg_1_1
	self._tf = self._go.transform
	self.animator = self._tf:GetChild(0):GetComponent(typeof(Animator))
	self.characterHandleController = GetOrAddComponent(self._go, typeof(CharacterHandleController))

	self.characterHandleController:AddStateEnterFunc(function(arg_2_0, arg_2_1)
		self:StateEnterHandle(arg_2_0, arg_2_1)

		return
	end)
	self.characterHandleController:AddStateExitFunc(function(arg_3_0, arg_3_1)
		self:StateExitHandle(arg_3_0, arg_3_1)

		return
	end)
	self.characterHandleController:AddStateEnterFixCompleteFunc(function(arg_4_0, arg_4_1)
		self:StateEnterFixHandle(arg_4_0, arg_4_1)

		return
	end)
	self.characterHandleController:AddStateExitFixCompleteFunc(function(arg_5_0, arg_5_1)
		self:StateExitFixHandle(arg_5_0, arg_5_1)

		return
	end)

	self.objTfList = {}
	self.toolIdMap = {}

	return
end

function IslandDisplayShipUnit:LoadInteractiveTool(arg_6_1)
	self.toolId = arg_6_1
	self.currentToolId = IslandAnimationAttachmentHelper.ResolveId(self.animator, self.toolId)
	self.toolIdMap[arg_6_1] = self.currentToolId

	if not IsNil(self.objTfList[self.currentToolId]) then
		setActive(self.objTfList[self.currentToolId], true)
		setParent(self.objTfList[self.currentToolId], self._tf)
		pg.ViewUtils.SetLayer(self.objTfList[self.currentToolId], Layer.Character3D)

		return
	end

	local var_6_0 = pg.island_animation_attachments[self.currentToolId]

	self.objTfList[self.currentToolId] = Object.Instantiate((LoadAny(pg.island_animation_attachments[self.currentToolId].model, nil))).transform
	GetOrAddComponent(self.objTfList[self.currentToolId], typeof(Animator)).runtimeAnimatorController = LoadAny(var_6_0.animator, nil, typeof(RuntimeAnimatorController))

	setParent(self.objTfList[self.currentToolId], self._tf)
	pg.ViewUtils.SetLayer(self.objTfList[self.currentToolId], Layer.Character3D)

	return
end

function IslandDisplayShipUnit:UnLoadInteractiveTool(arg_7_1)
	local var_7_1 = self.objTfList[self.toolIdMap[arg_7_1] or self.currentToolId or IslandAnimationAttachmentHelper.ResolveId(self.animator, arg_7_1)]

	if self.objTfList[self.toolIdMap[arg_7_1] or self.currentToolId or IslandAnimationAttachmentHelper.ResolveId(self.animator, arg_7_1)] then
		setActive(var_7_1, false)
		setParent(var_7_1, self.toolContainer)
	end

	return
end

function IslandDisplayShipUnit:StateEnterHandle(arg_8_1, arg_8_2)
	if arg_8_1 == var_0_1 then
		self:LoadInteractiveTool(arg_8_2)
	end

	return
end

function IslandDisplayShipUnit:StateEnterFixHandle(arg_9_1, arg_9_2)
	local var_9_0 = self.toolIdMap[arg_9_2] or self.currentToolId

	if arg_9_1 == var_0_1 and var_9_0 and self.objTfList[var_9_0] then
		pg.ViewUtils.SetLayer(self.objTfList[var_9_0], Layer.Character3D)
	end

	return
end

function IslandDisplayShipUnit:StateExitFixHandle(arg_10_1, arg_10_2)
	local var_10_0 = self.toolIdMap[arg_10_2] or self.currentToolId

	if arg_10_1 == var_0_1 and var_10_0 and self.objTfList[var_10_0] then
		pg.ViewUtils.SetLayer(self.objTfList[var_10_0], Layer.Default)
	end

	return
end

function IslandDisplayShipUnit:StateExitHandle(arg_11_1, arg_11_2)
	if arg_11_1 == var_0_1 then
		self:UnLoadInteractiveTool(arg_11_2)
	end

	return
end

function IslandDisplayShipUnit:OnClearItemAnimator()
	if self.toolId then
		self:UnLoadInteractiveTool(self.toolId)
	end

	return
end

function IslandDisplayShipUnit:ClearAnimationTools()
	for iter_13_0, iter_13_1 in pairs(self.objTfList or {}) do
		Object.Destroy(iter_13_1.gameObject)
	end

	self.objTfList = {}

	return
end

function IslandDisplayShipUnit:OnDetach()
	self:ClearAnimationTools()
	self.characterHandleController:AddStateEnterFunc(nil)
	self.characterHandleController:AddStateExitFunc(nil)
	self.characterHandleController:AddStateEnterFixCompleteFunc(nil)
	self.characterHandleController:AddStateExitFixCompleteFunc(nil)

	self._go = nil
	self._tf = nil
	self.objTfList = nil
	self.characterHandleController = nil

	return
end

return IslandDisplayShipUnit
