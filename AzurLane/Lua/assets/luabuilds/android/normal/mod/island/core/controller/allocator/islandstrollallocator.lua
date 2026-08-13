class = var_0_10000

local var_0_0 = var_0_10000("IslandStrollAllocator")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.mapId = arg_1_1.mapId
	pg = var_2

	local var_1_0

	if not var_2.island_waypoint.get_id_list_by_mapId[arg_1_0.mapId] then
		var_1_0 = {}
	end

	arg_1_0.paths = {}
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(var_1_0) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.island_waypoint[iter_1_1]

		local var_1_1

		if not arg_1_0.paths[var_1_10008.group] then
			var_1_1 = arg_1_0.paths
			var_1_1[var_1_10008.group] = {}
		end

		table = var_1_1

		var_1_1.insert(arg_1_0.paths[var_1_10008.group], iter_1_1)
	end

	arg_1_0.cache = {}

	return
end

function var_0_0.Allocator(arg_2_0, arg_2_1)
	assert = var_1_10002
	table = var_1_10003

	var_1_10002(not var_1_10003.contains(arg_2_0.cache, arg_2_1), "path has been used")

	if not arg_2_0.paths[arg_2_1] then
		arg_2_1 = arg_2_0:GetRandomPathId()
	end

	assert = var_2

	var_2(arg_2_0.paths[arg_2_1], "path not found" .. arg_2_1)

	table = var_2

	var_2.insert(arg_2_0.cache, arg_2_1)

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetWaypoints(var_2_0, arg_2_1)

	pg = var_2_0

	local var_2_2 = var_2_0.island_waypoint[var_2_1[1]].position

	return arg_2_1, var_2_2
end

function var_0_0.GetWaypoints(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_0.paths[arg_3_1] then
		var_3_0 = {}
	end

	table = var_1_10003

	var_1_10003.sort(var_3_0, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)

	return var_3_0
end

function var_0_0.GetRandomPathId(arg_5_0)
	local var_5_0 = {}

	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.paths) do
		table = var_1_10007

		if not var_1_10007.contains(arg_5_0.cache, iter_5_0) then
			table = var_1_10007

			var_1_10007.insert(var_5_0, iter_5_0)
		end
	end

	if #var_5_0 <= 0 then
		return -1
	end

	math = var_2

	return var_5_0[var_2.random(1, #var_5_0)]
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
