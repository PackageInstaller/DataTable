local var_0_0 = class("CourtYardAgent")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	setmetatable(arg_1_0, {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = rawget(arg_2_0, "class")

			if var_2_0[arg_2_1] then
				return var_2_0[arg_2_1] or arg_1_1[arg_2_1]
			end
		end
	})

	return
end

function var_0_0.Dispose(arg_3_0)
	return
end

return var_0_0
