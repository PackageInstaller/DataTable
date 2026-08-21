local var_0_0 = class("CourtYardOutStorey", import(".CourtYardStorey"))

function var_0_0.CanAddFurniture(arg_1_0, arg_1_1)
	return arg_1_1.config.belong == 1
end

return var_0_0
