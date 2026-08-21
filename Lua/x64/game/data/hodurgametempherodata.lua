local var_0_0 = singletonClass("HodurGameTempHeroData", BaseHeroViewData)

function var_0_0.Init(arg_1_0)
	arg_1_0.cacheHeroList_ = {}
	arg_1_0.trialList_ = {}
	arg_1_0.reserveHeroList = {}
end

function var_0_0.GetHeroData(arg_2_0, arg_2_1)
	return arg_2_0.cacheHeroList_[arg_2_1]
end

function var_0_0.GetCacheHeroList(arg_3_0)
	return arg_3_0.cacheHeroList_
end

function var_0_0.ModifyAllHeroInfo(arg_4_0)
	local var_4_0 = GetTrialHeroList(BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE, nil, ActivityConst.ACTIVITY_HODUR_MAIN)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_2 = HeroStandardSystemCfg[iter_4_1]

		if var_4_2 then
			local var_4_3 = var_4_2.hero_id

			table.insert(var_4_1, var_4_3)
		end
	end

	for iter_4_2, iter_4_3 in pairs(HeroData.GetUnlockHeros()) do
		local var_4_4 = deepClone(HeroData:GetHeroData(iter_4_3))

		var_4_4.equip_list = deepClone(HeroData:GetEquipDataList(var_4_4.id))

		local var_4_5 = HodurHeroDataTemplate.New(iter_4_3)

		var_4_5:Init(var_4_4)
		arg_4_0:ModifyHeroInfo(var_4_5)

		arg_4_0.cacheHeroList_[var_4_4.id] = var_4_5
	end

	for iter_4_4, iter_4_5 in pairs(var_4_0) do
		local var_4_6 = deepClone(TempHeroData:GetTempHeroDataByTempID(iter_4_5))
		local var_4_7 = HodurHeroDataTemplate.New(var_4_6.id)

		var_4_7:Init(var_4_6)
		arg_4_0:ModifyHeroInfo(var_4_7)

		arg_4_0.cacheHeroList_[iter_4_5] = var_4_6
	end
end

