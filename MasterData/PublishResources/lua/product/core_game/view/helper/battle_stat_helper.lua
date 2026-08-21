_class("BattleStatHelper", Object)
BattleStatHelper = BattleStatHelper

function BattleStatHelper._GetBattleStatComponent()
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  if not mainWorld then
    return
  end
  return mainWorld:BattleStat()
end

function BattleStatHelper._GetMainWorld()
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  return mainWorld
end

function BattleStatHelper.Get3StarProgress(conditionId)
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  return statCmpt:Get3StarProgress(conditionId)
end

function BattleStatHelper.GetBonusMatchResult()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  return statCmpt:GetBonusMatchResult()
end

function BattleStatHelper.GetDropCollectNum()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  return statCmpt:GetDropCollectNum()
end

function BattleStatHelper.IsAssignWaveLevel()
  local l_mainworld = BattleStatHelper._GetMainWorld()
  local configService = l_mainworld:GetService("Config")
  local statCmpt = l_mainworld:BattleStat()
  if configService then
    local levelConfigData = configService:GetLevelConfigData()
    local levelCompleteConditionType = levelConfigData:GetLevelCompleteConditionType()
    if levelCompleteConditionType == CompleteConditionType.AssignWaveAndRandomNextWave then
      local l_arrAssignWaveParams = levelConfigData:GetLevelCompleteConditionParams()[1]
      local l_nAssignWave = l_arrAssignWaveParams[LevelCompleteAssignWaveParamExp.AssignWaveEnd]
      if l_nAssignWave ~= nil then
        return true, l_nAssignWave
      end
    end
  end
  return false, statCmpt:GetTotalWaveCount()
end

function BattleStatHelper.GetCurWaveIndex()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  local nCurWave = statCmpt:GetCurWaveIndex()
  local isAssignLevel, nTotalWaveCount = BattleStatHelper.IsAssignWaveLevel()
  if isAssignLevel and nCurWave > nTotalWaveCount then
    return nTotalWaveCount
  else
    return nCurWave
  end
end

function BattleStatHelper.GetTotalWaveCount()
  local isAssignLevel, nTotalWaveCount = BattleStatHelper.IsAssignWaveLevel()
  return nTotalWaveCount
end

function BattleStatHelper.GetTotalDropCoin()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  local coinCount = statCmpt:GetDropRoleAssetNoDouble(RoleAssetID.RoleAssetGold)
  return coinCount
end

function BattleStatHelper.GetTotalDropMazeCoin()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  local coinCount = statCmpt:GetDropRoleAsset(RoleAssetID.RoleAssetMazeCoin)
  return coinCount
end

function BattleStatHelper.GetLevelTotalRoundCount()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  return statCmpt:GetLevelTotalRoundCount()
end

function BattleStatHelper.CalcBonusObjective()
  local mainWorld = BattleStatHelper._GetMainWorld()
  if not mainWorld then
    return
  end
  local bonusService = mainWorld:GetService("BonusCalc")
  bonusService:CalcBonusObjective()
end

function BattleStatHelper.GetAutoFightStat()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  if not statCmpt then
    return false
  end
  return statCmpt:GetAutoFight()
end

function BattleStatHelper.GetHandleShumolHPUI()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  if not statCmpt then
    return false
  end
  return statCmpt:GetHandleShumolHPUI()
end

function BattleStatHelper.GetDeadMonsterCount()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  if statCmpt then
    local deadMonsterList = statCmpt:GetCurWaveDeadMonsterIDList()
    return table.count(deadMonsterList)
  end
end

function BattleStatHelper.GetBattleWaveResult()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  if statCmpt then
    return statCmpt:GetBattleWaveResult()
  end
end

function BattleStatHelper.GetRoundBeginPlayerPos()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  if statCmpt then
    return statCmpt:GetRoundBeginPlayerPos()
  end
end

