local var_0_0 = class("IslandStrollAllocator")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.mapId = arg_1_1.mapId

	local var_1_0 = pg.island_waypoint.get_id_list_by_mapId[arg_1_0.mapId] or {}

	arg_1_0.paths = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.paths[pg.island_waypoint[iter_1_1].group] = arg_1_0.paths[pg.island_waypoint[iter_1_1].group] or {}

		table.insert(arg_1_0.paths[pg.island_waypoint[iter_1_1].group], iter_1_1)
	end

	arg_1_0.cache = {}

	return
end

function var_0_0.Allocator(arg_2_0, arg_2_1)
	assert(not table.contains(arg_2_0.cache, arg_2_1), "path has been used")

	if not arg_2_0.paths[arg_2_1] then
		arg_2_1 = arg_2_0:GetRandomPathId()
	end

	assert(arg_2_0.paths[arg_2_1], "path not found" .. arg_2_1)
	table.insert(arg_2_0.cache, arg_2_1)

	return arg_2_1, pg.island_waypoint[arg_2_0:GetWaypoints(arg_2_1)[1]].position
end

function var_0_0.GetWaypoints(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.paths[arg_3_1] or {}

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)

	return var_3_0
end

function var_0_0.GetRandomPathId(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.paths) do
		if not table.contains(arg_5_0.cache, iter_5_0) then
			table.insert({}, iter_5_0)
		end
	end

	if #{} <= 0 then
		return -1
	end

	return ({})[math.random(1, #{})]
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
