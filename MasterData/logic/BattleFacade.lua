-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/facade/BattleFacade.lua

module("logic.extensions.battle.facade.BattleFacade", package.seeall)

local BattleFacade = class("BattleFacade", BaseFacade)

BattleFacade.BATTLE_SPEED_IDX_1X = 1
BattleFacade.BATTLE_SPEED_IDX_2X = 2
BattleFacade.BATTLE_SPEED_IDX_4X = 3

function BattleFacade:registerResultHandler(handler, target)
	self._resultHandler = handler
	self._resultHandlerTarget = target
end

function BattleFacade:endBattle()
	BattleController.instance:endBattle()
end

function BattleFacade:sendPreviewPetBattle(raceId, skinId, handler, handlerObj, errHandler)
	self:clearStatus()

	BattleModel.instance.isPreviewPet = true
	skinId = checknumber(skinId)

	if skinId > 0 then
		PetManualAgent.instance:sendPreviewBattleReq(raceId, skinId, handler, handlerObj, errHandler)
	else
		PetManualAgent.instance:sendPreviewBattleReq(raceId, nil, handler, handlerObj, errHandler)
	end
end

function BattleFacade:invokeResultHandler()
	if self._resultHandler then
		if self._resultHandlerTarget then
			return self._resultHandler(self._resultHandlerTarget)
		else
			return self._resultHandler()
		end
	end
end

function BattleFacade:getLastBattleResult()
	return BattleController.instance:getLastBattleResult()
end

function BattleFacade:getTotalHurt(targetType)
	return BattleModel.instance:getTotalHurt(targetType)
end

function BattleFacade:isSelfRealWin()
	return BattleModel.instance:isSelfRealWin()
end

function BattleFacade:registerBattleWinnerOpHandler(initHandler, updateHandler, isReachHandler)
	self._battleWinnerInitHandler = initHandler
	self._battleWinnerUpdateHandler = updateHandler
	self._battleWinnerIsReachHandler = isReachHandler
end

function BattleFacade:getBattleWinnerOpHandler()
	return self._battleWinnerInitHandler, self._battleWinnerUpdateHandler, self._battleWinnerIsReachHandler
end

function BattleFacade:getCatchPetId()
	if BattleModel.instance:getActionMode() ~= GameEnum.ActionModel.UserAction_Catch then
		return
	end

	if BattleItemsModel.instance:isItemUsable() then
		local units = SceneMgr.instance:getCurScene().unitFactory:getAllCatchableUnit()

		if units and units[1] then
			return units[1]
		end
	end

	return nil
end

function BattleFacade:hasBattleItemsNum()
	local items = BattleItemsModel.instance:getBattleItems()

	if not items then
		return nil
	end

	return #items > 0
end

function BattleFacade:startFightSceneMonster(mstId, withOutFmtCheck)
	if not withOutFmtCheck and FormationFacade.instance:checkFormationEmpty() then
		return
	end

	local function start_fight_mst()
		local scene = SceneMgr.instance:getCurScene()
		local mstUnit = scene.unitFactory:getUnit(UnitTag.Monster, mstId)

		self:clearStatus()

		BattleModel.instance.monsterId = mstUnit.monsterId
		BattleModel.instance.monsterZoneId = mstUnit.zoneId

		BattleAgent.instance:sendFightSceneMonsterReq(mstUnit.monsterId, mstUnit.zoneId)
	end

	if not withOutFmtCheck then
		if not FormationFacade.instance:checkFormationPosNumber(start_fight_mst) then
			start_fight_mst()
		end
	else
		start_fight_mst()
	end
end

function BattleFacade:selectSceneMonster(mstId)
	local scene = SceneMgr.instance:getCurScene()
	local mstUnit = scene.unitFactory:getUnit(UnitTag.Monster, mstId)
	local monsterCo = SceneConfig.instance:getMonsterMaskterCo(mstUnit.monsterId)

	if monsterCo.mission then
		UIStateManager.instance:push(ViewName.monstermissionview, mstUnit.monsterId, mstId, mstUnit.zoneId)
	else
		self:startFightSceneMonster(mstId, mstUnit.zoneId)
	end
end

function BattleFacade:startPve(pveId, directStart)
	if not pveId or pveId == 0 then
		return
	end

	if WuShenConfig.instance:checkGuideUI(pveId) then
		WushenViewController.instance:openMissionView(pveId)
	elseif directStart then
		TaskFacade.instance:sendTaskFightMonsterReq(pveId)
	else
		UIStateManager.instance:push(ViewName.pvemissionview, pveId)
	end
