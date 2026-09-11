local var_0_0 = {
	reserveTemplateClassDic = {
		[ReserveConst.RESERVE_TYPE.DEFAULT] = "ReserveBaseTemplate",
		[ReserveConst.RESERVE_TYPE.PROPOSAL] = "ReserveProposalTemplate",
		[ReserveConst.RESERVE_TYPE.ABYSS] = "ReserveAbyssTemplate",
		[ReserveConst.RESERVE_TYPE.BOSS_CHALLENGE] = "ReserveBossChallengeTemplate",
		[ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE] = "ReserveSoloChallengeTemplate",
		[ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE] = "ReserveSequentialBattleTemplate",
		[ReserveConst.RESERVE_TYPE.ATTRIBUTE_ARENA] = "ReserveAttributeArenaTemplate",
		[ReserveConst.RESERVE_TYPE.GUILD_BOSS] = "ReserveGuildBossTemplate",
		[ReserveConst.RESERVE_TYPE.CORE_VERIFICATION] = "ReserveCoreVerificationTemplate",
		[ReserveConst.RESERVE_TYPE.GUILD_ACTIVITY] = "ReserveGuildActivityTemplate",
		[ReserveConst.RESERVE_TYPE.WATER] = "ReserveSummerWaterTemplate",
		[ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM] = "ReserveChallengeRogueTeamTemplate",
		[ReserveConst.RESERVE_TYPE.SWIMSUIT_BATTLE] = "ReserveSwimsuitBattleTemplate",
		[ReserveConst.RESERVE_TYPE.AREA_BATTLE] = "ReserveAreaBattleTemplate",
		[ReserveConst.RESERVE_TYPE.OSIRIS_PLAY_GAME] = "ReserveOsirisPlayGameBattleTemplate",
		[ReserveConst.RESERVE_TYPE.CORE_VERIFICATION_CHALLENGE] = "ReserveCoreVerificationChallengeTemplate",
		[ReserveConst.RESERVE_TYPE.HODUR_BATTLE] = "ReserveHodurChallengeTemplate",
		[ReserveConst.RESERVE_TYPE.ADVANCE_TEST] = "ReserveAdvanceTestTemplate"
	},
	contDataClassDic = {
		[ReserveConst.RESERVE_TYPE.DEFAULT] = "ReserveContDataTemplate",
		[ReserveConst.RESERVE_TYPE.PROPOSAL] = "ReserveProposalContDataTemplate",
		[ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE] = "ReserveSoloChallengeContDataTemplate",
		[ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE] = "ReserveSequentialContDataTemplate",
		[ReserveConst.RESERVE_TYPE.MULTI_CHESS] = "ReserveMultiChessContDataTemplate",
		[ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM] = "ReserveChallengeRogueTeamContDataTemplate"
	},
	singleTeamDataClassDic = {
		[ReserveConst.RESERVE_TYPE.DEFAULT] = "ReserveSingleTeamDataTemplate",
		[ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE] = "ReserveSoloChallengeSingleTeamDataTemplate",
		[ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE] = "ReserveSequentialSingleTeamDataTemplate",
		[ReserveConst.RESERVE_TYPE.MULTI_CHESS] = "ReserveMultiChessSingleTeamDataTemplate",
		[ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM] = "ReserveChangeRogueTeamSingleTeamDataTemplate"
	},
	heroPosDataClassDic = {
		[ReserveConst.RESERVE_TYPE.DEFAULT] = "ReserveHeroPosTemplate",
		[ReserveConst.RESERVE_TYPE.GUILD_BOSS] = "ReserveGuildBossHeroPosTemplate",
		[ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM] = "ReserveChangeRogueTeamHeroPosTemplate"
	},
	mimirDataClassDic = {
		[ReserveConst.RESERVE_TYPE.DEFAULT] = "ReserveMimirDataTemplate"
	},
	GetReserveType = function(arg_1_0, arg_1_1)
		local var_1_0 = ReserveConst.RESERVE_TYPE.NOT_NEED_RESERVE

		if arg_1_0 and arg_1_1 and arg_1_1 ~= 0 then
			local var_1_1 = BattleStageTools.GetStageCfg(arg_1_0, arg_1_1)

			if var_1_1.team_type and var_1_1.team_type[1] then
				var_1_0 = var_1_1.team_type[1]
			end
		end

		return var_1_0
	end,
	GetContID = function(arg_2_0, arg_2_1)
		local var_2_0 = ReserveConst.DETAULT_CONT_ID

		if arg_2_0 and arg_2_1 and arg_2_1 ~= 0 then
			local var_2_1 = BattleStageTools.GetStageCfg(arg_2_0, arg_2_1)

			if var_2_1.team_type and var_2_1.team_type[2] then
				var_2_0 = var_2_1.team_type[2]
			end
		end

		return var_2_0
	end,
	NeedDefaultTeam = function(arg_3_0, arg_3_1)
		if not arg_3_0 or not arg_3_1 or arg_3_1 == 0 then
			return false
		end

		local var_3_0 = BattleStageTools.GetStageCfg(arg_3_0, arg_3_1)

		if var_3_0.need_default_team then
			return var_3_0.need_default_team == ReserveConst.NEED_DEFAULT_TEAM
		end

		return false
	end,
	NeedCacheTeam = function(arg_4_0, arg_4_1)
		if arg_4_0 and arg_4_1 and arg_4_1 ~= 0 then
			local var_4_1 = BattleStageTools.GetStageCfg(arg_4_0, arg_4_1)

			if var_4_1.team_type and var_4_1.team_type[2] then
				return var_4_1.team_type[2] ~= ReserveConst.NOT_NEED_CACHE_CONT_ID
			end
		end

		return false
	end,
	GetReserveParams = function(arg_5_0, arg_5_1, arg_5_2)
		return ReserveParams.New(ReserveTools.GetReserveType(arg_5_0, arg_5_1), ReserveTools.GetContID(arg_5_0, arg_5_1), nil, {
			stageType = arg_5_0,
			stageID = arg_5_1,
			activityID = arg_5_2 or 0
		})
	end,
	GetReserveTemplateByReserveType = function(arg_6_0, arg_6_1)
		return not arg_6_1 and ReserveData:GetTeamTemplate(arg_6_0) or ReserveData:GetServerTeamTemplate(arg_6_0)
	end,
	GetReserveTemplate = function(arg_7_0, arg_7_1)
		return (ReserveData:GetTeamTemplate((ReserveTools.GetReserveType(arg_7_0, arg_7_1))))
	end,
	SetTeam = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
		ReserveTools.SetHeroList(arg_8_0, arg_8_1, arg_8_2)
		ReserveTools.SetComboSkillID(arg_8_0, arg_8_3)
		ReserveTools.SetMimirID(arg_8_0, arg_8_4)
		ReserveTools.SetMimirChipList(arg_8_0, arg_8_5)
		ReserveTools.SetCharChipBaseID(arg_8_0, arg_8_6 or 0)
	end,
	CleanCacheData = function(arg_9_0)
		ReserveTools.GetReserveTemplateByReserveType(arg_9_0):CleanCacheData()
	end
}

