return function(arg_1_0)
	return function(arg_2_0)
		return function(arg_3_0)
			if type(arg_3_0) == "function" then
				print("debugAction(function):", arg_3_0)
			else
				print("debugAction(action):", arg_3_0.type)
			end

			return arg_2_0(arg_3_0)
		end
	end
end
