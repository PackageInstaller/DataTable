_class("ConfigService", Object)
ConfigService = ConfigService

function ConfigService:Constructor(world)
  self._world = world
end

function ConfigService:Initialize()
  self._levelConfigData = LevelConfigData:New(self, self._world)
  self._monsterConfigData = MonsterConfigData:New(self._world)
  self._trapConfigData = TrapConfigData:New()
  self._aiConfigData = AiConfigData:New()
  self._chessPetConfigData = ChessPetConfigData:New(self._world)
  local hasViewParser = true
  local runPos = self._world:GetRunningPosition()
  if runPos == WorldRunPostion.AtServer then
    hasViewParser = false
  end
  self._skillConfigHelper = SkillConfigHelper:New(hasViewParser)
  self._buffConfigDic = {}
  self._dropConfigData = MonsterDropConfigData:New()
  self._dropItemConfigDic = {}
  self._cutsceneDic = {}
  self._featureConfigHelper = FeatureConfigHelper:New()
end

function ConfigService:InitConfig()
  local worldContext = self._world.BW_WorldInfo
  self._levelConfigData:ParseLevelConfig(worldContext.level_id)
end

function ConfigService:GetLevelConfigData()
  return self._levelConfigData
end

function ConfigService:GetMonsterConfigData()
  return self._monsterConfigData
end

function ConfigService:GetTrapConfigData()
  return self._trapConfigData
end

function ConfigService:GetAiConfigData()
  return self._aiConfigData
end

function ConfigService:ClearSkillConfigData()
  self._skillConfigHelper:ClearSkillData()
end

function ConfigService:GetSkillConfigData(skillID, casterEntity, forceFetchNew)
  local configData = self._skillConfigHelper:GetSkillData(skillID, forceFetchNew)
  if not (casterEntity and casterEntity:HasPetPstID()) or configData:GetSkillType() ~= SkillType.Active then
    return configData
  end
  local isSkillReplacedByFeatureScan = casterEntity:HasMatchPet()
  if isSkillReplacedByFeatureScan then
    local matchPetData = casterEntity:MatchPet():GetMatchPet()
    local featureList = matchPetData:GetFeatureList() or {
      feature = {}
    }
    isSkillReplacedByFeatureScan = featureList.feature[FeatureType.Scan] ~= nil
  end
  if not isSkillReplacedByFeatureScan then
    return configData
  else
    local eBoard = self._world:GetBoardEntity()
    local cLogicFeature = eBoard:LogicFeature()
    if not cLogicFeature:GetActiveSkillConfigData() then
      return configData
    end
    return cLogicFeature:GetActiveSkillConfigData()
  end
end

function ConfigService:GetBuffConfigData(buffID)
  if self._buffConfigDic[buffID] ~= nil then
    return self._buffConfigDic[buffID]
  end
  local buffConfigData = BuffConfigData:New(buffID)
  self._buffConfigDic[buffID] = buffConfigData
  return buffConfigData
end

function ConfigService:GetMonsterDropConfigData()
  return self._dropConfigData
end

function ConfigService:GetMonsterDropItemConfigData(dropItemID)
  if self._dropItemConfigDic[dropItemID] ~= nil then
    return self._dropItemConfigDic[dropItemID]
  end
  local dropItemConfigData = MonsterDropItemConfigData:New()
  self._dropItemConfigDic[dropItemID] = dropItemConfigData
  return dropItemConfigData
end

function ConfigService:GetMission3StarCondition(missionID)
  local mission_config = Cfg.cfg_mission[missionID]
  local condition = {}
  if mission_config then
    table.insert(condition, mission_config.ThreeStarCondition1)
    table.insert(condition, mission_config.ThreeStarCondition2)
    table.insert(condition, mission_config.ThreeStarCondition3)
  end
  return condition
end

function ConfigService:GetCampaignMission3StarCondition(missionID)
  local mission_config = Cfg.cfg_campaign_mission[missionID]
  local condition = {}
  if mission_config and mission_config.IgnoreThreeStar == 0 then
    table.insert(condition, mission_config.ThreeStarCondition1)
    table.insert(condition, mission_config.ThreeStarCondition2)
    table.insert(condition, mission_config.ThreeStarCondition3)
  end
  return condition
