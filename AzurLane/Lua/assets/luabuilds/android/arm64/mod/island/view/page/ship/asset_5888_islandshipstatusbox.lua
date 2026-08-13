class = var_0_10000

local var_0_0 = "IslandShipStatusBox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandShipStatusPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShipStatusBox"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.hideBtn = var_1.Find(var_2_0, "close")

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.hideBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.OnShow(arg_5_0, ...)
	var_0_1.super.OnShow(arg_5_0, ...)
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		groupDelta = 1
	})

	return
end

function var_0_1.OnHide(arg_6_0)
	var_0_1.super.OnHide(arg_6_0)
	arg_6_0:UnOverlayPanel(arg_6_0._tf, arg_6_0._parentTf)

	return
end

function var_0_1.OnDisable(arg_7_0)
	arg_7_0:OnHide()

	return
end

return var_0_1
