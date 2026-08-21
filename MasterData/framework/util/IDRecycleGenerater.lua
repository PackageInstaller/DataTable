module("framework.util.IDRecycleGenerater", package.seeall)

local var_0_0 = class("IDGenerater")

function var_0_0.ctor(arg_1_0)
	arg_1_0._id = 0
	arg_1_0._interval = 1
	arg_1_0._list = {}
end

function var_0_0.setId(arg_2_0, arg_2_1)
	arg_2_0._id = arg_2_1
end

function var_0_0.setInterval(arg_3_0, arg_3_1)
	arg_3_0._interval = arg_3_1
end

function var_0_0.generaterUid(arg_4_0)
	local var_4_0 = table.remove(arg_4_0._list)

	if not var_4_0 then
		var_4_0 = arg_4_0._id + arg_4_0._interval
		arg_4_0._id = var_4_0
	end

	return var_4_0
end

function var_0_0.recycle(arg_5_0, arg_5_1)
	table.insert(arg_5_0._list, arg_5_1)
end

function var_0_0.clear(arg_6_0)
	arg_6_0._id = 0

	table.clear(arg_6_0._list)
end

local var_0_1 = 0
local var_0_2 = {}

function getNewId()
	var_0_1 = var_0_1 + 1
	var_0_2[var_0_1] = var_0_0.New()

	return var_0_1
end

function clearIdGenerater(arg_8_0)
	var_0_2[arg_8_0] = nil
end

function getIdGenerater(arg_9_0)
	return var_0_2[arg_9_0]
end

function getUid(arg_10_0)
	local var_10_0 = getIdGenerater(arg_10_0)

	return var_10_0 and var_10_0:generaterUid() or 0
end

function recycleUid(arg_11_0, arg_11_1)
	local var_11_0 = getIdGenerater(arg_11_0)

	if var_11_0 then
		var_11_0:recycle(arg_11_1)
	end
end

function clearIdGenerater(arg_12_0)
	local var_12_0 = var_0_2[arg_12_0]

	if var_12_0 then
		var_12_0:clear()
	end

	table.remove(var_0_2, arg_12_0)
end

local var_0_3

function getInnerChannelUid()
	if not var_0_3 then
		var_0_3 = getNewId()

		getIdGenerater(var_0_3):setInterval(1000)
	end

	return getUid(var_0_3)
end

function recycleInnerChannelUid(arg_14_0)
	if var_0_3 then
		recycleUid(var_0_3, arg_14_0)
	end
end

function clearInnerChannel()
	clearIdGenerater(var_0_3)

	var_0_3 = nil
end
