local var_0_0 = class("ChallengeRogueTeamHeroData", BaseHeroViewData)

function var_0_0.ExportMethod(arg_1_0)
	return {
		"HeroSetLockState",
		"HeroGetLockState",
		"GetHeroList",
		"HeroAddUnlockHero",
		"GetTrialHeroList",
		"ModifyAllHeroInfo",
		"ResetHeroData",
		"GetUnlockTrailHeroList",
		"GetReserveHeroList",
		"GetTeamBuffAffixList",
		"GetAttriIDList",
		"GetHeroData",
		"GetHeroFinalAttr",
		"GetHeroUsingSkinInfo",
		"GetHeroBattleUsingSkinInfo",
		"RefreshFetters",
		"GetActiveFetters",
		"SetHeroTeamProxy",
		"GetHeroTeamProxy",
		"ResetHeroList"
	}
end

function var_0_0.Init(arg_2_0)
	arg_2_0.unlockHeroList_ = {}
	arg_2_0.cacheHeroList_ = {}
	arg_2_0.unlockTrailHeroList_ = {}
	arg_2_0.trailHeroList = {}
	arg_2_0.reserveHeroList = {}
	arg_2_0.heroTeamLock_ = false
	arg_2_0.heroProxy_ = nil
	arg_2_0.fettersList_ = {}
end

function var_0_0.HeroSetLockState(arg_3_0, arg_3_1)
	arg_3_0.heroTeamLock_ = arg_3_1
end

function var_0_0.HeroGetLockState(arg_4_0)
	return arg_4_0.heroTeamLock_
end

function var_0_0.ResetHeroData(arg_5_0)
	arg_5_0.unlockHeroList_ = {}
	arg_5_0.cacheHeroList_ = {}
	arg_5_0.trailHeroList = {}
	arg_5_0.unlockTrailHeroList_ = {}
	arg_5_0.heroTeamLock_ = false
	arg_5_0.heroProxy_ = nil
end

function var_0_0.HeroAddUnlockHero(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0

	if arg_6_2 ~= 0 then
		var_6_0 = deepClone(TempHeroData:GetTempHeroDataByTempID(arg_6_2))
		var_6_0.hpPercent = arg_6_3
		var_6_0.isRogueChallenge = true
		arg_6_0.unlockTrailHeroList_[var_6_0.tempID] = var_6_0

		return
	else
		var_6_0 = deepClone(HeroData:GetHeroData(arg_6_1))
		var_6_0.equip_list = HeroData:GetEquipDataList(var_6_0.id)
	end

	local var_6_1 = ChallengeRogueTeamHeroDataTemplate.New(arg_6_1)

	var_6_1:Init(var_6_0, arg_6_3)
	arg_6_0:ModifyHeroInfo(var_6_1)

	arg_6_0.unlockHeroList_[var_6_0.id] = var_6_1
end

function var_0_0.GetHeroData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3 then
		return arg_7_0.unlockHeroList_[arg_7_1] or arg_7_0:GetUnlockTrailHero(arg_7_1) or arg_7_0.cacheHeroList_[arg_7_1]
	end

	return arg_7_0.unlockHeroList_[arg_7_1] or arg_7_0.cacheHeroList_[arg_7_1]
end

function var_0_0.GetCacheHeroList(arg_8_0)
	return arg_8_0.cacheHeroList_
end

function var_0_0.ModifyAllHeroInfo(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(HeroData:GetHeroList()) do
		local var_9_0 = arg_9_0.cacheHeroList_[iter_9_1.id]
		local var_9_1 = deepClone(HeroData:GetHeroData(iter_9_1.id))

		var_9_0 = var_9_0 or ChallengeRogueTeamHeroDataTemplate.New(iter_9_1.id)
		var_9_1.equip_list = HeroData:GetEquipDataList(var_9_1.id)

		var_9_0:ModifyHero(var_9_1, arg_9_0.unlockHeroList_[iter_9_1.id] and arg_9_0.unlockHeroList_[iter_9_1.id].hpPercent or 10000)
		arg_9_0:ModifyHeroInfo(var_9_0, arg_9_1)

		if arg_9_0.unlockHeroList_[iter_9_1.id] then
			arg_9_0.unlockHeroList_[iter_9_1.id] = var_9_0
		end

		arg_9_0.cacheHeroList_[iter_9_1.id] = var_9_0
	end
end

function var_0_0.ModifyHeroInfo(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1.id

	if arg_10_1.tempID and arg_10_1.tempID ~= 0 then
		return
	end

	local var_10_1 = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.HEOR_MIN_LEVEL, arg_10_2)
	local var_10_2 = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.HEOR_SKILL_MIN_LEVEL, arg_10_2)
	local var_10_3 = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.HEOR_WEAPON_MIN_LEVEL, arg_10_2)
	local var_10_4 = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.HEOR_RARE_MIN_LEVEL, arg_10_2)

	arg_10_1.modifyLevel = false
	arg_10_1.modifyWeapon = false
	arg_10_1.modifyStar = false
	arg_10_1.modifyServant = false

	if var_10_1 > arg_10_1.level then
		arg_10_1.level = var_10_1
		arg_10_1.modifyLevel = true
		arg_10_1.break_level = var_10_1 / 10 - 2
		arg_10_1.exp = LvTools.LevelToExp(arg_10_1.level, "hero_level_exp1")
	end

	arg_10_1.modifySkill = {}

	for iter_10_0 = 1, 5 do
		if var_10_2 > arg_10_1.skill[iter_10_0].skill_level then
			arg_10_1.skill[iter_10_0].skill_level = var_10_2
			arg_10_1.modifySkill[iter_10_0] = true
		end
	end

	if var_10_3 > arg_10_1.weapon_info.level then
		arg_10_1.weapon_info.level = var_10_3
		arg_10_1.weapon_info.breakthrough = math.max(math.floor(var_10_3 / 10) - 2, 0)
		arg_10_1.weapon_info.exp = GameLevelSetting[var_10_3].weapon_lv_exp_sum
		arg_10_1.modifyWeapon = true
	end

	if arg_10_1.star < var_10_4 * 100 then
		arg_10_1.star = var_10_4 * 100
		arg_10_1.modifyStar = true
	end

	if arg_10_1.servantInfo.id ~= HeroTools.GetHeroSpecServant(var_10_0) then
		arg_10_1.servantInfo = {
			uid = 0,
			locked = true,
			id = HeroTools.GetHeroSpecServant(var_10_0),
			stage = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.HEOR_SERVANT_MIN_LEVEL, arg_10_2)
		}
		arg_10_1.modifyServant = true
	end