end

function BattleFacade:clearStatus()
	BattleModel.instance.goddesGloryChallengeId = nil
	BattleModel.instance.goddesGloryStageId = nil
	BattleModel.instance.goddesGloryEventId = nil
	BattleModel.instance.xinxiyaMirrorMasterId = nil
	BattleModel.instance.curMissionType = nil
	BattleModel.instance.isArena = nil
	BattleModel.instance.challengeLvId = nil
	BattleModel.instance.monsterId = nil
	BattleModel.instance.eveA = nil
	BattleModel.instance.eveB = nil
	BattleModel.instance.pveId = nil
	BattleModel.instance.monsterZoneId = nil
	BattleModel.instance.expedition = nil
	BattleModel.instance.copyId = nil
	BattleModel.instance.copyPassed = nil
	BattleModel.instance.copyLevelId = nil
	BattleModel.instance.isRankingRace = nil
	BattleModel.instance.isWTower = nil
	BattleModel.instance.wtowerIndex = nil
	BattleModel.instance.wtowerId = nil
	BattleModel.instance.breakFormationId = nil
	BattleModel.instance.breakFormationLvId = nil
	BattleModel.instance.legendChallengeId = nil
	BattleModel.instance.legendStageIdId = nil
	BattleModel.instance.legendPassed = nil
	BattleModel.instance.kindRoadId = nil
	BattleModel.instance.kindRoadPassed = nil
	BattleModel.instance.isFamilyBoss = nil
	BattleModel.instance.familyBossId = nil
	BattleModel.instance.isWorldBoss = nil
	BattleModel.instance.worldBossId = nil
	BattleModel.instance.teachingStageId = nil
	BattleModel.instance.kingWayId = nil
	BattleModel.instance.kingWayStageId = nil
	BattleModel.instance.kingWayPassed = nil
	BattleModel.instance.nightPalaceMasterId = nil
	BattleModel.instance.nightPalaceStageId = nil
	BattleModel.instance.nightPalaceStagePassed = nil
	BattleModel.instance.isPetCollege = nil
	BattleModel.instance.collegeChallengeId = nil
	BattleModel.instance.collegeStageId = nil
	BattleModel.instance.herotrialBossId = nil
	BattleModel.instance.isherotrial = nil
	BattleModel.instance.isEndlessBattle = nil
	BattleModel.instance.isAceteam = nil
	BattleModel.instance.isSeniorArena = nil
	BattleModel.instance.isMangTower3v3 = nil
	BattleModel.instance.isMangTower1v1 = nil
	BattleModel.instance.Infinitefuture = nil
	BattleModel.instance.VillainPet = nil
	BattleModel.instance.InfinitefutureCommon = nil
	BattleModel.instance.HolyStripeCopyFight = nil
	BattleModel.instance.StarGodChallenge = nil
	BattleModel.instance.SeasonPVEBoss = nil
	BattleModel.instance.UltimateWarTowerStage = nil
	BattleModel.instance.shareBossId = nil
	BattleModel.instance.isMyBoss = nil
	BattleModel.instance.shareCreepsMasterId = nil
	BattleModel.instance.isPreviewPet = nil
	BattleModel.instance.isTimeLimitedChallenge = nil
	BattleModel.instance.timedChallengeMonsterCfg = nil
	BattleModel.instance.holyChallId = nil
	BattleModel.instance.holyChallStageId = nil
	BattleModel.instance.isPkBattle = nil
	BattleModel.instance.resChapterId = nil
	BattleModel.instance.resStageId = nil

	BattleModel.instance:setOtherHeadInfo(nil)

	BattleModel.instance.familyTeamPlayType = nil
	BattleModel.instance.isFamilyTeamPlayPractice = nil
	BattleModel.instance.isAnheimm = nil
	BattleModel.instance.isSenluo = nil
	BattleModel.instance.sccopyActivityId = nil
	BattleModel.instance.sccopyTypeId = nil
	BattleModel.instance.sccopyChapterId = nil
	BattleModel.instance.nianNianChall = nil
	BattleModel.instance.isPassing = nil
	BattleModel.instance.isScuffle = nil
	BattleModel.instance.isFBBBattle = nil
	BattleModel.instance.isCampScuffle = nil
	BattleModel.instance.MirrorTrialStageId = nil
	BattleModel.instance.perfectRuleModeChanllengeId = nil
	BattleModel.instance.summonTowerGridId = nil
	BattleModel.instance.isWLTower = nil
	BattleModel.instance.isDragonTrail = nil
	BattleModel.instance.battleTaskIds = nil
	BattleModel.instance.isLongyanSQ = nil
	BattleModel.instance.isDishitianSQ = nil
	BattleModel.instance.dishitianSQWinId = nil
	BattleModel.instance.isFamilyWarNest = nil
	BattleModel.instance.familyWarParam = nil
	BattleModel.instance.exploreUnderFightCreepId = nil
	BattleModel.instance.SKTFightCfg = nil
	BattleModel.instance.isPowerLandChallenge = nil
	BattleModel.instance.powerLandChallengeParams = nil
	BattleModel.instance.isLailisiChallenge = nil
	BattleModel.instance.forceSpeedIndex = nil
	BattleModel.instance.maxFetter = nil
	BattleModel.instance.mkpBattle = nil
	BattleModel.instance.isGodARuiShiFight = nil
	BattleModel.instance.isGodARuiShiBossFight = nil
	BattleModel.instance.godARuiShiStageId = nil
	BattleModel.instance.godARuiShiChallengeId = nil
	BattleModel.instance.PeakTournamentFight = nil
	BattleModel.instance.PeakTournamentFightType = nil
	BattleModel.instance.PeakTournamentIsNeedAnim = nil
	BattleModel.instance.SummerTreasureSnatchPvpFight = nil
	BattleModel.instance.SummerTreasureSnatchPvpIsNeedAnim = nil
	BattleModel.instance.StartGodStatuesWar = nil
	BattleModel.instance.StartGodStatuesWarSeasonId = nil
	BattleModel.instance.StartGodStatuesWarFightType = nil
	BattleModel.instance.StartGodStatuesWarIsNeedAnim = nil
	BattleModel.instance.StartGodStatuesWarNest = nil
	BattleModel.instance.StartGodStatuesWarNestParams = nil
	BattleModel.instance.isXiuMumChallenge = nil
	BattleModel.instance.isGuardCityChallenge = nil
	BattleModel.instance.guardCityChallengeActivityId = nil
	BattleModel.instance.guardCityChallengeCreepsMasterId = nil
	BattleModel.instance.isLotusBattle = nil
	BattleModel.instance.isPkBattlePVE = nil
	BattleModel.instance.isAutoChessFight = nil
	BattleModel.instance.isHolyWaterOrder = nil
	BattleModel.instance.kingJiChallengeType = nil
	BattleModel.instance.isDivineNuoYaClg = nil
	BattleModel.instance.WuDiClgNor = nil
	BattleModel.instance.isDestroyEvil = nil
	BattleModel.instance.isDragonXiuerBoss = nil
	BattleModel.instance.DivineXiuErClgNor = nil
	BattleModel.instance.DivineXiuErClgNorOfParams = nil
	BattleModel.instance.DivineXiuErClgExt = nil
	BattleModel.instance.DivineXiuErClgExtOfParams = nil
	BattleModel.instance.FarnasClgNor = nil
	BattleModel.instance.FarnasClgExt = nil
	BattleModel.instance.FamilyHoudingClg = nil
	BattleModel.instance.FamilyHoudingClgParams = nil
	BattleModel.instance.isElementSpark = nil
	BattleModel.instance.elementSparkChunkId = nil
	BattleModel.instance.isXiaYin = nil
	BattleModel.instance.xiaYinActivityId = nil
	BattleModel.instance.xiaYinCreepsMasterId = nil
	BattleModel.instance.isNightFeastBoss = nil
	BattleModel.instance.nightFeastBossType = nil
	BattleModel.instance.nightFeastBossActivityId = nil
	BattleModel.instance.KingSpaceDragonClg = nil
	BattleModel.instance.DragonKingARuiShi = nil
	BattleModel.instance.DivineKingOrderClg = nil
	BattleModel.instance.LingShenChallenge = nil
	BattleModel.instance.HeartOfJieshenClgFmtType = 0
	BattleModel.instance.isRoguelikeBattle = nil
	BattleModel.instance.YoungChampionKingQualify = nil
	BattleModel.instance.SixArtChallengeId = nil
	BattleModel.instance.isContinuousBattle = nil
	BattleModel.instance.previewOpeningEffectId = nil
	BattleModel.instance.previewBattleBackgroundSkinId = nil