end

function ConfigService:GetChessMission3StarCondition(missionID)
  local mission_config = Cfg.cfg_chess_mission[missionID]
  local condition = {}
  if mission_config and mission_config.IgnoreThreeStar == 0 then
    table.insert(condition, mission_config.ThreeStarCondition1)
    table.insert(condition, mission_config.ThreeStarCondition2)
    table.insert(condition, mission_config.ThreeStarCondition3)
  end
  return condition
end

function ConfigService:GetExtMission3StarCondition(taskID)
  local mission_config = Cfg.cfg_extra_mission_task[taskID]
  local condition = {}
  if mission_config then
    condition[1] = mission_config.ThreeStarCondition1
    condition[2] = mission_config.ThreeStarCondition2
    condition[3] = mission_config.ThreeStarCondition3
  end
  return condition
end

function ConfigService:GetPopStar3StarCondition(missionID)
  local mission_config = Cfg.cfg_popstar_mission[missionID]
  local condition = {}
  if mission_config and mission_config.IgnoreThreeStar == 0 then
    table.insert(condition, mission_config.ThreeStarCondition1)
    table.insert(condition, mission_config.ThreeStarCondition2)
    table.insert(condition, mission_config.ThreeStarCondition3)
  end
  return condition
end

function ConfigService:GetPopStarPro3StarCondition(missionID)
  local mission_config = Cfg.cfg_line_popstar_mission[missionID]
  local condition = {}
  if mission_config and mission_config.IgnoreThreeStar == 0 then
    table.insert(condition, mission_config.ThreeStarCondition1)
    table.insert(condition, mission_config.ThreeStarCondition2)
    table.insert(condition, mission_config.ThreeStarCondition3)
  end
  return condition
end

function ConfigService:GetSeasonMission3StarCondition(missionID)
  local mission_config = Cfg.cfg_season_mission[missionID]
  local condition = {}
  if mission_config and mission_config.ShowCondition == 1 then
    table.insert(condition, mission_config.ThreeStarCondition1)
    table.insert(condition, mission_config.ThreeStarCondition2)
    table.insert(condition, mission_config.ThreeStarCondition3)
  end
  return condition
end

function ConfigService:GetPetPassiveSkill(passiveSkillID)
  local config = Cfg.cfg_passive_skill[passiveSkillID]
  return config
end

function ConfigService:GetChangeTeamLeaderCount()
  local count = self._levelConfigData:GetChangeTeamLeaderCount()
  return count
end

function ConfigService:GetWaveCompleteConditionType(waveIndex)
  local completeConditionType = self._levelConfigData:GetWaveCompleteConditionType(waveIndex)
  return completeConditionType
end

