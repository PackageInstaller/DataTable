class = var_0_10000

local var_0_0 = "BannerScrollRect4Mellow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BannerScrollRect"))

function var_0_1.UpdateDotPosition(arg_1_0, arg_1_1, arg_1_2)
	return
end

function var_0_1.TriggerDot(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2 and 45 or 10
	local var_2_1 = arg_2_1
	local var_2_2 = arg_2_1.GetComponent

	typeof = var_1_10006
	LayoutElement = var_1_10007
	var_2_2(var_2_1, var_1_10006(var_1_10007)).minWidth = var_2_0

	return
end

return var_0_1
