class = var_0_10000

local var_0_0 = "IslandTransferPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBasePerformancePlayer"))

function var_0_1.Play(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.objId
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.emit

	ISLAND_EX_EVT = var_1_10007

	var_1_2(var_1_1, var_1_10007.SWITCH_MAP, var_1_0)

	arg_1_0.callback = arg_1_2

	return
end

function var_0_1.EndAction(arg_2_0)
	if arg_2_0.callback then
		arg_2_0.callback()
	end

	arg_2_0.callback = nil

	return
end

return var_0_1
