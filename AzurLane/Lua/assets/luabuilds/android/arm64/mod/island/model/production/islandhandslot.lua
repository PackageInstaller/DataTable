class = var_0_10000

local var_0_0 = "IslandHandSlot"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.placeId = arg_1_1

	arg_1_0:UpdateData(arg_1_2)

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_production_slot
end

function var_0_1.UpdateData(arg_3_0, arg_3_1)
	arg_3_0.configId = arg_3_1.id
	arg_3_0.state = arg_3_1.state
	arg_3_0.formula_id = arg_3_1.formula_id
	arg_3_0.end_time = arg_3_1.end_time
	arg_3_0.start_time = arg_3_1.start_time

	return
end

function var_0_1.GetPlantFormulaId(arg_4_0)
	if arg_4_0.state == 0 then
		return false
	end

	return arg_4_0.formula_id
end

return var_0_1
