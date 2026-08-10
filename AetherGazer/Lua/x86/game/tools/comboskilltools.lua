local var_0_0 = {}
local var_0_1

local function var_0_2()
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(ComboSkillCfg.all) do
		local var_1_1 = ComboSkillCfg[iter_1_1]

		if not var_0_0.GetIsHide(iter_1_1) then
			for iter_1_2, iter_1_3 in ipairs(var_1_1.cooperate_role_ids) do
				var_1_0[iter_1_3] = var_1_0[iter_1_3] or {}

				table.insert(var_1_0[iter_1_3], var_1_1.id)
			end
		end
	end

	for iter_1_4, iter_1_5 in ipairs(var_1_0) do
		table.sort(iter_1_5, var_0_0.RuleSort)
	end

	return var_1_0
end

function var_0_0.InitComboList()
	var_0_1 = var_0_2()
end

function var_0_0.GetIsHide(arg_3_0)
	local var_3_0 = ComboSkillCfg[arg_3_0]

	for iter_3_0, iter_3_1 in ipairs(var_3_0.cooperate_role_ids) do
		if HeroTools.GetIsHide(iter_3_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetHeroComboSkill(arg_4_0)
	if var_0_1 == nil then
		var_0_0.InitComboList()
	end

	return var_0_1[arg_4_0]
end

local function var_0_3(arg_5_0, arg_5_1)
	local var_5_0 = 0
	local var_5_1 = {}
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		var_5_1[iter_5_1] = true
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
		if var_5_1[iter_5_3] then
			var_5_0 = var_5_0 + 1
		else
			table.insert(var_5_2, iter_5_3)
		end
	end

	return var_5_0 >= #arg_5_1, var_5_0 > 0, var_5_2
end

function var_0_0.IsAllMatch(arg_6_0, arg_6_1)
	local var_6_0 = ComboSkillCfg[arg_6_0]
	local var_6_1, var_6_2 = var_0_3(arg_6_1, var_6_0.cooperate_role_ids)

	return var_6_1
end

local function var_0_4(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		if HeroTools.GetIsHide(iter_7_1) then
			return true
		end
	end

	return false
end

function var_0_0.GroupByMatchFromHeroListComboSkills(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(ComboSkillCfg.all) do
		local var_8_2 = ComboSkillCfg[iter_8_1]
		local var_8_3, var_8_4, var_8_5 = var_0_3(arg_8_0, var_8_2.cooperate_role_ids)

		if var_8_3 then
			var_8_0[iter_8_1] = true
		elseif var_8_4 and not var_0_4(var_8_5) then
			var_8_1[iter_8_1] = true
		end
	end

	return var_8_0, var_8_1
end

function var_0_0.GetComboSkillLevel(arg_9_0)
	local var_9_0 = ComboSkillCfg[arg_9_0]
	local var_9_1 = GameSetting.hero_combo_skill_relate.value[1]
	local var_9_2 = 0

	for iter_9_0, iter_9_1 in ipairs(var_9_0.cooperate_role_ids) do
		if HeroData:GetHeroList()[iter_9_1].unlock == 0 then
			break
		end

		var_9_2 = var_9_2 + HeroTools.GetTotalSkillLv(iter_9_1, HeroCfg[iter_9_1].skills[var_9_1])
	end

	local var_9_3 = math.floor(var_9_2 / #var_9_0.cooperate_role_ids)

	return var_9_3 > 0 and var_9_3 or 1
end

function var_0_0.GetMatrixComboSkillLevel(arg_10_0, arg_10_1)
	local var_10_0 = ComboSkillCfg[arg_10_0]
	local var_10_1 = GameSetting.hero_combo_skill_relate.value[1]
	local var_10_2 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0.cooperate_role_ids) do
		local var_10_3 = MatrixData:GetHeroData(iter_10_1)

		var_10_2 = var_10_2 + HeroStandardSystemCfg[var_10_3:GetStandardId()].skill_lv
	end

	local var_10_4 = math.floor(var_10_2 / #var_10_0.cooperate_role_ids)

	return var_10_4 > 0 and var_10_4 or 1
end

function var_0_0.GetComboSkillList(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1, var_11_2 = var_0_0.GroupByMatchFromHeroListComboSkills(arg_11_0)
	local var_11_3 = {}

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		table.insert(var_11_3, iter_11_0)
	end

	table.sort(var_11_3, function(arg_12_0, arg_12_1)
		if arg_12_0 == arg_12_1 then
			return false
		end

		local var_12_0 = #ComboSkillCfg[arg_12_0].cooperate_role_ids
		local var_12_1 = #ComboSkillCfg[arg_12_1].cooperate_role_ids

		if var_12_0 == var_12_1 then
			if table.keyof(ComboSkillCfg[arg_12_0].cooperate_role_ids, arg_11_0[1]) then
				if table.keyof(ComboSkillCfg[arg_12_0].cooperate_role_ids, arg_11_0[2]) then
					return true
				end

				return false
			else
				return false
			end
		end

		return var_12_1 < var_12_0
	end)
	table.insertto(var_11_0, var_11_3)

	for iter_11_2, iter_11_3 in pairs(var_11_2) do
		table.insert(var_11_0, iter_11_2)
	end

	table.insert(var_11_0, 0)

	return var_11_0, var_11_3
end

function var_0_0.RuleSort(arg_13_0, arg_13_1)
	return #ComboSkillCfg[arg_13_0].cooperate_role_ids > #ComboSkillCfg[arg_13_1].cooperate_role_ids
end

function var_0_0.GetRecommendSkillID(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = var_0_0.GetComboSkillList(arg_14_0, arg_14_1)

	return var_14_1[1] or 0
end

function var_0_0.CheckError(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0 == 0 then
		return 0
	end

	if not arg_15_0 or not var_0_0.IsAllMatch(arg_15_0, arg_15_1) then
		return var_0_0.GetRecommendSkillID(arg_15_1, arg_15_2)
	end

	return arg_15_0
end

function var_0_0.GetMaxComboSkillLevel(arg_16_0)
	return 3
end

function var_0_0.CheckComboSkillUpContion(arg_17_0, arg_17_1)
	local var_17_0 = ComboSkillLevelCfg[arg_17_0]
	local var_17_1 = var_17_0.target

	if var_17_0.condition_type == 1 then
		local var_17_2 = ComboSkillCfg[arg_17_1]
		local var_17_3

		for iter_17_0, iter_17_1 in ipairs(var_17_2.cooperate_role_ids) do
			local var_17_4 = GameSetting.hero_combo_skill_relate.value[1]
			local var_17_5 = HeroTools.GetTotalSkillLv(iter_17_1, HeroCfg[iter_17_1].skills[var_17_4])

			if var_17_3 == nil or var_17_5 < var_17_3 then
				var_17_3 = var_17_5
			end
		end

		return var_17_1 <= var_17_3, math.min(var_17_3, var_17_1), var_17_1
	else
		local var_17_6 = ComboSkillData:GetComboSkillUpConditionProcess(arg_17_1, arg_17_0)
		local var_17_7 = math.min(var_17_6, var_17_1)

		return var_17_1 <= var_17_6, var_17_7, var_17_1
	end
end

return var_0_0
