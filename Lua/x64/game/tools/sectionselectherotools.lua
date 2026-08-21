local var_0_0 = {}

function var_0_0.CreateClassDic()
	var_0_0.classDicCreatedFlag = true
	var_0_0.proxyClassDic = {
		[BattleConst.STAGE_TYPE_NEW.ABYSS] = AbyssSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX] = ActivityMatrixSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE] = ActivityRaceSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS] = ActivityWorldBossSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST] = AdvanceTestSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA] = AttributeArenaSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE] = BossChallengeSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE] = BossChallengeSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY] = GuildActivitySelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP] = GuildActivitySPSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE] = GuildBossSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE] = GuildBossSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME] = KagutsuchiSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC] = MythicSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS] = NewWarChessSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE] = PushBoxSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.SLAYER] = SlayerSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE] = SoloChallengeSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX] = StrategyMatrixSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER] = XH3rdWaterSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE] = ActivityHeroEnhanceSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION] = CoreVerificationSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER] = SummerWaterSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_SWIMSUIT_BATTLE] = ActivitySwimsuitSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME] = DestroyBoxSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN] = IndiaNianSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM] = ChallengeRogueTeamSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION] = CooperationSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.AREA_BATTLE] = AreaBattleSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE] = SequentialBattleSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.RACE_TRIAL] = ActivityRaceTrialSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.OSIRIS_PLAY_GAME] = OsirisPlayGameSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.GOD_EATER_BATTLE] = GodEaterBattleSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE] = CoreVerificationChallengeSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2] = CoreVerificationChallengeSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3] = CoreVerificationChallengeSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4] = CoreVerificationChallengeSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.HODUR_BATTLE] = ActivityHodurSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.SUMMER_PUB] = SummerPubSelectHeroProxy
	}
	var_0_0.sepecialProxyClassDic = {
		[BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL] = {
			GetProxyClass = function(arg_2_0, arg_2_1)
				if arg_2_1.contID == 2 then
					return MythicFinalMutiSelectHeroProxy
				else
					return MythicFinalSelectHeroProxy
				end
			end
		}
	}
	var_0_0.selectHeroViewUIPathDic = {
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE] = "Widget/System/Formation/Core_Verification/CoreVerificationFormationMainUI",
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2] = "Widget/System/Formation/Core_Verification/CoreVerificationFormationMainUI",
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3] = "Widget/System/Formation/Core_Verification/CoreVerificationFormationMainUI",
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4] = "Widget/System/Formation/Core_Verification/CoreVerificationFormationMainUI"
	}
end

