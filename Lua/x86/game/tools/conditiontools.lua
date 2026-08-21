local var_0_0 = {
	GetConditionProgress = function(arg_1_0, arg_1_1)
		if arg_1_0 == 0 then
			return 1, 1
		end

		local var_1_0 = ConditionCfg[arg_1_0]

		if var_1_0.type == 8010 then
			local var_1_1 = DormData:GetCurrectSceneID()

			return DormData:GetDormSceneData(var_1_1).accruing_earnings, var_1_0.params[1]
		elseif var_1_0.type == 8011 then
			local var_1_2 = DormData:GetCurrectSceneID()

			return DormData:GetSceneAttractiveValue(var_1_2), var_1_0.params[1]
		elseif var_1_0.type == 8012 then
			local var_1_3 = DormData:GetDormSceneData(var_1_0.params[1])

			if var_1_3 == nil then
				return 0, var_1_0.params[2]
			end

			return var_1_3.level, var_1_0.params[2]
		elseif var_1_0.type == 8013 then
			return 0, 1
		elseif var_1_0.type == 8014 then
			return DormData:GetFurnitureNum(var_1_0.params[1]), 1
		end

		return 0, 1
	end
}

function var_0_0.IsConditionOK(arg_2_0, arg_2_1)
	local var_2_0, var_2_1 = var_0_0.GetConditionProgress(arg_2_0, arg_2_1)

	return var_2_1 <= var_2_0
end

return var_0_0
