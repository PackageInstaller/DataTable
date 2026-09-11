return function(arg_1_0)
	return function(arg_2_0)
		return function(arg_3_0)
			if type(arg_3_0) == "function" then
				return arg_3_0(arg_1_0.dispatch, arg_1_0.getState)
			else
				return arg_2_0(arg_3_0)
			end
		end
	end
end
