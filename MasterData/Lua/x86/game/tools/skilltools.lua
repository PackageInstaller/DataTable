local var_0_0 = {}
local HeroConst = import("game.const.HeroConst")

function var_0_0.GetAstrolabeDescByServant(arg_1_0, arg_1_1)
	if not AstrolabeEffectCfg[arg_1_0] then
		print("id" .. arg_1_0 .. "没有配置")
	end

	if AstrolabeEffectCfg[arg_1_0] and AstrolabeEffectCfg[arg_1_0].desc and type(AstrolabeEffectCfg[arg_1_0].desc) == "table" then
		if not AstrolabeEffectCfg[arg_1_0].desc[1] then
			print("id" .. arg_1_0 .. "等级溢出" .. 1)

			return ""
		end

		local var_1_0 = AstrolabeEffectCfg[arg_1_0].desc[1]

		if arg_1_1 ~= 0 and AstrolabeEffectCfg[arg_1_0].equip_orange_desc and type(AstrolabeEffectCfg[arg_1_0].equip_orange_desc) == "table" then
			for iter_1_0, iter_1_1 in ipairs(AstrolabeEffectCfg[arg_1_0].equip_orange_desc) do
				if iter_1_1[1] == arg_1_1 then
					var_1_0 = iter_1_1[2]
				end
			end
		end

		return GetCfgDescription(var_1_0, 1)
	end

	return ""
end

function var_0_0.GetHeroIDBySkillID(arg_2_0)
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
	return table.indexof(HeroCfg[var_0_0.GetMainHeroId(arg_7_0)].skills, arg_7_0)
end

function var_0_0.GetIsCanUp(arg_8_0, arg_8_1)
	if var_0_0.GetIsPassiveSkill(arg_8_0) or arg_8_1 == HeroConst.MAX_SKILL_LEVEL or var_0_0.GetIsDodgeSkill(arg_8_0) then
		return false
	end

	local var_8_0 = var_0_0.GetMainHeroId(arg_8_0)
	local var_8_1 = table.indexof(HeroCfg[var_8_0].skills, arg_8_0)
	local var_8_2

	if SkillCfg[arg_8_1]["skill_limit" .. var_8_1] > HeroData:GetHeroData(var_8_0).break_level then
		do return false end

		var_8_2 = ItemTools.getItemNum(SkillCfg[arg_8_1]["skill_cost" .. var_8_1][1][1])
	end

	return var_8_2 > SkillCfg[arg_8_1]["skill_cost" .. var_8_1][1][2]
end

function var_0_0.GetIsCanUpNew(arg_9_0, arg_9_1, arg_9_2)
	if SkillTools.GetIsDodgeSkill(arg_9_0) then
		return false
	end

	local var_9_0 = HeroData:GetHeroData((var_0_0.GetMainHeroId(arg_9_0)))
	local var_9_1 = SkillTools.GetSkillIdIndex(arg_9_0)
	local var_9_2

	if not arg_9_2 then
		if SkillCfg[arg_9_1]["skill_limit" .. var_9_1] > var_9_0.break_level or arg_9_1 >= HeroConst.MAX_SKILL_LEVEL then
			return false
		end

		var_9_2 = SkillCfg[arg_9_1]["skill_cost" .. var_9_1]
	else
		if arg_9_1 < HeroConst.MAX_SKILL_LEVEL then
			return false
		end

		local var_9_3 = HeroTools.GetSkillAttrLv(var_9_0.id, var_9_1)

		if var_9_3 == HeroConst.MAX_SKILL_ATTR_LEVEL then
			return false
		end

		local var_9_4 = var_0_0.GetSkillAttrCfg(var_9_0.id, var_9_1, var_9_3 + 1)

		var_9_2 = var_9_4 and var_9_4.cost or nil

		if var_9_2 == nil or var_9_2 and #var_9_2 == 0 then
			return false
		end
	end

	local var_9_5 = true

	for iter_9_0 = 1, 2 do
		if var_9_2 and var_9_2[iter_9_0] and var_9_2[iter_9_0][2] > ItemTools.getItemNum(var_9_2[iter_9_0][1]) then
			var_9_5 = false

			break
		end
	end

	return var_9_5
end

