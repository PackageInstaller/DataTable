local var_0_0 = class("WorkBenchActivity", import("model.vo.Activity"))

function var_0_0.GetFormulaUseCount(arg_1_0, arg_1_1)
	return arg_1_0.data1KeyValueList[1][arg_1_1] or 0
end

function var_0_0.AddFormulaUseCount(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.data1KeyValueList[1][arg_2_1] = arg_2_0:GetFormulaUseCount(arg_2_1) + arg_2_2

	return
end

function var_0_0.HasAvaliableFormula(arg_3_0)
	return _.any(_.map(pg.activity_workbench_recipe.all, function(arg_4_0)
		local var_4_0 = WorkBenchFormula.New({
			configId = arg_4_0
		})

		var_4_0:BuildFromActivity()

		return var_4_0
	end), function(arg_5_0)
		return arg_5_0:IsUnlock() and arg_5_0:IsAvaliable()
	end)
end

return var_0_0
