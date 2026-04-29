_class("LevelConfigData", Object)
LevelConfigData = LevelConfigData

function LevelConfigData:Constructor(configService, world)
  self._world = world
  self._configService = configService
  self._levelResPath = "NoneConfig"
  self._levelGridGenID = 0
  self._isApplyPetSupplyPieceWeight = 0
  self._runPosition = self._world:GetRunningPosition()
  if self._runPosition == WorldRunPostion.AtClient or self._runPosition == WorldRunPostion.Performance then
    self._levelCameraParam = LevelCameraParam:New()
  end
  self._levelMonsterParam = LevelMonsterParam:New(world)
  self._levelCompleteConditionType = 0
  self._levelCompleteConditionParams = {}
  self._levelFirstMonsterArray = {}
  self._levelFirstWaveBossID = nil
  self._levelPlayerBornPos = Vector2(0, 0)
  self._levelPlayerBornRotation = Vector2(0, 0)
  self._levelID = 0
  self._collectDropItemID = -1
  self._collectDropItemNum = -1
  self._boardCenter = Vector3(0, 0, 1)
  self._themeID = -1
  self._levelStoryTips = {}
  self._levelStoryBanner = {}
  self._levelCutscene = {}
  self._levelRoundCount = 0
  self._levelWeakLineData = nil
  self._bgmID = nil
  self._autoFightLevelPolicy = nil
  self._changeTeamLeaderCount = -1
  self._remotePlayerBornPos = Vector2(5, 5)
  self._remotePlayerBornDir = Vector2(0, -1)
  self._chessPetRefreshID = nil
  self._multiBoard = {}
  self._outOfRoundType = 0
  self._miniMazeWaveCfgArray = {}
end

function LevelConfigData:_ParseLevelRoundCount()
  if self._world:MatchType() == MatchType.MT_Maze then
    local mazeService = self._world:GetService("Maze")
    self._levelRoundCount = mazeService:GetLightCount()
  elseif self._world:MatchType() == MatchType.MT_Conquest then
    local cfg = self:GetConquestConfig()
    self._levelRoundCount = cfg.MaxRound
  elseif self._world:MatchType() == MatchType.MT_SimpleBattleField then
    local cfg = self:GetSimpleConquestConfig()
    self._levelRoundCount = cfg.MaxRound
  elseif self._world:MatchType(GetMatchTypeType.PopStarProNoRelic) == MatchType.MT_PopStarPro then
    local popStarProSvc = self._world:GetService("PopStarProLogic")
    self._levelRoundCount = popStarProSvc:GetLeftRoundCount()
  elseif self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local seasonMazeService = self._world:GetService("SeasonMaze")
    self._levelRoundCount = seasonMazeService:GetRoundCount()
  end
  if self._world:GetRunningPosition() ~= WorldRunPostion.Performance and self._world:GetRunningPosition() ~= WorldRunPostion.Cutscene then
    local affixService = self._world:GetService("Affix")
    self._levelRoundCount = affixService:ChangeLevelRound(self._levelRoundCount)
    local talentSvc = self._world:GetService("Talent")
    self._levelRoundCount = self._levelRoundCount + talentSvc:GetAddRoundCount(self._levelID)
  end
end

function LevelConfigData:_ParseChangeTeamLeaderCount()
  if self._world:GetRunningPosition() ~= WorldRunPostion.Performance then
    local talentSvc = self._world:GetService("Talent")
    self._changeTeamLeaderCount = self._changeTeamLeaderCount + talentSvc:GetAddChangeTeamLeaderCount()
  end
end

