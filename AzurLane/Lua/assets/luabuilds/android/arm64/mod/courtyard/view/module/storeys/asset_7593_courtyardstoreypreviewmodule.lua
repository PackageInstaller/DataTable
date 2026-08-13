class = var_0_10000

local var_0_0 = "CourtYardStoreyPreviewModule"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardStoreyModule"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_0.bgmAgent

	var_3.Clear(var_1_0)

	return
end

function var_0_1.EnableZoom(arg_2_0, arg_2_1)
	arg_2_0.zoomAgent.enabled = false

	return
end

return var_0_1
