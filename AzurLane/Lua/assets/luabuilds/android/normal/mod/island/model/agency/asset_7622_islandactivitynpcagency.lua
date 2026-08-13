class = var_0_10000

local var_0_0 = "IslandActivityNpcAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.ACTIVITY_NPC_ADD = "IslandActivityNpcAgency:ACTIVITY_NPC_ADD"
var_0_1.ACTIVITY_NPC_UPDATE = "IslandActivityNpcAgency:ACTIVITY_NPC_UPDATE"
var_0_1.ACTIVITY_NPC_DEL = "IslandActivityNpcAgency:ACTIVITY_NPC_DEL"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.activityNpcs = {}

	return
end

function var_0_1.ExistTradeNpc(arg_2_0)
	pairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0.activityNpcs) do
		pg = var_1_10006

		if var_1_10006.island_world_objects[iter_2_1] and var_1_10006.type == 1 and var_1_10006.unitId == 101500 then
			return true, iter_2_1
		end
	end

	return false
end

function var_0_1.InitNpcList(arg_3_0, arg_3_1)
	arg_3_0.activityNpcs = {}
	ipairs = var_2

	for iter_3_0, iter_3_1 in var_2(arg_3_1) do
		arg_3_0.activityNpcs[iter_3_1.id] = iter_3_1.object_id
	end

	return
end

function var_0_1.GetNpcList(arg_4_0)
	return arg_4_0.activityNpcs
end

function var_0_1.GetNpcObjects(arg_5_0)
	local var_5_0 = {}

	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.activityNpcs) do
		table = var_1_10007

		var_1_10007.insert(var_5_0, iter_5_1)
	end

	return var_5_0
end

function var_0_1.AddNpc(arg_6_0, arg_6_1)
	if not arg_6_0:IncludeNpc(arg_6_1) then
		arg_6_0.activityNpcs[arg_6_1.id] = arg_6_1.object_id

		arg_6_0:DispatchEvent(var_0_1.ACTIVITY_NPC_ADD, arg_6_1.object_id)
	end

	return
end

function var_0_1.UpdateNpc(arg_7_0, arg_7_1)
	if arg_7_0:IncludeNpc(arg_7_1) then
		local var_7_0 = arg_7_0.activityNpcs[arg_7_1.id]

		arg_7_0.activityNpcs[arg_7_1.id] = arg_7_1.object_id

		arg_7_0:DispatchEvent(var_0_1.ACTIVITY_NPC_UPDATE, var_7_0, arg_7_1.object_id)
	end

	return
end

function var_0_1.RemoveNpc(arg_8_0, arg_8_1)
	if arg_8_0:IncludeNpc(arg_8_1) then
		local var_8_0 = arg_8_0.activityNpcs[arg_8_1.id]

		arg_8_0.activityNpcs[arg_8_1.id] = nil

		arg_8_0:DispatchEvent(var_0_1.ACTIVITY_NPC_DEL, var_8_0)
	end

	return
end

function var_0_1.IncludeNpc(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.activityNpcs

	npcId = var_1_10003

	return var_9_0[var_1_10003] ~= nil
end

return var_0_1
