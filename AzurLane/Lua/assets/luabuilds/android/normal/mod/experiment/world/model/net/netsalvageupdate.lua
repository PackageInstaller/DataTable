class = var_0_10000

local var_0_0 = "NetSalvageUpdate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....BaseEntity"))

var_0_1.Fields = {
	id = "number",
	list = "table",
	mapId = "number",
	step = "number"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.group_id
	arg_1_0.step = arg_1_1.cmd_collection.progress
	underscore = var_2
	arg_1_0.list = var_2.rest(arg_1_1.cmd_collection.progress_list, 1)
	arg_1_0.mapId = arg_1_1.cmd_collection.random_id

	return
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

return var_0_1
