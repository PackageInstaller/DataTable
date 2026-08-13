class = var_0_10000

local var_0_0 = "ContextProxy"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.Proxy)

function var_0_1.getCurrentContext(arg_1_0)
	return arg_1_0.data[#arg_1_0.data]
end

function var_0_1.pushContext(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.insert(arg_2_0.data, arg_2_1)

	return
end

function var_0_1.popContext(arg_3_0)
	table = var_1_10001

	return var_1_10001.remove(arg_3_0.data)
end

function var_0_1.cleanContext(arg_4_0)
	arg_4_0.data = {}

	return
end

function var_0_1.getContextCount(arg_5_0)
	return #arg_5_0.data
end

function var_0_1.getContextByMediator(arg_6_0, arg_6_1)
	for iter_6_0 = #arg_6_0.data, 1, -1 do
		local var_6_0 = arg_6_0.data[iter_6_0]

		if var_6.getContextByMediator(var_6_0, arg_6_1) then
			return var_7, var_6
		end
	end

	return nil
end

function var_0_1.CleanUntilMediator(arg_7_0, arg_7_1)
	for iter_7_0 = #arg_7_0.data, 1, -1 do
		if not (arg_7_0.data[iter_7_0].mediator.__cname == arg_7_1.__cname) then
			table = var_8

			var_8.remove(arg_7_0.data, iter_7_0)
		else
			break
		end
	end

	return
end

function var_0_1.GetPrevContext(arg_8_0, arg_8_1)
	return arg_8_0.data[#arg_8_0.data - arg_8_1]
end

function var_0_1.RemoveContext(arg_9_0, arg_9_1)
	for iter_9_0 = #arg_9_0.data, 1, -1 do
		if arg_9_1 == arg_9_0.data[iter_9_0] then
			table = var_6

			var_6.remove(arg_9_0.data, iter_9_0)
		end
	end

	return
end

function var_0_1.PushContext2Prev(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or 1
	math = var_1_10003

	local var_10_0 = var_1_10003.clamp(#arg_10_0.data + 1 - arg_10_2, 1, #arg_10_0.data + 1)

	table = var_1_10004

	var_1_10004.insert(arg_10_0.data, var_10_0, arg_10_1)

	return
end

return var_0_1
