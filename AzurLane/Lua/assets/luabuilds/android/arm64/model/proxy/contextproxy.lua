local var_0_0 = class("ContextProxy", pm.Proxy)

function var_0_0.getCurrentContext(arg_1_0)
	return arg_1_0.data[#arg_1_0.data]
end

function var_0_0.pushContext(arg_2_0, arg_2_1)
	table.insert(arg_2_0.data, arg_2_1)

	return
end

function var_0_0.popContext(arg_3_0)
	return table.remove(arg_3_0.data)
end

function var_0_0.cleanContext(arg_4_0)
	arg_4_0.data = {}

	return
end

function var_0_0.getContextCount(arg_5_0)
	return #arg_5_0.data
end

function var_0_0.getContextByMediator(arg_6_0, arg_6_1)
	for iter_6_0 = #arg_6_0.data, 1, -1 do
		local var_6_0 = arg_6_0.data[iter_6_0]:getContextByMediator(arg_6_1)

		if var_6_0 then
			return var_6_0, arg_6_0.data[iter_6_0]
		end
	end

	return nil
end

function var_0_0.CleanUntilMediator(arg_7_0, arg_7_1)
	for iter_7_0 = #arg_7_0.data, 1, -1 do
		if arg_7_0.data[iter_7_0].mediator.__cname ~= arg_7_1.__cname then
			table.remove(arg_7_0.data, iter_7_0)
		else
			break
		end
	end

	return
end

function var_0_0.GetPrevContext(arg_8_0, arg_8_1)
	return arg_8_0.data[#arg_8_0.data - arg_8_1]
end

function var_0_0.RemoveContext(arg_9_0, arg_9_1)
	for iter_9_0 = #arg_9_0.data, 1, -1 do
		if arg_9_1 == arg_9_0.data[iter_9_0] then
			table.remove(arg_9_0.data, iter_9_0)
		end
	end

	return
end

function var_0_0.PushContext2Prev(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or 1

	table.insert(arg_10_0.data, math.clamp(#arg_10_0.data + 1 - arg_10_2, 1, #arg_10_0.data + 1), arg_10_1)

	return
end

return var_0_0
