class = var_0_10000

local var_0_0 = "WorkBenchActivity"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.Activity"))

function var_0_1.GetFormulaUseCount(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_0.data1KeyValueList[1][arg_1_1] then
		var_1_0 = 0
	end

	return var_1_0
end

function var_0_1.AddFormulaUseCount(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:GetFormulaUseCount(arg_2_1)

	arg_2_0.data1KeyValueList[1][arg_2_1] = var_2_0 + arg_2_2

	return
end

function var_0_1.HasAvaliableFormula(arg_3_0)
	_ = var_1_10001

	local var_3_0 = var_1_10001.map

	pg = var_1_10003

	local var_3_1 = var_3_0(var_1_10003.activity_workbench_recipe.all, function(arg_4_0)
		WorkBenchFormula = var_2_10001

		local var_4_0 = var_2_10001.New({
			configId = arg_4_0
		})

		var_1.BuildFromActivity(var_4_0)

		return var_1
	end)

	_ = var_1_10002

	return var_1_10002.any(var_3_1, function(arg_5_0)
		local var_5_0

		if arg_5_0:IsUnlock() then
			var_5_0 = arg_5_0:IsAvaliable()
		end

		return var_5_0
	end)
end

return var_0_1