function LevelConfigData:ParseLevelConfig(levelID)
  Log.notice("[LevelConfigData] level id = ", levelID)
  self._levelID = levelID
  local levelConfigData = Cfg.cfg_level[levelID]
  if not levelConfigData then
    Log.exception("ParseLevelConfig not find levelID = ", levelID)
    return
  end
  self._levelRoundCount = levelConfigData.Round
  self:_ParseLevelRoundCount()
  local bornPos = levelConfigData.BornPos
  self._levelPlayerBornPos = Vector2(bornPos[1], bornPos[2])
  local bornRotation = levelConfigData.BornRotation
  self._levelPlayerBornRotation = Vector2(bornRotation[1], bornRotation[2])
  local remotePos = levelConfigData.EnemyBornPos
  if remotePos then
    self._remotePlayerBornPos.x, self._remotePlayerBornPos.y = remotePos[1], remotePos[2]
  end
  local remoteRotation = levelConfigData.EnemyBornRotation
  if remoteRotation then
    self._remotePlayerBornDir.x, self._remotePlayerBornDir.y = remoteRotation[1], remoteRotation[2]
  end
  self._levelGridGenID = levelConfigData.GridGenID
  if self._world:MatchType() == MatchType.MT_Conquest then
    local cfg = self:GetConquestConfig()
    self._levelGridGenID = cfg.BoardID
  end
  if self._world:MatchType() == MatchType.MT_SimpleBattleField then
    local cfg = self:GetSimpleConquestConfig()
    self._levelGridGenID = cfg.BoardID
  end
  self._isApplyPetSupplyPieceWeight = levelConfigData.PetSupplyPieceWeight or 0
  self._themeID = levelConfigData.Theme
  if self._runPosition ~= WorldRunPostion.Cutscene then
    self._levelMonsterParam:ParseMonsterParam(levelConfigData)
  end
  self._levelCompleteConditionType = levelConfigData.CompleteConditionID
  self._levelCompleteConditionParams = levelConfigData.CompleteConditionParams or {}
  if self._levelCompleteConditionType == CompleteConditionType.CombinedCompleteCondition then
    self._combinedCompleteConditionA = levelConfigData.CombinedCompleteConditionA
    self._combinedCompleteConditionAParam = levelConfigData.CombinedCompleteConditionParamA
    self._combinedCompleteConditionB = levelConfigData.CombinedCompleteConditionB
    self._combinedCompleteConditionBParam = levelConfigData.CombinedCompleteConditionParamB
  end
  if levelConfigData.BoardCenter ~= nil then
    local center = Vector3(levelConfigData.BoardCenter[1], levelConfigData.BoardCenter[2], levelConfigData.BoardCenter[3])
    self._boardCenter = center
  end
  if levelConfigData.StoryTips then
    for _, param in ipairs(levelConfigData.StoryTips) do
      local tipsParam = LevelStoryTipsParam:New(param)
      table.insert(self._levelStoryTips, tipsParam)
    end
  end
  if levelConfigData.StoryBanner then
    for _, param in ipairs(levelConfigData.StoryBanner) do
      local bannerParam = LevelStoryBannerParam:New(param)
      table.insert(self._levelStoryBanner, bannerParam)
    end
  end
  if levelConfigData.Cutscene then
    for _, param in ipairs(levelConfigData.Cutscene) do
      local cutsceneParam = LevelCutsceneParam:New(param)
      table.insert(self._levelCutscene, cutsceneParam)
    end
  end
  if levelConfigData.WeakLine then
    self._levelWeakLineData = {}
    local showType = levelConfigData.WeakLine[1].type
    if showType == 1 then
    elseif showType == 0 then
      local dontShowRounds = {}
      for i = 2, #levelConfigData.WeakLine do
        local data = levelConfigData.WeakLine[i]
        table.insert(dontShowRounds, data)
      end
      self._levelWeakLineData.dontShowRounds = dontShowRounds
    end
  else
    self._levelWeakLineData = nil
  end
  if self._runPosition == WorldRunPostion.AtClient then
    self:ParseCameraParam(levelConfigData.Theme)
    local cfgThemeData = Cfg.cfg_theme[levelConfigData.Theme]
    self._bgmID = cfgThemeData.BgmID
  end
  self._autoFightLevelPolicy = levelConfigData.AutoFightLevelPolicy
  self._autoFightLevelPolicyParam = levelConfigData.AutoFightLevelPolicyParam
  self._changeTeamLeaderCount = levelConfigData.ChangTeamMaxCount
  self:_ParseChangeTeamLeaderCount()
  if self._world:MatchType() == MatchType.MT_Chess then
    self._chessPetRefreshID = levelConfigData.ChessPetRefreshID
  end
  local affixService = self._world:GetService("Affix")
  self._featureList = affixService:ReplaceReplaceFeatureModule(levelConfigData.FeatureList)
  if levelConfigData.GridGenID then
    self._multiBoard = table.cloneconf(levelConfigData.MultiBoard) or {}
    self._levelMonsterParamMultiBoard = {}
    for _, v in ipairs(self._multiBoard) do
      local boardIndex = v.index
      local levelMonsterParam = LevelMonsterParam:New(self._world)
      levelMonsterParam:ParseMonsterParamMultiBoard(v.monsterWave)
      self._levelMonsterParamMultiBoard[boardIndex] = levelMonsterParam
    end
  end
  self._outOfRoundType = levelConfigData.OutOfRoundType or 0
  local extraLogic = levelConfigData.ExtraLogic
  if extraLogic then
    self._ignoreProtectedTrapDead = extraLogic.IgnoreProtectedDead
  end
  self:_ParseMiniMazeWaveCfg(levelConfigData)