end

function BattleFacade:setBattleLockSpeedIndex(idx)
	self:clearStatus()

	BattleModel.instance.forceSpeedIndex = idx
end

function BattleFacade:startPk(isPVE)
	self:clearStatus()

	BattleModel.instance.isPkBattle = true
	BattleModel.instance.isPkBattlePVE = isPVE
end

function BattleFacade:startSummonTower(summonTowerGridId)
	self:clearStatus()

	BattleModel.instance.summonTowerGridId = summonTowerGridId
end

function BattleFacade:startSCCopy(sccopyActivityId, sccopyTypeId, sccopyChapterId)
	self:clearStatus()

	BattleModel.instance.sccopyActivityId = sccopyActivityId
	BattleModel.instance.sccopyTypeId = sccopyTypeId
	BattleModel.instance.sccopyChapterId = sccopyChapterId
end

function BattleFacade:startHolyChall(holyChallId, holyChallStageId)
	self:clearStatus()

	BattleModel.instance.holyChallId = holyChallId
	BattleModel.instance.holyChallStageId = holyChallStageId
end

function BattleFacade:startFightNightPalace(nightPalaceStageId, nightPalaceMasterId)
	self:clearStatus()

	BattleModel.instance.nightPalaceStageId = nightPalaceStageId
	BattleModel.instance.nightPalaceMasterId = nightPalaceMasterId
	BattleModel.instance.nightPalaceStagePassed = nil
