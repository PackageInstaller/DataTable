-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleSkipTimeMgr.lua

module("logic.extensions.battle.model.BattleSkipTimeMgr", package.seeall)

local BattleSkipTimeMgr = class("BattleSkipTimeMgr")

function BattleSkipTimeMgr:setCurrFightConfig(cfg)
	self._currFightConfig = cfg
end

function BattleSkipTimeMgr:getSkipTime()
	local time = self:_getSkipTime()

	if not time or time == 0 then
		return (not BattleModel.instance.testSkippedBattle and Framework.OSDef.isEditor or nil) and 1
	end

	return time
end

function BattleSkipTimeMgr:getNextSkipTimeVipLv()
	local skipTime = self:getSkipTime()
	local vipLv, vipNextTime = VipModel.instance:getNextSkipBattleTime(skipTime)

	if vipLv and vipNextTime and vipNextTime < skipTime then
		return vipLv, vipNextTime
	end
end

function BattleSkipTimeMgr:_getSkipTime()
	if BattleModel.instance.maxFetter then
		return self:_checkSkipTime(self:getBuddyFetterSkipTime())
	end

	if BattleModel.instance.copyId then
		return self:_checkSkipTime(self:getPlotCopySkipTime())
	end

	if BattleModel.instance.resChapterId then
		return self:_checkSkipTime(self:getResCopySkipTime())
	end

	if BattleModel.instance.pveId then
		return self:_checkSkipTime(self:getPVESkipTime())
	end

	if BattleModel.instance.wtowerIndex then
		return self:_checkSkipTime(self:getWTowerSkipTime())
	end

	if BattleModel.instance.herotrialBossId then
		return self:_checkSkipTime(self:getHeroTrialSkipTime())
	end

	if BattleModel.instance.breakFormationId then
		return self:_checkSkipTime(self:getBreakFormationSkipTime())
	end

	if BattleModel.instance.legendChallengeId then
		return self:_checkSkipTime(self:getLegendSkipTime())
	end

	if BattleModel.instance.kindRoadId then
		return self:_checkSkipTime(self:getKingRoadSkipTime())
	end

	if BattleModel.instance.kingWayId then
		return self:_checkSkipTime(self:getKingWaySkipTime())
	end

	if BattleModel.instance.nightPalaceStageId then
		return self:_checkSkipTime(self:getNinePalaceSkipTime())
	end

	if BattleModel.instance.expedition then
		return self:_checkSkipTime(self:getExpeditionSkipTime())
	end

	if BattleModel.instance.familyBossId then
		return self:_checkSkipTime(self:getFamilyBossSkipTime())
	end

	if BattleModel.instance.worldBossId then
		return self:_checkSkipTime(self:getWorldBossSkipTime())
	end

	if BattleModel.instance.sccopyTypeId then
		return self:_checkSkipTime(self:getSCCopySkipTime())
	end

	if BattleModel.instance.summonTowerGridId then
		return self:_checkSkipTime(self:getSummonTowerSkipTime())
	end

	if BattleModel.instance.isMangTower1v1 or BattleModel.instance.isMangTower3v3 then
		return self:_checkSkipTime(self:getMangTowerSkipTime())
	end

	if BattleModel.instance.isYirenPozhen then
		return self:_checkSkipTime(0)
	end

	if BattleModel.instance.xinxiyaMirrorMasterId then
		return self:_checkSkipTime(self:getXinxiyaMirrorSkipTime())
	end

	if BattleModel.instance.isPreviewPet then
		return 5
	end

	if BattleModel.instance.viewFightBtl then
		return 0
	end

	if BattleModel.instance.isArena then
		return 5
	end

	if BattleModel.instance.familyTeamPlayType then
		return self:_checkSkipTime(self:getFamilyTeamPlaySkipTime(BattleModel.instance.familyTeamPlayType))
	end

	if BattleModel.instance.isEndlessBattle then
		return self:_checkSkipTime(self:getEndlessBattleSkipTime())
	end

	if BattleModel.instance.Infinitefuture then
		return self:_checkSkipTime(self:getInfinitefutureSkipTime())
	end

	if BattleModel.instance.InfinitefutureCommon then
		return self:_checkSkipTime(self:getInfinitefutureCommonSkipTime())
	end

	if BattleModel.instance.goddesGloryChallengeId then
		return self:_checkSkipTime(self:getGoddesGloryBattleSkipTime())
	end

	if BattleModel.instance.isXinxiyaMirror then
		return self:_checkSkipTime(0)
	end

	if BattleModel.instance.isWLTower then
		return self:_checkSkipTime(0)
	end

	if BattleModel.instance.isLongyanSQ then
		return self:_checkSkipTime(self:getSQLongYanSkipTime())
	end

	if BattleModel.instance.shareCreepsMasterId ~= nil then
		return self:_checkSkipTime(self:getShareTaskSkipTime())
	end

	if BattleModel.instance.exploreUnderFightCreepId then
		return self:_checkSkipTime(self:getExploreUnderFightSkipTime())
	end

	if BattleModel.instance.SKTFightCfg then
		return self:_checkSkipTime(BattleModel.instance.SKTFightCfg.skipTime)
	end

	if BattleModel.instance.isPowerLandChallenge then
		return self:_checkSkipTime(self:getPowerLandChallengeSkipTime())
	end

	if BattleModel.instance.isLailisiChallenge then
		return self:_checkSkipTime(self:getLailisiChallengeSkipTime())
	end

	if BattleModel.instance.VillainPet then
		return self:_checkSkipTime(self:getisVillaintrialSkipTime())
	end

	if BattleModel.instance.HolyStripeCopyFight and BattleModel.instance.HolyStripeCopyFight ~= 2 then
		return self:_checkSkipTime(self:getHolyStripeCopySoloSkipTime())
	end

	if BattleModel.instance.mkpBattle then
		return self:_checkSkipTime(self:getMKPBattleSkipTime())
	end

	if BattleModel.instance.PeakTournamentFight then
		return self:_checkSkipTime(self:getPTBattleSkipTime())
	end

	if BattleModel.instance.StartGodStatuesWar then
		return self:_checkSkipTime(self:getGodStatuesWarSkipTime())
	end

	if BattleModel.instance.isGuardCityChallenge then
		return self:_checkSkipTime(self:getGuardCityChallengeSkipTime())
	end

	if BattleModel.instance.isElementSpark then
		return self:_checkSkipTime(self:_getElementSparkSkipTime())
	end

	if self._currFightConfig then
		return checknumber(self._currFightConfig.skipTime)
	end

	return 0
