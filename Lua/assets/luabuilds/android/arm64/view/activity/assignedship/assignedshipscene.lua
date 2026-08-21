local var_0_0 = class("AssignedShipScene", import(".BaseAssignedShipScene"))

function var_0_0.getUIName(arg_1_0)
	return "AssignedShipUI"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.scrollrect = arg_2_0._tf:Find("layer/select_panel")
	arg_2_0.rightBtn = arg_2_0._tf:Find("layer/right")
	arg_2_0.leftBtn = arg_2_0._tf:Find("layer/left")

	return
end

function var_0_0.didEnter(arg_3_0)
	var_0_0.super.didEnter(arg_3_0)

	arg_3_0.isZero = true
	arg_3_0.isOne = false

	onScroll(arg_3_0, arg_3_0.scrollrect, function(arg_4_0)
		local var_4_0 = Mathf.Clamp01(arg_4_0.x)
		local var_4_1 = arg_3_0.isZero
		local var_4_2 = arg_3_0.isOne

		arg_3_0.isZero = var_4_0 - 0.0001 <= 0
		arg_3_0.isOne = var_4_0 + 0.0001 >= 1

		if var_4_1 ~= arg_3_0.isZero or var_4_2 ~= arg_3_0.isOne then
			arg_3_0:UpdateArr()
		end

		return
	end)
	arg_3_0:UpdateArr()

	return
end

function var_0_0.UpdateArr(arg_5_0)
	setActive(arg_5_0.rightBtn, not arg_5_0.isZero)
	setActive(arg_5_0.leftBtn, not arg_5_0.isOne)

	return
end

return var_0_0
