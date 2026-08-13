class = var_0_10000

local var_0_0 = "Returner"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PlayerAttire"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.user then
		var_1_0 = {}
	end

	var_0_1.super.Ctor(arg_1_0, var_1_0)

	local var_1_1

	if not arg_1_1.pt then
		var_1_1 = 0
	end

	arg_1_0.pt = var_1_1

	local var_1_2

	if not var_1_0.id then
		var_1_2 = 0
	end

	arg_1_0.id = var_1_2
	arg_1_0.name = var_1_0.name

	return
end

function var_0_1.getName(arg_2_0)
	return arg_2_0.name
end

function var_0_1.getIcon(arg_3_0)
	return arg_3_0.icon
end

function var_0_1.getPt(arg_4_0)
	return arg_4_0.pt
end

return var_0_1