function var_0_0.ModifyHeroInfo(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.id

	if arg_5_1.tempID and arg_5_1.tempID ~= 0 and not HodurTools.CheckSpecialAffix() then
		return
	end

	local var_5_1 = ActivityTeamSettingCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_MAIN]
	local var_5_2 = var_5_1[1]

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_3 = ActivityTeamSettingCfg[iter_5_1]
		local var_5_4 = HodurTools.CheckSpecialAffix() and 2 or 1

		if var_5_3.type == var_5_4 then
			var_5_2 = iter_5_1
		end
	end

	local var_5_5 = ActivityTeamSettingCfg[var_5_2]

	if HodurTools.CheckSpecialAffix() then
		arg_5_1.level = var_5_5.hero_level
		arg_5_1.exp = GameLevelSetting[var_5_5.hero_level].hero_lv_exp_sum
		arg_5_1.break_level = 6

		for iter_5_2 = 1, 5 do
			arg_5_1.skill[iter_5_2].skill_level = var_5_5.skill_level
		end

		arg_5_1.weapon_info.level = var_5_5.weapon_level
		arg_5_1.weapon_info.breakthrough = 4
		arg_5_1.weapon_info.exp = 99800
		arg_5_1.star = var_5_5.hero_star_level * 100

		for iter_5_3, iter_5_4 in ipairs(arg_5_1.equip_list) do
			if iter_5_4.prefab_id > 0 then
				local var_5_6 = arg_5_1.equip_list[iter_5_3].star
				local var_5_7 = arg_5_1.equip_list[iter_5_3].prefab_id
				local var_5_8 = EquipCfg[var_5_7]
				local var_5_9 = var_5_8.max_level[#var_5_8.max_level]
				local var_5_10 = EquipExpCfg[var_5_9]["exp_sum_" .. var_5_8.starlevel]

				arg_5_1.equip_list[iter_5_3].equip_id = iter_5_3

				local var_5_11 = tostring(arg_5_1.equip_list[iter_5_3].prefab_id)
				local var_5_12 = "5" .. string.sub(var_5_11, 2)

				arg_5_1.equip_list[iter_5_3].exp = var_5_10
				arg_5_1.equip_list[iter_5_3].now_break_level = var_5_8.break_times_max
			end
		end

		if var_5_5.exclusive > 0 then
			local var_5_13 = arg_5_1.transition
			local var_5_14 = true

			for iter_5_5, iter_5_6 in ipairs(var_5_13) do
				if iter_5_6.skill_list and #iter_5_6.skill_list >= 2 then
					-- block empty
				else
					var_5_14 = false

					break
				end
			end

			if not var_5_14 then
				local var_5_15 = GameSetting.bossrush_challenge_equip_exclusive.value
				local var_5_16 = {}

				for iter_5_7 = 1, 6 do
					if arg_5_1.equip_list[iter_5_7] and arg_5_1.equip_list[iter_5_7].star >= 5 then
						table.insert(var_5_16, {
							talent_points = 6,
							skill_list = {
								{
									skill_id = var_5_15[iter_5_7][1],
									skill_level = var_5_5.exclusive
								},
								{
									skill_id = var_5_15[iter_5_7][2],
									skill_level = var_5_5.exclusive
								}
							},
							slot_id = iter_5_7
						})
					end
				end

				arg_5_1.transition = var_5_16
			else
				for iter_5_8, iter_5_9 in ipairs(arg_5_1.transition) do
					for iter_5_10, iter_5_11 in ipairs(iter_5_9.skill_list) do
						if iter_5_11.skill_id > 0 then
							iter_5_11.skill_level = var_5_5.exclusive
						end
					end

					iter_5_9.talent_points = 6
				end
			end
		end

		if arg_5_1.servantInfo.id ~= HeroTools.GetHeroSpecServant(var_5_0) then
			arg_5_1.servantInfo = {
				uid = 0,
				locked = true,
				id = HeroTools.GetHeroSpecServant(var_5_0),
				stage = var_5_5.weapon_star_level
			}
		end

		arg_5_1.servantInfo.stage = var_5_5.weapon_star_level
	else
		if arg_5_1.level <= var_5_5.hero_level then
			arg_5_1.level = var_5_5.hero_level
			arg_5_1.break_level = 7
			arg_5_1.exp = GameLevelSetting[var_5_5.hero_level].hero_lv_exp_sum
		end

		for iter_5_12 = 1, 5 do
			arg_5_1.skill[iter_5_12].skill_level = arg_5_1.skill[iter_5_12].skill_level <= var_5_5.skill_level and var_5_5.skill_level or arg_5_1.skill[iter_5_12].skill_level
		end

		if (arg_5_1.weapon_info.level or 0) <= var_5_5.weapon_level then
			arg_5_1.weapon_info.level = var_5_5.weapon_level
			arg_5_1.weapon_info.breakthrough = 4
			arg_5_1.weapon_info.exp = 99800
		end

		arg_5_1.star = arg_5_1.star <= var_5_5.hero_star_level * 100 and var_5_5.hero_star_level * 100 or arg_5_1.star

		for iter_5_13, iter_5_14 in ipairs(arg_5_1.equip_list) do
			if iter_5_14.prefab_id > 0 then
				local var_5_17 = arg_5_1.equip_list[iter_5_13].star
				local var_5_18 = arg_5_1.equip_list[iter_5_13].prefab_id
				local var_5_19 = EquipCfg[var_5_18]
				local var_5_20 = var_5_19.max_level[#var_5_19.max_level]
				local var_5_21 = EquipExpCfg[var_5_20]["exp_sum_" .. var_5_19.starlevel]

				arg_5_1.equip_list[iter_5_13].equip_id = iter_5_13

				local var_5_22 = tostring(arg_5_1.equip_list[iter_5_13].prefab_id)
				local var_5_23 = "5" .. string.sub(var_5_22, 2)

				arg_5_1.equip_list[iter_5_13].exp = var_5_21
				arg_5_1.equip_list[iter_5_13].now_break_level = var_5_19.break_times_max
			end
		end

		if var_5_5.exclusive > 0 then
			local var_5_24 = arg_5_1.transition
			local var_5_25 = true

			for iter_5_15, iter_5_16 in ipairs(var_5_24) do
				if iter_5_16.skill_list and #iter_5_16.skill_list >= 2 then
					-- block empty
				else
					var_5_25 = false

					break
				end
			end

			if not var_5_25 then
				local var_5_26 = GameSetting.bossrush_challenge_equip_exclusive.value
				local var_5_27 = {}

				for iter_5_17 = 1, 6 do
					if arg_5_1.equip_list[iter_5_17] and arg_5_1.equip_list[iter_5_17].star >= 5 then
						table.insert(var_5_27, {
							talent_points = 6,
							skill_list = {
								{
									skill_id = var_5_26[iter_5_17][1],
									skill_level = var_5_5.exclusive
								},
								{
									skill_id = var_5_26[iter_5_17][2],
									skill_level = var_5_5.exclusive
								}
							},
							slot_id = iter_5_17
						})
					end
				end

				arg_5_1.transition = var_5_27
			else
				for iter_5_18, iter_5_19 in ipairs(arg_5_1.transition) do
					for iter_5_20, iter_5_21 in ipairs(iter_5_19.skill_list) do
						if iter_5_21.skill_id > 0 and iter_5_21.skill_level < var_5_5.exclusive then
							iter_5_21.skill_level = var_5_5.exclusive
						end
					end

					iter_5_19.talent_points = 6
				end
			end
		end

		if arg_5_1.servantInfo.id ~= HeroTools.GetHeroSpecServant(var_5_0) then
			arg_5_1.servantInfo = {
				uid = 0,
				locked = true,
				id = HeroTools.GetHeroSpecServant(var_5_0),
				stage = var_5_5.weapon_star_level
			}
		end

		if arg_5_1.servantInfo.stage < var_5_5.weapon_star_level then
			arg_5_1.servantInfo.stage = var_5_5.weapon_star_level
		end
	end
end

function var_0_0.GetHeroList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.cacheHeroList_) do
		if iter_6_1.tempID and iter_6_1.tempID ~= 0 then
			-- block empty
		else
			table.insert(var_6_0, iter_6_1.id)
		end
	end

	return var_6_0
end

function var_0_0.GetHeroIDList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = arg_7_0:GetHeroList()

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		table.insert(var_7_0, iter_7_1)
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0 < arg_8_1
	end)

	return var_7_0