end

function BattleSkipTimeMgr:_checkSkipTime(skipTime)
	local vipLv = VipModel.instance:getCurVipLv()

	if skipTime == 0 then
		skipTime = vipLv == 0 and VipConfig.instance:getParamInt("VIP0_SKIP_FIGHT_TIME_LIMIT") or VipModel.instance:getTimesOfSkipBattle()
	end

	if BattleModel.instance.enableSkip == GameEnum.SkipType.VIP_FIRST_SKIP then
		if vipLv == 0 then
			return VipConfig.instance:getParamInt("VIP0_SKIP_FIGHT_TIME_LIMIT")
		else
			return skipTime
		end
	end

	return skipTime
end

function BattleSkipTimeMgr:getPlotCopySkipTime()
	local copyId = BattleModel.instance.copyId
	local copyLevelId = BattleModel.instance.copyLevelId

	if copyId and copyLevelId then
		local stageCo = CopyConfig.instance:getStageById(copyId, copyLevelId)
		local teamCo = CopyConfig.instance:getTeamCfg(stageCo.teamIds)

		if teamCo then
			return teamCo.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getResCopySkipTime()
	local chapterId = BattleModel.instance.resChapterId
	local stageId = BattleModel.instance.resStageId

	if chapterId and stageId then
		local stageCo = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)
		local teamCo = MaterialChallengeConfig.instance:getTeamCfg(stageCo.teamIds)

		if teamCo then
			return teamCo.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getPVESkipTime()
	local pveId = BattleModel.instance.pveId

	if pveId and pveId > 0 then
		local teamCo = CopyConfig.instance:getTeamCfg(pveId)

		if teamCo then
			return teamCo.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getWTowerSkipTime()
	local wtowerIndex = BattleModel.instance.wtowerIndex
	local towerId = WTowerModel.instance:getTowerId()

	if wtowerIndex and wtowerIndex > 0 then
		local wtowerCo = WTowerConfig.instance:getCfgById(wtowerIndex, towerId)

		if wtowerCo then
			return wtowerCo.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getHeroTrialSkipTime()
	local bossId = BattleModel.instance.herotrialBossId

	if bossId and bossId > 0 then
		local wtowerCo = HerotrialConfig.instance:getBossCfgById(bossId)

		if wtowerCo then
			return wtowerCo.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getKingRoadSkipTime()
	local kindRoadId = BattleModel.instance.kindRoadId

	if kindRoadId and kindRoadId > 0 then
		local kindRoadCo = PetTrialConfig.instance:getStageCfgById(kindRoadId)

		if kindRoadCo then
			return kindRoadCo.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getKingWaySkipTime()
	local kingWayId = BattleModel.instance.kingWayId
	local kingWayStageId = BattleModel.instance.kingWayStageId

	if kingWayId and kingWayId > 0 and kingWayStageId and kingWayStageId > 0 then
		local allCfgs = KingWayConfig.instance:GetWayStageCfg(kingWayId)

		if allCfgs == nil or allCfgs[kingWayStageId] == nil then
			return 0
		end

		local cfg = allCfgs[kingWayStageId]

		if cfg then
			return cfg.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getBreakFormationSkipTime()
	local breakFormationId = BattleModel.instance.breakFormationId
	local breakFormationLvId = BattleModel.instance.breakFormationLvId

	if breakFormationId and breakFormationId > 0 and breakFormationLvId and breakFormationLvId > 0 then
		local cfg = BreakFormationConfig.instance:getMonsterCfg(breakFormationId, breakFormationLvId)

		if cfg then
			return cfg.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getLegendSkipTime()
	local legendChallengeId = BattleModel.instance.legendChallengeId
	local legendStageIdId = BattleModel.instance.legendStageIdId

	if legendChallengeId and legendChallengeId > 0 and legendStageIdId and legendStageIdId > 0 then
		local cfg = LegendConfig.instance:getLegendChallengeStageCfg(legendChallengeId, legendStageIdId)

		if cfg then
			return cfg.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getNinePalaceSkipTime()
	local nightPalaceStageId = BattleModel.instance.nightPalaceStageId
	local nightPalaceMasterId = BattleModel.instance.nightPalaceMasterId

	if nightPalaceStageId and nightPalaceStageId > 0 and nightPalaceMasterId then
		local cfg = NinePlaceConfig.instance:getMonsterCfg(nightPalaceStageId, nightPalaceMasterId)

		if cfg then
			return cfg.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getExpeditionSkipTime()
	local expedition = BattleModel.instance.expedition

	if expedition then
		local skipTime = ExpeditionConfig.instance:getConstInt("skipTime")

		return skipTime or 0
	end

	return 0
