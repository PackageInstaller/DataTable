class = var_0_10000

local var_0_0 = var_0_10000("MainPaintingShift")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	Vector3 = var_1_10003

	local var_1_0 = var_1_10003(arg_1_1[1], arg_1_1[2], 0)
	local var_1_1

	if not arg_1_2 then
		::label_1_0::

		Vector3 = var_1_1
		var_1_1 = var_1_1.zero
	end

	arg_1_0.meshImageShift = var_1_0 + var_1_1
	Vector3 = var_3
	arg_1_0.l2dShift = var_3(arg_1_1[3], arg_1_1[4], 0)
	Vector3 = var_3
	arg_1_0.spineShift = var_3(arg_1_1[5], arg_1_1[6], 0)
	Vector3 = var_3
	arg_1_0.scale = var_3(arg_1_1[7], arg_1_1[7], 1)
	Vector3 = var_3
	arg_1_0.l2dScale = var_3(arg_1_1[8], arg_1_1[8], 1)
	Vector3 = var_3
	arg_1_0.spineScale = var_3(arg_1_1[9], arg_1_1[9], 1)

	return
end

function var_0_0.GetMeshImageShift(arg_2_0)
	return arg_2_0.meshImageShift, arg_2_0.scale
end

function var_0_0.GetL2dShift(arg_3_0)
	return arg_3_0.l2dShift, arg_3_0.l2dScale
end

function var_0_0.GetSpineShift(arg_4_0)
	return arg_4_0.spineShift, arg_4_0.spineScale
end

function var_0_0.IsLimitYPos(arg_5_0)
	return arg_5_0 == "biaoqiang" or arg_5_0 == "z23" or arg_5_0 == "lafei" or arg_5_0 == "lingbo" or arg_5_0 == "mingshi" or arg_5_0 == "xuefeng"
end

function var_0_0.GetHalfBodyOffsetY(arg_6_0, arg_6_1)
	return arg_6_0.rect.height * -0.5 + 325 * arg_6_1.localScale.y
end

return var_0_0
