pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.CldNode = var_0_10001("CldNode")

function var_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.cylinder = false

	return
end

function var_1.UpdateBox(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.min = arg_2_1:Copy2(arg_2_0.min)
	arg_2_0.max = arg_2_2:Copy2(arg_2_0.max)

	if arg_2_3 then
		local var_2_0 = arg_2_0.min

		var_4.Add(var_2_0, arg_2_3)

		local var_2_1 = arg_2_0.max

		var_4.Add(var_2_1, arg_2_3)
	end

	return arg_2_0
end

function var_1.UpdateStaticBox(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.min = arg_3_1
	arg_3_0.max = arg_3_2

	return arg_3_0
end

function var_1.UpdateCylinder(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 < 0 then
		arg_4_3 = -arg_4_3
	end

	arg_4_0.center = arg_4_1:Copy2(arg_4_0.center)
	arg_4_0.range = arg_4_3
	Vector3 = var_4
	arg_4_0.min = arg_4_1 - var_4(arg_4_3, arg_4_2, arg_4_3)
	arg_4_0.max = arg_4_1 + var_4
	arg_4_0.cylinder = true

	return arg_4_0
end

return