function var_0_0:GetHeroList()
	self = var_0_0.CheckReserveParams(self)

	local var_10_5, var_10_6, var_10_7, var_10_8, var_10_9 = ReserveTools.GetReserveTemplateByReserveType(self.reserveType):GetHeroList(self)

	return var_10_5, var_10_6, var_10_7, var_10_8, var_10_9
end

function var_0_0:SetHeroList(arg_11_1, arg_11_2)
	self = var_0_0.CheckReserveParams(self)

	ReserveTools.GetReserveTemplateByReserveType(self.reserveType):SetHeroList(self, arg_11_1, arg_11_2)
end

function var_0_0:GetAddedHeroIDList()
	self = var_0_0.CheckReserveParams(self)

	return ReserveTools.GetReserveTemplateByReserveType(self.reserveType):GetAddedHeroIDList(self)
end

function var_0_0:GetComboSkillID()
	self = var_0_0.CheckReserveParams(self)

	return ReserveTools.GetReserveTemplateByReserveType(self.reserveType):GetComboSkillID(self)
end

function var_0_0:GetRawComboSkillID()
	self = var_0_0.CheckReserveParams(self)

	return ReserveTools.GetReserveTemplateByReserveType(self.reserveType):GetRawComboSkillID(self)
end

function var_0_0:SetComboSkillID(arg_15_1)
	self = var_0_0.CheckReserveParams(self)

	ReserveTools.GetReserveTemplateByReserveType(self.reserveType):SetComboSkillID(self, arg_15_1)
end

function var_0_0:GetValidComboSkillID(arg_16_1)
	self = var_0_0.CheckReserveParams(self)

	return ReserveTools.GetReserveTemplateByReserveType(self.reserveType):GetValidComboSkillID(self, arg_16_1)
end

function var_0_0:GetMimirData()
	self = var_0_0.CheckReserveParams(self)

	local var_17_0, var_17_1 = ReserveTools.GetReserveTemplateByReserveType(self.reserveType):GetMimirData(self)

	return var_17_0, var_17_1
end

function var_0_0:GetMimirID()
	self = var_0_0.CheckReserveParams(self)

	return ReserveTools.GetReserveTemplateByReserveType(self.reserveType):GetMimirID(self)
end

function var_0_0:SetMimirID(arg_19_1)
	self = var_0_0.CheckReserveParams(self)

	ReserveTools.GetReserveTemplateByReserveType(self.reserveType):SetMimirID(self, arg_19_1)
end

function var_0_0:GetMimirChipList()
	self = var_0_0.CheckReserveParams(self)

	return ReserveTools.GetReserveTemplateByReserveType(self.reserveType):GetMimirChipList(self)
