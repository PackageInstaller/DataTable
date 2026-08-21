local var_0_0 = class("IslandProductSlotUnitVO", import(".IslandUnitVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.slotId = arg_1_1.slotId
	arg_1_0.isSelfIsland = arg_1_1.isSelfIsland

	arg_1_0:ChangeSlotType(arg_1_1.slotType)
	arg_1_0:StartPlantGrowthTime(arg_1_1.formula_id)

	return
end

function var_0_0.ChangeSlotType(arg_2_0, arg_2_1)
	arg_2_0.slotType = arg_2_1

	arg_2_0:BindSlotData()
	arg_2_0:InitGrowthEndTime()

	return
end

function var_0_0.InitGrowthEndTime(arg_3_0)
	if not arg_3_0.slotData then
		return
	end

	switch(arg_3_0.slotType, {
		[IslandProductConst.ProductSlotType.HandPlant] = function()
			arg_3_0.logic_startTime = arg_3_0.slotData.start_time
			arg_3_0.end_time = arg_3_0.slotData.end_time

			return
		end,
		[IslandProductConst.ProductSlotType.RoleDelegation] = function()
			local var_5_0 = arg_3_0.slotData:GetSlotRoleData()

			if var_5_0 then
				arg_3_0.logic_startTime = var_5_0.start_time
				arg_3_0.end_time = arg_3_0.logic_startTime + var_5_0.cost_time_list[1]
			else
				local var_5_1 = arg_3_0

				var_5_1.logic_startTime = pg.TimeMgr.GetInstance():GetServerTime()
				arg_3_0.end_time = arg_3_0.logic_startTime
			end

			return
		end
	})

	return
end

function var_0_0.GetEndProductEndTime(arg_6_0)
	if not arg_6_0.slotData then
		return
	end

	if arg_6_0.slotType == IslandProductConst.ProductSlotType.HandPlant then
		return arg_6_0.slotData.end_time
	else
		return arg_6_0.slotData.end_time
	end

	return
end

function var_0_0.StartPlantGrowthTime(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.formula_id = arg_7_1

	if not arg_7_0.formula_id then
		arg_7_0.productProcess = {}

		return
	end

	arg_7_0.startGrowthTime = arg_7_2 or arg_7_0.logic_startTime
	arg_7_0.productProcess = {}

	for iter_7_0, iter_7_1 in ipairs(pg.island_formula[arg_7_0.formula_id].unitid) do
		table.insert(arg_7_0.productProcess, {
			startTime = math.floor(iter_7_1[1] * (arg_7_0.end_time - arg_7_0.startGrowthTime)) + arg_7_0.startGrowthTime,
			model = iter_7_1[2]
		})
	end

	return
end

function var_0_0.StartDelegateSlotPerform(arg_8_0)
	arg_8_0:StartPlantGrowthTime(arg_8_0.slotData:GetFormulaId(), pg.TimeMgr.GetInstance():GetServerTime())

	return
end

function var_0_0.BindSlotData(arg_9_0)
	switch(arg_9_0.slotType, {
		[IslandProductConst.ProductSlotType.HandPlant] = function()
			arg_9_0.slotData = arg_9_0:HandPlantSlotData()

			return
		end,
		[IslandProductConst.ProductSlotType.RoleDelegation] = function()
			arg_9_0.slotData = arg_9_0:HandDelegationData()

			return
		end
	})

	return
end

function var_0_0.GetProductProcess(arg_12_0)
	return arg_12_0.productProcess
end

function var_0_0.HandPlantSlotData(arg_13_0)
	local var_13_0 = arg_13_0.isSelfIsland and getProxy(IslandProxy):GetIsland():GetBuildingAgency() or getProxy(IslandProxy):GetSharedIsland():GetBuildingAgency()
	local var_13_1 = arg_13_0.slotId
	local var_13_2 = var_13_0:GetBuilding(pg.island_production_slot[arg_13_0.slotId].place)

	if not var_13_2 then
		return nil
	end

	local var_13_3 = var_13_2:GetHandPlantSlotData(var_13_1)

	if var_13_3 then
		return var_13_3
	end

	return nil
end

function var_0_0.HandDelegationData(arg_14_0)
	local var_14_0 = arg_14_0.isSelfIsland and getProxy(IslandProxy):GetIsland():GetBuildingAgency() or getProxy(IslandProxy):GetSharedIsland():GetBuildingAgency()
	local var_14_1 = var_14_0:GetBuilding(pg.island_production_slot[arg_14_0.slotId].place)

	if not var_14_1 then
		return nil
	end

	local var_14_2 = var_14_1:GetDelegationSlotData(pg.island_production_slot[arg_14_0.slotId].exclusion_slot[1])

	if var_14_2 then
		return var_14_2
	end

	return nil
end

function var_0_0.SetHighLight(arg_15_0, arg_15_1)
	arg_15_0.isHighLight = arg_15_1

	return
end

function var_0_0.GetHighLight(arg_16_0, arg_16_1)
	return arg_16_0.isHighLight
end

return var_0_0