end

function BattleFacade:startFightChallenge()
	self:clearStatus()

	BattleModel.instance.challengeLvId = self:getChallengeTeamId()
end

function BattleFacade:startMKPBattle(masterId)
	self:clearStatus()

	BattleModel.instance.mkpBattle = masterId
end

function BattleFacade:startWTower(index, towerId)
	self:clearStatus()

	BattleModel.instance.isWTower = true
	BattleModel.instance.wtowerIndex = index
	BattleModel.instance.wtowerId = towerId
end

function BattleFacade:startHeroTrial(bossId)
	self:clearStatus()

	BattleModel.instance.isherotrial = true
	BattleModel.instance.herotrialBossId = bossId
end

function BattleFacade:startBreakFormation(id, lvId)
	self:clearStatus()

	BattleModel.instance.breakFormationId = id
	BattleModel.instance.breakFormationLvId = lvId
end

function BattleFacade:startLegend(id, lvId)
	self:clearStatus()

	BattleModel.instance.legendChallengeId = id
	BattleModel.instance.legendStageIdId = lvId
	BattleModel.instance.legendPassed = LegendModel.instance:isStagePass(id, lvId)
end

function BattleFacade:startKingRoad(id)
	self:clearStatus()

	BattleModel.instance.kindRoadId = id
	BattleModel.instance.kindRoadPassed = nil
end

function BattleFacade:startKingWay(id, stageId)
	self:clearStatus()

	BattleModel.instance.kingWayId = id
	BattleModel.instance.kingWayStageId = stageId
	BattleModel.instance.kingWayPassed = nil
end

function BattleFacade:startShareTask(bossId, isMyBoss, creepsMasterId)
	self:clearStatus()

	BattleModel.instance.shareBossId = bossId
	BattleModel.instance.isMyBoss = isMyBoss
	BattleModel.instance.shareCreepsMasterId = creepsMasterId
end

function BattleFacade:viewUserFightMonsterBtl(battleId)
	GMAgent.instance:sendPM_ViewUserFightMonsterBtlResultReq(battleId, function(msg)
		local btlresult = msg.btlResult

		BattleFacade.instance:onViewUserFightMonsterBtlResult(btlresult)
	end)
end

function BattleFacade:onViewUserFightMonsterBtlResult(btlresult)
	self:clearStatus()
	BattleController.instance:viewUserFightMonsterBtlResult(btlresult, true)
end

function BattleFacade:startFightingByBtlResult(btlresult, entry)
	self:clearStatus()

	BattleModel.instance.isArena = true
	entry = entry or GameEnum.BattleRecordEntry.Arena

	BattleController.instance:viewUserFightMonsterBtlResult(btlresult, false, entry)
end

