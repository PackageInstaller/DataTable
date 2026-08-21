local var_0_0 = class("Dispatcher")

function var_0_0.Emit(arg_1_0, arg_1_1, ...)
	local var_1_0 = {
		...
	}

	if arg_1_0.events[arg_1_1] then
		local var_1_1 = {}

		table.merge(var_1_1, arg_1_0.events[arg_1_1])

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			iter_1_1(arg_1_1, unpack(var_1_0))
		end
	end
end

function var_0_0.Bind(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.events = arg_2_0.events or {}

	local var_2_0 = arg_2_0.events[arg_2_1]

	if not var_2_0 then
		var_2_0 = {}
		arg_2_0.events[arg_2_1] = var_2_0
	end

	if not table.indexof(var_2_0, arg_2_2) then
		table.insert(var_2_0, arg_2_2)
	end
end

function var_0_0.Unbind(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.events[arg_3_1] then
		if arg_3_2 ~= nil then
			table.removebyvalue(arg_3_0.events[arg_3_1], arg_3_2)
		else
			arg_3_0.events[arg_3_1] = {}
		end
	end
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.events = nil
end

return var_0_0
