require("library/redux/lib/functional")

return function(...)
	local var_1_0 = {
		...
	}

	if #var_1_0 == 0 then
		return function(arg_2_0)
			return arg_2_0
		end
	end

	if #var_1_0 == 1 then
		return var_1_0[1]
	end

	return reduce(function(arg_3_0, arg_3_1)
		return function(...)
			return arg_3_0(arg_3_1(unpack({
				...
			})))
		end
	end, var_1_0)
end
