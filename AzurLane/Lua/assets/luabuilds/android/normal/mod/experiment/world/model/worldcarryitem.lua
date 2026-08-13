class = var_0_10000

local var_0_0 = "WorldCarryItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	config = "table",
	id = "number",
	offsetRow = "number",
	offsetColumn = "number"
}
var_0_1.EventUpdateOffset = "WorldCarryItem.EventUpdateOffset"

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	pg = var_1_10002
	arg_1_0.config = var_1_10002.world_carry_item[arg_1_0.id]
	assert = var_2

	var_2(arg_1_0.config, "world_carry_item not exist: " .. arg_1_0.id)

	arg_1_0.offsetRow = 0
	arg_1_0.offsetColumn = 0

	return
end

function var_0_1.UpdateOffset(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.offsetRow ~= arg_2_1 or arg_2_0.offsetColumn ~= arg_2_2 then
		arg_2_0.offsetRow = arg_2_1
		arg_2_0.offsetColumn = arg_2_2

		arg_2_0:DispatchEvent(var_0_1.EventUpdateOffset)
	end

	return
end

function var_0_1.GetScale(arg_3_0)
	Vector3 = var_1_10001

	return var_1_10001(arg_3_0.config.scale / 100, arg_3_0.config.scale / 100, 1)
end

function var_0_1.IsAvatar(arg_4_0)
	return arg_4_0.config.enemyicon == 1
end

return var_0_1
