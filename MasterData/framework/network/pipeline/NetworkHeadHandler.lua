module("framework.network.pipeline.NetworkHeadHandler", package.seeall)

local var_0_0 = class("NetworkHeadHandler", NetworkHandler)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_2, arg_1_3)

	arg_1_0._mgr = arg_1_1
	arg_1_0._beforeFilters = {}
	arg_1_0._afterFilters = {}
end

function var_0_0.addFilter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_3 and arg_2_0._afterFilters or arg_2_0._beforeFilters

	table.insert(var_2_0, arg_2_1)
	table.insert(var_2_0, arg_2_2 or false)
end

function var_0_0.onSend(arg_3_0, ...)
	local var_3_0
	local var_3_1
	local var_3_2
	local var_3_3
	local var_3_4

	for iter_3_0 = 1, #arg_3_0._beforeFilters, 2 do
		local var_3_5, var_3_6 = arg_3_0._beforeFilters[iter_3_0], arg_3_0._beforeFilters[iter_3_0 + 1]

		if var_3_6 then
			var_3_2 = var_3_5(var_3_6, ...)
		else
			var_3_2 = var_3_5(...)
		end

		if var_3_2 then
			var_3_3 = true
		elseif var_3_2 == false then
			var_3_4 = true
		end
	end

	if var_3_4 and not var_3_3 then
		return
	end

	if not var_3_3 then
		arg_3_0._mgr:doSend(...)
	end

	for iter_3_1 = 1, #arg_3_0._afterFilters, 2 do
		local var_3_7, var_3_8 = arg_3_0._afterFilters[iter_3_1], arg_3_0._afterFilters[iter_3_1 + 1]

		if var_3_8 then
			var_3_7(var_3_8, ...)
		else
			var_3_7(...)
		end
	end
end

return var_0_0
