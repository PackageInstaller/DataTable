local var_0_0 = singletonClass("OsirisPlayGameTempHeroData", BaseHeroViewData)

function var_0_0.Init(arg_1_0)
	arg_1_0.unlockHeroList_ = {}
	arg_1_0.cacheHeroList_ = {}
	arg_1_0.unlockTrailHeroList_ = {}
	arg_1_0.trailHeroList = {}
	arg_1_0.reserveHeroList = {}
end

function var_0_0:HeroAddUnlockHero(arg_2_1, arg_2_2)
	if HeroStandardSystemCfg[arg_2_2] then
		self.unlockTrailHeroList_[arg_2_2] = deepClone(TempHeroData:GetTempHeroDataByTempID(arg_2_2))
	end
end

function var_0_0:GetHeroData(arg_3_1)
	return self.cacheHeroList_[arg_3_1]
end

function var_0_0:GetCacheHeroList()
	return self.cacheHeroList_
end

function var_0_0:GetTrialHeroList()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.unlockTrailHeroList_) do
		table.insert(var_5_0, iter_5_0)
	end

	return var_5_0
end

function var_0_0:ModifyAllHeroInfo(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[iter_6_1.stage_id][1]].unlock_charactor
		local var_6_1 = ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[iter_6_1.stage_id][1]].unlock_charactor == 0 and 0 or ActivityGeneralityCharactorCfg[var_6_0].charactor_id

		if ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[iter_6_1.stage_id][1]].unlock_charactor ~= 0 and var_6_1 ~= 0 then
			var_0_0:HeroAddUnlockHero(var_6_0, var_6_1)
		end
	end

	for iter_6_2, iter_6_3 in ipairs(ActivityGeneralityCharactorCfg.get_id_list_by_initial_unlock[1]) do
		var_0_0:HeroAddUnlockHero(iter_6_3, ActivityGeneralityCharactorCfg[iter_6_3].charactor_id)
	end

	for iter_6_4, iter_6_5 in pairs((HeroData:GetHeroList())) do
		if ActivityGeneralityCharactorCfg[iter_6_4] and iter_6_4 and HeroTools.GetHeroIsUnlock(iter_6_4) and (self:IsStageUnlockHero(iter_6_4, arg_6_1) or ActivityGeneralityCharactorCfg[iter_6_4].initial_unlock == 1) then
			heroData = deepClone(HeroData:GetHeroData(iter_6_4))
			heroData.equip_list = deepClone(HeroData:GetEquipDataList(heroData.id))

			local var_6_2 = OsirisPlayGameDataTemplate.New(iter_6_4)

			var_6_2:Init(heroData)
			self:ModifyHeroInfo(var_6_2)

			self.cacheHeroList_[heroData.id] = var_6_2
		end
	end
end

function var_0_0.IsStageUnlockHero(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		if arg_7_1 == ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[iter_7_1.stage_id][1]].unlock_charactor then
			return true
		end
	end

	return false
end

