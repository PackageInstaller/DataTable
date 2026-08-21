local var_0_0 = class("ReserveHeroPosTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.x = 0
	arg_1_0.y = 0
end

function var_0_0.UpdateServerData(arg_2_0, arg_2_1)
	arg_2_0.x = arg_2_1.x
	arg_2_0.y = arg_2_1.y
end

return var_0_0
