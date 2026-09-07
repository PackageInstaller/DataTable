local WorldPlaceGroup = class("WorldPlaceGroup")
local var_0_1 = pg.world_collection_place_group

function WorldPlaceGroup:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = arg_1_1.id
	self.config = var_0_1[self.configId]

	assert(self.config, "config is missed")

	self.pacles = {}

	for iter_1_0, iter_1_1 in ipairs(self.config.group) do
		self.pacles[iter_1_1] = WorldPlace.New({
			id = iter_1_1,
			number = iter_1_0
		})
	end

	return
end

function WorldPlaceGroup:isUnlockAll()
	return _.all(_.values(self.pacles), function(arg_3_0)
		return arg_3_0:isUnlock()
	end)
end

function WorldPlaceGroup:existPlace(arg_4_1)
	return _.any(_.values(self.pacles), function(arg_5_0)
		return arg_5_0.id == arg_4_1
	end)
end

function WorldPlaceGroup:getPlace(arg_6_1)
	assert(self.pacles[arg_6_1])

	return self.pacles[arg_6_1]
end

function WorldPlaceGroup:unlockPlace(arg_7_1)
	assert(self.pacles[arg_7_1])
	self.pacles[arg_7_1]:setUnlock(true)

	return
end

function WorldPlaceGroup:getPlaces()
	return self.pacles
end

function WorldPlaceGroup:getTitle()
	return self.config.title
end

function WorldPlaceGroup:getProgress()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(self.pacles) do
		if iter_10_1:isUnlock() then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0
end

function WorldPlaceGroup:getTotalProgress()
	return table.getCount(self.pacles)
end

return WorldPlaceGroup