function var_0_0.ModifyHeroInfo(arg_8_0, arg_8_1)
	if arg_8_1.tempID and arg_8_1.tempID ~= 0 then
		return
	end

	local var_8_0 = deepClone(TempHeroData:GetTempHeroDataByTempID(ActivityGeneralityCharactorCfg[arg_8_1.id].charactor_id))
	local var_8_1 = ActivityTeamSettingCfg[ActivityTeamSettingCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME][1]]

	if arg_8_1.level <= ActivityTeamSettingCfg[ActivityTeamSettingCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME][1]].hero_level then
		arg_8_1.level = var_8_1.hero_level
		arg_8_1.break_level = 6
	end

	for iter_8_0 = 1, 5 do
		if arg_8_1.skill[iter_8_0].skill_level <= var_8_1.skill_level then
			arg_8_1.skill[iter_8_0].skill_level = var_8_1.skill_level or arg_8_1.skill[iter_8_0].skill_level
		end
	end

	if arg_8_1.weapon_info.level <= var_8_1.weapon_level then
		arg_8_1.weapon_info.level = var_8_1.weapon_level
		arg_8_1.weapon_info.breakthrough = 4
		arg_8_1.weapon_info.exp = 99800
	end

	if arg_8_1.star <= var_8_1.hero_star_level * 100 then
		arg_8_1.star = var_8_1.hero_star_level * 100 or arg_8_1.star
	end

	for iter_8_1, iter_8_2 in ipairs(arg_8_1.equip_list) do
		if iter_8_2.prefab_id > 0 and iter_8_2.exp < 27800 then
			arg_8_1.equip_list[iter_8_1].equip_id = iter_8_1

			local var_8_3 = tonumber("5" .. string.sub(tostring(arg_8_1.equip_list[iter_8_1].prefab_id), 2))

			arg_8_1.equip_list[iter_8_1].prefab_id = var_8_3
			arg_8_1.equip_list[iter_8_1].exp = 27800
			arg_8_1.equip_list[iter_8_1].now_break_level = 5
			arg_8_1.equip_list[iter_8_1].star = 5
			arg_8_1.equip_list[iter_8_1].equipConfig = EquipCfg[var_8_3]
		end
	end

	if var_8_1.exclusive > 0 then
		for iter_8_3, iter_8_4 in ipairs(arg_8_1.transition) do
			for iter_8_5, iter_8_6 in ipairs(iter_8_4.skill_list) do
				if iter_8_6.skill_id > 0 then
					iter_8_6.skill_level = 3
				else
					iter_8_6 = var_8_0.transition[iter_8_3].skill_list
				end
			end

			iter_8_4.talent_points = 6
		end
	end

	if arg_8_1.servantInfo.id ~= HeroTools.GetHeroSpecServant(arg_8_1.id) then
		local var_8_4 = {
			uid = 0,
			locked = true,
			id = HeroTools.GetHeroSpecServant(arg_8_1.id)
		}

		var_8_4.stage = arg_8_1.servantInfo.stage or 1
		arg_8_1.servantInfo = var_8_4
	end
end

function var_0_0:GetHeroList()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self.cacheHeroList_) do
		table.insert(var_9_0, iter_9_1.id)
	end

	return var_9_0
end

function var_0_0:GetHeroIDList()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs((self:GetHeroList())) do
		table.insert(var_10_0, iter_10_1)
	end

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		return arg_11_0 < arg_11_1
	end)

	return var_10_0
end

function var_0_0.GetAttriIDList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs((clone(HeroConst.HERO_ATTACK_TYPE_STR))) do
		table.insert(var_12_0, iter_12_0)
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		return arg_13_0 < arg_13_1
	end)

	return var_12_0
end

function var_0_0.GetHeroFinalAttr(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	if arg_14_4 and arg_14_4 ~= 0 then
		if type(HeroStandardSystemCfg[arg_14_4].hero_attrib) == "table" then
			local var_14_0 = {}

			for iter_14_0, iter_14_1 in pairs(HeroStandardSystemCfg[arg_14_4].hero_attrib) do
				var_14_0[iter_14_1[1]] = iter_14_1[2]
			end

			return var_14_0
		else
			return (GetHeroPracticalAttr(arg_14_1, arg_14_2, arg_14_3, arg_14_5, true))
		end
	end

	return (GetHeroPracticalAttr(arg_14_1, arg_14_2, arg_14_3, arg_14_5, false))
end

function var_0_0:GetEquipInfoList(arg_15_1)
	return self:GetHeroData(arg_15_1):GetEquipInfoList()
end

function var_0_0:GetEquipDataList(arg_16_1)
	return self:GetHeroData(arg_16_1).equip_list
end

function var_0_0:GetHeroWeaponInfo(arg_17_1)
	return self:GetHeroData(arg_17_1):GetWeaponInfo()
end

function var_0_0:GetHeroServantInfo(arg_18_1)
	return self:GetHeroData(arg_18_1):GetServantInfo()
end

function var_0_0:GetHeroSkillInfoList(arg_19_1)
	return self:GetHeroData(arg_19_1):GetSkillInfoList()
end

function var_0_0:GetHeroTransitionInfoList(arg_20_1)
	return self:GetHeroData(arg_20_1):GetTransitionInfoList()
end

function var_0_0:GetHeroUsingSkinInfo(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = self:GetHeroData(arg_21_1, arg_21_3)
	local var_21_1

	if var_21_0 then
		var_21_1 = var_21_0.using_skin or 0

		if var_21_1 == 0 then
			var_21_1 = arg_21_1
		end
	end

	return SkinCfg[var_21_1]
end

function var_0_0.GetHeroName(arg_22_0, arg_22_1)
	return HeroCfg[arg_22_1].suffix
end

function var_0_0.HasCustomNickName(arg_23_0, arg_23_1)
	return false
end

function var_0_0.IsHeroOath(arg_24_0, arg_24_1)
	return false
end

return var_0_0