end

function LevelConfigData:_ParseMiniMazeWaveCfg(levelConfig)
  if self._world:MatchType() == MatchType.MT_MiniMaze then
    local monsterWaveArray = levelConfig.MonsterWave
    if monsterWaveArray then
      for k, monsterWaveID in ipairs(monsterWaveArray) do
        local miniMazeWaveConfig = Cfg.cfg_mini_maze_wave[monsterWaveID]
        if miniMazeWaveConfig == nil then
          Log.error("LevelMonsterParam miniMazeWaveConfig =nil", monsterWaveID)
        end
        self._miniMazeWaveCfgArray[#self._miniMazeWaveCfgArray + 1] = miniMazeWaveConfig
      end
    end
  end
end

function LevelConfigData:ParseCameraParam(themeID)
  local cfgThemeData = Cfg.cfg_theme[themeID]
  self._levelResPath = cfgThemeData.SceneResPath
  self._levelCameraParam:ParseCameraParam(cfgThemeData)
end

function LevelConfigData:GetFeatureList()
  return self._featureList
end

function LevelConfigData:GetAutoFightLevelPolicy()
  return self._autoFightLevelPolicy, self._autoFightLevelPolicyParam
end

function LevelConfigData:GetLevelRoundCount()
  return self._levelRoundCount
end

function LevelConfigData:GetLevelWeakLineData()
  return self._levelWeakLineData
end

function LevelConfigData:GetLevelID()
  return self._levelID
end

function LevelConfigData:GetPlayerBornPos()
  return self._levelPlayerBornPos
end

function LevelConfigData:SetPlayerBornPos(pos)
  self._levelPlayerBornPos = pos
end

function LevelConfigData:GetRemotePlayerBornPos()
  return self._remotePlayerBornPos
end

function LevelConfigData:GetRemotePlayerBornRotation()
  return self._remotePlayerBornDir
end

function LevelConfigData:GetPlayerBornRotation()
  return self._levelPlayerBornRotation
end

function LevelConfigData:GetBgmID()
  return self._bgmID
end

function LevelConfigData:GetWaveCompleteConditionType(waveNum)
  local affixService = self._world:GetService("Affix")
  local waveCount = self._levelMonsterParam:GetMonsterWaveCount()
  if waveCount == waveNum then
    return affixService:GetAffixLastWaveCompleteType(self._levelMonsterParam:GetWaveCompleteConditionType(waveNum))
  end
  return self._levelMonsterParam:GetWaveCompleteConditionType(waveNum)
end

function LevelConfigData:GetWaveCombinedCompleteConditionArguments(waveNum)
  return self._levelMonsterParam:GetWaveCombinedCompleteConditionArguments(waveNum)
end

function LevelConfigData:GetWaveCompleteConditionParam(waveNum)
  local affixService = self._world:GetService("Affix")
  local waveCount = self._levelMonsterParam:GetMonsterWaveCount()
  if waveCount == waveNum then
    return affixService:GetAffixLastWaveCompleteParam(self._levelMonsterParam:GetWaveCompleteConditionParam(waveNum))
  end
  return self._levelMonsterParam:GetWaveCompleteConditionParam(waveNum)
end

function LevelConfigData:GetWaveCount()
  return self._levelMonsterParam:GetMonsterWaveCount()
end

function LevelConfigData:GetWaveConfig(waveNum)
  return self._levelMonsterParam:GetWaveConfig(waveNum)
end

function LevelConfigData:GetCameraParam()
  return self._levelCameraParam
end

function LevelConfigData:GetLevelResPath()
  return self._levelResPath
end

function LevelConfigData:GetGridGenID()
  return self._levelGridGenID
end

function LevelConfigData:IsApplyPetSupplyPieceWeight()
  return self._isApplyPetSupplyPieceWeight == 1
end

function LevelConfigData:GetLevelWaveBeginRefreshMonsterParam(waveNum, playerPos)
  return self._levelMonsterParam:GetWaveBeginMonsterParam(waveNum, playerPos)
end

function LevelConfigData:GetLevelWaveInternalRefreshMonsterParam(waveNum, refreshType)
  return self._levelMonsterParam:GetWaveInternalRefreshMonsterParam(waveNum, refreshType)
end

function LevelConfigData:GetLevelWaveTrapIDArray(waveNum)
  return self._levelMonsterParam:GetWaveBeginTrapArray(waveNum)
end

function LevelConfigData:GetLevelAllWaveTraps()
  local trapParamArray = {}
  local trapIDPreArray = self:GetLevelWaveTrapIDArray(0)
  if trapIDPreArray then
    table.appendArray(trapParamArray, trapIDPreArray)
  end
  for i = 1, self:GetWaveCount() do
    local trapIDArray = self:GetLevelWaveTrapIDArray(i)
    table.appendArray(trapParamArray, trapIDArray)
  end
  return trapParamArray
end

function LevelConfigData:GetLevelWaveInternalRefreshData(waveNum)
  return self._levelMonsterParam:GetWaveInternalRefreshData(waveNum)
end

function LevelConfigData:GetLevelCompleteConditionType()
  local affixService = self._world:GetService("Affix")
  return affixService:GetAffixLevelCompleteType(self._levelCompleteConditionType)
end

function LevelConfigData:IsCombinedCompleteCondition()
  local conditionType = self:GetLevelCompleteConditionType()
  return conditionType == CompleteConditionType.CombinedCompleteCondition
end

function LevelConfigData:GetCombinedCompleteConditionArguments()
  return {
    conditionA = self._combinedCompleteConditionA,
    conditionParamA = self._combinedCompleteConditionAParam,
    conditionB = self._combinedCompleteConditionB,
    conditionParamB = self._combinedCompleteConditionBParam
  }
end

function LevelConfigData:GetLevelCollectItem()
  local waves = self._levelMonsterParam:GetMonsterWaveArray()
  if not waves then
    return
  end
  local count = 0
  for i, v in ipairs(waves) do
    if v:GetCompleteConditionType() == CompleteConditionType.CollectItems or v:GetCompleteConditionType() == CompleteConditionType.AllMonsterDeadOrCollectItems then
      local param = v:GetCompleteConditionParam()[1]
      count = count + param[2]
      break
    end
  end
  return count
end

function LevelConfigData:GetLevelMonsterEscapeLimit()
  local waves = self._levelMonsterParam:GetMonsterWaveArray()
  if not waves then
    return
  end
  local count = 0
  for i, v in ipairs(waves) do
    if v:GetCompleteConditionType() == CompleteConditionType.RoundCountLimitAndCheckMonsterEscape then
      local param = v:GetCompleteConditionParam()[1]
      count = count + param[2]
    end
  end
  return count
end

function LevelConfigData:GetLevelCompleteConditionParamList(completeConditionType)
  local waves = self._levelMonsterParam:GetMonsterWaveArray()
  if not waves then
    return
  end
  local paramList = {}
  for i, v in ipairs(waves) do
    local param = v:GetCompleteConditionParam()[1]
    if completeConditionType and v:GetCompleteConditionType() == completeConditionType then
      table.insert(paramList, param)
    else
      table.insert(paramList, param)
    end
  end
  return paramList
end

function LevelConfigData:GetLevelCompleteConditionParams()
  local affixService = self._world:GetService("Affix")
  return affixService:GetAffixLevelCompleteParam(self._levelCompleteConditionParams)
end

function LevelConfigData:GetLevelCompleteConditionStr()
  if self._levelCompleteConditionType ~= CompleteConditionType.CombinedCompleteCondition then
    return self:_GetSingleCompleteConditionStr(self._levelCompleteConditionType, self._levelCompleteConditionParams)
  end
  local mode = self._levelCompleteConditionParams[1][1]
  local args = self:GetCombinedCompleteConditionArguments()
  local strA = self:_GetSingleCompleteConditionStr(args.conditionA, args.conditionParamA)
  local strB = self:_GetSingleCompleteConditionStr(args.conditionB, args.conditionParamB)
  local str = ""
  if mode == CombinedCompleteConditionMode.And then
    str = StringTable.Get("str_battle_condition_and", strA, strB)
  elseif mode == CombinedCompleteConditionMode.Or then
    str = StringTable.Get("str_battle_condition_or", strA, strB)
  end
  return str
end

function LevelConfigData:_GetSingleCompleteConditionStr(conditionType, param)
  Log.debug("[level] LevelConfigData:GetLevelCompleteConditionStr", conditionType)
  if conditionType == CompleteConditionType.AllBossNotSurvival then
    local strID = Cfg.cfg_level_complete_condition[conditionType].ConditionStr
    local monsterConfigData = self._configService:GetMonsterConfigData()
    local monsterNameList = {}
    for k, v in ipairs(param[1]) do
      local name = StringTable.Get(monsterConfigData:GetMonsterName(tonumber(v)))
      local bornType = monsterConfigData:GetMonsterBornType(tonumber(v))
      if bornType ~= MonsterBornType.AfterFury then
        table.insert(monsterNameList, name)
      end
    end
    local ret = StringTable.Get(strID) .. " "
    for _, name in ipairs(monsterNameList) do
      ret = ret .. "【" .. name .. "】 "
    end
    return ret
  elseif conditionType == CompleteConditionType.AllConfigMonsterDead then
    local strID = Cfg.cfg_level_complete_condition[conditionType].ConditionStr
    local monsterConfigData = self._configService:GetMonsterConfigData()
    local monsterNameList = {}
    for k, param in ipairs(param) do
      if type(param) == "number" then
        local name = StringTable.Get(monsterConfigData:GetMonsterName(tonumber(param)))
        local bornType = monsterConfigData:GetMonsterBornType(tonumber(param))
        if bornType ~= MonsterBornType.AfterFury then
          table.insert(monsterNameList, name)
        end
      elseif type(param) == "table" then
        for i, v in ipairs(param) do
          local monsterID = tonumber(v)
          local name = StringTable.Get(monsterConfigData:GetMonsterName(tonumber(monsterID)))
          local bornType = monsterConfigData:GetMonsterBornType(tonumber(monsterID))
          if bornType ~= MonsterBornType.AfterFury then
            table.insert(monsterNameList, name)
          end
        end
      end
    end
    local ret = StringTable.Get(strID) .. " "
    for _, name in ipairs(monsterNameList) do
      ret = ret .. "【" .. name .. "】 "
    end
    return ret
  else
    local strID = ""
    local cfgv = Cfg.cfg_level_complete_condition[conditionType]
    if cfgv then
      strID = cfgv.ConditionStr
    else
      Log.warn("### no data in cfg_level_complete_condition. ID=", conditionType)
    end
    if conditionType == CompleteConditionType.CollectItems or conditionType == CompleteConditionType.AllMonsterDeadOrCollectItems then
      local dropItemID = param[1][1]
      local dropItemCount = param[1][2]
      local collectDropType = param[1][3] or UICollectDropType.Base
      local retStr = StringTable.Get(strID, dropItemCount)
      local collectCfg = Cfg.cfg_level_complete_condition_collect_drop[collectDropType]
      if collectCfg and collectCfg.LevelConditionStr then
        if collectCfg.DropName then
          retStr = StringTable.Get(collectCfg.LevelConditionStr, dropItemCount, collectCfg.DropName)
        else
          retStr = StringTable.Get(collectCfg.LevelConditionStr, dropItemCount)
        end
      end
      return retStr
    elseif conditionType == CompleteConditionType.KillSpecificMonsterCount then
      local monsterID = param[1][1]
      local monsterCount = param[1][2]
      local monsterConfigData = self._configService:GetMonsterConfigData()
      local monsterName = StringTable.Get(monsterConfigData:GetMonsterName(monsterID))
      return StringTable.Get(strID, monsterCount, monsterName)
    elseif conditionType == CompleteConditionType.KillMoreThanPetMonster then
      local monsterID = param[1][1]
      local monsterConfigData = self._configService:GetMonsterConfigData()
      local monsterName = StringTable.Get(monsterConfigData:GetMonsterName(monsterID))
      return StringTable.Get(strID, monsterName)
    elseif param[1] then
      return StringTable.Get(strID, param[1][1])
    else
      return StringTable.Get(strID)
    end
  end
end

function LevelConfigData:GetIsBoss(waveNum)
  return self._levelMonsterParam:GetIsBoss(waveNum)
end

function LevelConfigData:GetBossID(waveNum)
  local id = self._levelMonsterParam:GetBossID(waveNum)
  if not id then
    Log.fatal("GetBossID Failed LevelID:", self._levelID, "WaveNum:", waveNum)
  end
  local affixService = self._world:GetService("Affix")
  id = affixService:ChangeMonsterID(id, waveNum)
  return id
end

function LevelConfigData:GetAllMonsterID()
  return self._levelMonsterParam:GetAllMonsterID()
end

function LevelConfigData:GetLoadingMonsterID()
  return self._levelMonsterParam:GetLoadingMonsterID()
end

function LevelConfigData:GetRunningMonsterID()
  return self._levelMonsterParam:GetRunningMonsterID()
end

function LevelConfigData:HitBackParam(waveNum)
  return self._levelMonsterParam:HitBackParam(waveNum)
end

function LevelConfigData:GetBoardCenterPos(waveNum)
  return self._boardCenter
end

function LevelConfigData:BGMParam(waveNum)
  return self._levelMonsterParam:BGMParam(waveNum)
end

function LevelConfigData:GetLevelStoryTipsParam()
  return self._levelStoryTips
end

function LevelConfigData:GetLevelStoryBannerParam()
  return self._levelStoryBanner
end

function LevelConfigData:GetLevelCutsceneParam()
  return self._levelCutscene
end

function LevelConfigData:GetStoryTipsList(tipsID)
  local tipsConfig = Cfg.cfg_level_story_tips[tipsID]
  local tipsList = {}
  if not tipsConfig then
    Log.fatal("tipsConfig is Nil TipsID:", tipsID)
  end
  for _, v in ipairs(tipsConfig.TipsList) do
    local storyTipsParam = StoryTipsParam:New(v)
    table.insert(tipsList, storyTipsParam)
  end
  return tipsList
end

function LevelConfigData:GetStoryBannerList(bannerID)
  local bannerConfig = Cfg.cfg_story_banner[bannerID]
  local bannerList = {}
  if not bannerConfig then
    Log.fatal("bannerConfig is Nil BannerID:", bannerID)
  end
  for _, v in ipairs(bannerConfig.BannerList) do
    local bannerParam = StoryBannerParam:New(v)
    table.insert(bannerList, bannerParam)
  end
  return bannerList
end

function LevelConfigData:DebugCompleteCondition(nType, nParam)
  self._levelCompleteConditionType = nType
  self._levelCompleteConditionParams = nParam
  self._levelMonsterParam:DebugCompleteCondition(nType, nParam)
end

function LevelConfigData:GetChangeTeamLeaderCount()
  return self._changeTeamLeaderCount
end

function LevelConfigData:GetWaveBoard(waveNum)
  return self._levelMonsterParam:GetWaveBoard(waveNum)
end

function LevelConfigData:GetWaveBuff(waveNum)
  local cfg = Cfg.cfg_conquest_level_wave({
    LevelID = self._levelID,
    WaveIndex = waveNum
  })
  if cfg then
  end
end

function LevelConfigData:GetSimpleConquestWaveBuff(waveNum)
  local cfg = Cfg.cfg_simple_conquest_level_wave({
    LevelID = self._levelID,
    WaveIndex = waveNum
  })
  if cfg then
  end
end

function LevelConfigData:GetConquestConfig()
  if self._world:MatchType() == MatchType.MT_Conquest or self._world:MatchType() == MatchType.MT_SimpleBattleField then
    local conQuestInfo = self._world.BW_WorldInfo:GetConquestCreateInfo()
    local missionID = conQuestInfo.mission_id
    local randomIndex = conQuestInfo.random_index
    local cfg = Cfg.cfg_conquest_mission({MissionID = missionID, RandomID = randomIndex})
    if not cfg then
      Log.fatal("GetConquestConfig Failed missionID:", missionID, "RandomID:", randomIndex)
    end
    return cfg[1]
  else
    Log.fatal("GetInvalidConfig MatchTypeInvalid MatchType:", self._world:MatchType())
  end
end

function LevelConfigData:GetSimpleConquestConfig()
  if self._world:MatchType() == MatchType.MT_SimpleBattleField then
    local simpleConquestInfo = self._world.BW_WorldInfo:GetSimpleConquestCreateInfo()
    local missionID = simpleConquestInfo.mission_id
    local cfg = Cfg.cfg_simple_conquest_mission({MissionID = missionID})
    if not cfg then
      Log.fatal("GetSimpleConquestConfig Failed missionID:", missionID)
    end
    return cfg[1]
  else
    Log.fatal("GetInvalidConfig MatchTypeInvalid MatchType:", self._world:MatchType())
  end
end

function LevelConfigData:GetChessPetRefreshID()
  return self._chessPetRefreshID
end

function LevelConfigData:IsSpliceBoardLevel()
  local boardConfig = Cfg.cfg_board[self._levelGridGenID]
  local isSpliceBoardLevel = boardConfig.SpliceBoard and table.count(boardConfig.SpliceBoard) > 0
  return isSpliceBoardLevel
end

function LevelConfigData:IsPushBoardLevel()
  local boardConfig = Cfg.cfg_board[self._levelGridGenID]
  return boardConfig.PushBoard and table.count(boardConfig.PushBoard) > 0
end

function LevelConfigData:GetMultiBoard()
  return self._multiBoard
end

function LevelConfigData:IsMultiBoardLevel()
  local isMultiBoardLevel = self._multiBoard and table.count(self._multiBoard) > 0
  return isMultiBoardLevel
end

function LevelConfigData:GetMultiBoardInfo(boardIndex)
  local boardInfo
  for _, v in ipairs(self._multiBoard) do
    if v.index == boardIndex then
      boardInfo = v
      break
    end
  end
  return boardInfo
end

function LevelConfigData:GetLevelWaveBeginRefreshMonsterParamMultiBoard(boardIndex, waveNum, playerPos)
  local levelMonsterParam = self._levelMonsterParamMultiBoard[boardIndex]
  if levelMonsterParam then
    local monsterRefreshParam = levelMonsterParam:GetWaveBeginMonsterParam(waveNum, playerPos)
    if monsterRefreshParam then
      monsterRefreshParam:SetBoardIndex(boardIndex)
    end
    return monsterRefreshParam
  end
end

function LevelConfigData:GetOutOfRoundType()
  return self._outOfRoundType
end

function LevelConfigData:GetWaveShowInterval(waveNum)
  return self._levelMonsterParam:WaveMonsterShowInterval(waveNum)
end

function LevelConfigData:GetIgnoreProtectedTrapDead()
  return self._ignoreProtectedTrapDead
end

function LevelConfigData:GetMiniMazeWaveCfg(waveNum)
  return self._miniMazeWaveCfgArray[waveNum]
end
