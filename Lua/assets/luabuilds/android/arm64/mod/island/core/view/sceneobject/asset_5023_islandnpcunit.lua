local IslandNpcUnit = class("IslandNpcUnit", import(".IslandNavigableUnit"))
local var_0_1 = {
	JumpHandle = 1,
	LoadToolHandle = 2
}

function IslandNpcUnit:OnAttach(arg_1_1)
	IslandNpcUnit.super.OnAttach(self, arg_1_1)

	self.characterHandleController = self._go:GetComponent(typeof(CharacterHandleController))

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
		return
	end)

	self.objTfList = {}
	self.toolIdMap = {}

	if self.behaviourTreeOwner then
		local var_1_0, var_1_1 = self:GetDataVO():GetPersonality()

		LuaHelper.NodeCanvasSetIntVariableValue(self.behaviourTreeOwner, "personality", var_1_0)
		LuaHelper.NodeCanvasSetIntVariableValue(self.behaviourTreeOwner, "proactive", var_1_1)
	end

	return
end

function IslandNpcUnit:StateEnterHandle(arg_6_1, arg_6_2)
	if arg_6_1 == var_0_1.LoadToolHandle then
		self:LoadInteractiveTool(arg_6_2)
	end

	return
end

function IslandNpcUnit:StateEnterFixHandle(arg_7_1, arg_7_2)
	if arg_7_1 == var_0_1.LoadToolHandle then
		local var_7_0 = self.toolIdMap[arg_7_2] or self.currentToolId or self:GetToolId(arg_7_2)

		if var_7_0 and self.objTfList[var_7_0] then
			pg.ViewUtils.SetLayer(self.objTfList[var_7_0], Layer.Default)
		end
	end

	return
end

function IslandNpcUnit:StateExitHandle(arg_8_1, arg_8_2)
	if arg_8_1 == var_0_1.LoadToolHandle then
		self:UnLoadInteractiveTool(arg_8_2)
	end

	return
end

function IslandNpcUnit:GetToolId(arg_9_1)
	if arg_9_1 ~= 0 then
		return arg_9_1
	end

	return
end

function IslandNpcUnit:LoadInteractiveTool(arg_10_1)
	local var_10_0 = arg_10_1

	arg_10_1 = IslandAnimationAttachmentHelper.ResolveId(self:GetAnimator(), arg_10_1)
	self.currentToolId = arg_10_1
	self.toolIdMap[var_10_0] = arg_10_1

	if self.objTfList[arg_10_1] then
		setActive(self.objTfList[arg_10_1], true)
		setParent(self.objTfList[arg_10_1], self._tf)
		pg.ViewUtils.SetLayer(self.objTfList[arg_10_1], Layer.UIHidden)

		return
	end

	local var_10_1 = pg.island_animation_attachments[arg_10_1]
	local var_10_2 = pg.island_animation_attachments[arg_10_1].model

	if arg_10_1 == pg.island_set.island_manage_animation_extroversion.key_value_int or arg_10_1 == pg.island_set.island_manage_animation_introverted.key_value_int then
		local var_10_3 = self.behaviourTreeOwner.graph.blackboard:GetVariable("systemId").value

		if var_10_3 ~= 0 then
			var_10_2 = pg.island_manage_restaurant[var_10_3].performance_param
		end
	end

	self.objTfList[arg_10_1] = Object.Instantiate((LoadAny(var_10_2, nil))).transform
	GetOrAddComponent(self.objTfList[arg_10_1], typeof(Animator)).runtimeAnimatorController = LoadAny(var_10_1.animator, nil, typeof(RuntimeAnimatorController))

	setParent(self.objTfList[arg_10_1], self._tf)
	pg.ViewUtils.SetLayer(self.objTfList[arg_10_1], Layer.UIHidden)

	return
end

function IslandNpcUnit:UnLoadInteractiveTool(arg_11_1)
	arg_11_1 = self.toolIdMap[arg_11_1] or IslandAnimationAttachmentHelper.ResolveId(self:GetAnimator(), arg_11_1)

	if self.objTfList[arg_11_1] then
		setActive(self.objTfList[arg_11_1], false)
	end

	return
end

function IslandNpcUnit:DestroyInteractiveTools()
	for iter_12_0, iter_12_1 in pairs(self.objTfList) do
		Object.Destroy(iter_12_1.gameObject)
	end

	self.objTfList = {}

	return
end

return IslandNpcUnit