end

function var_0_0:SetMimirChipList(arg_21_1)
	self = var_0_0.CheckReserveParams(self)

	ReserveTools.GetReserveTemplateByReserveType(self.reserveType):SetMimirChipList(self, arg_21_1)
end

function var_0_0:InsertMimirChip(arg_22_1)
	self = var_0_0.CheckReserveParams(self)

	local var_22_0 = ReserveTools.GetReserveTemplateByReserveType(self.reserveType)

	ChipTools.InsertChip(var_22_0:GetMimirChipList(self), arg_22_1, function(arg_23_0)
		var_22_0:SetMimirChipList(self, arg_23_0)
	end)
end

function var_0_0:RemoveMimirChip(arg_24_1)
	self = var_0_0.CheckReserveParams(self)

	local var_24_0 = ReserveTools.GetReserveTemplateByReserveType(self.reserveType)

	ChipTools.RemoveChip(var_24_0:GetMimirChipList(self), arg_24_1, function(arg_25_0)
		var_24_0:SetMimirChipList(self, arg_25_0)
	end)
end

function var_0_0:ResetMimirChipList()
	self = var_0_0.CheckReserveParams(self)

	ReserveTools.GetReserveTemplateByReserveType(self.reserveType):ResetMimirChipList(self)
end

function var_0_0:GetCharChipBaseID()
	self = var_0_0.CheckReserveParams(self)

	return ReserveTools.GetReserveTemplateByReserveType(self.reserveType):GetCharChipBaseID(self)
end

function var_0_0:SetCharChipBaseID(arg_28_1)
	self = var_0_0.CheckReserveParams(self)

	return ReserveTools.GetReserveTemplateByReserveType(self.reserveType):SetCharChipBaseID(self, arg_28_1)
end

function var_0_0:GetCharChipExtraIDList()
	local var_29_0 = ReserveTools.GetCharChipBaseID(self)

	if var_29_0 == 0 then
		return {}
	end

	self = var_0_0.CheckReserveParams(self)

	local var_29_1 = ReserveTools.GetReserveTemplateByReserveType(self.reserveType):GetCharChipExtraIDList(self, var_29_0)

	if var_29_1 ~= nil then
		return var_29_1
	end

	return ChipTools.GetCharChipExtraIDListUnlock(var_29_0)
end

function var_0_0.GetCharChipIDList(arg_30_0)
	local var_30_0 = ReserveTools.GetCharChipBaseID(arg_30_0)

	if var_30_0 == 0 then
		return {}
	end

	local var_30_1 = {
		var_30_0
	}

	table.insertto(var_30_1, (ReserveTools.GetCharChipExtraIDList(arg_30_0, var_30_0)))

	return var_30_1
end

function var_0_0.ResetContData(arg_31_0, arg_31_1)
	ReserveTools.GetReserveTemplateByReserveType(arg_31_0):GetContDataTemplateById(arg_31_1):Reset()
end

function var_0_0.SwapTeam(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	ReserveTools.GetReserveTemplateByReserveType(arg_32_0):GetContDataTemplateById(arg_32_1):SwapTeam(arg_32_2, arg_32_3)
end

function var_0_0.GetReserveTemplateClass(arg_33_0)
	return _G[var_0_0.reserveTemplateClassDic[arg_33_0] or var_0_0.reserveTemplateClassDic[ReserveConst.RESERVE_TYPE.DEFAULT]]
end

function var_0_0.GetContDataClass(arg_34_0)
	return _G[var_0_0.contDataClassDic[arg_34_0] or var_0_0.contDataClassDic[ReserveConst.RESERVE_TYPE.DEFAULT]]
end

function var_0_0.GetSingleTeamDataClass(arg_35_0)
	return _G[var_0_0.singleTeamDataClassDic[arg_35_0] or var_0_0.singleTeamDataClassDic[ReserveConst.RESERVE_TYPE.DEFAULT]]
end

function var_0_0.GetHeroPosDataClass(arg_36_0)
	return _G[var_0_0.heroPosDataClassDic[arg_36_0] or var_0_0.heroPosDataClassDic[ReserveConst.RESERVE_TYPE.DEFAULT]]
end

function var_0_0.GetMimirDataClass(arg_37_0)
	return _G[var_0_0.mimirDataClassDic[arg_37_0] or var_0_0.mimirDataClassDic[ReserveConst.RESERVE_TYPE.DEFAULT]]
end

function var_0_0:CheckReserveParams()
	if not self then
		self = ReserveParams.New(ReserveConst.RESERVE_TYPE.DEFAULT)

		Debug.LogError("编队参数为空，使用默认编队参数")
	end

	if not self.reserveType then
		self.reserveType = ReserveConst.RESERVE_TYPE.DEFAULT

		Debug.LogError("编队类型为空，使用默认编队类型")
	end

	return self
end

return var_0_0