function var_0_0.GetSkillUpCostNum(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = SkillTools.GetSkillIdIndex(arg_10_0)
	local var_10_1 = {}

	for iter_10_0 = 1, arg_10_2 do
		var_10_1[SkillCfg[arg_10_1 + iter_10_0 - 1]["skill_cost" .. var_10_0][1][1]] = (var_10_1[SkillCfg[arg_10_1 + iter_10_0 - 1]["skill_cost" .. var_10_0][1][1]] or 0) + SkillCfg[arg_10_1 + iter_10_0 - 1]["skill_cost" .. var_10_0][1][2]
	end

	return var_10_1
end

function var_0_0.GetSkillAttrUpCostNum(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = SkillTools.GetSkillIdIndex(arg_11_0)
	local var_11_1 = {}

	for iter_11_0 = 1, arg_11_3 do
		local var_11_2 = var_0_0.GetSkillAttrCfg(arg_11_1, var_11_0, arg_11_2 + iter_11_0)

		if var_11_2 then
			local var_11_3 = var_11_2.cost or nil

			if var_11_3 then
				for iter_11_1, iter_11_2 in pairs(var_11_3) do
					if iter_11_2[1] and iter_11_2[2] then
						var_11_1[iter_11_2[1]] = (var_11_1[iter_11_2[1]] or 0) + iter_11_2[2]
					end
				end
			end
		end
	end

	return var_11_1
end

function var_0_0.GetSkillMaxUpLv(arg_12_0, arg_12_1)
	local var_12_0 = HeroData:GetHeroData((var_0_0.GetMainHeroId(arg_12_0)))
	local var_12_1 = SkillTools.GetSkillIdIndex(arg_12_0)
	local var_12_2 = arg_12_1
	local var_12_3 = {}

	for iter_12_0 = arg_12_1 + 1, HeroConst.MAX_SKILL_LEVEL do
		if SkillCfg[iter_12_0 - 1]["skill_limit" .. var_12_1] > var_12_0.break_level then
			break
		end

		costCfg = SkillCfg[iter_12_0 - 1]["skill_cost" .. var_12_1]

		local var_12_4 = false

		for iter_12_1, iter_12_2 in pairs(costCfg) do
			local var_12_5 = var_12_3[iter_12_2[1]]

			if not var_12_3[iter_12_2[1]] then
				var_12_5 = ItemTools.getItemNum(iter_12_2[1])
				var_12_3[iter_12_2[1]] = var_12_5
			end

			if var_12_5 < iter_12_2[2] then
				var_12_4 = true

				break
			end

			var_12_3[iter_12_2[1]] = var_12_3[iter_12_2[1]] - iter_12_2[2]
		end

		if var_12_4 then
			break
		end

		var_12_2 = iter_12_0
	end

	return var_12_2
end

function var_0_0.GetSkillAttrMaxUpLv(arg_13_0, arg_13_1)
	local var_13_0 = HeroData:GetHeroData((var_0_0.GetMainHeroId(arg_13_0)))
	local var_13_1 = SkillTools.GetSkillIdIndex(arg_13_0)
	local var_13_2 = arg_13_1
	local var_13_3 = {}

	for iter_13_0 = arg_13_1 + 1, HeroConst.MAX_SKILL_ATTR_LEVEL do
		local var_13_4 = var_0_0.GetSkillAttrCfg(var_13_0.id, var_13_1, iter_13_0)
		local var_13_5

		if var_13_4 then
			var_13_5 = var_13_4.cost or nil
		end

		local var_13_6 = false

		for iter_13_1, iter_13_2 in pairs(var_13_5) do
			local var_13_7 = var_13_3[iter_13_2[1]]

			if not var_13_3[iter_13_2[1]] then
				var_13_7 = ItemTools.getItemNum(iter_13_2[1])
				var_13_3[iter_13_2[1]] = var_13_7
			end

			if var_13_7 < iter_13_2[2] then
				var_13_6 = true

				break
			end

			var_13_3[iter_13_2[1]] = var_13_3[iter_13_2[1]] - iter_13_2[2]
		end

		if var_13_6 then
			break
		end

		var_13_2 = iter_13_0
	end

	return var_13_2
end

function var_0_0.GetRealSkillIdByWeaponServantId(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2

	for iter_14_0, iter_14_1 in pairs(HeroCfg[arg_14_0].equip_orange_skill) do
		if iter_14_1[1] == arg_14_2 and arg_14_1 == iter_14_1[2] then
			var_14_0 = iter_14_1[3]
		end
	end

	return var_14_0
end

function var_0_0:GetAttr()
	return PublicAttrCfg[self[1]].name, PublicAttrCfg[self[1]].percent == 1 and string.format("%.2f%%", self[2] / 10) or string.format("%d", self[2]), (getSprite("Atlas/SystemCommonAtlas", PublicAttrCfg[self[1]].icon))
end

function var_0_0.GetSkillModuleDes(arg_16_0)
	local var_16_0 = getSkillAffectByModule(arg_16_0)
	local var_16_1 = var_0_0.GetHeroIDBySkillID(var_16_0)
	local var_16_2

	for iter_16_0, iter_16_1 in pairs(HeroCfg[var_16_1].skills) do
		if iter_16_1 == var_16_0 then
			var_16_2 = GetI18NText(HeroCfg[var_16_1].skill_subhead[iter_16_0])

			break
		end
	end

	local var_16_3 = GetI18NText(HeroSkillCfg[var_16_0].name)
	local var_16_4

	if HeroSkillCfg[var_16_0].strengthen_desc and HeroSkillCfg[var_16_0].strengthen_desc ~= "" then
		for iter_16_2, iter_16_3 in ipairs(HeroSkillCfg[var_16_0].strengthen_desc) do
			if iter_16_3[1] == arg_16_0 then
				var_16_4 = iter_16_3[2]
			end
		end
	end

	return string.format(GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_2"), var_16_2, var_16_3, var_0_0.GetSkillRate(HeroSkillCfg[var_16_0].desc[1]), var_0_0.GetSkillRate(var_16_4))
end

local function var_0_2(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if HeroSkillCfg[arg_17_3] == nil then
		return nil
	end

	local var_17_0 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_2")
	local var_17_1

	for iter_17_0, iter_17_1 in pairs(HeroCfg[arg_17_0].skills) do
		if iter_17_1 == arg_17_2 then
			var_17_1 = GetI18NText(HeroCfg[arg_17_0].skill_subhead[iter_17_0])

			break
		end
	end

	local var_17_2 = GetI18NText(HeroSkillCfg[arg_17_3].name)
	local var_17_3

	if HeroSkillCfg[arg_17_3].strengthen_desc and HeroSkillCfg[arg_17_3].strengthen_desc ~= "" then
		for iter_17_2, iter_17_3 in ipairs(HeroSkillCfg[arg_17_3].strengthen_desc) do
			if iter_17_3[1] == arg_17_1 then
				var_17_3 = iter_17_3[2]
			end
		end
	end

	return string.format(var_17_0, var_17_1, var_17_2, var_0_0.GetSkillRate(HeroSkillCfg[arg_17_3].desc[1]), var_0_0.GetSkillRate(var_17_3))
end

function var_0_0.GetServantSkillModuleDes(arg_18_0)
	local var_18_0 = getSkillAffectByModule(arg_18_0)
	local var_18_1 = var_0_0.GetHeroIDBySkillID(var_18_0)

	return var_0_2(var_18_1, arg_18_0, HeroCfg[var_18_1].equip_orange_skill[1][1], var_18_0)
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
	if not DescriptionCfg[arg_20_0] then
		return ""
	end

	local var_20_0

	if DescriptionCfg[arg_20_0].type == 1 then
		if #DescriptionCfg[arg_20_0].param >= 1 then
			for iter_20_0, iter_20_1 in ipairs(DescriptionCfg[arg_20_0].param) do
				local var_20_1 = iter_20_1[3]
				local var_20_2 = iter_20_1[1]

				var_20_2 = iter_20_1[1] % 1 == 0 and string.format("%.0f", var_20_2) .. iter_20_1[4] or string.format("%.1f", var_20_2) .. iter_20_1[4]

				if var_20_1 then
					var_20_0 = var_20_0 == nil and var_20_2 or var_20_0 .. "/" .. var_20_2
				end
			end
		end
	end

	return var_20_0 or ""
end

function var_0_0.CanUseComboSkill(arg_21_0, arg_21_1)
	if arg_21_0 == 0 then
		return true
	end

	for iter_21_0, iter_21_1 in ipairs(ComboSkillCfg[arg_21_0].cooperate_role_ids) do
		if not table.keyof(arg_21_1, iter_21_1) then
			return false
		end
	end

	return true
end

function var_0_0.GetSkillAttrCfg(arg_22_0, arg_22_1, arg_22_2)
	local var_22_1 = HeroSkillElementCfg[tonumber(arg_22_2 < 10 and string.format("%s0%s", arg_22_0, arg_22_2) or string.format("%s%s", arg_22_0, arg_22_2))]

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
			var_23_0[var_23_1.cost[1]] = (var_23_0[var_23_1.cost[1]] or 0) + var_23_1.cost[2]
		end
	end

	return var_23_0
end

return var_0_0
