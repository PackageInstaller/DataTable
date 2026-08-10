local var_0_0 = {}
local var_0_1 = {
	{
		lv = 20,
		weaponservant = 20,
		skill = 5,
		equip = 20
	},
	{
		lv = 30,
		weaponservant = 20,
		skill = 10,
		equip = 20
	},
	{
		lv = 40,
		weaponservant = 30,
		skill = 15,
		equip = 20
	},
	{
		lv = 50,
		weaponservant = 40,
		skill = 20,
		equip = 30
	},
	{
		lv = 60,
		weaponservant = 50,
		skill = 25,
		equip = 40
	},
	{
		lv = 60,
		weaponservant = 50,
		skill = 25,
		equip = 60
	},
	{
		lv = 70,
		weaponservant = 60,
		skill = 30,
		equip = 60
	},
	{
		lv = 80,
		weaponservant = 60,
		skill = 50,
		equip = 60
	},
	{
		lv = 100,
		weaponservant = 60,
		skill = 50,
		equip = 60
	}
}

function var_0_0.GetHeroLvCfg(arg_1_0)
	if arg_1_0 < 20 then
		return var_0_1[1]
	elseif arg_1_0 >= 20 and arg_1_0 <= 49 then
		local var_1_0 = math.floor(arg_1_0 / 10)

		return var_0_1[var_1_0]
	elseif arg_1_0 >= 50 and arg_1_0 <= 54 then
		return var_0_1[5]
	elseif arg_1_0 >= 55 and arg_1_0 <= 59 then
		return var_0_1[6]
	elseif arg_1_0 >= 60 and arg_1_0 <= 79 then
		local var_1_1 = math.floor(arg_1_0 / 10) + 1

		return var_0_1[var_1_1]
	elseif arg_1_0 >= 80 then
		return var_0_1[9]
	end
end

function var_0_0.GetHeroLv(arg_2_0)
	local var_2_0 = 0

	return HeroData:GetHeroData(arg_2_0).level
end