end

function BattleSkipTimeMgr:getFamilyBossSkipTime()
	local familyBossId = BattleModel.instance.familyBossId

	if familyBossId and familyBossId > 0 then
		local monsterCo = FamilyConfig.instance:getFamilyBossCfg(familyBossId)

		if monsterCo then
			return monsterCo.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getWorldBossSkipTime()
	local worldBossId = BattleModel.instance.worldBossId

	if worldBossId and worldBossId > 0 then
		local monsterCo = WorldBossConfig.instance:getWorldBossTeamCo(worldBossId)

		if monsterCo then
			return monsterCo.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getSCCopySkipTime()
	local sccopyActivityId = BattleModel.instance.sccopyActivityId
	local sccopyTypeId = BattleModel.instance.sccopyTypeId
	local sccopyChapterId = BattleModel.instance.sccopyChapterId

	if sccopyActivityId and sccopyTypeId and sccopyChapterId then
		local stageCfg = ScenariocopyConfig.instance:getStageCfg(sccopyTypeId, sccopyChapterId)

		if stageCfg then
			return stageCfg.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getSummonTowerSkipTime()
	local summonTowerGridId = BattleModel.instance.summonTowerGridId

	if summonTowerGridId then
		local gridData = SummontowerMapModel.instance:getMapGridData(summonTowerGridId)

		if not gridData then
			return 0
		end

		if gridData.gridEventType ~= SummonGridEvtType.Guard then
			return 0
		end

		local evtCo = SummontowerConfig.instance:getGuardEventCo(gridData.gridEventId)

		if not evtCo then
			return 0
		end

		return evtCo.skipTime or 0
	end
end

