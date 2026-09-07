local IslandDelegateEffectMgr = class("IslandDelegateEffectMgr", import(".IslandBaseUnit"))

function IslandDelegateEffectMgr:Ctor(arg_1_1)
	IslandDelegateEffectMgr.super.Ctor(self, arg_1_1)

	self.effectPath = pg.island_unit_item[1018].model
	self.selectEffectPath = pg.island_unit_item[1019].model
	self.effectDic = {}
	self.effectIsShow = {}

	return
end

function IslandDelegateEffectMgr:LoadDelegatePreviewRole(arg_2_1, arg_2_2)
	self.modelData = arg_2_1

	local var_2_0 = Vector3(pg.island_world_objects[arg_2_2].param.position[1], pg.island_world_objects[arg_2_2].param.position[2], pg.island_world_objects[arg_2_2].param.position[3])
	local var_2_1 = Vector3(pg.island_world_objects[arg_2_2].param.rotation[1], pg.island_world_objects[arg_2_2].param.rotation[2], pg.island_world_objects[arg_2_2].param.rotation[3])

	self:GetPoolMgr():GetCharacter(arg_2_1.model, arg_2_1.animator, function(arg_3_0)
		self.role = arg_3_0
		self.role.transform.eulerAngles = var_2_1
		self.role.transform.position = var_2_0

		GraphicsInterface.Instance:SetSelectedTransparency(self.role.transform:GetChild(0).gameObject, pg.island_set.delegate_role_transparency.key_value_int / 100, true)

		return
	end)

	return
end

function IslandDelegateEffectMgr:UnLoadDelegatePreviewRole()
	if self.role then
		GraphicsInterface.Instance:SetSelectedTransparency(self.role.transform:GetChild(0).gameObject, 0, false)
		self:GetPoolMgr():ReturnCharacter(self.modelData.model, self.modelData.animator, self.role)

		self.modelData = nil
		self.role = nil
	end

	return
end

function IslandDelegateEffectMgr:UpdatePositionAndRotation(arg_5_1, arg_5_2, arg_5_3)
	arg_5_1.transform.rotation = arg_5_3
	arg_5_1.transform.position = arg_5_2

	return
end

function IslandDelegateEffectMgr:SelectSlotEffectShow(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.effectIsShow[arg_6_1] = arg_6_1 == arg_6_2

	if arg_6_1 ~= arg_6_2 then
		if self.effectDic[arg_6_1] then
			setActive(self.effectDic[arg_6_1], true)
			self:UpdatePositionAndRotation(self.effectDic[arg_6_1], arg_6_3, arg_6_4)

			return
		end

		self:GetPoolMgr():GetDelegateEffect(self.effectPath, function(arg_7_0)
			if self.effectIsShow[arg_6_1] then
				return
			end

			setParent(arg_7_0, self:GetView().root)

			self.effectDic[arg_6_1] = arg_7_0

			self:UpdatePositionAndRotation(arg_7_0, arg_6_3, arg_6_4)

			return
		end)
	else
		if self.effectDic[arg_6_1] then
			setActive(self.effectDic[arg_6_1], false)
		end

		if self.selectEffect then
			self:UpdatePositionAndRotation(self.selectEffect, arg_6_3, arg_6_4)

			return
		end

		self:GetPoolMgr():GetDelegateEffect(self.selectEffectPath, function(arg_8_0)
			if not self.effectIsShow[arg_6_1] then
				return
			end

			setParent(arg_8_0, self:GetView().root)

			self.selectEffect = arg_8_0

			self:UpdatePositionAndRotation(arg_8_0, arg_6_3, arg_6_4)

			return
		end)
	end

	return
end

function IslandDelegateEffectMgr:RecycleAllSlotEffct()
	for iter_9_0, iter_9_1 in pairs(self.effectIsShow) do
		self.effectIsShow[iter_9_0] = false
	end

	self.effectIsShow = {}

	for iter_9_2, iter_9_3 in pairs(self.effectDic) do
		if not IsNil(iter_9_3) then
			self:GetPoolMgr():ReturnDelegateEffect(self.effectPath, iter_9_3)
		end
	end

	self.effectDic = {}

	if not IsNil(self.selectEffect) then
		self:GetPoolMgr():ReturnDelegateEffect(self.selectEffect, self.selectEffect)
	end

	self.selectEffect = nil

	return
end

function IslandDelegateEffectMgr:OnDestroy()
	self:RecycleAllSlotEffct()

	return
end

return IslandDelegateEffectMgr