function BattleStatHelper.CheckActiveSkillCastCondition(petPstID, skillID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  return utilData:CheckActiveSkillCastCondition(petPstID, skillID)
end

function BattleStatHelper.IsSkillDisabledWhenCasterIsTeamLeader(petPstID, skillID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  return utilData:IsSkillDisabledWhenCasterIsTeamLeader(petPstID, skillID)
end

function BattleStatHelper.IsPetCurrentTeamLeader(petPstID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  return utilData:IsPetCurrentTeamLeader(petPstID)
end

function BattleStatHelper.CheckCanCastActiveSkill_TeamLeaderCondi(petPstID, skillID)
  if BattleStatHelper.IsPetCurrentTeamLeader(petPstID) and BattleStatHelper.IsSkillDisabledWhenCasterIsTeamLeader(petPstID, skillID) then
    return false
  end
  return true
end

function BattleStatHelper.CheckCanCastActiveSkill_SwapPetTeamOrder(petPstID, skillID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  return utilData:CheckCanCastActiveSkillBySwapPetTeamOrder(petPstID, skillID)
end

function BattleStatHelper.GetLogicCurrentLocalTeamOrder()
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local eTeam = mainWorld:Player():GetLocalTeamEntity()
  return eTeam:Team():CloneTeamOrder()
end

function BattleStatHelper.GetCurRoundDoActiveSkillTimes(petPstID)
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  return statCmpt:GetCurRoundDoActiveSkillTimes(petPstID)
end

function BattleStatHelper.GetLevelOutOfRoundType()
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local configService = mainWorld:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  return levelConfigData:GetOutOfRoundType()
end

function BattleStatHelper.GetOutOfRoundPunishHPPercent(preview)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local battleStatCmpt = mainWorld:BattleStat()
  local punishmentRoundCount = battleStatCmpt:GetCurWavePunishmentRoundCount()
  if preview then
    punishmentRoundCount = punishmentRoundCount + 1
  end
  local punishPercent = 0
  for round, percent in pairs(BattleConst.PunishmentRoundHPPercent) do
    if round <= punishmentRoundCount then
      punishPercent = percent
    end
  end
  return punishPercent
end

function BattleStatHelper.GetPreviousReadyRoundCount(petPstID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  return utilData:GetPreviousReadyRoundCount(petPstID)
end

function BattleStatHelper.GetAllMiniMazeRelic()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  return statCmpt:GetAllMiniMazeRelicList()
end

function BattleStatHelper.GetWaveChooseRelic()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  local waveIndex = statCmpt:GetCurWaveIndex()
  return statCmpt:GetWaveChooseRelic(waveIndex)
end

function BattleStatHelper.GetWaveChoosePartner()
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  local waveIndex = statCmpt:GetCurWaveIndex()
  return statCmpt:GetWaveChoosePartner(waveIndex)
end

function BattleStatHelper.GetEliteIDArray(entityID, monsterID)
  local mainWorld = BattleStatHelper._GetMainWorld()
  if not mainWorld then
    return
  end
  local monster = mainWorld:GetEntityByID(entityID)
  if not monster:HasMonsterID() then
    return
  end
  local monsterIDCmpt = monster:MonsterID()
  if monsterID ~= monsterIDCmpt:GetMonsterID() then
    return
  end
  return monsterIDCmpt:GetEliteIDArray()
end

function BattleStatHelper.CheckForceMatch(petPstID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  local entity = utilData:GetEntityByPstID(petPstID)
  return utilData:GetEntityBuffValue(entity, "PetForceMatch")
end

function BattleStatHelper.GetAllFeatureSkillCdOff()
  local mainWorld = BattleStatHelper._GetMainWorld()
  if not mainWorld then
    return
  end
  local lsvcFeature = mainWorld:GetService("FeatureLogic")
  if lsvcFeature then
    local cdOff = lsvcFeature:GetAllFeatureSkillCdOff()
    return cdOff
  end
  return 0
end

function BattleStatHelper.GetSpecificFeatureSkillCdOff(featureType)
  local mainWorld = BattleStatHelper._GetMainWorld()
  if not mainWorld then
    return
  end
  local lsvcFeature = mainWorld:GetService("FeatureLogic")
  if lsvcFeature then
    local specificCdOff = lsvcFeature:GetSpecificFeatureSkillCdOff(featureType)
    return specificCdOff
  end
  return 0
end

function BattleStatHelper.GetPetSkillReadyAttr(petPstID, skillID)
  local mainWorld = BattleStatHelper._GetMainWorld()
  if not mainWorld then
    return
  end
  local utilData = mainWorld:GetService("UtilData")
  local entity = utilData:GetEntityByPstID(petPstID)
  return utilData:GetPetSkillReadyAttr(entity, skillID)
end

function BattleStatHelper.CalcZhongxuForceMovementCostByPick(petPstID, skillID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  local entity = utilData:GetEntityByPstID(petPstID)
  return utilData:CalcZhongxuForceMovementCostByPick(entity, skillID)
end

function BattleStatHelper.CalcZhongxuForceMovementNextMinCost(petPstID, skillID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  local entity = utilData:GetEntityByPstID(petPstID)
  return utilData:CalcZhongxuForceMovementNextMinCostForUI(entity, skillID)
end

function BattleStatHelper.CheckCanCastActiveSkill_GetCantReadyReasonByBuff(petPstID, skillID)
  local mainWorld = BattleStatHelper._GetMainWorld()
  if not mainWorld then
    return
  end
  local utilData = mainWorld:GetService("UtilData")
  local entity = utilData:GetEntityByPstID(petPstID)
  if not entity then
    return
  end
  if utilData:IsPetExtraActiveSkill(entity, skillID) then
    local canNotReady, reason = utilData:IsBuffSetExtraActiveSkillCanNotReady(petPstID, skillID)
    return reason
  else
    local canNotReady, reason = utilData:IsBuffSetActiveSkillCanNotReady(petPstID)
    return reason
  end
end

function BattleStatHelper.GetMonsterBeHitDamageValue(entityID)
  local statCmpt = BattleStatHelper._GetBattleStatComponent()
  return statCmpt:GetMonsterBeHitDamageValue(entityID)
end

function BattleStatHelper.CheckCanCastActiveSkill_MinimumCondition(petPstID, skillID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  local entity = utilData:GetEntityByPstID(petPstID)
  return utilData:CheckCanCastActiveSkillMinimumCondition(entity, skillID)
end

function BattleStatHelper.GetCasterPickUpExtraChainPowerCount(petPstID, skillID)
  local mainWorld = BattleStatHelper._GetMainWorld()
  if not mainWorld then
    return
  end
  local utilData = mainWorld:GetService("UtilData")
  local entity = utilData:GetEntityByPstID(petPstID)
  return utilData:GetCasterPickUpExtraChainPowerCount(entity, skillID)
end

function BattleStatHelper.IsPetJoinChainSpecial(petPstID, chainPathLen, elementType, firstElementType)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  return utilData:IsPetJoinChainSpecial(petPstID, chainPathLen, elementType, firstElementType)
end

function BattleStatHelper.OnCheckEntityHasBuffFlag(petPstID, BuffFlag)
  local mainWorld = BattleStatHelper._GetMainWorld()
  if not mainWorld then
    return
  end
  local utilData = mainWorld:GetService("UtilData")
  local entity = utilData:GetEntityByPstID(petPstID)
  return utilData:OnCheckEntityHasBuffFlag(entity, BuffFlag)
end

function BattleStatHelper.CheckCanCastActiveSkill_ByExtraParam(petPstID, skillID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilData = mainWorld:GetService("UtilData")
  local entity = utilData:GetEntityByPstID(petPstID)
  return utilData:CheckSkillCanCastByExtraParam(entity, skillID)
end