end

function var_0_0.GetHeroList(arg_11_0)
	return arg_11_0.unlockHeroList_
end

function var_0_0.GetUnlockTrailHeroList(arg_12_0)
	return arg_12_0.unlockTrailHeroList_
end

function var_0_0.GetUnlockTrailHero(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.unlockTrailHeroList_) do
		if HeroStandardSystemCfg[iter_13_0].hero_id == arg_13_1 then
			return iter_13_1
		end
	end
end

function var_0_0.GetHeroIDList(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = arg_14_0:GetHeroList(arg_14_1)

	if not arg_14_0.heroTeamLock_ then
		var_14_1 = HeroData:GetHeroList()
	end

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		table.insert(var_14_0, iter_14_1.id)
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0 < arg_15_1
	end)

	return var_14_0
end

function var_0_0.GetTrialHeroList(arg_16_0)
	return RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].hero_list
end

function var_0_0.GetReserveHeroList(arg_17_0)
	local var_17_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM, 0, 1, {
		stageType = BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM
	})

	return ReserveTools.GetHeroList(var_17_0)
end

function var_0_0.GetTeamBuffAffixList(arg_18_0, arg_18_1)
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.TEAM_ATTRIBUTE_BUFF_LIST)
	local var_18_3 = arg_18_0:GetAttriIDList()

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_4 = table.indexof(var_18_3, iter_18_1.mainDamageType)

		if var_18_4 then
			if not table.indexof(var_18_1, var_18_2[var_18_4]) then
				table.insert(var_18_1, var_18_2[var_18_4])

				var_18_0[var_18_2[var_18_4]] = 1
			else
				var_18_0[var_18_2[var_18_4]] = var_18_0[var_18_2[var_18_4]] + 1
			end
		end
	end

	return var_18_1, var_18_0
end

function var_0_0.GetAttriIDList(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = clone(HeroConst.HERO_ATTACK_TYPE_STR)

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		table.insert(var_19_0, iter_19_0)
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		return arg_20_0 < arg_20_1
	end)

	return var_19_0
end

function var_0_0.GetHeroFinalAttr(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local var_21_0 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.HERO_HP_MAX_PRECENT) / 1000

	if arg_21_4 and arg_21_4 ~= 0 then
		local var_21_1 = HeroStandardSystemCfg[arg_21_4].hero_attrib

		if type(var_21_1) == "table" then
			local var_21_2 = {}

			for iter_21_0, iter_21_1 in pairs(var_21_1) do
				var_21_2[iter_21_1[1]] = iter_21_1[2]
			end

			var_21_2[3] = var_21_2[3] * var_21_0

			return var_21_2
		else
			local var_21_3 = true
			local var_21_4 = GetHeroPracticalAttr(arg_21_1, arg_21_2, arg_21_3, arg_21_5, var_21_3)

			var_21_4[3] = var_21_4[3] * var_21_0

			return var_21_4
		end
	end

	local var_21_5 = GetHeroPracticalAttr(arg_21_1, arg_21_2, arg_21_3, arg_21_5, false)

	var_21_5[3] = var_21_5[3] * var_21_0

	return var_21_5
end

function var_0_0.RefreshFetters(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	table.insert(arg_22_0.fettersList_, {
		activityId = arg_22_1,
		fettersId = arg_22_2,
		nextTimestamps = arg_22_3
	})
end

function var_0_0.GetActiveFetters(arg_23_0)
	return arg_23_0.fettersList_[#arg_23_0.fettersList_]
end

function var_0_0.SetHeroTeamProxy(arg_24_0, arg_24_1)
	arg_24_0.heroProxy_ = arg_24_1
end

function var_0_0.GetHeroTeamProxy(arg_25_0)
	return arg_25_0.heroProxy_
end

function var_0_0.ResetHeroList(arg_26_0)
	local var_26_0, var_26_1, var_26_2, var_26_3 = arg_26_0.heroProxy_:GetHeroTeam()

	ReserveTools.SetHeroList(arg_26_0.heroProxy_:GetReserveParams(), var_26_0, var_26_3)
end

return var_0_0
