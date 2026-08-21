local var_0_0 = class("NetFleetAttachUpdate", import("....BaseEntity"))

var_0_0.Fields = {
	row = "number",
	column = "number",
	id = "number"
}

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.item_id
	arg_1_0.row = arg_1_1.pos.row
	arg_1_0.column = arg_1_1.pos.column

	return
end

return var_0_0
