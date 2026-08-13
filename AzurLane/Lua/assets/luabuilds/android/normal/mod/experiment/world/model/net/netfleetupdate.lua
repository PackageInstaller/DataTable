class = var_0_10000

local var_0_0 = "NetFleetUpdate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....BaseEntity"))

var_0_1.Fields = {
	id = "number",
	buffs = "table"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	WorldConst = var_2
	arg_1_0.buffs = var_2.ParsingBuffs(arg_1_1.buff_list)

	return
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0:Clear()

	return
end

function var_0_1.GetBuffsByTrap(arg_3_0, arg_3_1)
	local var_3_0 = {}

	pairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0.buffs) do
		if iter_3_1:GetFloor() > 0 and iter_3_1:GetTrapType() == arg_3_1 then
			table = var_8

			var_8.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

return var_0_1