function var_0_0.GetProxy(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.sectionType or arg_3_0.stageType
	local var_3_1 = var_0_0.GetProxyClass(var_3_0, arg_3_0, arg_3_1)

	arg_3_1 = arg_3_1 or ReserveTools.GetReserveParams(var_3_0, arg_3_0.section, arg_3_0.activityID)
	arg_3_2 = arg_3_2 or HeroConst.HERO_DATA_TYPE.DEFAULT

	return var_3_1.New(arg_3_0, arg_3_1, arg_3_2)
end

function var_0_0.GetProxyClass(arg_4_0, arg_4_1, arg_4_2)
	if not var_0_0.classDicCreatedFlag then
		var_0_0.CreateClassDic()
	end

	if not arg_4_0 then
		return SelectHeroBaseProxy
	end

	if var_0_0.sepecialProxyClassDic[arg_4_0] then
		return var_0_0.sepecialProxyClassDic[arg_4_0].GetProxyClass(arg_4_1, arg_4_2)
	end

	return var_0_0.proxyClassDic[arg_4_0] or SelectHeroBaseProxy
end

function var_0_0.IsDiffViewClass(arg_5_0, arg_5_1)
	local var_5_0 = false

	if arg_5_0.__cname ~= arg_5_1.__cname then
		var_5_0 = true
	end

	return var_5_0
end

function var_0_0.ReloadView(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.gameObject_
	local var_6_1 = arg_6_0.transform_.parent
	local var_6_2 = Object.Instantiate(var_6_0, var_6_1)
	local var_6_3 = arg_6_1.New(var_6_2, var_6_1)

	arg_6_0:Dispose()

	return var_6_3
end

function var_0_0.GetSelectHeroViewUIPath(arg_7_0)
	if not var_0_0.classDicCreatedFlag then
		var_0_0.CreateClassDic()
	end

	return var_0_0.selectHeroViewUIPathDic[arg_7_0] or "Widget/System/Formation/FormationMainUI"
end

function var_0_0.GetRestrictHeroList(arg_8_0, arg_8_1)
	local var_8_0 = {
		{},
		{},
		{}
	}
	local var_8_1 = var_0_0.GetDefaultCanSwitchResctrictHeroList()

	if arg_8_0 and arg_8_1 and arg_8_1 ~= 0 then
		local var_8_2, var_8_3 = BattleStageTools.GetRestrictHeroList(arg_8_0, arg_8_1)

		if type(var_8_3) == "table" then
			var_8_1 = var_8_3
		end

		if type(var_8_2) == "table" then
			var_8_0 = var_8_2
		end
	end

	return var_8_0, var_8_1
end

function var_0_0.GetRestrictHeroPosDic(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.GetRestrictHeroList(arg_9_0, arg_9_1)
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_3 = 1
		local var_9_4 = 2

		while var_9_3 <= #iter_9_1 and var_9_4 <= #iter_9_1 do
			local var_9_5 = iter_9_1[var_9_3]
			local var_9_6 = iter_9_1[var_9_4]

			if var_9_5 ~= 0 and HeroCfg[var_9_5] and HeroCfg[var_9_5].private == 0 then
				var_9_1[var_9_5] = iter_9_0
				var_9_2[var_9_6] = iter_9_0
			end

			var_9_3 = var_9_3 + 2
			var_9_4 = var_9_4 + 2
		end
	end

	return var_9_1, var_9_2
end

function var_0_0.IsInTeam(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = false
	local var_10_1 = false
	local var_10_2 = -1

	arg_10_2 = arg_10_2 or {}
	arg_10_3 = arg_10_3 or {}

	for iter_10_0, iter_10_1 in pairs(arg_10_2) do
		if arg_10_0 == iter_10_1 and arg_10_1 == arg_10_3[iter_10_0] then
			var_10_0 = true
			var_10_1 = iter_10_0 == 1
			var_10_2 = iter_10_0

			break
		end
	end

	return var_10_0, var_10_1, var_10_2
end

function var_0_0.IsSameHeroInTeam(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or {}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		if arg_11_0 == iter_11_1 then
			return true, iter_11_0
		end
	end

	return false, nil
end

function var_0_0.IsHeroDataEqual(arg_12_0, arg_12_1)
	if arg_12_0.id ~= arg_12_1.id then
		return false
	end

	if arg_12_0.trialID ~= arg_12_1.trialID then
		return false
	end

	if arg_12_0.type ~= arg_12_1.type then
		return false
	end

	return true
end

function var_0_0.IsEmptyTeam(arg_13_0)
	arg_13_0 = arg_13_0 or {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0) do
		if iter_13_1 ~= 0 then
			return false
		end
	end

	return true
end

function var_0_0.IsAllPosFullLock(arg_14_0, arg_14_1)
	if not arg_14_1 or arg_14_1 == 0 then
		return false
	end

	if not BattleStageTools.GetStageCfg(arg_14_0, arg_14_1) then
		return false
	end

	local var_14_0 = true
	local var_14_1, var_14_2 = SectionSelectHeroTools.GetRestrictHeroList(arg_14_0, arg_14_1)

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if not iter_14_1[1] or var_14_2[iter_14_0] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
			var_14_0 = false

			break
		end
	end

	return var_14_0
end

function var_0_0.ReorderHeroTeam(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or var_0_0.GetDefaultCanSwitchResctrictHeroList()

	local var_15_0 = 1
	local var_15_1 = 2

	while var_15_0 <= 3 and var_15_1 <= 3 do
		if arg_15_0[var_15_0] == 0 then
			if arg_15_2[var_15_1] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID and arg_15_0[var_15_1] ~= 0 then
				arg_15_0[var_15_0] = arg_15_0[var_15_1]
				arg_15_1[var_15_0] = arg_15_1[var_15_1]
				arg_15_0[var_15_1] = 0
				arg_15_1[var_15_1] = 0
				var_15_0 = var_15_1
			end
		else
			var_15_0 = var_15_0 + 1
		end

		var_15_1 = var_15_1 + 1
	end
end

function var_0_0.GetDefaultCanSwitchResctrictHeroList()
	local var_16_0 = {}
	local var_16_1 = ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID

	return {
		var_16_1,
		var_16_1,
		var_16_1
	}
end

function var_0_0.IsReserveProposalEqual(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6)
	local var_17_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.PROPOSAL, arg_17_0)
	local var_17_1 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL, arg_17_5)
	local var_17_2 = var_17_1:GetHeroList(var_17_0)

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		if iter_17_1 ~= var_17_2[iter_17_0] then
			return false
		end
	end

	if arg_17_2 ~= var_17_1:GetComboSkillID(var_17_0) then
		return false
	end

	local var_17_3, var_17_4 = var_17_1:GetMimirData(var_17_0)

	if arg_17_3 ~= var_17_3 then
		return false
	end

	if #arg_17_4 ~= #var_17_4 then
		return false
	end

	local var_17_5 = {}

	for iter_17_2, iter_17_3 in ipairs(var_17_4) do
		var_17_5[iter_17_3] = true
	end

	for iter_17_4, iter_17_5 in ipairs(arg_17_4) do
		if not var_17_5[iter_17_5] then
			return false
		end
	end

	if arg_17_6 ~= var_17_1:GetCharChipBaseID(var_17_0) then
		return false
	end

	return true
end

function var_0_0.IsNeedDisplayFilterLockHero(arg_18_0, arg_18_1)
	if not arg_18_0.needDisplayFilterLocalHero then
		return false
	end

	if #arg_18_1.filterLockHeroList == 0 then
		return false
	end

	if manager.time:IsToday(var_0_0.GetSkipDisplayFilterLockHeroTime()) then
		return false
	end

	return true
end

function var_0_0.SetSkipDisplayFilterLockHeroTime(arg_19_0)
	saveData("section_select_hero", "SkipDisplayFilterLockHeroTime", arg_19_0)
end

function var_0_0.GetSkipDisplayFilterLockHeroTime()
	return getData("section_select_hero", "SkipDisplayFilterLockHeroTime") or 0
end

function var_0_0.CanUseMultiMode(arg_21_0, arg_21_1)
	if not arg_21_0 or not arg_21_1 or arg_21_1 == 0 then
		return false
	end

	local var_21_0 = var_0_0.GetRestrictHeroList(arg_21_0, arg_21_1)

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1[1] and iter_21_1[1] ~= 0 then
			return false
		end
	end

	return true
end

function var_0_0.GetModelOffsetPosition(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0
	local var_22_1

	if arg_22_0.x <= arg_22_1.x then
		var_22_0 = SectionSelectHeroConst.f2SModelDistanceX
		var_22_1 = SectionSelectHeroConst.f2SModelDistanceZ
	else
		var_22_0 = SectionSelectHeroConst.f2TModelDistanceX
		var_22_1 = SectionSelectHeroConst.f2TModelDistanceZ
	end

	local var_22_2 = Vector3(0, 0, 0)
	local var_22_3 = (arg_22_1.x - arg_22_0.x) / arg_22_2

	var_22_2.x = var_22_3 * var_22_0

	if var_22_3 > 0 then
		var_22_2.z = -var_22_3 * var_22_1
	else
		var_22_2.z = var_22_3 * var_22_1
	end

	return var_22_2
end

function var_0_0.GetModelOffsetRotation(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0

	if arg_23_0.x <= arg_23_1.x then
		var_23_0 = SectionSelectHeroConst.f2SModelRotationY
	else
		var_23_0 = SectionSelectHeroConst.f2TModelRotationY
	end

	local var_23_1 = Vector3(0, 0, 0)

	var_23_1.y = (arg_23_1.x - arg_23_0.x) / arg_23_2 * var_23_0

	return var_23_1
end

function var_0_0.SetCurSelectHeroData(arg_24_0)
	var_0_0.curSelectHeroData = arg_24_0
end

function var_0_0.GetCurSelectHeroData()
	return var_0_0.curSelectHeroData
end

function var_0_0.GetRuntimeScreenOffsetOfHeroInfoItem()
	if _G.SCREEN_HEIGHT < 1080 then
		return SectionSelectHeroConst.SCREEN_OFFSET_OF_HERO_INFO_ITEM / 1080 * _G.SCREEN_HEIGHT
	else
		return SectionSelectHeroConst.SCREEN_OFFSET_OF_HERO_INFO_ITEM
	end
end

return var_0_0
