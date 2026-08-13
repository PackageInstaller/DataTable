class = var_0_10000

local var_0_0 = "IslandProductSlotUnitVO"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandUnitVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.slotId = arg_1_1.slotId
	arg_1_0.isSelfIsland = arg_1_1.isSelfIsland

	arg_1_0:ChangeSlotType(arg_1_1.slotType)
	arg_1_0:StartPlantGrowthTime(arg_1_1.formula_id)

	return
end

function var_0_1.ChangeSlotType(arg_2_0, arg_2_1)
	arg_2_0.slotType = arg_2_1

	arg_2_0:BindSlotData()
	arg_2_0:InitGrowthEndTime()

	return
end

function var_0_1.InitGrowthEndTime(arg_3_0)
	if not arg_3_0.slotData then
		return
	end

	switch = var_1

	local var_3_0 = arg_3_0.slotType
	local var_3_1 = {}

	IslandProductConst = var_1_10004
	var_3_1[var_1_10004.ProductSlotType.HandPlant] = function()
		arg_3_0.logic_startTime = arg_3_0.slotData.start_time
		arg_3_0.end_time = arg_3_0.slotData.end_time

		return
	end
	IslandProductConst = var_4
	var_3_1[var_4.ProductSlotType.RoleDelegation] = function()
		local var_5_0 = arg_3_0.slotData

		if var_0.GetSlotRoleData(var_5_0) then
			arg_3_0.logic_startTime = var_0.start_time
			arg_3_0.end_time = arg_3_0.logic_startTime + var_0.cost_time_list[1]
		else
			local var_5_1 = arg_3_0

			pg = var_2_10002

			local var_5_2 = var_2_10002.TimeMgr.GetInstance()

			var_5_1.logic_startTime = var_2.GetServerTime(var_5_2)
			arg_3_0.end_time = arg_3_0.logic_startTime
		end

		return
	end

	var_1(var_3_0, var_3_1)

	return
end

function var_0_1.GetEndProductEndTime(arg_6_0)
	if not arg_6_0.slotData then
		return
	end

	local var_6_0 = arg_6_0.slotType

	IslandProductConst = var_1_10002

	if var_6_0 == var_1_10002.ProductSlotType.HandPlant then
		return arg_6_0.slotData.end_time
	else
		return arg_6_0.slotData.end_time
	end

	return
end

function var_0_1.StartPlantGrowthTime(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.formula_id = arg_7_1

	if not arg_7_0.formula_id then
		arg_7_0.productProcess = {}

		return
	end

	arg_7_0.startGrowthTime = arg_7_2 or arg_7_0.logic_startTime
	pg = var_3

	local var_7_0 = var_3.island_formula[arg_7_0.formula_id].unitid

	arg_7_0.productProcess = {}

	local var_7_1 = arg_7_0.end_time - arg_7_0.startGrowthTime

	ipairs = var_6

	for iter_7_0, iter_7_1 in var_6(var_7_0) do
		math = var_1_10011
		var_1_10011 = var_1_10011.floor(iter_7_1[1] * var_7_1) + arg_7_0.startGrowthTime

		local var_7_2 = iter_7_1[2]

		table = var_1_10013

		var_1_10013.insert(arg_7_0.productProcess, {
			startTime = var_1_10011,
			model = var_7_2
		})
	end

	return
end

function var_0_1.StartDelegateSlotPerform(arg_8_0)
	local var_8_0 = arg_8_0.slotData
	local var_8_1 = var_1.GetFormulaId(var_8_0)
	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.StartPlantGrowthTime
	local var_8_4 = var_8_1

	pg = var_1_10005

	local var_8_5 = var_1_10005.TimeMgr.GetInstance()

	var_8_3(var_8_2, var_8_4, var_5.GetServerTime(var_8_5))

	return
end

function var_0_1.BindSlotData(arg_9_0)
	switch = var_1_10001

	local var_9_0 = arg_9_0.slotType
	local var_9_1 = {}

	IslandProductConst = var_1_10004
	var_9_1[var_1_10004.ProductSlotType.HandPlant] = function()
		local var_10_0 = arg_9_0
		local var_10_1 = arg_9_0

		var_10_0.slotData = var_1.HandPlantSlotData(var_10_1)

		return
	end
	IslandProductConst = var_4
	var_9_1[var_4.ProductSlotType.RoleDelegation] = function()
		local var_11_0 = arg_9_0
		local var_11_1 = arg_9_0

		var_11_0.slotData = var_1.HandDelegationData(var_11_1)

		return
	end

	var_1_10001(var_9_0, var_9_1)

	return
end

function var_0_1.GetProductProcess(arg_12_0)
	return arg_12_0.productProcess
end

function var_0_1.HandPlantSlotData(arg_13_0)
	local var_13_0

	if arg_13_0.isSelfIsland then
		getProxy = var_2
		IslandProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)
		var_1_10003 = var_2.GetIsland(var_1_10003)
		var_13_0 = var_2.GetBuildingAgency(var_1_10003)
	else
		getProxy = var_2
		IslandProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)
		var_1_10003 = var_2.GetSharedIsland(var_1_10003)
		var_13_0 = var_2.GetBuildingAgency(var_1_10003)
	end

	local var_13_1 = arg_13_0.slotId

	pg = var_1_10003

	local var_13_2 = var_1_10003.island_production_slot[var_13_1].place

	if not var_13_0:GetBuilding(var_13_2) then
		return nil
	end

	if var_4:GetHandPlantSlotData(var_13_1) then
		return var_5
	end

	return nil
end

function var_0_1.HandDelegationData(arg_14_0)
	local var_14_0

	if arg_14_0.isSelfIsland then
		getProxy = var_2
		IslandProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)
		var_1_10003 = var_2.GetIsland(var_1_10003)
		var_14_0 = var_2.GetBuildingAgency(var_1_10003)
	else
		getProxy = var_2
		IslandProxy = var_1_10003
		var_1_10003 = var_2(var_1_10003)
		var_1_10003 = var_2.GetSharedIsland(var_1_10003)
		var_14_0 = var_2.GetBuildingAgency(var_1_10003)
	end

	local var_14_1 = arg_14_0.slotId

	pg = var_1_10003

	local var_14_2 = var_1_10003.island_production_slot[var_14_1].exclusion_slot[1]

	pg = var_1_10004

	local var_14_3 = var_1_10004.island_production_slot[var_14_1].place

	if not var_14_0:GetBuilding(var_14_3) then
		return nil
	end

	if var_5:GetDelegationSlotData(var_14_2) then
		return var_6
	end

	return nil
end

function var_0_1.SetHighLight(arg_15_0, arg_15_1)
	arg_15_0.isHighLight = arg_15_1

	return
end

function var_0_1.GetHighLight(arg_16_0, arg_16_1)
	return arg_16_0.isHighLight
end

return var_0_1
