local var_0_0 = class("Returner", import(".PlayerAttire"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.user or {}

	var_0_0.super.Ctor(arg_1_0, var_1_0)

	arg_1_0.pt = arg_1_1.pt or 0
	arg_1_0.id = var_1_0.id or 0
	arg_1_0.name = var_1_0.name

	return
end

function var_0_0.getName(arg_2_0)
	return arg_2_0.name
end

function var_0_0.getIcon(arg_3_0)
	return arg_3_0.icon
end

function var_0_0.getPt(arg_4_0)
	return arg_4_0.pt
end

return var_0_0
