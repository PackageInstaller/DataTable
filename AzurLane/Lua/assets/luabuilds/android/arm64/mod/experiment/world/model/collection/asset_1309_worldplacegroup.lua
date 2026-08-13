class = var_0_10000

local var_0_0 = var_0_10000("WorldPlaceGroup")

pg = var_0_10001

local var_0_1 = var_0_10001.world_collection_place_group

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id
	arg_1_0.config = var_0_1[arg_1_0.configId]
	assert = var_2

	var_2(arg_1_0.config, "config is missed")

	arg_1_0.pacles = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0.config.group) do
		local var_1_0 = arg_1_0.pacles

		WorldPlace = var_1_10008
		var_1_0[iter_1_1] = var_1_10008.New({
			id = iter_1_1,
			number = iter_1_0
		})
	end

	return
end

function var_0_0.isUnlockAll(arg_2_0)
	_ = var_1_10001

	local var_2_0 = var_1_10001.all

	_ = var_1_10003

	return var_2_0(var_1_10003.values(arg_2_0.pacles), function(arg_3_0)
		return arg_3_0:isUnlock()
	end)
end

function var_0_0.existPlace(arg_4_0, arg_4_1)
	_ = var_1_10002

	local var_4_0 = var_1_10002.any

	_ = var_1_10004

	return var_4_0(var_1_10004.values(arg_4_0.pacles), function(arg_5_0)
		return arg_5_0.id == arg_4_1
	end)
end

function var_0_0.getPlace(arg_6_0, arg_6_1)
	assert = var_1_10002

	var_1_10002(arg_6_0.pacles[arg_6_1])

	return arg_6_0.pacles[arg_6_1]
end

function var_0_0.unlockPlace(arg_7_0, arg_7_1)
	assert = var_1_10002

	var_1_10002(arg_7_0.pacles[arg_7_1])

	local var_7_0 = arg_7_0.pacles[arg_7_1]

	var_2.setUnlock(var_7_0, true)

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

	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.pacles) do
		if iter_10_1:isUnlock() then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0
end

function var_0_0.getTotalProgress(arg_11_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_11_0.pacles)
end

return var_0_0
