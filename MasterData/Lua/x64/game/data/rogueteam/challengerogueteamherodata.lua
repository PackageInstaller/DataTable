local ChallengeRogueTeamHeroData = class("ChallengeRogueTeamHeroData", BaseHeroViewData)

function ChallengeRogueTeamHeroData:ExportMethod()
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

function ChallengeRogueTeamHeroData:Init()
	self.unlockHeroList_ = {}
	self.cacheHeroList_ = {}
	self.unlockTrailHeroList_ = {}
	self.trailHeroList = {}
	self.reserveHeroList = {}
	self.heroTeamLock_ = false
	self.heroProxy_ = nil
	self.fettersList_ = {}
end

function ChallengeRogueTeamHeroData:HeroSetLockState(arg_3_1)
	self.heroTeamLock_ = arg_3_1
end

function ChallengeRogueTeamHeroData:HeroGetLockState()
	return self.heroTeamLock_
end

function ChallengeRogueTeamHeroData:ResetHeroData()
	self.unlockHeroList_ = {}
	self.cacheHeroList_ = {}
	self.trailHeroList = {}
	self.unlockTrailHeroList_ = {}
	self.heroTeamLock_ = false
	self.heroProxy_ = nil
end

function ChallengeRogueTeamHeroData:HeroAddUnlockHero(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0

	if arg_6_2 ~= 0 then
		var_6_0 = deepClone(TempHeroData:GetTempHeroDataByTempID(arg_6_2))
		var_6_0.hpPercent = arg_6_3
		var_6_0.isRogueChallenge = true
		self.unlockTrailHeroList_[var_6_0.tempID] = var_6_0

		return
	else
		var_6_0 = deepClone(HeroData:GetHeroData(arg_6_1))
		var_6_0.equip_list = HeroData:GetEquipDataList(var_6_0.id)
	end

	local var_6_1 = ChallengeRogueTeamHeroDataTemplate.New(arg_6_1)

	var_6_1:Init(var_6_0, arg_6_3)
	self:ModifyHeroInfo(var_6_1)

	self.unlockHeroList_[var_6_0.id] = var_6_1
end

function ChallengeRogueTeamHeroData:GetHeroData(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3 then
		local var_7_0 = self.unlockHeroList_[arg_7_1]

		if not self.unlockHeroList_[arg_7_1] then
			var_7_0 = self:GetUnlockTrailHero(arg_7_1)
			var_7_0 = var_7_0 or self.cacheHeroList_[arg_7_1]
		end

		return var_7_0
	end

	return self.unlockHeroList_[arg_7_1] or self.cacheHeroList_[arg_7_1]
end

function ChallengeRogueTeamHeroData:GetCacheHeroList()
	return self.cacheHeroList_
end

function ChallengeRogueTeamHeroData:ModifyAllHeroInfo(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(HeroData:GetHeroList()) do
		local var_9_0 = self.cacheHeroList_[iter_9_1.id]
		local var_9_1 = deepClone(HeroData:GetHeroData(iter_9_1.id))

		if not self.cacheHeroList_[iter_9_1.id] then
			var_9_0 = ChallengeRogueTeamHeroDataTemplate.New(iter_9_1.id)
		end

		var_9_1.equip_list = HeroData:GetEquipDataList(var_9_1.id)

		var_9_0:ModifyHero(var_9_1, (self.unlockHeroList_[iter_9_1.id] or nil) and (self.unlockHeroList_[iter_9_1.id].hpPercent or 10000))
		self:ModifyHeroInfo(var_9_0, arg_9_1)

		if self.unlockHeroList_[iter_9_1.id] then
			self.unlockHeroList_[iter_9_1.id] = var_9_0
		end

		self.cacheHeroList_[iter_9_1.id] = var_9_0
	end
end

function ChallengeRogueTeamHeroData:ModifyHeroInfo(arg_10_1, arg_10_2)
	if arg_10_1.tempID and arg_10_1.tempID ~= 0 then
		return
	end

	local var_10_0 = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.HEOR_MIN_LEVEL, arg_10_2)
	local var_10_1 = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.HEOR_SKILL_MIN_LEVEL, arg_10_2)
	local var_10_2 = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.HEOR_WEAPON_MIN_LEVEL, arg_10_2)
	local var_10_3 = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.HEOR_RARE_MIN_LEVEL, arg_10_2)

	arg_10_1.modifyLevel = false
	arg_10_1.modifyWeapon = false
	arg_10_1.modifyStar = false
	arg_10_1.modifyServant = false

	if var_10_0 > arg_10_1.level then
		arg_10_1.level = var_10_0
		arg_10_1.modifyLevel = true
		arg_10_1.break_level = var_10_0 / 10 - 2
		arg_10_1.exp = LvTools.LevelToExp(arg_10_1.level, "hero_level_exp1")
	end

	arg_10_1.modifySkill = {}

	for iter_10_0 = 1, 5 do
		if var_10_1 > arg_10_1.skill[iter_10_0].skill_level then
			arg_10_1.skill[iter_10_0].skill_level = var_10_1
			arg_10_1.modifySkill[iter_10_0] = true
		end
	end

	if var_10_2 > arg_10_1.weapon_info.level then
		arg_10_1.weapon_info.level = var_10_2
		arg_10_1.weapon_info.breakthrough = math.max(math.floor(var_10_2 / 10) - 2, 0)
		arg_10_1.weapon_info.exp = GameLevelSetting[var_10_2].weapon_lv_exp_sum
		arg_10_1.modifyWeapon = true
	end

	if arg_10_1.star < var_10_3 * 100 then
		arg_10_1.star = var_10_3 * 100
		arg_10_1.modifyStar = true
	end

	if arg_10_1.servantInfo.id ~= HeroTools.GetHeroSpecServant(arg_10_1.id) then
		arg_10_1.servantInfo = {
			uid = 0,
			locked = true,
			id = HeroTools.GetHeroSpecServant(arg_10_1.id),
			stage = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.HEOR_SERVANT_MIN_LEVEL, arg_10_2)
		}
		arg_10_1.modifyServant = true
	end
