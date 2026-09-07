local IslandProductSlotUnitVO = class("IslandProductSlotUnitVO", import(".IslandUnitVO"))

function IslandProductSlotUnitVO:Ctor(arg_1_1)
	IslandProductSlotUnitVO.super.Ctor(self, arg_1_1)

	self.slotId = arg_1_1.slotId
	self.isSelfIsland = arg_1_1.isSelfIsland

	self:ChangeSlotType(arg_1_1.slotType)
	self:StartPlantGrowthTime(arg_1_1.formula_id)

	return
end

function IslandProductSlotUnitVO:ChangeSlotType(arg_2_1)
	self.slotType = arg_2_1

	self:BindSlotData()
	self:InitGrowthEndTime()

	return
end

function IslandProductSlotUnitVO:InitGrowthEndTime()
	if not self.slotData then
		return
	end

	switch(self.slotType, {
		[IslandProductConst.ProductSlotType.HandPlant] = function()
			self.logic_startTime = self.slotData.start_time
			self.end_time = self.slotData.end_time

			return
		end,
		[IslandProductConst.ProductSlotType.RoleDelegation] = function()
			local var_5_0 = self.slotData:GetSlotRoleData()

			if var_5_0 then
				self.logic_startTime = var_5_0.start_time
				self.end_time = self.logic_startTime + var_5_0.cost_time_list[1]
			else
				self.logic_startTime = pg.TimeMgr.GetInstance():GetServerTime()
				self.end_time = self.logic_startTime
			end

			return
		end
	})

	return
end

function IslandProductSlotUnitVO:GetEndProductEndTime()
	if not self.slotData then
		return
	end

	if self.slotType == IslandProductConst.ProductSlotType.HandPlant then
		return self.slotData.end_time
	else
		return self.slotData.end_time
	end

	return
end

function IslandProductSlotUnitVO:StartPlantGrowthTime(arg_7_1, arg_7_2)
	self.formula_id = arg_7_1

	if not self.formula_id then
		self.productProcess = {}

		return
	end

	self.startGrowthTime = arg_7_2 or self.logic_startTime
	self.productProcess = {}

	for iter_7_0, iter_7_1 in ipairs(pg.island_formula[self.formula_id].unitid) do
		table.insert(self.productProcess, {
			startTime = math.floor(iter_7_1[1] * (self.end_time - self.startGrowthTime)) + self.startGrowthTime,
			model = iter_7_1[2]
		})
	end

	return
end

function IslandProductSlotUnitVO:StartDelegateSlotPerform()
	self:StartPlantGrowthTime(self.slotData:GetFormulaId(), pg.TimeMgr.GetInstance():GetServerTime())

	return
end

function IslandProductSlotUnitVO:BindSlotData()
	switch(self.slotType, {
		[IslandProductConst.ProductSlotType.HandPlant] = function()
			self.slotData = self:HandPlantSlotData()

			return
		end,
		[IslandProductConst.ProductSlotType.RoleDelegation] = function()
			self.slotData = self:HandDelegationData()

			return
		end
	})

	return
end

function IslandProductSlotUnitVO:GetProductProcess()
	return self.productProcess
end

function IslandProductSlotUnitVO:HandPlantSlotData()
	local var_13_1 = self.slotId
	local var_13_2 = (self.isSelfIsland and getProxy(IslandProxy):GetIsland():GetBuildingAgency() or getProxy(IslandProxy):GetSharedIsland():GetBuildingAgency()):GetBuilding(pg.island_production_slot[self.slotId].place)

	if not var_13_2 then
		return nil
	end

	local var_13_3 = var_13_2:GetHandPlantSlotData(var_13_1)

	if var_13_3 then
		return var_13_3
	end

	return nil
end

function IslandProductSlotUnitVO:HandDelegationData()
	local var_14_1 = (self.isSelfIsland and getProxy(IslandProxy):GetIsland():GetBuildingAgency() or getProxy(IslandProxy):GetSharedIsland():GetBuildingAgency()):GetBuilding(pg.island_production_slot[self.slotId].place)

	if not var_14_1 then
		return nil
	end

	local var_14_2 = var_14_1:GetDelegationSlotData(pg.island_production_slot[self.slotId].exclusion_slot[1])

	if var_14_2 then
		return var_14_2
	end

	return nil
end

function IslandProductSlotUnitVO:SetHighLight(arg_15_1)
	self.isHighLight = arg_15_1

	return
end

function IslandProductSlotUnitVO:GetHighLight(arg_16_1)
	return self.isHighLight
end

return IslandProductSlotUnitVO
