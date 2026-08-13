class = var_0_10000

local var_0_0 = "LinerTimeGroup"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.times = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0:GetIds()) do
		local var_1_0 = arg_1_0.times

		LinerTime = var_1_10008
		var_1_0[iter_1_1] = var_1_10008.New(iter_1_1)
	end

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_liner_time_group
end

function var_0_1.GetTime(arg_3_0, arg_3_1)
	return arg_3_0.times[arg_3_1]
end

function var_0_1.GetTimes(arg_4_0)
	return arg_4_0.times
end

function var_0_1.GetIds(arg_5_0)
	return arg_5_0:getConfig("ids")
end

function var_0_1.GetTimeList(arg_6_0)
	local var_6_0 = {}

	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.times) do
		table = var_1_10007

		var_1_10007.insert(var_6_0, iter_6_1)
	end

	return var_6_0
end

function var_0_1.GetDrop(arg_7_0)
	Drop = var_1_10001

	return var_1_10001.Create(arg_7_0:getConfig("drop_display"))
end

return var_0_1
