local var_0_0 = singletonClass("HodurGameTempHeroData", BaseHeroViewData)

function var_0_0.Init(arg_1_0)
	arg_1_0.cacheHeroList_ = {}
	arg_1_0.trialList_ = {}
	arg_1_0.reserveHeroList = {}
end

function var_0_0:GetHeroData(arg_2_1)
	return self.cacheHeroList_[arg_2_1]
end

function var_0_0:GetCacheHeroList()
	return self.cacheHeroList_
end

function var_0_0:ModifyAllHeroInfo()
	local var_4_0 = GetTrialHeroList(BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE, nil, ActivityConst.ACTIVITY_HODUR_MAIN)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if HeroStandardSystemCfg[iter_4_1] then
			table.insert(var_4_1, HeroStandardSystemCfg[iter_4_1].hero_id)
		end
	end

	for iter_4_2, iter_4_3 in pairs(HeroData.GetUnlockHeros()) do
		local var_4_2 = deepClone(HeroData:GetHeroData(iter_4_3))

		var_4_2.equip_list = deepClone(HeroData:GetEquipDataList(var_4_2.id))

		local var_4_3 = HodurHeroDataTemplate.New(iter_4_3)

		var_4_3:Init(var_4_2)
		self:ModifyHeroInfo(var_4_3)

		self.cacheHeroList_[var_4_2.id] = var_4_3
	end

	for iter_4_4, iter_4_5 in pairs(var_4_0) do
		local var_4_4 = deepClone(TempHeroData:GetTempHeroDataByTempID(iter_4_5))
		local var_4_5 = HodurHeroDataTemplate.New(var_4_4.id)

		var_4_5:Init(var_4_4)
		self:ModifyHeroInfo(var_4_5)

		self.cacheHeroList_[iter_4_5] = var_4_4
	end
end