function BattleFacade:startShareFightingByBtlResult(btlresult, entry)
	self:clearStatus()

	BattleModel.instance.isArena = true
	entry = entry or GameEnum.BattleRecordEntry.Arena

	BattleController.instance:viewUserShareTaskFightMonsterBtlResult(btlresult, false, entry)
end

function BattleFacade:startFightEvE(eveA, eveB)
	self:clearStatus()

	BattleModel.instance.eveA = eveA
	BattleModel.instance.eveB = eveB
end

function BattleFacade:startFightPvE(pveId)
	self:clearStatus()

	BattleModel.instance.pveId = pveId
end

function BattleFacade:startExpedition()
	self:clearStatus()

	BattleModel.instance.expedition = true
end

function BattleFacade:startGoddesGlory(challengeId, stageId, goddesGloryEventId)
	self:clearStatus()

	BattleModel.instance.goddesGloryChallengeId = challengeId
	BattleModel.instance.goddesGloryStageId = stageId
	BattleModel.instance.goddesGloryEventId = goddesGloryEventId
end

function BattleFacade:startCopy(copyId, copyLevelId)
	self:clearStatus()

	BattleModel.instance.copyId = copyId
	BattleModel.instance.copyLevelId = copyLevelId
	BattleModel.instance.copyPassed = PlotCopyModel.instance:isStagePassedAllCopy(copyId, copyLevelId)
end

function BattleFacade:startResCopy(chapterId, stageId)
	self:clearStatus()

	BattleModel.instance.resChapterId = chapterId
	BattleModel.instance.resStageId = stageId
	BattleModel.instance.resStagePassed = MaterialChallengeModel.instance:isStagePassed(chapterId, stageId)
end

function BattleFacade:startRankRace()
	self:clearStatus()

	BattleModel.instance.isRankingRace = true
end

function BattleFacade:startScuffle()
	self:clearStatus()

	BattleModel.instance.isScuffle = true
end

function BattleFacade:startCampScuffle()
	self:clearStatus()

	BattleModel.instance.isCampScuffle = true
end

function BattleFacade:startMirrorTrial(stateId)
	self:clearStatus()

	BattleModel.instance.MirrorTrialStageId = stateId
end

function BattleFacade:startXinxiyaMirror(masterId)
	self:clearStatus()

	BattleModel.instance.xinxiyaMirrorMasterId = masterId
end

function BattleFacade:startFamilyWar(isNest, param)
	self:clearStatus()

	BattleModel.instance.isFamilyWarNest = isNest
	BattleModel.instance.familyWarParam = param
end

function BattleFacade:setPveId(pveId)
	BattleModel.instance.pveId = pveId
end

function BattleFacade:getPveId()
	return BattleModel.instance.pveId
end

function BattleFacade:getChallengeTeamId()
	local model = ChallengeModel.instance
	local currId = model:getCurId()

	if not currId then
		return
	end

	local currParse = model:getCurPhase()

	if not currParse then
		return
	end

	local currBranch = model:getCurBranch()

	if not currBranch then
		return
	end

	local winCnt = model:getWinCount(phase, branch) or 0

	return BattleConfig.instance:getChallengeTeamId(currId, currParse, currBranch, winCnt + 1)
end

function BattleFacade:getChallengeTeamIdById(currId, currParse, currBranch)
	local model = ChallengeModel.instance

	if currId ~= model:getCurId() then
		return
	end

	if currParse ~= model:getCurPhase() then
		return
	end

	if currBranch ~= model:getCurBranch() then
		return
	end

	local winCnt = model:getWinCount(phase, branch) or 0

	return BattleConfig.instance:getChallengeTeamId(currId, currParse, currBranch, winCnt + 1)
end

function BattleFacade:setBattlePause(pause)
	BattleController.instance:setBattlePause(pause)
end

function BattleFacade:isUnitVigourMax(unit)
	if unit then
		return unit.attrs:getCurVigour() >= unit.attrs:getMaxVigour()
	end
end

function BattleFacade:sendGetMutatedSceneInfoReq()
	BattleAgent.instance:sendPM_GetMutatedSceneInfoReq()
end

function BattleFacade:setBattleEndRoundFromStoryHandler(handler)
	self._battleEndRoundFromStoryHandler = handler
end

function BattleFacade:getBattleEndRoundFromStoryHandler()
	return self._battleEndRoundFromStoryHandler
end

