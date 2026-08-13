class = var_0_10000

local var_0_0 = var_0_10000("IslandComparableAllocator")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1
	arg_1_0.flags = {}

	arg_1_0:OnInitFlags()

	return
end

function var_0_0.Flush(arg_2_0)
	Clone = var_1_10001

	local var_2_0 = var_1_10001(arg_2_0.flags)

	arg_2_0.flags = {}

	arg_2_0:OnInitFlags(var_2_0)
	arg_2_0:OnCompareSample(var_2_0, arg_2_0.flags)

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:OnDispose()

	arg_3_0.controller = nil
	arg_3_0.flags = nil

	return
end

function var_0_0.RemoveUnit(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.controller
	local var_4_1 = var_3.NotifiyCore

	ISLAND_EVT = var_1_10006

	var_4_1(var_4_0, var_1_10006.RMOVE_UNIT, arg_4_1, arg_4_2)

	return
end

function var_0_0.GenUnit(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.controller
	local var_5_1 = var_2.NotifiyCore

	ISLAND_EVT = var_1_10005

	var_5_1(var_5_0, var_1_10005.GEN_UNIT, arg_5_1)

	return
end

function var_0_0.OnInitFlags(arg_6_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite!!!")

	return
end

function var_0_0.IsVisible(arg_7_0, arg_7_1)
	assert = var_1_10002

	var_1_10002(false, "overwrite!!!")

	return
end

function var_0_0.OnCompareSample(arg_8_0, arg_8_1, arg_8_2)
	assert = var_1_10003

	var_1_10003(false, "overwrite!!!")

	return
end

function var_0_0.OnDispose(arg_9_0)
	return
end

return var_0_0
