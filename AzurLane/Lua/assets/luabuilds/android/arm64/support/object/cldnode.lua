pg = pg or {}

local var_0_0 = class("CldNode")

pg.CldNode = var_0_0

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.cylinder = false

	return
end

function var_0_0.UpdateBox(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.min = arg_2_1:Copy2(arg_2_0.min)
	arg_2_0.max = arg_2_2:Copy2(arg_2_0.max)

	if arg_2_3 then
		arg_2_0.min:Add(arg_2_3)
		arg_2_0.max:Add(arg_2_3)
	end

	return arg_2_0
end

function var_0_0.UpdateStaticBox(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.min = arg_3_1
	arg_3_0.max = arg_3_2

	return arg_3_0
end

function var_0_0.UpdateCylinder(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 < 0 then
		arg_4_3 = -arg_4_3
	end

	arg_4_0.center = arg_4_1:Copy2(arg_4_0.center)
	arg_4_0.range = arg_4_3

	local var_4_0 = Vector3(arg_4_3, arg_4_2, arg_4_3)

	arg_4_0.min = arg_4_1 - var_4_0
	arg_4_0.max = arg_4_1 + var_4_0
	arg_4_0.cylinder = true

	return arg_4_0
end

return