end

function var_0_0.GetAttriIDList(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = clone(HeroConst.HERO_ATTACK_TYPE_STR)

	for iter_9_0, iter_9_1 in pairs(var_9_1) do
		table.insert(var_9_0, iter_9_0)
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0 < arg_10_1
	end)

	return var_9_0
end

function var_0_0.GetHeroFinalAttr(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	if arg_11_4 and arg_11_4 ~= 0 then
		local var_11_0 = HeroStandardSystemCfg[arg_11_4].hero_attrib

		if type(var_11_0) == "table" then
			local var_11_1 = {}

			for iter_11_0, iter_11_1 in pairs(var_11_0) do
				var_11_1[iter_11_1[1]] = iter_11_1[2]
			end

			return var_11_1
		else
			local var_11_2 = true

			return (GetHeroPracticalAttr(arg_11_1, arg_11_2, arg_11_3, arg_11_5, var_11_2))
		end
	else
		arg_11_0:ModifyHeroInfo(arg_11_1)
	end

	return (GetHeroPracticalAttr(arg_11_1, arg_11_2, arg_11_3, arg_11_5, false))
end

function var_0_0.GetEquipInfoList(arg_12_0, arg_12_1)
	return arg_12_0:GetHeroData(arg_12_1):GetEquipInfoList()
end

function var_0_0.GetEquipDataList(arg_13_0, arg_13_1)
	return arg_13_0:GetHeroData(arg_13_1).equip_list
end

function var_0_0.GetHeroWeaponInfo(arg_14_0, arg_14_1)
	return arg_14_0:GetHeroData(arg_14_1):GetWeaponInfo()
end

function var_0_0.GetHeroServantInfo(arg_15_0, arg_15_1)
	return arg_15_0:GetHeroData(arg_15_1):GetServantInfo()
end

function var_0_0.GetHeroSkillInfoList(arg_16_0, arg_16_1)
	return arg_16_0:GetHeroData(arg_16_1):GetSkillInfoList()
end

function var_0_0.GetHeroTransitionInfoList(arg_17_0, arg_17_1)
	return arg_17_0:GetHeroData(arg_17_1):GetTransitionInfoList()
end

function var_0_0.GetHeroUsingSkinInfo(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0:GetHeroData(arg_18_1, arg_18_3)
	local var_18_1 = var_18_0 and var_18_0.using_skin or 0

	if var_18_1 == 0 then
		var_18_1 = arg_18_1
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
