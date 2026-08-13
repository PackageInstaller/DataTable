class = var_0_10000

local var_0_0 = "LevelStageTotalRewardPanelMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	LevelMediator2 = var_1_10004

	var_1_1(var_1_0, var_1_10004.ON_RETRACKING, function(arg_2_0, ...)
		packEx = var_2_10001

		local var_2_0 = var_2_10001(...)
		local var_2_1 = arg_1_0
		local var_2_2 = var_2.sendNotification

		LevelMediator2 = var_2_10005

		var_2_2(var_2_1, var_2_10005.ON_RETRACKING, var_2_0)

		return
	end)

	return
end

return var_0_1
