module("framework.datastruct.SignalAmount", package.seeall)

local var_0_0 = "default_key"
local var_0_1 = class("SignalAmount")

function var_0_1.ctor(arg_1_0, arg_1_1)
	arg_1_0._name = arg_1_1
	arg_1_0._key2Num = nil
	arg_1_0._count = 0
end

function var_0_1.add(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or var_0_0
	arg_2_0._key2Num = arg_2_0._key2Num or {}

	if arg_2_0._key2Num[arg_2_1] then
		arg_2_0._key2Num[arg_2_1] = arg_2_0._key2Num[arg_2_1] + 1
	else
		arg_2_0._key2Num[arg_2_1] = 1
	end

	arg_2_0._count = arg_2_0._count + 1
end

function var_0_1.remove(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or var_0_0

	if arg_3_0._key2Num and arg_3_0._key2Num[arg_3_1] then
		if arg_3_0._key2Num[arg_3_1] - 1 == 0 then
			arg_3_0._key2Num[arg_3_1] = nil
		else
			arg_3_0._key2Num[arg_3_1] = 0
		end

		arg_3_0._count = arg_3_0._count - 1
	end
end

function var_0_1.isActive(arg_4_0)
	return arg_4_0:getCount() > 0
end

function var_0_1.isUnactive(arg_5_0)
	return not arg_5_0:isActive()
end

function var_0_1.getCount(arg_6_0)
	return arg_6_0._count
end

function var_0_1.getKeyCount(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or var_0_0

	if arg_7_0._key2Num and arg_7_0._key2Num[arg_7_1] then
		return arg_7_0._key2Num[arg_7_1]
	end

	return 0
end

function var_0_1.hasKey(arg_8_0, arg_8_1)
	return arg_8_0:getKeyCount(arg_8_1) > 0
end

function var_0_1.clear(arg_9_0)
	if arg_9_0._key2Num then
		arg_9_0._key2Num = nil
		arg_9_0._count = 0
	end
end

function var_0_1.toString(arg_10_0)
	local var_10_0 = StringBuffer.New()

	var_10_0:append("Signal Name:"):append(arg_10_0._name):appendLine()
	var_10_0:append("Total Count:"):append(arg_10_0._count):appendLine()

	for iter_10_0, iter_10_1 in pairs(arg_10_0._key2Num) do
		var_10_0:append(iter_10_0):append(":"):append(iter_10_1):appendLine()
	end

	local var_10_1 = var_10_0:toString()

	var_10_0:clear()

	return var_10_1
end

function var_0_1.dump(arg_11_0)
	print(arg_11_0:toString())
end

return var_0_1
