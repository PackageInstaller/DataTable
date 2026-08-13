class = var_0_10000

local var_0_0 = "IslandActivityNpcAllocator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandComparableAllocator"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:GetIsland()
	local var_1_1 = var_2.GetActivityNpcAgency(var_1_0)

	arg_1_0.npcList = var_3.GetNpcObjects(var_1_1)

	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.AddNpc(arg_2_0, arg_2_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_2_0.npcList, arg_2_1) then
		table = var_2

		var_2.insert(arg_2_0.npcList, arg_2_1)
	end

	return
end

function var_0_1.DelNpc(arg_3_0, arg_3_1)
	table = var_1_10002

	if var_1_10002.contains(arg_3_0.npcList, arg_3_1) then
		table = var_2

		var_2.removebyvalue(arg_3_0.npcList, arg_3_1)
	end

	return
end

function var_0_1.OnInitFlags(arg_4_0)
	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.controller.sceneData.activityUnits) do
		arg_4_0.flags[iter_4_1.id] = arg_4_0:IsVisible(iter_4_1.id)
	end

	return
end

function var_0_1.IsVisible(arg_5_0, arg_5_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_5_0.npcList, arg_5_1) then
		return false
	end

	pg = var_2

	if not var_2.island_world_objects[arg_5_1] then
		return false
	end

	local var_5_0

	if not var_2.param.activity or not var_2.param.activity[1] then
		var_5_0 = 0
	end

	if var_5_0 <= 0 then
		return false
	end

	getProxy = var_4
	ActivityProxy = var_1_10005

	local var_5_1 = var_4(var_1_10005)
	local var_5_2

	var_5_2 = var_4.RawGetActivityById(var_5_1, var_5_0) and not var_4:isEnd()

	return var_5_2
end

function var_0_1.OnCompareSample(arg_6_0, arg_6_1, arg_6_2)
	pairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_1) do
		local var_6_0 = iter_6_1
		local var_6_1 = arg_6_2[iter_6_0]

		if var_6_0 ~= nil and var_6_1 ~= nil and var_6_0 ~= var_6_1 then
			if var_6_0 == true and var_6_1 == false then
				local var_6_2 = arg_6_0
				local var_6_3 = arg_6_0.RemoveUnit

				IslandConst = var_1_10012

				var_6_3(var_6_2, var_1_10012.UNIT_LIST_OBJ, iter_6_0)
			elseif var_6_0 == false and var_6_1 == true and arg_6_0:GetUnitData(iter_6_0) then
				var_1_10012 = arg_6_0

				arg_6_0.GenUnit(var_1_10012, var_10)
			end
		end
	end

	return
end

function var_0_1.GetUnitData(arg_7_0, arg_7_1)
	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.controller.sceneData.activityUnits) do
		if iter_7_1.id == arg_7_1 then
			return iter_7_1
		end
	end

	return nil
end

return var_0_1
