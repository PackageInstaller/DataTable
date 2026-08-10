require("library/redux/lib/functional")

local var_0_0 = require("library/redux/utils/compose")

return function(...)
	local var_1_0 = {
		...
	}

	return function(arg_2_0)
		return function(...)
			local var_3_0 = arg_2_0(unpack({
				...
			}))

			local function var_3_1()
				error("                Dispatching while constructing your middleware is not allowed.\n                Other middleware would not be applied to this dispatch.")
			end

			local var_3_2 = {
				getState = var_3_0.getState,
				dispatch = function(...)
					return var_3_1(unpack({
						...
					}))
				end
			}
			local var_3_3 = map(function(arg_6_0)
				return arg_6_0(var_3_2)
			end, var_1_0)

			var_3_1 = var_0_0(unpack(var_3_3))(var_3_0.dispatch)

			local var_3_4 = {}

			for iter_3_0, iter_3_1 in pairs(var_3_0) do
				var_3_4[iter_3_0] = iter_3_1
			end

			var_3_4.dispatch = var_3_1

			return var_3_4
		end
	end
end
