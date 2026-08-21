local var_0_0 = singletonClass("TempHeroData", BaseHeroViewData)
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.GetHeroList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if not var_0_1[iter_2_1] then
			arg_2_0:GetTempHeroDataByTempID(iter_2_1)
		end

		var_2_0[iter_2_1] = var_0_1[iter_2_1]
	end

	return var_2_0
end

function var_0_0.GetTempHeroDataByTempID(arg_3_0, arg_3_1)
	if var_0_1[arg_3_1] then
		return var_0_1[arg_3_1]
	end

	local var_3_0 = HeroStandardSystemCfg[arg_3_1]
	local var_3_1 = SkinCfg[var_3_0.skin_id].hero

	var_0_1[arg_3_1] = TemplateHeroDataTemplate.New(var_3_1)

	var_0_1[arg_3_1]:Init(var_3_0)

	return var_0_1[arg_3_1]
end

function var_0_0.GetTempHeroList(arg_4_0, arg_4_1)
	local var_4_0
	local var_4_1
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_3 = HeroStandardSystemCfg[iter_4_1]

		if var_4_3 then
			local var_4_4 = SkinCfg[var_4_3.hero_id].hero

			table.insert(var_4_2, var_4_4)
		end
	end

	return var_4_2
end

function var_0_0.GetHeroData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_1 = arg_5_0:GetTempHeroDataByTempID(iter_5_1)

		if var_5_1.id == arg_5_1 then
			return var_5_1
		end
	end

	return {}
end

function var_0_0.GetBattlePower(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetTempHeroDataByTempID(arg_6_1)

	return calcBattlePower(var_6_0, var_6_0.servantInfo, var_6_0.equip_list, arg_6_1)
end

function var_0_0.GetEquipInfoList(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0:GetHeroData(arg_7_1, arg_7_2):GetEquipInfoList()
end

function var_0_0.GetEquipDataList(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0:GetHeroData(arg_8_1, arg_8_2).equip_list
end

function var_0_0.GetHeroWeaponInfo(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0:GetHeroData(arg_9_1, arg_9_2).weapon_info
end

function var_0_0.GetHeroUsingSkinInfo(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:GetHeroData(arg_10_1, arg_10_2)
	local var_10_1 = var_10_0 and var_10_0.using_skin or 0

	if var_10_1 == 0 then
		var_10_1 = arg_10_1
	end

	return SkinCfg[var_10_1]
end

function var_0_0.GetHeroBattleUsingSkinInfo(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:GetHeroData(arg_11_1, arg_11_2)
	local var_11_1 = var_11_0 and var_11_0.battle_using_skin or 0

	if var_11_1 == 0 then
		var_11_1 = arg_11_1
	end

	return SkinCfg[var_11_1]
end

function var_0_0.GetHeroServantInfo(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0:GetHeroData(arg_12_1, arg_12_2):GetServantInfo()
end

function var_0_0.GetHeroSkillInfoList(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0:GetHeroData(arg_13_1, arg_13_2):GetSkillInfoList()
end

function var_0_0.GetHeroTransitionInfoList(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0:GetHeroData(arg_14_1, arg_14_2):GetTransitionInfoList()
end

function var_0_0.GetHeroName(arg_15_0, arg_15_1)
	return HeroCfg[arg_15_1].suffix
end

function var_0_0.HasCustomNickName(arg_16_0, arg_16_1)
	return false
end

function var_0_0.IsHeroOath(arg_17_0, arg_17_1)
	return false
end

return var_0_0
