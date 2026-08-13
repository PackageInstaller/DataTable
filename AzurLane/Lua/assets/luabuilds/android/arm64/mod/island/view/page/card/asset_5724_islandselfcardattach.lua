class = var_0_10000

local var_0_0 = "IslandSelfCardAttach"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".external.IslandSelfCardLayer"))

function var_0_1.didEnter(arg_1_0)
	var_0_1.super.didEnter(arg_1_0)

	onNextTick = var_1

	var_1(function()
		local var_2_0 = arg_1_0

		var_0.ExtraHandle(var_2_0)

		return
	end)

	return
end

function var_0_1.ExtraHandle(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.closeView(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf, arg_4_0.contextData.container)
	arg_4_0.contextData.onClose()

	return
end

return var_0_1