function BattleFacade:onBattleEndReset()
	self._battleEndRoundFromStoryHandler = nil
end

function BattleFacade:startFamilyBoss(bossId)
	self:clearStatus()

	BattleModel.instance.isFamilyBoss = true
	BattleModel.instance.familyBossId = bossId
end

function BattleFacade:startTeaching(stageId)
	self:clearStatus()

	BattleModel.instance.teachingStageId = stageId
end

function BattleFacade:startWorldBoss(bossId)
	self:clearStatus()

	BattleModel.instance.isWorldBoss = true
	BattleModel.instance.worldBossId = bossId
end

function BattleFacade:startPetCollege(challengeId, stageId)
	self:clearStatus()

	BattleModel.instance.isPetCollege = true
	BattleModel.instance.collegeChallengeId = challengeId
	BattleModel.instance.collegeStageId = stageId
end

function BattleFacade:startEndlessBattle()
	self:clearStatus()

	BattleModel.instance.isEndlessBattle = true
end

function BattleFacade:startInfinitefutureBattle()
	self:clearStatus()

	BattleModel.instance.Infinitefuture = true
end

function BattleFacade:startUltimateWarTowerStageBattle()
	self:clearStatus()

	BattleModel.instance.UltimateWarTowerStage = true
end

function BattleFacade:startHolyStripeCopySoloBattle(fightType, maxFetter)
	self:clearStatus()

	BattleModel.instance.HolyStripeCopyFight = fightType

	if fightType == 2 then
		BattleModel.instance.forceSpeedIndex = BattleFacade.BATTLE_SPEED_IDX_4X
		BattleModel.instance.maxFetter = maxFetter
	end
end

function BattleFacade:startStarGodChallengeBattle(maxFetter)
	self:clearStatus()

	BattleModel.instance.StarGodChallenge = true
	BattleModel.instance.maxFetter = maxFetter
end

function BattleFacade:startPeakTournamentFight(fightType, isNeedAnim)
	self:clearStatus()

	BattleModel.instance.PeakTournamentFight = true
	BattleModel.instance.PeakTournamentFightType = fightType
	BattleModel.instance.PeakTournamentIsNeedAnim = isNeedAnim
end

function BattleFacade:startSummerTreasureSnatchPvpFight(isNeedAnim)
	self:clearStatus()

	BattleModel.instance.SummerTreasureSnatchPvpFight = true
	BattleModel.instance.SummerTreasureSnatchPvpIsNeedAnim = isNeedAnim
end

function BattleFacade:startGodStatuesWar(fightType, isNeedAnim, seasonId)
	self:clearStatus()

	BattleModel.instance.StartGodStatuesWar = true
	BattleModel.instance.StartGodStatuesWarFightType = fightType
	BattleModel.instance.StartGodStatuesWarIsNeedAnim = isNeedAnim
	BattleModel.instance.StartGodStatuesWarSeasonId = seasonId
end

function BattleFacade:startGodStatuesWarNest(...)
	self:clearStatus()

	BattleModel.instance.StartGodStatuesWarNest = true
	BattleModel.instance.StartGodStatuesWarNestParams = {
		...
	}
end

function BattleFacade:startVillainPetBattle()
	self:clearStatus()

	BattleModel.instance.VillainPet = true
end

function BattleFacade:startSeasonPVEBossBattle()
	self:clearStatus()

	BattleModel.instance.SeasonPVEBoss = true
end

function BattleFacade:startInfinitefutureCommonBattle()
	self:clearStatus()

	BattleModel.instance.InfinitefutureCommon = true
end

function BattleFacade:startAceTeamFight(btlResult)
	self:clearStatus()

	BattleModel.instance.isAceteam = true

	BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)
end

function BattleFacade:startSeniorArena(btlResult, headInfo)
	self:clearStatus()

	BattleModel.instance.isSeniorArena = true

	BattleModel.instance:setOtherHeadInfo(headInfo)
	BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)
end

function BattleFacade:startMangTower3v3(btlResult, headInfo)
	self:clearStatus()

	BattleModel.instance.isMangTower3v3 = true

	BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)
end

function BattleFacade:startMangTower1v1(btlResult, headInfo)
	self:clearStatus()

	BattleModel.instance.isMangTower1v1 = true

	BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)
end

function BattleFacade:startAnheimm()
	self:clearStatus()

	BattleModel.instance.isAnheimm = true
