class = var_0_10000

local var_0_0 = "NetShipUpdate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....BaseEntity"))

var_0_1.Fields = {
	id = "number",
	hpRant = "number"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.hpRant = arg_1_1.hp_rant

	return
end

return var_0_1
