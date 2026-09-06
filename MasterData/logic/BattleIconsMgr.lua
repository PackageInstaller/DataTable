-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleIconsMgr.lua

module("logic.extensions.battle.model.BattleIconsMgr", package.seeall)

local BattleIconsMgr = class("BattleIconsMgr")

function BattleIconsMgr:getIconRaceId()
	local raceId = self:_getIconRaceId()

	if not raceId or raceId == 0 then
		local enemyTeam = BattleModel.instance:getEnemyPlayerTeam()
		local enemyPlayer = BattleModel.instance:getPlayer(enemyTeam)
		local characterViews = enemyPlayer.characterViews

		if not characterViews then
			return 0
		end

		local posIndex = math.huge

		for k, v in ipairs(characterViews) do
			local fmtIndex = v.y * 3 + v.x + 1

			if fmtIndex <= posIndex then
				posIndex = fmtIndex
				raceId = v.raceId
			end
		end
	end

	return raceId
end

function BattleIconsMgr:_getIconRaceId()
	if BattleModel.instance.copyId then
		return self:getPlotCopyIconRaceId()
	end

	if BattleModel.instance.resChapterId then
		return self:getResCopyIconRaceId()
	end

	if BattleModel.instance.pveId then
		return self:getPVEIconRaceId()
	end

	if BattleModel.instance.wtowerIndex then
		return self:getWTowerIconRaceId()
	end

	if BattleModel.instance.herotrialBossId then
		return self:getHeroTrialIconRaceId()
	end

	if BattleModel.instance.breakFormationId then
		return self:getBreakFormationIconRaceId()
	end

	if BattleModel.instance.legendChallengeId then
		return self:getLegendIconRaceId()
	end

	if BattleModel.instance.kindRoadId then
		return self:getKingRoadIconRaceId()
	end

	if BattleModel.instance.kingWayId then
		return self:getKingWayIconRaceId()
	end

	if BattleModel.instance.nightPalaceStageId then
		return self:getNinePalaceIconRaceId()
	end

	if BattleModel.instance.expedition then
		return self:getExpeditionIconRaceId()
	end

	if BattleModel.instance.familyBossId then
		return self:getFamilyBossIconRaceId()
	end

	if BattleModel.instance.worldBossId then
		return self:getWorldBossIconRaceId()
	end

	if BattleModel.instance.holyChallId then
		return self:getHolyChallIdIconRaceId()
	end

	if BattleModel.instance.isFBBBattle then
		return self:_getFBBChallIdIconRaceId()
	end

	local monsterCfg = BattleModel.instance.timedChallengeMonsterCfg

	if monsterCfg ~= nil then
		return monsterCfg.creepMasterHeadIcon
	end

	return 0
end