end

function BattleFacade:startPerfectRuleModeChanllenge(challengeId)
	self:clearStatus()

	BattleModel.instance.perfectRuleModeChanllengeId = challengeId
end

function BattleFacade:startSenluo()
	self:clearStatus()

	BattleModel.instance.isSenluo = true
end

function BattleFacade:startBattle(missionType)
	self:clearStatus()

	BattleModel.instance.curMissionType = missionType
end

function BattleFacade:startTimeLimitedChallenge(monsterCfg)
	self:clearStatus()

	BattleModel.instance.isTimeLimitedChallenge = true
	BattleModel.instance.timedChallengeMonsterCfg = monsterCfg
end

function BattleFacade:startFamilyTeamPlay(tpType, isPractice)
	self:clearStatus()

	BattleModel.instance.familyTeamPlayType = tpType
	BattleModel.instance.isFamilyTeamPlayPractice = isPractice
end

function BattleFacade:startWLTowerBattle(isWLTower)
	self:clearStatus()

	BattleModel.instance.isWLTower = true
end

function BattleFacade:getRoundNum()
	return self._uiRoundNum
end

function BattleFacade:setRoundNum(value)
	self._uiRoundNum = value
end

function BattleFacade:startFBBBattle()
	self:clearStatus()

	BattleModel.instance.isFBBBattle = true
end

function BattleFacade:startNNCBattle()
	self:clearStatus()

	BattleModel.instance.nianNianChall = true
end

function BattleFacade:startDragonTrail()
	self:clearStatus()

	BattleModel.instance.isDragonTrail = true
end

function BattleFacade:startFightWithTask(taskIds)
	self:clearStatus()

	BattleModel.instance.battleTaskIds = taskIds ~= nil and (type(taskIds) == "table" and taskIds or {
		taskIds
	}) or nil
end

function BattleFacade:startLongyanSQFight()
	self:clearStatus()

	BattleModel.instance.isLongyanSQ = true
end

function BattleFacade:startDishitianSQFight(winId)
	self:clearStatus()

	BattleModel.instance.isDishitianSQ = true
	BattleModel.instance.dishitianSQWinId = winId
end

function BattleFacade:startExploreUnderFight(creepId)
	self:clearStatus()

	BattleModel.instance.exploreUnderFightCreepId = creepId
end

function BattleFacade:startSKTFight(cfg)
	self:clearStatus()

	BattleModel.instance.SKTFightCfg = cfg
end

function BattleFacade:startPowerLandFight(...)
	self:clearStatus()

	BattleModel.instance.isPowerLandChallenge = true
	BattleModel.instance.powerLandChallengeParams = {
		...
	}
end

function BattleFacade:startLailisiFight()
	self:clearStatus()

	BattleModel.instance.isLailisiChallenge = true
end

function BattleFacade:startGodARuiShiFight(challengeId, stageId, isBoss)
	self:clearStatus()

	BattleModel.instance.isGodARuiShiFight = true
	BattleModel.instance.godARuiShiChallengeId = challengeId

	if isBoss == true then
		BattleModel.instance.isGodARuiShiBossFight = true
	else
		BattleModel.instance.godARuiShiStageId = stageId
	end
end

function BattleFacade:startXiuMumChallengeBattle()
	self:clearStatus()

	BattleModel.instance.isXiuMumChallenge = true
end

function BattleFacade:startGuardCityChallengeBattle(activityId, creepsMasterId)
	self:clearStatus()

	BattleModel.instance.isGuardCityChallenge = true
	BattleModel.instance.guardCityChallengeActivityId = activityId
	BattleModel.instance.guardCityChallengeCreepsMasterId = creepsMasterId
end

function BattleFacade:startLotusBattle(btlresult)
	self:clearStatus()

	BattleModel.instance.isLotusBattle = true

	BattleController.instance:viewUserFightMonsterBtlResult(btlresult, false)
end

function BattleFacade:startAutoChess()
	self:clearStatus()

	BattleModel.instance.isAutoChessFight = true
end

function BattleFacade:startHolyWaterOrderBattle()
	self:clearStatus()

	BattleModel.instance.isHolyWaterOrder = true
end

function BattleFacade:startKingji(challengeType)
	self:clearStatus()

	BattleModel.instance.kingJiChallengeType = challengeType
end