function var_0_0.ModifyHeroInfo(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_1.tempID and arg_5_1.tempID ~= 0 and not HodurTools.CheckSpecialAffix() then
		do return end

		var_5_0 = ActivityTeamSettingCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_MAIN][1]
	end

	for iter_5_0, iter_5_1 in ipairs(ActivityTeamSettingCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_MAIN]) do
		if ActivityTeamSettingCfg[iter_5_1].type == (HodurTools.CheckSpecialAffix() and 2 or 1) then
			var_5_0 = iter_5_1
		end
	end

	local var_5_1 = ActivityTeamSettingCfg[var_5_0]

	if HodurTools.CheckSpecialAffix() then
		arg_5_1.level = var_5_1.hero_level
		arg_5_1.exp = GameLevelSetting[var_5_1.hero_level].hero_lv_exp_sum
		arg_5_1.break_level = 6

		for iter_5_2 = 1, 5 do
			arg_5_1.skill[iter_5_2].skill_level = var_5_1.skill_level
		end

		arg_5_1.weapon_info.level = var_5_1.weapon_level
		arg_5_1.weapon_info.breakthrough = 4
		arg_5_1.weapon_info.exp = 99800
		arg_5_1.star = var_5_1.hero_star_level * 100

		for iter_5_3, iter_5_4 in ipairs(arg_5_1.equip_list) do
			if iter_5_4.prefab_id > 0 then
				local var_5_3 = EquipExpCfg[EquipCfg[arg_5_1.equip_list[iter_5_3].prefab_id].max_level[#EquipCfg[arg_5_1.equip_list[iter_5_3].prefab_id].max_level]]["exp_sum_" .. EquipCfg[arg_5_1.equip_list[iter_5_3].prefab_id].starlevel]

				arg_5_1.equip_list[iter_5_3].equip_id = iter_5_3

				local var_5_4 = "5" .. string.sub(tostring(arg_5_1.equip_list[iter_5_3].prefab_id), 2)

				arg_5_1.equip_list[iter_5_3].exp = var_5_3
				arg_5_1.equip_list[iter_5_3].now_break_level = EquipCfg[arg_5_1.equip_list[iter_5_3].prefab_id].break_times_max
			end
		end

		if var_5_1.exclusive > 0 then
			local var_5_5 = true

			for iter_5_5, iter_5_6 in ipairs(arg_5_1.transition) do
				if iter_5_6.skill_list and #iter_5_6.skill_list >= 2 then
					-- block empty
				else
					var_5_5 = false

					break
				end
			end

			if not var_5_5 then
				local var_5_6 = {}

				for iter_5_7 = 1, 6 do
					if arg_5_1.equip_list[iter_5_7] and arg_5_1.equip_list[iter_5_7].star >= 5 then
						table.insert(var_5_6, {
							talent_points = 6,
							skill_list = {
								{
									skill_id = GameSetting.bossrush_challenge_equip_exclusive.value[iter_5_7][1],
									skill_level = var_5_1.exclusive
								},
								{
									skill_id = GameSetting.bossrush_challenge_equip_exclusive.value[iter_5_7][2],
									skill_level = var_5_1.exclusive
								}
							},
							slot_id = iter_5_7
						})
					end
				end

				arg_5_1.transition = var_5_6
			else
				for iter_5_8, iter_5_9 in ipairs(arg_5_1.transition) do
					for iter_5_10, iter_5_11 in ipairs(iter_5_9.skill_list) do
						if iter_5_11.skill_id > 0 then
							iter_5_11.skill_level = var_5_1.exclusive
						end
					end

					iter_5_9.talent_points = 6
				end
			end
		end

		if arg_5_1.servantInfo.id ~= HeroTools.GetHeroSpecServant(arg_5_1.id) then
			arg_5_1.servantInfo = {
				uid = 0,
				locked = true,
				id = HeroTools.GetHeroSpecServant(arg_5_1.id),
				stage = var_5_1.weapon_star_level
			}
		end

		arg_5_1.servantInfo.stage = var_5_1.weapon_star_level
	else
		if arg_5_1.level <= var_5_1.hero_level then
			arg_5_1.level = var_5_1.hero_level
			arg_5_1.break_level = 7
			arg_5_1.exp = GameLevelSetting[var_5_1.hero_level].hero_lv_exp_sum
		end

		for iter_5_12 = 1, 5 do
			if arg_5_1.skill[iter_5_12].skill_level <= var_5_1.skill_level then
				arg_5_1.skill[iter_5_12].skill_level = var_5_1.skill_level or arg_5_1.skill[iter_5_12].skill_level
			end
		end

		if (arg_5_1.weapon_info.level or 0) <= var_5_1.weapon_level then
			arg_5_1.weapon_info.level = var_5_1.weapon_level
			arg_5_1.weapon_info.breakthrough = 4
			arg_5_1.weapon_info.exp = 99800
		end

		if arg_5_1.star <= var_5_1.hero_star_level * 100 then
			arg_5_1.star = var_5_1.hero_star_level * 100 or arg_5_1.star
		end

		for iter_5_13, iter_5_14 in ipairs(arg_5_1.equip_list) do
			if iter_5_14.prefab_id > 0 then
				local var_5_9 = EquipExpCfg[EquipCfg[arg_5_1.equip_list[iter_5_13].prefab_id].max_level[#EquipCfg[arg_5_1.equip_list[iter_5_13].prefab_id].max_level]]["exp_sum_" .. EquipCfg[arg_5_1.equip_list[iter_5_13].prefab_id].starlevel]

				arg_5_1.equip_list[iter_5_13].equip_id = iter_5_13

				local var_5_10 = "5" .. string.sub(tostring(arg_5_1.equip_list[iter_5_13].prefab_id), 2)

				arg_5_1.equip_list[iter_5_13].exp = var_5_9
				arg_5_1.equip_list[iter_5_13].now_break_level = EquipCfg[arg_5_1.equip_list[iter_5_13].prefab_id].break_times_max
			end
		end

		if var_5_1.exclusive > 0 then
			local var_5_11 = true

			for iter_5_15, iter_5_16 in ipairs(arg_5_1.transition) do
				if iter_5_16.skill_list and #iter_5_16.skill_list >= 2 then
					-- block empty
				else
					var_5_11 = false

					break
				end
			end

			if not var_5_11 then
				local var_5_12 = {}

				for iter_5_17 = 1, 6 do
					if arg_5_1.equip_list[iter_5_17] and arg_5_1.equip_list[iter_5_17].star >= 5 then
						table.insert(var_5_12, {
							talent_points = 6,
							skill_list = {
								{
									skill_id = GameSetting.bossrush_challenge_equip_exclusive.value[iter_5_17][1],
									skill_level = var_5_1.exclusive
								},
								{
									skill_id = GameSetting.bossrush_challenge_equip_exclusive.value[iter_5_17][2],
									skill_level = var_5_1.exclusive
								}
							},
							slot_id = iter_5_17
						})
					end
				end

				arg_5_1.transition = var_5_12
			else
				for iter_5_18, iter_5_19 in ipairs(arg_5_1.transition) do
					for iter_5_20, iter_5_21 in ipairs(iter_5_19.skill_list) do
						if iter_5_21.skill_id > 0 and iter_5_21.skill_level < var_5_1.exclusive then
							iter_5_21.skill_level = var_5_1.exclusive
						end
					end

					iter_5_19.talent_points = 6
				end
			end
		end

		if arg_5_1.servantInfo.id ~= HeroTools.GetHeroSpecServant(arg_5_1.id) then
			arg_5_1.servantInfo = {
				uid = 0,
				locked = true,
				id = HeroTools.GetHeroSpecServant(arg_5_1.id),
				stage = var_5_1.weapon_star_level
			}
		end

		if arg_5_1.servantInfo.stage < var_5_1.weapon_star_level then
			arg_5_1.servantInfo.stage = var_5_1.weapon_star_level
		end
	end
end

function var_0_0:GetHeroList()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self.cacheHeroList_) do
		if iter_6_1.tempID and iter_6_1.tempID ~= 0 then
			-- block empty
		else
			table.insert(var_6_0, iter_6_1.id)
		end
	end

	return var_6_0
end

function var_0_0:GetHeroIDList()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs((self:GetHeroList())) do
		table.insert(var_7_0, iter_7_1)
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0 < arg_8_1
	end)

	return var_7_0
end

function var_0_0.GetAttriIDList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs((clone(HeroConst.HERO_ATTACK_TYPE_STR))) do
		table.insert(var_9_0, iter_9_0)
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0 < arg_10_1
	end)

	return var_9_0
end

function var_0_0:GetHeroFinalAttr(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	if arg_11_4 and arg_11_4 ~= 0 then
		if type(HeroStandardSystemCfg[arg_11_4].hero_attrib) == "table" then
			local var_11_0 = {}

			for iter_11_0, iter_11_1 in pairs(HeroStandardSystemCfg[arg_11_4].hero_attrib) do
				var_11_0[iter_11_1[1]] = iter_11_1[2]
			end

			return var_11_0
		else
			return (GetHeroPracticalAttr(arg_11_1, arg_11_2, arg_11_3, arg_11_5, true))
		end
	else
		self:ModifyHeroInfo(arg_11_1)
	end

	return (GetHeroPracticalAttr(arg_11_1, arg_11_2, arg_11_3, arg_11_5, false))
end

function var_0_0:GetEquipInfoList(arg_12_1)
	return self:GetHeroData(arg_12_1):GetEquipInfoList()
end

function var_0_0:GetEquipDataList(arg_13_1)
	return self:GetHeroData(arg_13_1).equip_list
end

function var_0_0:GetHeroWeaponInfo(arg_14_1)
	return self:GetHeroData(arg_14_1):GetWeaponInfo()
end

function var_0_0:GetHeroServantInfo(arg_15_1)
	return self:GetHeroData(arg_15_1):GetServantInfo()
end

function var_0_0:GetHeroSkillInfoList(arg_16_1)
	return self:GetHeroData(arg_16_1):GetSkillInfoList()
end

function var_0_0:GetHeroTransitionInfoList(arg_17_1)
	return self:GetHeroData(arg_17_1):GetTransitionInfoList()
end

function var_0_0:GetHeroUsingSkinInfo(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = self:GetHeroData(arg_18_1, arg_18_3)
	local var_18_1

	if var_18_0 then
		var_18_1 = var_18_0.using_skin or 0

		if var_18_1 == 0 then
			var_18_1 = arg_18_1
		end
	end

	return SkinCfg[var_18_1]
end

function var_0_0.GetHeroName(arg_19_0, arg_19_1)
	return HeroCfg[arg_19_1].suffix
end

function var_0_0.HasCustomNickName(arg_20_0, arg_20_1)
	return false
end

function var_0_0.IsHeroOath(arg_21_0, arg_21_1)
	return false
end

return var_0_0