function var_0_0.GetHeroLvSchedule(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0.GetHeroLvCfg(arg_3_1)
	local var_3_1 = 0
	local var_3_2 = var_3_0.lv * 3

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		if iter_3_1 > 0 then
			var_3_1 = var_3_1 + var_0_0.GetHeroLv(iter_3_1)

			local var_3_3 = HeroCfg[iter_3_1].race
		end
	end

	return var_3_1 / var_3_2 * 0.4
end

function var_0_0.GetWeaponServantLv(arg_4_0)
	local var_4_0 = 0

	return HeroData:GetHeroData(arg_4_0).weapon_info.level
end

function var_0_0.GetWeaponLvSchedule(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.GetHeroLvCfg(arg_5_1)
	local var_5_1 = 0
	local var_5_2 = var_5_0.weaponservant * 3

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		if iter_5_1 > 0 then
			var_5_1 = var_5_1 + var_0_0.GetWeaponServantLv(iter_5_1)
		end
	end

	return var_5_1 / var_5_2 * 0.3
end

function var_0_0.GetSkillLv(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = HeroData:GetHeroData(arg_6_0).skill

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if iter_6_0 <= 5 then
			local var_6_2 = SkillTools.GetSkillIdIndex(iter_6_1.skill_id)
			local var_6_3 = HeroTools.GetSkillAttrLv(arg_6_0, var_6_2)

			var_6_0 = var_6_0 + iter_6_1.skill_level + var_6_3
		end
	end

	return var_6_0
end

function var_0_0.GetSkillLvSchedule(arg_7_0, arg_7_1)
	local var_7_0 = var_0_0.GetHeroLvCfg(arg_7_1)
	local var_7_1 = 0
	local var_7_2 = var_7_0.skill * 5 * 3

	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		if iter_7_1 > 0 then
			var_7_1 = var_7_1 + var_0_0.GetSkillLv(iter_7_1)
		end
	end

	return var_7_1 / var_7_2 * 0.3
end

function var_0_0.GetEquipLv(arg_8_0)
	local var_8_0 = 0
	local var_8_1 = HeroData:GetHeroData(arg_8_0).equip

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if iter_8_1.equip_id > 0 then
			var_8_0 = var_8_0 + EquipData:GetEquipData(iter_8_1.equip_id):GetLevel()
		end
	end

	return var_8_0
end

function var_0_0.GetEquipStrengthSchedule(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.GetHeroLvCfg(arg_9_1)
	local var_9_1 = 0
	local var_9_2 = var_9_0.equip * 6 * 3

	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		if iter_9_1 > 0 then
			var_9_1 = var_9_1 + var_0_0.GetEquipLv(iter_9_1)
		end
	end

	return var_9_1 / var_9_2 * 0.4
end

function var_0_0.GetEquipRebuild(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = HeroData:GetHeroData(arg_10_0).equip

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if iter_10_1.equip_id > 0 then
			local var_10_2 = EquipData:GetEquipData(iter_10_1.equip_id)

			if var_10_2.race == 0 then
				var_10_0 = var_10_0 + 0
			elseif table.keyof(RaceEffectCfg.all, var_10_2.race) == nil then
				var_10_0 = var_10_0 + 5
			else
				var_10_0 = var_10_0 + 1
			end
		end
	end

	return var_10_0
end

function var_0_0.GetEquipReBuildSchedule(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = 90

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		if iter_11_1 > 0 then
			var_11_0 = var_11_0 + var_0_0.GetEquipRebuild(iter_11_1)
		end
	end

	return var_11_0 / var_11_1 * 0.2
end

function var_0_0.GetEquipEnchant(arg_12_0)
	local var_12_0 = 0
	local var_12_1 = HeroData:GetHeroData(arg_12_0)
	local var_12_2 = var_12_1.equip

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		if iter_12_1.equip_id > 0 then
			local var_12_3 = EquipData:GetEquipData(iter_12_1.equip_id).enchant

			var_12_0 = var_12_0 + var_0_0.GetEnchantLv(var_12_3, arg_12_0)
		end
	end

	local var_12_4 = EquipTools.GetEquipDataList(var_12_2)
	local var_12_5, var_12_6, var_12_7 = EquipTools.CountHeroTotalSkill(var_12_4, var_12_1, true)
	local var_12_8 = 0

	for iter_12_2, iter_12_3 in pairs(var_12_5) do
		local var_12_9 = EquipSkillCfg[iter_12_2]

		if iter_12_3 > var_12_9.lvmax then
			local var_12_10 = iter_12_3 - var_12_9.lvmax

			var_12_8 = var_12_8 + var_0_0.GetEnchantCoefficient(iter_12_2, arg_12_0) * var_12_10
		end
	end

	return var_12_0 - var_12_8
end

function var_0_0.GetEnchantLv(arg_13_0, arg_13_1)
	local var_13_0 = 0

	if arg_13_0 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
			for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
				var_13_0 = var_0_0.GetEnchantCoefficient(iter_13_3.id, arg_13_1) + var_13_0
			end
		end
	end

	return var_13_0
end

function var_0_0.GetEnchantCoefficient(arg_14_0, arg_14_1)
	local var_14_0 = HeroCfg[arg_14_1].recommend_equip_skill

	if var_14_0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
				if iter_14_3 == arg_14_0 and iter_14_0 == 1 then
					return 5
				elseif iter_14_3 == arg_14_0 and iter_14_0 == 3 then
					return 3
				end
			end
		end
	end

	return 1
end

function var_0_0.GetEquipEnchantSchedule(arg_15_0, arg_15_1)
	local var_15_0 = 0
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0) do
		if iter_15_1 > 0 then
			var_15_0 = var_15_0 + var_0_0.GetEquipEnchant(iter_15_1)
		end

		var_15_1 = var_15_1 + var_0_0.GetEquipEnchantMaxByHeroStar(iter_15_1)
	end

	return var_15_0 / var_15_1 * 0.4
end

function var_0_0.GetEquipEnchantMaxByHeroStar(arg_16_0)
	if arg_16_0 > 0 and HeroData:GetHeroData(arg_16_0).star >= 500 then
		return 95
	end

	return 120
end

function var_0_0.GetTransitionLv(arg_17_0)
	local var_17_0 = 0
	local var_17_1 = HeroData:GetHeroTransitionInfoList(arg_17_0)

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1.skill_list) do
			var_17_0 = var_17_0 + iter_17_3.skill_level
		end
	end

	return var_17_0
end

function var_0_0.GetTransitionSkillSchedule(arg_18_0)
	local var_18_0 = 0
	local var_18_1 = 108

	for iter_18_0, iter_18_1 in ipairs(arg_18_0) do
		if iter_18_1 > 0 then
			var_18_0 = var_18_0 + var_0_0.GetTransitionLv(iter_18_1)
		end
	end

	return var_18_0 / var_18_1
end

return var_0_0
