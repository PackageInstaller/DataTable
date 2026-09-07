local IslandBottomHeadHudView = class("IslandBottomHeadHudView", import(".IslandBaseHudView"))

function IslandBottomHeadHudView:GetUIName()
	return "IslandTopHeadHudUI"
end

function IslandBottomHeadHudView:GetHeadOffset()
	return Vector3(0.5, 1.5, 0)
end

function IslandBottomHeadHudView:OnInit(arg_3_1)
	self.animationOpTpl = self._tf:Find("tpls/IslandNpcAnimationOpTpl")
	self.animationOpTpls = {}
	self.animationOpShowFlags = {}
	self.animationOpShowDistance = pg.island_set.action_bubble_range.key_value_int

	IslandBottomHeadHudView.super.OnInit(self, arg_3_1)

	return
end

function IslandBottomHeadHudView:OnLateUpdate()
	IslandBottomHeadHudView.super.OnLateUpdate(self)

	local var_4_0 = self:GetView().player

	if var_4_0 then
		for iter_4_0, iter_4_1 in ipairs(self.animationOpShowFlags) do
			local var_4_1 = self.animationOpTpls[iter_4_1]
			local var_4_2 = self:UnitKey2unitData(iter_4_1)
			local var_4_3 = self:GetView():GetUnitModuleWithType(var_4_2.type, var_4_2.id)

			if var_4_3 then
				setActive(var_4_1, Vector3.Distance(var_4_0._go.transform.position, var_4_3._go.transform.position) <= self.animationOpShowDistance)
			end
		end
	end

	return
end

function IslandBottomHeadHudView:UpdateTplPosition(arg_5_1, arg_5_2, arg_5_3)
	IslandBottomHeadHudView.super.UpdateTplPosition(self, arg_5_1, arg_5_2, arg_5_3)

	local var_5_0 = IslandCalcUtil.IsBehindCamera(arg_5_1.transform.forward)

	arg_5_2.transform.localScale = Vector3(var_5_0 and -1 or 1, 1, 1)
	arg_5_2.transform:Find("aniamtionOpContainer"):GetChild(0):Find("Image").localScale = Vector3(var_5_0 and -1 or 1, 1, 1)

	return
end

function IslandBottomHeadHudView:ShowAnimationOp(arg_6_1, arg_6_2)
	local var_6_0 = self:GenUnitData(arg_6_1.id, arg_6_1.unitType)
	local var_6_1 = self:GetUnitHudRoot(var_6_0):Find("aniamtionOpContainer")
	local var_6_2 = self.animationOpTpls[var_6_0.key] or Object.Instantiate(self.animationOpTpl, var_6_1)

	setParent(var_6_2, var_6_1)
	setActive(var_6_2, true)
	assert(pg.island_action[arg_6_2], "island_action>>>>" .. arg_6_2)
	LoadImageSpriteAsync("island/IslandActionIcon/" .. pg.island_action[arg_6_2].resource, var_6_2.transform:Find("Image"), false)

	self.animationOpTpls[var_6_0.key] = var_6_2

	table.insert(self.animationOpShowFlags, var_6_0.key)
	setActive(var_6_2.transform:Find("effect"), false)

	return
end

function IslandBottomHeadHudView:UpdateAnimationOpEffect(arg_7_1, arg_7_2)
	local var_7_0, var_7_1 = IslandCalcUtil.GetTypeAndIdByUniqueId(arg_7_1)
	local var_7_2 = self.animationOpTpls[self:GenUnitData(var_7_1, var_7_0).key]

	if not var_7_2 then
		return
	end

	setActive(var_7_2.transform:Find("effect"), arg_7_2)

	return
end

function IslandBottomHeadHudView:HideAnimationOp(arg_8_1)
	local var_8_0 = self:GenUnitData(arg_8_1.id, arg_8_1.unitType)

	table.removebyvalue(self.animationOpShowFlags, var_8_0.key)

	if not self.animationOpTpls[var_8_0.key] then
		return
	end

	setActive(self.animationOpTpls[var_8_0.key], false)
	setActive(self.animationOpTpls[var_8_0.key].transform:Find("effect"), false)

	return
end

function IslandBottomHeadHudView:OnDispose()
	IslandBottomHeadHudView.super.OnDispose(self)

	for iter_9_0, iter_9_1 in pairs(self.animationOpTpls) do
		Object.Destroy(iter_9_1)
	end

	self.animationOpTpls = nil
	self.animationOpShowFlags = nil

	return
end

return IslandBottomHeadHudView
