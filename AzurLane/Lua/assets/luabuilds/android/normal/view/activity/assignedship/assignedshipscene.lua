class = var_0_10000

local var_0_0 = "AssignedShipScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseAssignedShipScene"))

function var_0_1.getUIName(arg_1_0)
	return "AssignedShipUI"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.scrollrect = var_1.Find(var_2_0, "layer/select_panel")

	local var_2_1 = arg_2_0._tf

	arg_2_0.rightBtn = var_1.Find(var_2_1, "layer/right")

	local var_2_2 = arg_2_0._tf

	arg_2_0.leftBtn = var_1.Find(var_2_2, "layer/left")

	return
end

function var_0_1.didEnter(arg_3_0)
	var_0_1.super.didEnter(arg_3_0)

	arg_3_0.isZero = true
	arg_3_0.isOne = false
	onScroll = var_1

	var_1(arg_3_0, arg_3_0.scrollrect, function(arg_4_0)
		Mathf = var_2_10001

		local var_4_0 = var_2_10001.Clamp01(arg_4_0.x)
		local var_4_1 = arg_3_0.isZero
		local var_4_2 = arg_3_0.isOne

		arg_3_0.isZero = var_4_0 - 0.0001 <= 0
		arg_3_0.isOne = var_4_0 + 0.0001 >= 1

		if var_4_1 ~= arg_3_0.isZero or var_4_2 ~= arg_3_0.isOne then
			local var_4_3 = arg_3_0

			var_4.UpdateArr(var_4_3)
		end

		return
	end)
	arg_3_0:UpdateArr()

	return
end

function var_0_1.UpdateArr(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.rightBtn, not arg_5_0.isZero)

	setActive = var_1_10001

	var_1_10001(arg_5_0.leftBtn, not arg_5_0.isOne)

	return
end

return var_0_1
