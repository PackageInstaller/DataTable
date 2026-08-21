local var_0_0 = class("IslandActivityNpcAllocator", import(".IslandComparableAllocator"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.npcList = arg_1_1:GetIsland():GetActivityNpcAgency():GetNpcObjects()

	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.AddNpc(arg_2_0, arg_2_1)
	if not table.contains(arg_2_0.npcList, arg_2_1) then
		table.insert(arg_2_0.npcList, arg_2_1)
	end

	return
end

function var_0_0.DelNpc(arg_3_0, arg_3_1)
	if table.contains(arg_3_0.npcList, arg_3_1) then
		table.removebyvalue(arg_3_0.npcList, arg_3_1)
	end

	return
end

function var_0_0.OnInitFlags(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.controller.sceneData.activityUnits) do
		arg_4_0.flags[iter_4_1.id] = arg_4_0:IsVisible(iter_4_1.id)
	end

	return
end

function var_0_0.IsVisible(arg_5_0, arg_5_1)
	if not table.contains(arg_5_0.npcList, arg_5_1) then
		return false
	end

	local var_5_0 = pg.island_world_objects[arg_5_1]

	if not pg.island_world_objects[arg_5_1] then
		return false
	end

	if var_5_0.param.activity then
		local var_5_1 = var_5_0.param.activity[1] or 0

		if var_5_1 <= 0 then
			return false
		end

		local var_5_2 = getProxy(ActivityProxy):RawGetActivityById(var_5_1)

		return var_5_2 and not var_5_2:isEnd()
	end
end

function var_0_0.OnCompareSample(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		if iter_6_1 ~= nil and arg_6_2[iter_6_0] ~= nil and iter_6_1 ~= arg_6_2[iter_6_0] then
			if iter_6_1 == true and arg_6_2[iter_6_0] == false then
				arg_6_0:RemoveUnit(IslandConst.UNIT_LIST_OBJ, iter_6_0)
			elseif iter_6_1 == false and arg_6_2[iter_6_0] == true then
				local var_6_1 = arg_6_0:GetUnitData(iter_6_0)

				if var_6_1 then
					arg_6_0:GenUnit(var_6_1)
				end
			end
		end
	end

	return
end

function var_0_0.GetUnitData(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.controller.sceneData.activityUnits) do
		if iter_7_1.id == arg_7_1 then
			return iter_7_1
		end
	end

	return nil
end

return var_0_0
