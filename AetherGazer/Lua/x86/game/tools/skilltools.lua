local var_0_0 = {}
local var_0_1 = import("game.const.HeroConst")

function var_0_0.GetAstrolabeDescByServant(arg_1_0, arg_1_1)
	local var_1_0 = AstrolabeEffectCfg[arg_1_0]

	if not var_1_0 then
		print("id" .. arg_1_0 .. "没有配置")
	end

	if var_1_0 and var_1_0.desc and type(var_1_0.desc) == "table" then
		if not var_1_0.desc[1] then
			print("id" .. arg_1_0 .. "等级溢出" .. 1)

			return ""
		end

		local var_1_1 = var_1_0.desc[1]

		if arg_1_1 ~= 0 and var_1_0.equip_orange_desc and type(var_1_0.equip_orange_desc) == "table" then
			for iter_1_0, iter_1_1 in ipairs(var_1_0.equip_orange_desc) do
				if iter_1_1[1] == arg_1_1 then
					var_1_1 = iter_1_1[2]
				end
			end
		end

		return GetCfgDescription(var_1_1, 1)
	end

	return ""
end

function var_0_0.GetHeroIDBySkillID(arg_2_0)
	local var_2_0

	while arg_2_0 > 9999 do
		arg_2_0 = arg_2_0 / 10
	end

	return (math.modf(arg_2_0))
end

function var_0_0.GetIsDodgeSkill(arg_3_0)
	return arg_3_0 % 1000 == 305
end

function var_0_0.GetIsPassiveSkill(arg_4_0)
	return arg_4_0 % 1000 == 999
end

function var_0_0.GetIsMelee(arg_5_0)
	return arg_5_0 % 1000 < 200
end

function var_0_0.GetMainHeroId(arg_6_0)
	return math.floor(arg_6_0 / 1000)
end

function var_0_0.GetSkillIdIndex(arg_7_0)
	local var_7_0 = var_0_0.GetMainHeroId(arg_7_0)
	local var_7_1 = HeroCfg[var_7_0]

	return table.indexof(var_7_1.skills, arg_7_0)
end

function var_0_0.GetIsCanUp(arg_8_0, arg_8_1)
	if var_0_0.GetIsPassiveSkill(arg_8_0) or arg_8_1 == var_0_1.MAX_SKILL_LEVEL or var_0_0.GetIsDodgeSkill(arg_8_0) then
		return false
	end

	local var_8_0 = var_0_0.GetMainHeroId(arg_8_0)
	local var_8_1 = HeroCfg[var_8_0]
	local var_8_2 = HeroData:GetHeroData(var_8_0)
	local var_8_3 = table.indexof(var_8_1.skills, arg_8_0)

	if SkillCfg[arg_8_1]["skill_limit" .. var_8_3] > var_8_2.break_level then
		return false
	end

	local var_8_4 = SkillCfg[arg_8_1]["skill_cost" .. var_8_3][1]

	return ItemTools.getItemNum(var_8_4[1]) > var_8_4[2]
end