end

function ChallengeRogueTeamHeroData:GetHeroList()
	return self.unlockHeroList_
end

function ChallengeRogueTeamHeroData:GetUnlockTrailHeroList()
	return self.unlockTrailHeroList_
end

function ChallengeRogueTeamHeroData:GetUnlockTrailHero(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.unlockTrailHeroList_) do
		if HeroStandardSystemCfg[iter_13_0].hero_id == arg_13_1 then
			return iter_13_1
		end
	end
end

function ChallengeRogueTeamHeroData:GetHeroIDList(arg_14_1)
	local var_14_0 = {}
	local var_14_1 = self:GetHeroList(arg_14_1)

	for iter_14_0, iter_14_1 in pairs((not self.heroTeamLock_ or nil) and HeroData:GetHeroList()) do
		table.insert(var_14_0, iter_14_1.id)
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0 < arg_15_1
	end)

	return var_14_0
end

function ChallengeRogueTeamHeroData:GetTrialHeroList()
	return RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].hero_list
end

function ChallengeRogueTeamHeroData:GetReserveHeroList()
	return ReserveTools.GetHeroList((ReserveParams.New(ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM, 0, 1, {
		stageType = BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM
	})))
end

function ChallengeRogueTeamHeroData:GetTeamBuffAffixList(arg_18_1)
	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.TEAM_ATTRIBUTE_BUFF_LIST)
	local var_18_3 = self:GetAttriIDList()

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

function ChallengeRogueTeamHeroData:GetAttriIDList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs((clone(HeroConst.HERO_ATTACK_TYPE_STR))) do
		table.insert(var_19_0, iter_19_0)
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		return arg_20_0 < arg_20_1
	end)

	return var_19_0
end

function ChallengeRogueTeamHeroData:GetHeroFinalAttr(arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local var_21_0 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.HERO_HP_MAX_PRECENT) / 1000

	if arg_21_4 and arg_21_4 ~= 0 then
		if type(HeroStandardSystemCfg[arg_21_4].hero_attrib) == "table" then
			local var_21_1 = {}

			for iter_21_0, iter_21_1 in pairs(HeroStandardSystemCfg[arg_21_4].hero_attrib) do
				var_21_1[iter_21_1[1]] = iter_21_1[2]
			end

			var_21_1[3] = var_21_1[3] * var_21_0

			return var_21_1
		else
			local var_21_2 = GetHeroPracticalAttr(arg_21_1, arg_21_2, arg_21_3, arg_21_5, true)

			var_21_2[3] = var_21_2[3] * var_21_0

			return var_21_2
		end
	end

	local var_21_3 = GetHeroPracticalAttr(arg_21_1, arg_21_2, arg_21_3, arg_21_5, false)

	var_21_3[3] = var_21_3[3] * var_21_0

	return var_21_3
end

function ChallengeRogueTeamHeroData:RefreshFetters(arg_22_1, arg_22_2, arg_22_3)
	table.insert(self.fettersList_, {
		activityId = arg_22_1,
		fettersId = arg_22_2,
		nextTimestamps = arg_22_3
	})
end

function ChallengeRogueTeamHeroData:GetActiveFetters()
	return self.fettersList_[#self.fettersList_]
end

function ChallengeRogueTeamHeroData:SetHeroTeamProxy(arg_24_1)
	self.heroProxy_ = arg_24_1
end

function ChallengeRogueTeamHeroData:GetHeroTeamProxy()
	return self.heroProxy_
end

function ChallengeRogueTeamHeroData:ResetHeroList()
	local var_26_0, var_26_1, var_26_2, var_26_3 = self.heroProxy_:GetHeroTeam()

	ReserveTools.SetHeroList(self.heroProxy_:GetReserveParams(), var_26_0, var_26_3)
end

return ChallengeRogueTeamHeroData