function ConfigService:GetMonsterHealth(entity)
  if not entity:HasMonsterID() then
    if EDITOR then
      Log.exception("Func Call Invalid ,Trace:", Log.traceback())
    else
      Log.fatal("Func Call Invalid ,Trace:", Log.traceback())
    end
  end
  local monsterIDCmpt = entity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  if not monsterIDCmpt:IsMultiHPMonster() then
    return self._monsterConfigData:GetMonsterHealth(monsterID)
  else
    local multiHPData = self._monsterConfigData:GetMonsterMultiHealth(monsterID)
    local stage = monsterIDCmpt:GetMultiHPStage()
    if stage > #multiHPData then
      return multiHPData[#multiHPData]
    end
    return multiHPData[stage]
  end
end

function ConfigService:GetCutsceneConfig(cutsceneID)
  if self._cutsceneDic[cutsceneID] ~= nil then
    return self._cutsceneDic[cutsceneID]
  end
  local cutsceneCfgData = CutsceneConfigData:New()
  cutsceneCfgData:ParseCutsceneConfig(cutsceneID)
  self._cutsceneDic[cutsceneID] = cutsceneCfgData
  return cutsceneCfgData
end

function ConfigService:GetN5CurWaveConfig()
  if self._world._matchType == MatchType.MT_Conquest then
    local levelID = self._world.BW_WorldInfo.level_id
    local waveIndex = self._world:BattleStat():GetCurWaveIndex()
    local cfg = Cfg.cfg_conquest_level_wave({LevelID = levelID, WaveIndex = waveIndex})
    if not cfg then
      Log.fatal("GetN5CurWaveConfig Failed LevelID:", levelID, "WaveIndex:", waveIndex)
    end
    return cfg[1]
  end
  Log.fatal("GetN5CurWaveConfig MatchType", self._world._matchType, " Invalid ")
end

function ConfigService:N5GetCurWaveScore()
  local cfg = self:GetN5CurWaveConfig()
  if cfg then
    return cfg.WaveFirstPassAward[2]
  end
end

function ConfigService:GetN5WaveBuff()
  local cfg = self:GetN5CurWaveConfig()
  if cfg then
    return cfg.WavePassBuff
  end
end

function ConfigService:GetCNN5CurWaveConfig()
  if self._world._matchType == MatchType.MT_SimpleBattleField then
    local levelID = self._world.BW_WorldInfo.level_id
    local waveIndex = self._world:BattleStat():GetCurWaveIndex()
    local cfg = Cfg.cfg_simple_conquest_level_wave({LevelID = levelID, WaveIndex = waveIndex})
    if not cfg then
      Log.fatal("GetCNN5CurWaveConfig Failed LevelID:", levelID, "WaveIndex:", waveIndex)
    end
    return cfg[1]
  end
  Log.fatal("GetCNN5CurWaveConfig MatchType", self._world._matchType, " Invalid ")
end

function ConfigService:CNCNN5GetCurWaveScore()
  local cfg = self:GetCNN5CurWaveConfig()
  if cfg then
    return cfg.WaveFirstPassAward[2]
  end
end

function ConfigService:GetCNN5WaveBuff()
  local cfg = self:GetCNN5CurWaveConfig()
  if cfg then
    return cfg.WavePassBuff
  end
end

function ConfigService:GetHardID()
  if self._world._matchType == MatchType.MT_Conquest then
    local cfg = self:GetN5CurWaveConfig()
    return cfg.DiffParamID
  elseif self._world._matchType == MatchType.MT_MiniMaze then
    local levelConfigData = self:GetLevelConfigData()
    local curWaveIndex = self._world:BattleStat():GetCurWaveIndex()
    local cfgMiniMazeWave = levelConfigData:GetMiniMazeWaveCfg(curWaveIndex)
    return cfgMiniMazeWave.DiffParamID
  elseif self._world._matchType == MatchType.MT_SimpleBattleField then
    local cfg = self:GetCNN5CurWaveConfig()
    return cfg.DiffParamID
  else
    return self._world:GetHardID()
  end
end

function ConfigService:GetAffixHardParam(attrFormalType)
  local defY = BattleConst.MonsterADHFormula2ParmaYDefault
  local defZ = BattleConst.MonsterADHFormula2ParmaZDefault
  local hardID = self:GetHardID()
  local cfg = Cfg.cfg_affix_hard_param[hardID]
  if cfg then
    if attrFormalType == MonsterADHFormulaType.N4AttackAndDefense then
      return cfg.ParamY, cfg.ParamZ
    elseif attrFormalType == MonsterADHFormulaType.N4HP then
      return cfg.ParamY2, cfg.ParamZ2
    elseif attrFormalType == MonsterADHFormulaType.N25MiniMaze then
      return cfg.ParamY3 or defY, cfg.ParamZ3 or defZ
    end
  end
  return defY, defZ
end

function ConfigService:GetChessPetConfigData()
  return self._chessPetConfigData
end

function ConfigService:GetFeatureConfigData(featureType)
  return self._featureConfigHelper:GetFeatureData(featureType)
end

function ConfigService:ParseCustomFeatureList(featureCfg)
  return self._featureConfigHelper:ParseCustomFeatureList(featureCfg)
end
