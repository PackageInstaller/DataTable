table = var_0_10000

local var_0_0 = var_0_10000.remove

setmetatable = var_0_10001

return var_0_10001({
	flush = function(arg_1_0)
		for iter_1_0 = #arg_1_0, 1, -1 do
			arg_1_0[iter_1_0] = nil
		end

		return
	end,
	get = function(arg_2_0)
		return arg_2_0[#arg_2_0]
	end
}, {
	__call = function(arg_3_0, arg_3_1)
		if arg_3_1 then
			arg_3_0[#arg_3_0 + 1] = arg_3_1
		else
			assert = var_1_10002

			return (var_1_10002(var_0_0(arg_3_0), "empty zone stack"))
		end

		return
	end
})
