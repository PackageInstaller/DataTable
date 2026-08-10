local var_0_0 = class("Guide_53", BaseGuide)

function var_0_0.CheckGuide(arg_1_0)
	if not GuideTool.SatisfyCondition(arg_1_0.open_condition) then
		return false
	end

	if (#CanteenFoodData:GetChooseFoodList() or 0) >= DormSkillData:GetCanSignFoodNum() then
		return false
	end

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(BackHomeCanteenFoodCfg.all) do
		if DormEnum.FurnitureTypeNum.Pan == BackHomeCanteenFoodCfg[iter_1_1].cook_type then
			if BackHomeCanteenFoodCfg[iter_1_1].unlock > 0 then
				if CanteenTools:CheckFoodUnLock(iter_1_1) then
					table.insert(var_1_0, iter_1_1)
				end
			else
				table.insert(var_1_0, iter_1_1)
			end
		end
	end

	CommonTools.UniversalSortEx(var_1_0, {
		map = function(arg_2_0)
			return arg_2_0
		end
	})

	if #var_1_0 > 0 then
		local var_1_1 = var_1_0[1]

		if CanteenFoodData:CheckIsSignFood(var_1_1) then
			return false
		end

		local var_1_2 = BackHomeCanteenFoodCfg[var_1_1].ingredient_list

		for iter_1_2, iter_1_3 in ipairs(var_1_2) do
			if iter_1_3[2] > CanteenFoodData:GetCateenIngredientNum(iter_1_3[1]) then
				return false
			end
		end
	else
		return false
	end

	return true
end

return var_0_0
