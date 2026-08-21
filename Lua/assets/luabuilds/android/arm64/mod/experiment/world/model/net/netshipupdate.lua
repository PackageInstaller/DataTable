local var_0_0 = class("NetShipUpdate", import("....BaseEntity"))

var_0_0.Fields = {
	id = "number",
	hpRant = "number"
}

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.hpRant = arg_1_1.hp_rant

	return
end

return var_0_0
