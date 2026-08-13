class = var_0_10000

local var_0_0 = var_0_10000("CourtYardAgent")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	setmetatable = var_1_10002

	var_1_10002(arg_1_0, {
		__index = function(arg_2_0, arg_2_1)
			rawget = var_2_10002

			local var_2_0

			if not var_2_10002(arg_2_0, "class")[arg_2_1] or not var_2[arg_2_1] then
				var_2_0 = arg_1_1[arg_2_1]
			end

			return var_2_0
		end
	})

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0