function BattleSkipTimeMgr:getMangTowerSkipTime()
	local cfg = MangTowerModel.instance:getCurCfg()

	if cfg then
		return cfg.skipTime or 0
	end

	return 0
end

function BattleSkipTimeMgr:getXinxiyaMirrorSkipTime()
	local masterId = BattleModel.instance.xinxiyaMirrorMasterId

	if masterId and masterId > 0 then
		local teamCfg = XinxiyaMirrorConfig.instance:getMasterTeamCfg(masterId)

		if teamCfg then
			return teamCfg.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getYirenPozhenSkipTime()
	local creepsMasterId = YirenPozhenModel.instance:getcreepsMasterId()
	local cfg = YirenPozhenConfig.instance:getTeamCfg(creepsMasterId)

	if cfg then
		return cfg.skipTime or 0
	end

	return 0
end

function BattleSkipTimeMgr:getFamilyTeamPlaySkipTime(tpType)
	if tpType == nil then
		return 0
	end

	local baseInfo = FamilyteamplayModel.instance:getBaseProgressInfo()

	if baseInfo == nil or checknumber(baseInfo.periodId) <= 0 or baseInfo.progressInfo == nil then
		return 0
	end

	local info = baseInfo.progressInfo[tpType]

	if info == nil or checknumber(info.realBossId) <= 0 then
		return 0
	end

	local cfg = FamilyteamplayConfig.instance:getBossCfg(baseInfo.periodId, info.realBossId)
	local monsterCfg = FamilyteamplayConfig.instance:getMonsterCfg(cfg.creepMasterId)

	return monsterCfg.skipTime
end

function BattleSkipTimeMgr:getEndlessBattleSkipTime()
	local waveId = EndlessBattleModel.instance:getCurWaveId()
	local stageCfgs = EndlessBattleConfig.instance:getStageCfgsByWaveId(waveId)
	local defendCount = EndlessBattleController.instance:getDefendCount()
	local stageCfg = stageCfgs[defendCount + 1]

	if stageCfg then
		local teamCfg = EndlessBattleConfig.instance:getTeamCfg(stageCfg.creepsMasterId)

		return teamCfg.skipTime
	end

	return 0
end

function BattleSkipTimeMgr:getInfinitefutureSkipTime()
	local actId = InfinitefutureModel.instance.curActId
	local stageId = InfinitefutureModel.instance.curStageId
	local teamId = InfinitefutureModel.instance.curTeamID
	local stageCfg = InfinitefutureConfig.instance:getTeamCfgs(actId, stageId)

	if stageCfg then
		local teamCfg = InfinitefutureConfig.instance:getTeamCfg(stageCfg[teamId].creepsMasterId)

		return teamCfg.skipTime
	end

	return 1
end

function BattleSkipTimeMgr:getInfinitefutureCommonSkipTime()
	local actId = InfinitefutureModel.instance.curActId
	local stageId = InfinitefutureModel.instance.curStageId
	local teamId = InfinitefutureModel.instance.curTeamID
	local stageCfg = InfinitefutureConfig.instance:getTeamCfgs(actId, stageId)

	if stageCfg then
		local teamCfg = InfinitefutureConfig.instance:getTeamCfg(stageCfg[teamId].creepsMasterId)

		return teamCfg.skipTime
	end

	return 1
end

function BattleSkipTimeMgr:getGoddesGloryBattleSkipTime()
	local goddesGloryChallengeId = BattleModel.instance.goddesGloryChallengeId
	local goddesGloryStageId = BattleModel.instance.goddesGloryStageId
	local goddesGloryEventId = BattleModel.instance.goddesGloryEventId

	if goddesGloryChallengeId and goddesGloryChallengeId > 0 and goddesGloryStageId and goddesGloryStageId > 0 then
		local eventCo = GoddessGloryConfig.instance:getEventCo(goddesGloryEventId)
		local creepsCo = GoddessGloryConfig.instance:getMonsterCo(eventCo.creepsMasterId)

		if creepsCo then
			return creepsCo.skipTime or 0
		end
	end

	return 0
end

function BattleSkipTimeMgr:getSQLongYanSkipTime()
	local fmo = GodLongYanModel.instance:getCustomFmtMo()

	if fmo then
		local conf = fmo:getFmtInfoConfig()

		if conf then
			return conf.skipTime
		end
	end

	return 0
end

