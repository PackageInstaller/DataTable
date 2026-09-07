local IslandBaseHudView = class("IslandBaseHudView", import(".IslandBaseOpView"))

function IslandBaseHudView:OnInit(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.parent = self._tf:Find("parent")
	self.unitHudRoot = self._tf:Find("parent/unitHud")
	self.unitHudDic = {}
	self.views = {}

	self:SubViewInit()

	return
end

function IslandBaseHudView:GetUIParent(arg_2_1)
	return self:GetView().hudContainer
end

function IslandBaseHudView:GetSubView(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.views) do
		if isa(iter_3_1, arg_3_1) then
			return iter_3_1
		end
	end

	return nil
end

function IslandBaseHudView:OnUpdate()
	for iter_4_0, iter_4_1 in ipairs(self.views) do
		iter_4_1:Update()
	end

	return
end

function IslandBaseHudView:OnLateUpdate()
	for iter_5_0, iter_5_1 in pairs(self.unitHudDic) do
		local var_5_0 = self:UnitKey2unitData(iter_5_0)
		local var_5_1 = self:GetView():GetUnitModuleWithType(var_5_0.type, var_5_0.id)

		if var_5_1 then
			local var_5_2 = var_5_1._go or nil

			if var_5_1 and not IsNil(var_5_2) then
				local var_5_3 = var_5_2.transform.position + self:GetHeadOffset() * var_5_2.transform.rotation
				local var_5_4 = IslandCalcUtil.IsInViewport(var_5_3)

				setActive(iter_5_1, var_5_4)

				if var_5_4 then
					self:UpdateTplPosition(var_5_2, iter_5_1, var_5_3)
				end
			end
		end
	end

	return
end

function IslandBaseHudView:UpdateTplPosition(arg_6_1, arg_6_2, arg_6_3)
	arg_6_2.transform.localPosition = IslandCalcUtil.WorldPosition2LocalPosition(self.parent, arg_6_3)

	return
end

function IslandBaseHudView:GetUnitHudRoot(arg_7_1)
	local var_7_0 = self.unitHudDic[arg_7_1.key]

	if IsNil(self.unitHudDic[arg_7_1.key]) then
		var_7_0 = Object.Instantiate(self.unitHudRoot, self.parent)
		var_7_0.name = arg_7_1.key

		setActive(var_7_0, true)

		self.unitHudDic[arg_7_1.key] = var_7_0
	end

	return var_7_0.transform
end

function IslandBaseHudView:GenUnitData(arg_8_1, arg_8_2)
	return {
		id = arg_8_1,
		type = arg_8_2,
		key = arg_8_2 .. "_" .. arg_8_1
	}
end

function IslandBaseHudView:UnitKey2unitData(arg_9_1)
	local var_9_0 = string.split(arg_9_1, "_")

	return {
		id = tonumber(var_9_0[2]),
		type = tonumber(var_9_0[1])
	}
end

function IslandBaseHudView:OnDispose()
	IslandBaseHudView.super.OnDispose(self)

	for iter_10_0, iter_10_1 in pairs(self.unitHudDic) do
		Object.Destroy(iter_10_1.gameObject)
	end

	self.unitHudDic = nil

	return
end

function IslandBaseHudView:SubViewInit()
	return
end

function IslandBaseHudView:GetHeadOffset()
	assert(false, "overwrite me!!!!")

	return
end

return IslandBaseHudView