function BattleFacade:startDivineNuoYaBattle()
	self:clearStatus()

	BattleModel.instance.isDivineNuoYaClg = true
end

function BattleFacade:startWuDiClgNorBattle()
	self:clearStatus()

	BattleModel.instance.WuDiClgNor = true
end

function BattleFacade:startDestroyEvilFight()
	self:clearStatus()

	BattleModel.instance.isDestroyEvil = true
end

function BattleFacade:startDragonXiuerBossBattle()
	self:clearStatus()

	BattleModel.instance.isDragonXiuerBoss = true
end

function BattleFacade:startDivineXiuErClgNorBattle(...)
	self:clearStatus()

	BattleModel.instance.DivineXiuErClgNor = true
	BattleModel.instance.DivineXiuErClgNorOfParams = {
		...
	}
end

function BattleFacade:startDivineXiuErClgExtBattle(...)
	self:clearStatus()

	BattleModel.instance.DivineXiuErClgExt = true
	BattleModel.instance.DivineXiuErClgExtOfParams = {
		...
	}
end

function BattleFacade:startFarnasClgNorBattle()
	self:clearStatus()

	BattleModel.instance.FarnasClgNor = true
end

function BattleFacade:startFarnasClgExtBattle()
	self:clearStatus()

	BattleModel.instance.FarnasClgExt = true
end

function BattleFacade:startFamilyHoudingClgBattle(...)
	self:clearStatus()

	BattleModel.instance.FamilyHoudingClg = true
	BattleModel.instance.FamilyHoudingClgParams = {
		...
	}
end

function BattleFacade:startElementSpark(chunkId)
	self:clearStatus()

	BattleModel.instance.isElementSpark = true
	BattleModel.instance.elementSparkChunkId = chunkId
end

function BattleFacade:startXiaYinBattle(activityId, creepsMasterId)
	self:clearStatus()

	BattleModel.instance.isXiaYin = true
	BattleModel.instance.xiaYinActivityId = activityId
	BattleModel.instance.xiaYinCreepsMasterId = creepsMasterId
end

function BattleFacade:startNightFeastBossBattle(isBoss, activityId)
	self:clearStatus()

	BattleModel.instance.isNightFeastBoss = true
	BattleModel.instance.nightFeastBossType = isBoss and 2 or 1
	BattleModel.instance.nightFeastBossActivityId = activityId
end

function BattleFacade:startKingSpaceDragonClg()
	self:clearStatus()

	BattleModel.instance.KingSpaceDragonClg = true
end

function BattleFacade:startDragonKingARuiShiClg()
	self:clearStatus()

	BattleModel.instance.DragonKingARuiShi = true
end

function BattleFacade:startDivineKingOrderClg()
	self:clearStatus()

	BattleModel.instance.DivineKingOrderClg = true
end

function BattleFacade:startLingShenClg()
	self:clearStatus()

	BattleModel.instance.LingShenChallenge = true
end

function BattleFacade:startHeartOfJieshenClg(fmtType)
	self:clearStatus()

	BattleModel.instance.HeartOfJieshenClgFmtType = fmtType
end

function BattleFacade:startRoguelikeBattle()
	self:clearStatus()

	BattleModel.instance.isRoguelikeBattle = true
end

function BattleFacade:startYoungChampionKingQualify()
	self:clearStatus()

	BattleModel.instance.YoungChampionKingQualify = true
end

function BattleFacade:startSixArtBattle(challengeId)
	BattleModel.instance.SixArtChallengeId = challengeId
end

function BattleFacade:startContinuousBattle()
	self:clearStatus()

	BattleModel.instance.isContinuousBattle = true
end

function BattleFacade:sendPreviewPetBattleWithIds(raceId, skinId, openingEffectId, battleBackgroundSkinId, handler, handlerObj, errHandler)
	self:clearStatus()

	BattleModel.instance.isPreviewPet = true
	BattleModel.instance.previewOpeningEffectId = openingEffectId
	BattleModel.instance.previewBattleBackgroundSkinId = battleBackgroundSkinId
	skinId = checknumber(skinId)

	if skinId > 0 then
		PetManualAgent.instance:sendPreviewBattleReq(raceId, skinId, handler, handlerObj, errHandler)
	else
		PetManualAgent.instance:sendPreviewBattleReq(raceId, nil, handler, handlerObj, errHandler)
	end
end

BattleFacade.instance = BattleFacade.New()

return BattleFacade
