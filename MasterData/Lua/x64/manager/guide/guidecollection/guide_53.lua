local Guide_53 = class("Guide_53", BaseGuide)

function Guide_53:CheckGuide()
	if not GuideTool.SatisfyCondition(self.open_condition) then
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
		if CanteenFoodData:CheckIsSignFood(var_1_0[1]) then
			return false
		end

		for iter_1_2, iter_1_3 in ipairs(BackHomeCanteenFoodCfg[var_1_0[1]].ingredient_list) do
			if iter_1_3[2] > CanteenFoodData:GetCateenIngredientNum(iter_1_3[1]) then
				return false
			end
		end
	else
		return false
	end

	return true
end

return Guide_53
