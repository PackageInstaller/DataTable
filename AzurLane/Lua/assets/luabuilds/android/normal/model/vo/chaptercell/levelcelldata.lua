class = var_0_10000

local var_0_0 = "LevelCellData"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.GetLine(arg_1_0)
	return {
		row = arg_1_0.row,
		column = arg_1_0.column
	}
end

function var_0_1.SetLine(arg_2_0, arg_2_1)
	arg_2_0.row = arg_2_1.row
	arg_2_0.column = arg_2_1.column

	return
end

return var_0_1