function BattleSkipTimeMgr:getShareTaskSkipTime()
	local conf = ShareTaskConfig.instance:GetBossTeamCfg(BattleModel.instance.shareCreepsMasterId)

	if conf then
		return conf.skipTime
	end

	return 0
end

function BattleSkipTimeMgr:getExploreUnderFightSkipTime()
	local conf = ExploreUnderConfig.instance:getCreepsCfg(BattleModel.instance.exploreUnderFightCreepId)

	if conf then
		return conf.skipTime
	end

	return 0
end

function BattleSkipTimeMgr:getPowerLandChallengeSkipTime()
	local params = BattleModel.instance.powerLandChallengeParams

	if params then
		local activityId = checknumber(params[1])
		local stageId = checknumber(params[2])
		local creepsMasterId = checknumber(params[3])

		if activityId > 0 and stageId > 0 and creepsMasterId > 0 then
			local data = PowerLandConfig.instance:getPlTeamDataById(activityId, stageId, creepsMasterId)

			return data and data.skipTime
		end
	end

	return 0
end

function BattleSkipTimeMgr:getLailisiChallengeSkipTime()
	local time = LailisiModel.instance:getSkipTime()

	if time then
		return time
	end

	return 0
end

function BattleSkipTimeMgr:getisVillaintrialSkipTime()
	local creepsMasterId = VillaintrialModel.instance:getCreepsMasterId()
	local teamData = VillaintrialConfig.instance:getPlCreepsCfg(creepsMasterId)
	local time = teamData.skipTime

	if time then
		return time
	end

	return 0
end

function BattleSkipTimeMgr:getHolyStripeCopySoloSkipTime()
	local fmtMo = HolyStripeCopyModel.instance:getSoloCustomFmtMo()
	local curCfg = fmtMo:getFmtInfoConfig()

	if curCfg then
		return curCfg.skipTime
	end

	return 0
end

function BattleSkipTimeMgr:getBuddyFetterSkipTime()
	return FriendConfig.instance:getSkipTimeByFetter(BattleModel.instance.maxFetter)
end

function BattleSkipTimeMgr:getMKPBattleSkipTime()
	if checknumber(BattleModel.instance.mkpBattle) <= 0 then
		return 0
	end

	local cfg = MoonKingConfig.instance:getMasterTeamCfg(BattleModel.instance.mkpBattle)

	if cfg == nil or cfg.skipTime == nil then
		return 0
	end

	return cfg.skipTime
end

function BattleSkipTimeMgr:getPTBattleSkipTime()
	local fightType = BattleModel.instance.PeakTournamentFightType

	if fightType == PeakTournamentController.FightType.QuaFight then
		return 3
	elseif fightType == PeakTournamentController.FightType.EliFight then
		return 0
	elseif fightType == PeakTournamentController.FightType.FightVieo then
		return 3
	else
		return 0
	end
end

function BattleSkipTimeMgr:getGodStatuesWarSkipTime()
	local fightType = BattleModel.instance.StartGodStatuesWarFightType

	if fightType == GswEnum.FightType_Normal then
		return 3
	elseif fightType == GswEnum.FightType_Vieo then
		return 0
	else
		return 0
	end
end

function BattleSkipTimeMgr:getGuardCityChallengeSkipTime()
	if BattleModel.instance.guardCityChallengeActivityId and BattleModel.instance.guardCityChallengeCreepsMasterId then
		local actCfg = GuardCityConfig.instance:getActivityCfg(BattleModel.instance.guardCityChallengeActivityId)

		if not actCfg then
			return 0
		end

		local monsterCfg = GuardCityConfig.instance:getMonsterCfg(actCfg.masterPlanId, BattleModel.instance.guardCityChallengeCreepsMasterId)

		if not monsterCfg then
			return 0
		end

		return monsterCfg.skipTime
	end

	return 0
end

function BattleSkipTimeMgr:_getElementSparkSkipTime()
	if BattleModel.instance.elementSparkChunkId then
		local planId = ElementSparkController.instance:getMapPlanId()
		local cfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, BattleModel.instance.elementSparkChunkId)

		if cfg then
			local bossCfg = ElementSparkConfig.instance:getMasterCfg(cfg.bossId)

			if bossCfg then
				return bossCfg.skipTime
			end
		end
	end

	return 3
end

BattleSkipTimeMgr.instance = BattleSkipTimeMgr.New()

return BattleSkipTimeMgr