function BattleIconsMgr:getPlotCopyIconRaceId()
	local copyId = BattleModel.instance.copyId
	local copyLevelId = BattleModel.instance.copyLevelId

	if copyId and copyLevelId then
		local stageCo = CopyConfig.instance:getStageById(copyId, copyLevelId)
		local teamCo = CopyConfig.instance:getTeamCfg(stageCo.teamIds)

		if teamCo then
			return teamCo.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getResCopyIconRaceId()
	local chapterId = BattleModel.instance.resChapterId
	local stageId = BattleModel.instance.resStageId

	if chapterId and stageId then
		local stageCo = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)
		local teamCo = MaterialChallengeConfig.instance:getTeamCfg(stageCo.teamIds)

		if teamCo then
			return teamCo.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getPVEIconRaceId()
	local pveId = BattleModel.instance.pveId

	if pveId and pveId > 0 then
		local teamCo = CopyConfig.instance:getTeamCfg(pveId)

		if teamCo then
			return teamCo.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getWTowerIconRaceId()
	local wtowerIndex = BattleModel.instance.wtowerIndex
	local towerId = WTowerModel.instance:getTowerId()

	if wtowerIndex and wtowerIndex > 0 then
		local wtowerCo = WTowerConfig.instance:getCfgById(wtowerIndex, towerId)

		if wtowerCo then
			return wtowerCo.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getHeroTrialIconRaceId()
	local bossId = BattleModel.instance.herotrialBossId

	if bossId and bossId > 0 then
		local wtowerCo = HerotrialConfig.instance:getBossCfgById(bossId)

		if wtowerCo then
			return wtowerCo.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getKingRoadIconRaceId()
	local kindRoadId = BattleModel.instance.kindRoadId

	if kindRoadId and kindRoadId > 0 then
		local kindRoadCo = PetTrialConfig.instance:getStageCfgById(kindRoadId)

		if kindRoadCo then
			return kindRoadCo.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getKingWayIconRaceId()
	local kingWayId = BattleModel.instance.kingWayId
	local kingWayStageId = BattleModel.instance.kingWayStageId

	if kingWayId and kingWayId > 0 and kingWayStageId and kingWayStageId > 0 then
		local allCfgs = KingWayConfig.instance:GetWayStageCfg(kingWayId)

		if allCfgs == nil or allCfgs[kingWayStageId] == nil then
			return 0
		end

		local cfg = allCfgs[kingWayStageId]

		if cfg then
			return cfg.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getBreakFormationIconRaceId()
	local breakFormationId = BattleModel.instance.breakFormationId
	local breakFormationLvId = BattleModel.instance.breakFormationLvId

	if breakFormationId and breakFormationId > 0 and breakFormationLvId and breakFormationLvId > 0 then
		local cfg = BreakFormationConfig.instance:getMonsterCfg(breakFormationId, breakFormationLvId)

		if cfg then
			return cfg.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getLegendIconRaceId()
	local legendChallengeId = BattleModel.instance.legendChallengeId
	local legendStageIdId = BattleModel.instance.legendStageIdId

	if legendChallengeId and legendChallengeId > 0 and legendStageIdId and legendStageIdId > 0 then
		local cfg = LegendConfig.instance:getLegendChallengeStageCfg(legendChallengeId, legendStageIdId)

		if cfg then
			return cfg.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getNinePalaceIconRaceId()
	local nightPalaceStageId = BattleModel.instance.nightPalaceStageId
	local nightPalaceMasterId = BattleModel.instance.nightPalaceMasterId

	if nightPalaceStageId and nightPalaceStageId > 0 and nightPalaceMasterId then
		local cfg = NinePlaceConfig.instance:getMonsterCfg(nightPalaceStageId, nightPalaceMasterId)

		if cfg then
			return cfg.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getExpeditionIconRaceId()
	local expedition = BattleModel.instance.expedition

	if expedition then
		local creepMasterHeadIcon = ExpeditionConfig.instance:getConstInt("creepMasterHeadIcon")

		return creepMasterHeadIcon or 0
	end

	return 0
end

function BattleIconsMgr:getFamilyBossIconRaceId()
	local familyBossId = BattleModel.instance.familyBossId

	if familyBossId and familyBossId > 0 then
		local monsterCo = FamilyConfig.instance:getFamilyBossCfg(familyBossId)

		if monsterCo then
			return monsterCo.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getWorldBossIconRaceId()
	local worldBossId = BattleModel.instance.worldBossId

	if worldBossId and worldBossId > 0 then
		local monsterCo = WorldBossConfig.instance:getWorldBossTeamCo(worldBossId)

		if monsterCo then
			return monsterCo.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:getHolyChallIdIconRaceId()
	local holyChallId = BattleModel.instance.holyChallId

	if holyChallId and holyChallId > 0 then
		local stageCfg = HolyChallConfig.instance:GetChallStageCfg(holyChallId, BattleModel.instance.holyChallStageId)

		if stageCfg then
			return stageCfg.creepMasterHeadIcon or 0
		end
	end

	return 0
end

function BattleIconsMgr:_getFBBChallIdIconRaceId()
	local monsterCfg = FbbchallengeConfig.instance:getMonsterCfg(FbbchallengeModel.instance:getCurrCreepsMasterId())

	return monsterCfg.creepMasterHeadIcon or 0
end

BattleIconsMgr.instance = BattleIconsMgr.New()

return BattleIconsMgr