function var_0_0.GetIsCanUpNew(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0

	if SkillTools.GetIsDodgeSkill(var_9_0) then
		return false
	end

	local var_9_1 = var_0_0.GetMainHeroId(var_9_0)
	local var_9_2 = HeroData:GetHeroData(var_9_1)
	local var_9_3 = arg_9_1
	local var_9_4 = SkillTools.GetSkillIdIndex(var_9_0)
	local var_9_5

	if not arg_9_2 then
		if SkillCfg[var_9_3]["skill_limit" .. var_9_4] > var_9_2.break_level or var_9_3 >= var_0_1.MAX_SKILL_LEVEL then
			return false
		end

		var_9_5 = SkillCfg[var_9_3]["skill_cost" .. var_9_4]
	else
		if var_9_3 < var_0_1.MAX_SKILL_LEVEL then
			return false
		end

		local var_9_6 = HeroTools.GetSkillAttrLv(var_9_2.id, var_9_4)

		if var_9_6 == var_0_1.MAX_SKILL_ATTR_LEVEL then
			return false
		end

		local var_9_7 = var_0_0.GetSkillAttrCfg(var_9_2.id, var_9_4, var_9_6 + 1)

		var_9_5 = var_9_7 and var_9_7.cost or nil

		if var_9_5 == nil or var_9_5 and #var_9_5 == 0 then
			return false
		end
	end

	local var_9_8 = true

	for iter_9_0 = 1, 2 do
		if var_9_5 and var_9_5[iter_9_0] then
			local var_9_9 = var_9_5[iter_9_0][1]

			if var_9_5[iter_9_0][2] > ItemTools.getItemNum(var_9_9) then
				var_9_8 = false

				break
			end
		end
	end

	return var_9_8
end

function var_0_0.GetSkillUpCostNum(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = SkillTools.GetSkillIdIndex(arg_10_0)
	local var_10_1 = {}

	for iter_10_0 = 1, arg_10_2 do
		local var_10_2 = SkillCfg[arg_10_1 + iter_10_0 - 1]["skill_cost" .. var_10_0][1]

		var_10_1[var_10_2[1]] = (var_10_1[var_10_2[1]] or 0) + var_10_2[2]
	end

	return var_10_1
end

function var_0_0.GetSkillAttrUpCostNum(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = SkillTools.GetSkillIdIndex(arg_11_0)
	local var_11_1 = {}

	for iter_11_0 = 1, arg_11_3 do
		local var_11_2 = var_0_0.GetSkillAttrCfg(arg_11_1, var_11_0, arg_11_2 + iter_11_0)
		local var_11_3 = var_11_2 and var_11_2.cost or nil

		if var_11_3 then
			for iter_11_1, iter_11_2 in pairs(var_11_3) do
				local var_11_4 = iter_11_2[1]
				local var_11_5 = iter_11_2[2]

				if var_11_4 and var_11_5 then
					var_11_1[var_11_4] = (var_11_1[var_11_4] or 0) + var_11_5
				end
			end
		end
	end

	return var_11_1
end

function var_0_0.GetSkillMaxUpLv(arg_12_0, arg_12_1)
	local var_12_0 = var_0_0.GetMainHeroId(arg_12_0)
	local var_12_1 = HeroData:GetHeroData(var_12_0)
	local var_12_2 = SkillTools.GetSkillIdIndex(arg_12_0)
	local var_12_3 = arg_12_1
	local var_12_4 = {}

	for iter_12_0 = arg_12_1 + 1, var_0_1.MAX_SKILL_LEVEL do
		if SkillCfg[iter_12_0 - 1]["skill_limit" .. var_12_2] > var_12_1.break_level then
			break
		end

		costCfg = SkillCfg[iter_12_0 - 1]["skill_cost" .. var_12_2]

		local var_12_5 = false

		for iter_12_1, iter_12_2 in pairs(costCfg) do
			local var_12_6 = iter_12_2[1]
			local var_12_7 = iter_12_2[2]
			local var_12_8 = var_12_4[var_12_6]

			if not var_12_8 then
				var_12_8 = ItemTools.getItemNum(var_12_6)
				var_12_4[var_12_6] = var_12_8
			end

			if var_12_8 < var_12_7 then
				var_12_5 = true

				break
			end

			var_12_4[var_12_6] = var_12_4[var_12_6] - var_12_7
		end

		if var_12_5 then
			break
		end

		var_12_3 = iter_12_0
	end

	return var_12_3
end

function var_0_0.GetSkillAttrMaxUpLv(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0.GetMainHeroId(arg_13_0)
	local var_13_1 = HeroData:GetHeroData(var_13_0)
	local var_13_2 = SkillTools.GetSkillIdIndex(arg_13_0)
	local var_13_3 = arg_13_1
	local var_13_4 = {}

	for iter_13_0 = arg_13_1 + 1, var_0_1.MAX_SKILL_ATTR_LEVEL do
		local var_13_5 = var_0_0.GetSkillAttrCfg(var_13_1.id, var_13_2, iter_13_0)
		local var_13_6 = var_13_5 and var_13_5.cost or nil
		local var_13_7 = false

		for iter_13_1, iter_13_2 in pairs(var_13_6) do
			local var_13_8 = iter_13_2[1]
			local var_13_9 = iter_13_2[2]
			local var_13_10 = var_13_4[var_13_8]

			if not var_13_10 then
				var_13_10 = ItemTools.getItemNum(var_13_8)
				var_13_4[var_13_8] = var_13_10
			end

			if var_13_10 < var_13_9 then
				var_13_7 = true

				break
			end

			var_13_4[var_13_8] = var_13_4[var_13_8] - var_13_9
		end

		if var_13_7 then
			break
		end

		var_13_3 = iter_13_0
	end

	return var_13_3
end

function var_0_0.GetRealSkillIdByWeaponServantId(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = HeroCfg[arg_14_0]
	local var_14_1 = arg_14_2

	for iter_14_0, iter_14_1 in pairs(var_14_0.equip_orange_skill) do
		if iter_14_1[1] == arg_14_2 and arg_14_1 == iter_14_1[2] then
			var_14_1 = iter_14_1[3]
		end
	end

	return var_14_1
end

function var_0_0.GetAttr(arg_15_0)
	local var_15_0 = PublicAttrCfg[arg_15_0[1]].name
	local var_15_1

	if PublicAttrCfg[arg_15_0[1]].percent == 1 then
		var_15_1 = string.format("%.2f%%", arg_15_0[2] / 10)
	else
		var_15_1 = string.format("%d", arg_15_0[2])
	end

	local var_15_2 = getSprite("Atlas/SystemCommonAtlas", PublicAttrCfg[arg_15_0[1]].icon)

	return var_15_0, var_15_1, var_15_2
end

function var_0_0.GetSkillModuleDes(arg_16_0)
	local var_16_0 = getSkillAffectByModule(arg_16_0)
	local var_16_1 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_2")
	local var_16_2 = var_0_0.GetHeroIDBySkillID(var_16_0)
	local var_16_3

	for iter_16_0, iter_16_1 in pairs(HeroCfg[var_16_2].skills) do
		if iter_16_1 == var_16_0 then
			var_16_3 = GetI18NText(HeroCfg[var_16_2].skill_subhead[iter_16_0])

			break
		end
	end

	local var_16_4 = GetI18NText(HeroSkillCfg[var_16_0].name)
	local var_16_5 = HeroSkillCfg[var_16_0].desc[1]
	local var_16_6
	local var_16_7 = HeroSkillCfg[var_16_0].strengthen_desc

	if var_16_7 and var_16_7 ~= "" then
		for iter_16_2, iter_16_3 in ipairs(var_16_7) do
			if iter_16_3[1] == arg_16_0 then
				var_16_6 = iter_16_3[2]
			end
		end
	end

	return string.format(var_16_1, var_16_3, var_16_4, var_0_0.GetSkillRate(var_16_5), var_0_0.GetSkillRate(var_16_6))
end

local function var_0_2(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = HeroSkillCfg[arg_17_3]

	if var_17_0 == nil then
		return nil
	end

	local var_17_1 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_2")
	local var_17_2

	for iter_17_0, iter_17_1 in pairs(HeroCfg[arg_17_0].skills) do
		if iter_17_1 == arg_17_2 then
			var_17_2 = GetI18NText(HeroCfg[arg_17_0].skill_subhead[iter_17_0])

			break
		end
	end

	local var_17_3 = GetI18NText(var_17_0.name)
	local var_17_4 = var_17_0.desc[1]
	local var_17_5 = var_17_0.strengthen_desc
	local var_17_6

	if var_17_5 and var_17_5 ~= "" then
		for iter_17_2, iter_17_3 in ipairs(var_17_5) do
			if iter_17_3[1] == arg_17_1 then
				var_17_6 = iter_17_3[2]
			end
		end
	end

	return string.format(var_17_1, var_17_2, var_17_3, var_0_0.GetSkillRate(var_17_4), var_0_0.GetSkillRate(var_17_6))
end

function var_0_0.GetServantSkillModuleDes(arg_18_0)
	local var_18_0 = getSkillAffectByModule(arg_18_0)
	local var_18_1 = var_0_0.GetHeroIDBySkillID(var_18_0)
	local var_18_2 = HeroCfg[var_18_1].equip_orange_skill[1][1]

	return var_0_2(var_18_1, arg_18_0, var_18_2, var_18_0)
end

function var_0_0.GetAstrolabeSkillModuleDes(arg_19_0)
	local var_19_0 = getSkillAffectByModule(arg_19_0)
	local var_19_1 = var_0_0.GetHeroIDBySkillID(var_19_0)
	local var_19_2

	for iter_19_0, iter_19_1 in ipairs(HeroCfg[var_19_1].astrolabe_skill) do
		if var_19_0 == iter_19_1[3] then
			var_19_2 = iter_19_1[1]
		end
	end

	return var_0_2(var_19_1, arg_19_0, var_19_2, var_19_0)
end

function var_0_0.GetSkillRate(arg_20_0)
	local var_20_0 = DescriptionCfg[arg_20_0]

	if not var_20_0 then
		return ""
	end

	local var_20_1

	if var_20_0.type == 1 then
		local var_20_2 = var_20_0.param

		if #var_20_2 >= 1 then
			for iter_20_0, iter_20_1 in ipairs(var_20_2) do
				local var_20_3 = iter_20_1[1]
				local var_20_4 = iter_20_1[3]
				local var_20_5 = iter_20_1[4]
				local var_20_6 = var_20_3

				if var_20_6 % 1 == 0 then
					var_20_6 = string.format("%.0f", var_20_6) .. var_20_5
				else
					var_20_6 = string.format("%.1f", var_20_6) .. var_20_5
				end

				if var_20_4 then
					if var_20_1 == nil then
						var_20_1 = var_20_6
					else
						var_20_1 = var_20_1 .. "/" .. var_20_6
					end
				end
			end
		end
	end

	return var_20_1 or ""
end

function var_0_0.CanUseComboSkill(arg_21_0, arg_21_1)
	if arg_21_0 == 0 then
		return true
	end

	local var_21_0 = ComboSkillCfg[arg_21_0]

	for iter_21_0, iter_21_1 in ipairs(var_21_0.cooperate_role_ids) do
		if not table.keyof(arg_21_1, iter_21_1) then
			return false
		end
	end

	return true
end

function var_0_0.GetSkillAttrCfg(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0

	if arg_22_2 < 10 then
		var_22_0 = string.format("%s0%s", arg_22_0, arg_22_2)
	else
		var_22_0 = string.format("%s%s", arg_22_0, arg_22_2)
	end

	local var_22_1 = HeroSkillElementCfg[tonumber(var_22_0)]

	if var_22_1 then
		return {
			cost = var_22_1["skill_element_cost" .. arg_22_1],
			attr = var_22_1["skill_element_attr" .. arg_22_1]
		}
	end

	return nil
end

function var_0_0.GetSkillAttrCost(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = {}

	for iter_23_0 = 1, arg_23_3 do
		local var_23_1 = var_0_0.GetSkillAttrCfg(arg_23_0, arg_23_1, arg_23_2 + iter_23_0 - 1)

		if var_23_1 then
			local var_23_2 = var_23_1.cost

			var_23_0[var_23_2[1]] = (var_23_0[var_23_2[1]] or 0) + var_23_2[2]
		end
	end

	return var_23_0
end

return var_0_0
