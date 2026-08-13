class = var_0_10000

local var_0_0 = "GMTProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0:on(50115, function(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.GMTMgr.GetInstance()

		var_1.showGMT(var_2_0, arg_2_0.timestamp)

		return
	end)

	return
end

return var_0_1
