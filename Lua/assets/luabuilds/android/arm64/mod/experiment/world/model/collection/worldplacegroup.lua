local var_0_0 = class("WorldPlaceGroup")
local var_0_1 = pg.world_collection_place_group

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id
	arg_1_0.config = var_0_1[arg_1_0.configId]

	assert(arg_1_0.config, "config is missed")

	arg_1_0.pacles = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.config.group) do
		arg_1_0.pacles[iter_1_1] = WorldPlace.New({
			id = iter_1_1,
			number = iter_1_0
		})
	end

	return
end

function var_0_0.isUnlockAll(arg_2_0)
	return _.all(_.values(arg_2_0.pacles), function(arg_3_0)
		return arg_3_0:isUnlock()
	end)
end

function var_0_0.existPlace(arg_4_0, arg_4_1)
	return _.any(_.values(arg_4_0.pacles), function(arg_5_0)
		return arg_5_0.id == arg_4_1
	end)
end

function var_0_0.getPlace(arg_6_0, arg_6_1)
	assert(arg_6_0.pacles[arg_6_1])

	return arg_6_0.pacles[arg_6_1]
end

function var_0_0.unlockPlace(arg_7_0, arg_7_1)
	assert(arg_7_0.pacles[arg_7_1])
	arg_7_0.pacles[arg_7_1]:setUnlock(true)

	return
end

function var_0_0.getPlaces(arg_8_0)
	return arg_8_0.pacles
end

function var_0_0.getTitle(arg_9_0)
	return arg_9_0.config.title
end

function var_0_0.getProgress(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.pacles) do
		if iter_10_1:isUnlock() then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0
end

function var_0_0.getTotalProgress(arg_11_0)
	return table.getCount(arg_11_0.pacles)
end

return var_0_0
