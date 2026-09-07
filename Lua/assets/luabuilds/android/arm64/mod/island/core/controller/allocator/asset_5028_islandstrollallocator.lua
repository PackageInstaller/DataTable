local IslandStrollAllocator = class("IslandStrollAllocator")

function IslandStrollAllocator:Ctor(arg_1_1)
	self.mapId = arg_1_1.mapId
	self.paths = {}

	for iter_1_0, iter_1_1 in ipairs(pg.island_waypoint.get_id_list_by_mapId[self.mapId] or {}) do
		self.paths[pg.island_waypoint[iter_1_1].group] = self.paths[pg.island_waypoint[iter_1_1].group] or {}

		table.insert(self.paths[pg.island_waypoint[iter_1_1].group], iter_1_1)
	end

	self.cache = {}

	return
end

function IslandStrollAllocator:Allocator(arg_2_1)
	assert(not table.contains(self.cache, arg_2_1), "path has been used")

	if not self.paths[arg_2_1] then
		arg_2_1 = self:GetRandomPathId()
	end

	assert(self.paths[arg_2_1], "path not found" .. arg_2_1)
	table.insert(self.cache, arg_2_1)

	return arg_2_1, pg.island_waypoint[self:GetWaypoints(arg_2_1)[1]].position
end

function IslandStrollAllocator:GetWaypoints(arg_3_1)
	local var_3_0 = self.paths[arg_3_1] or {}

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)

	return var_3_0
end

function IslandStrollAllocator:GetRandomPathId()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.paths) do
		if not table.contains(self.cache, iter_5_0) then
			table.insert(var_5_0, iter_5_0)
		end
	end

	if #var_5_0 <= 0 then
		return -1
	end

	return var_5_0[math.random(1, #var_5_0)]
end

function IslandStrollAllocator:Dispose()
	return
end

return IslandStrollAllocator
