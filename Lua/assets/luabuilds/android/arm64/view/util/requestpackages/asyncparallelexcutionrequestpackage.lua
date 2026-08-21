local var_0_0 = class("AsyncParallelExcutionRequestPackage", import(".RequestPackage"))

function var_0_0.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	if not arg_1_0.funcs or #arg_1_0.funcs == 0 then
		return
	end

	local var_1_0 = arg_1_0.funcs

	if #arg_1_0.funcs > 0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			iter_1_1(function()
				if arg_1_0.stopped then
					return
				end

				var_0 = var_0 - 1

				if var_0 == 0 and arg_1_0.final then
					arg_1_0.final()
				end

				return
			end)
		end
	elseif arg_1_0.final then
		arg_1_0.final()
	end

	return
end

function var_0_0.Ctor(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.funcs = arg_3_1
	arg_3_0.final = arg_3_2

	return
end

return var_0_0
