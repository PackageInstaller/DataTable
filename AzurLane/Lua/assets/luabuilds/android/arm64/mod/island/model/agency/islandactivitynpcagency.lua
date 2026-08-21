local var_0_0 = class("IslandActivityNpcAgency", import(".IslandBaseAgency"))

var_0_0.ACTIVITY_NPC_ADD = "IslandActivityNpcAgency:ACTIVITY_NPC_ADD"
var_0_0.ACTIVITY_NPC_UPDATE = "IslandActivityNpcAgency:ACTIVITY_NPC_UPDATE"
var_0_0.ACTIVITY_NPC_DEL = "IslandActivityNpcAgency:ACTIVITY_NPC_DEL"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.activityNpcs = {}

	return
end

function var_0_0.ExistTradeNpc(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.activityNpcs) do
		if pg.island_world_objects[iter_2_1] and pg.island_world_objects[iter_2_1].type == 1 and pg.island_world_objects[iter_2_1].unitId == 101500 then
			return true, iter_2_1
		end
	end

	return false
end

function var_0_0.InitNpcList(arg_3_0, arg_3_1)
	arg_3_0.activityNpcs = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0.activityNpcs[iter_3_1.id] = iter_3_1.object_id
	end

	return
end

function var_0_0.GetNpcList(arg_4_0)
	return arg_4_0.activityNpcs
end

function var_0_0.GetNpcObjects(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.activityNpcs) do
		table.insert({}, iter_5_1)
	end

	return {}
end

function var_0_0.AddNpc(arg_6_0, arg_6_1)
	if not arg_6_0:IncludeNpc(arg_6_1) then
		arg_6_0.activityNpcs[arg_6_1.id] = arg_6_1.object_id

		arg_6_0:DispatchEvent(var_0_0.ACTIVITY_NPC_ADD, arg_6_1.object_id)
	end

	return
end

function var_0_0.UpdateNpc(arg_7_0, arg_7_1)
	if arg_7_0:IncludeNpc(arg_7_1) then
		arg_7_0.activityNpcs[arg_7_1.id] = arg_7_1.object_id

		arg_7_0:DispatchEvent(var_0_0.ACTIVITY_NPC_UPDATE, arg_7_0.activityNpcs[arg_7_1.id], arg_7_1.object_id)
	end

	return
end

function var_0_0.RemoveNpc(arg_8_0, arg_8_1)
	if arg_8_0:IncludeNpc(arg_8_1) then
		arg_8_0.activityNpcs[arg_8_1.id] = nil

		arg_8_0:DispatchEvent(var_0_0.ACTIVITY_NPC_DEL, arg_8_0.activityNpcs[arg_8_1.id])
	end

	return
end

function var_0_0.IncludeNpc(arg_9_0, arg_9_1)
	return arg_9_0.activityNpcs[npcId] ~= nil
end

return var_0_0
