class = var_0_10000

local var_0_0 = "NetFleetAttachUpdate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....BaseEntity"))

var_0_1.Fields = {
	row = "number",
	column = "number",
	id = "number"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.item_id
	arg_1_0.row = arg_1_1.pos.row
	arg_1_0.column = arg_1_1.pos.column

	return
end

return var_0_1
