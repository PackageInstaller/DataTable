class = var_0_10000

local var_0_0 = "Technology"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.technology_data_template
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.poolId = arg_2_1.pool_id
	arg_2_0.time = arg_2_1.time
	arg_2_0.isQueue = arg_2_1.queue

	return
end

function var_0_1.start(arg_3_0, arg_3_1)
	arg_3_0.time = arg_3_1

	return
end

function var_0_1.isActivate(arg_4_0)
	return arg_4_0.time > 0
end

function var_0_1.isCompleted(arg_5_0)
	local var_5_0

	if arg_5_0:isFinish() then
		var_5_0 = arg_5_0:finishCondition()
	end

	return var_5_0
end

function var_0_1.isStarting(arg_6_0)
	if not arg_6_0:isActivate() then
		return false
	end

	pg = var_1

	local var_6_0 = var_1.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_6_0) < arg_6_0.time
end

function var_0_1.isWaiting(arg_7_0)
	if not arg_7_0:isActivate() then
		return false
	end

	pg = var_1

	local var_7_0 = var_1.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_7_0) < arg_7_0.time - arg_7_0:getConfig("time")
end

function var_0_1.isDoing(arg_8_0)
	if not arg_8_0:isActivate() then
		return false
	end

	pg = var_1

	local var_8_0 = var_1.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_8_0) >= arg_8_0.time - arg_8_0:getConfig("time") and var_1 < arg_8_0.time
end

function var_0_1.isFinish(arg_9_0)
	if not arg_9_0:isActivate() then
		return false
	end

	pg = var_1

	local var_9_0 = var_1.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_9_0) >= arg_9_0.time
end

function var_0_1.finishCondition(arg_10_0)
	if arg_10_0.isQueue then
		return true
	end

	local var_10_2

	if arg_10_0:getConfig("condition") ~= 0 then
		getProxy = var_1_10002
		TaskProxy = var_4

		local var_10_0 = var_1_10002(var_4)
		local var_10_1 = var_2.getTaskVO(var_10_0, var_1)

		var_10_2 = var_2.isFinish(var_10_1)

		if false then
			var_10_2 = false
		end
	else
		var_10_2 = true
	end

	return var_10_2
end

function var_0_1.hasResToStart(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.getConfig(var_11_0, "consume")

	getProxy = var_1_10002
	PlayerProxy = var_4

	local var_11_2 = var_1_10002(var_4)
	local var_11_3 = var_2.getData(var_11_2)

	getProxy = var_11_0
	BagProxy = var_1_10005

	local var_11_4 = var_11_0(var_1_10005)

	ipairs = var_11_2

	for iter_11_0, iter_11_1 in var_11_2(var_11_1) do
		local var_11_5 = iter_11_1[1]

		DROP_TYPE_RESOURCE = var_1_10010

		if var_11_5 == var_1_10010 and var_11_3:getResById(iter_11_1[2]) < iter_11_1[3] then
			local var_11_6 = false

			i18n = var_1_10010
			var_1_10010 = var_1_10010("common_no_resource")

			return
		else
			local var_11_7 = iter_11_1[1]

			DROP_TYPE_ITEM = var_1_10010

			if var_11_7 == var_1_10010 and var_11_4:getItemCountById(iter_11_1[2]) < iter_11_1[3] then
				local var_11_8 = false

				i18n = var_1_10010
				var_1_10010 = var_1_10010("common_no_item_1")

				return
			end
		end
	end

	return true
end

function var_0_1.reset(arg_12_0)
	arg_12_0.time = 0

	return
end

return var_0_1
