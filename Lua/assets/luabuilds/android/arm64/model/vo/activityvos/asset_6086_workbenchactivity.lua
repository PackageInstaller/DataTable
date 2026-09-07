local WorkBenchActivity = class("WorkBenchActivity", import("model.vo.Activity"))

function WorkBenchActivity:GetFormulaUseCount(arg_1_1)
	return self.data1KeyValueList[1][arg_1_1] or 0
end

function WorkBenchActivity:AddFormulaUseCount(arg_2_1, arg_2_2)
	self.data1KeyValueList[1][arg_2_1] = self:GetFormulaUseCount(arg_2_1) + arg_2_2

	return
end

function WorkBenchActivity:HasAvaliableFormula()
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

return WorkBenchActivity
