_class("LevelMonsterParam", Object)
LevelMonsterParam = LevelMonsterParam

function LevelMonsterParam:Constructor(world)
  self._world = world
  self._monsterWaveCount = 0
  self._monsterWaveArray = {}
  self._allWaveMonsterIDs = {}
  self._loadingMonsterIDs = {}
  self._runningMonsterIDs = {}
end

function LevelMonsterParam:GetMonsterWaveArray()
  return self._monsterWaveArray
end

function LevelMonsterParam:GetWaveConfig(waveNum)
  local waveConfig = self._monsterWaveArray[waveNum]
  if waveConfig then
    return waveConfig
  end
  return nil
end

function LevelMonsterParam:GetWaveCompleteConditionType(waveNum)
  local waveConfig = self._monsterWaveArray[waveNum]
  if waveConfig then
    return waveConfig:GetCompleteConditionType()
  end
  return nil
end

function LevelMonsterParam:GetWaveCompleteConditionParam(waveNum)
  local waveConfig = self._monsterWaveArray[waveNum]
  if waveConfig then
    return waveConfig:GetCompleteConditionParam()
  end
  return nil
end

function LevelMonsterParam:IsCombinedConditionWave(waveNum)
  local waveConfig = self._monsterWaveArray[waveNum]
  if not waveConfig then
    return
  end
  return waveConfig:IsCombinedConditionWave()
end

function LevelMonsterParam:GetWaveCombinedCompleteConditionArguments(waveNum)
  local waveConfig = self._monsterWaveArray[waveNum]
  if not waveConfig then
    return
  end
  return waveConfig:GetCombinedCompleteConditionArguments()
end

function LevelMonsterParam:GetWaveInternalRefreshData(waveNum)
  local waveConfig = self._monsterWaveArray[waveNum]
  if waveConfig then
    return waveConfig:GetWaveInternalRefreshData()
  end
  return nil
end

function LevelMonsterParam:GetWaveInternalRefreshType(waveNum)
  local waveConfig = self._monsterWaveArray[waveNum]
  if waveConfig then
    return waveConfig:GetInternalRefreshType()
  end
  return nil
end

function LevelMonsterParam:GetWaveInternalRefreshTypeParam(waveNum)
  local waveConfig = self._monsterWaveArray[waveNum]
  if waveConfig then
    return waveConfig:GetInternalRefreshTypeParam()
  end
  return nil
end

function LevelMonsterParam:GetMonsterWaveCount()
  return self._monsterWaveCount
end

function LevelMonsterParam:GetWaveBeginMonsterParam(waveNum, playerPos)
  local waveConfig = self:GetWaveConfig(waveNum)
  if waveConfig then
    return waveConfig:GetWaveBeginRefreshParam(playerPos)
  end
  return nil
end

function LevelMonsterParam:GetWaveInternalRefreshMonsterParam(waveNum, refreshType)
  local waveConfig = self:GetWaveConfig(waveNum)
  if waveConfig then
    return waveConfig:GetWaveInternalRefreshParam(refreshType)
  end
  return nil
end

function LevelMonsterParam:GetWaveBeginTrapArray(waveNum)
  local waveConfig = self:GetWaveConfig(waveNum)
  if waveConfig then
    return waveConfig:GetWaveBeginRefreshTrapArray()
  end
  return nil
end

function LevelMonsterParam:GetMonsterConfigWaveArray(levelConfigData)
  if self._world:MatchType() == MatchType.MT_Conquest or self._world:MatchType() == MatchType.MT_SimpleBattleField then
    return self._world.BW_WorldInfo.waveIDList
  else
    return levelConfigData.MonsterWave
  end
end

function LevelMonsterParam:GetWaveRandoms()
  local mazeService = self._world:GetService("Maze")
  if mazeService and mazeService:IsMazeMatch() then
    return mazeService:GetMazeWaveRandoms()
  end
  local popStarPorSvc = self._world:GetService("PopStarProLogic")
  if popStarPorSvc and self._world:MatchType(GetMatchTypeType.PopStarProNoRelic) == MatchType.MT_PopStarPro then
    return popStarPorSvc:GetWaveRandoms()
  end
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local seasonMazeSvc = self._world:GetService("SeasonMaze")
    return seasonMazeSvc:GetWaveRandoms()
  end
end

function LevelMonsterParam:ParseMonsterParam(levelConfigData)
  self._monsterWaveArray = {}
  self._allWaveMonsterIDs = {}
  self._loadingMonsterIDs = {}
  self._runningMonsterIDs = {}
  local monsterWaveArray = self:GetMonsterConfigWaveArray(levelConfigData)
  self._monsterWaveCount = #monsterWaveArray
  local waveRandoms = self:GetWaveRandoms()
  local affixService = self._world:GetService("Affix")
  for k, monsterWaveID in ipairs(monsterWaveArray) do
    local monsterWaveConfig = Cfg.cfg_monster_wave[monsterWaveID]
    if monsterWaveConfig == nil then
      Log.error("LevelMonsterParam:ParseMonsterParam monsterWaveConfig =nil", monsterWaveID)
    end
    local mazeWaveInfo
    if waveRandoms then
      mazeWaveInfo = {
        waveRandoms[2 * k - 1],
        waveRandoms[2 * k]
      }
    end
    local monsterWaveParam = LevelMonsterWaveParam:New(self._world, k)
    monsterWaveParam:ParseMonsterWaveParam(monsterWaveConfig, mazeWaveInfo)
    if affixService then
      monsterWaveParam = affixService:ChangeWaveMonsterRefreshParam(monsterWaveParam, k)
    end
    self._monsterWaveArray[#self._monsterWaveArray + 1] = monsterWaveParam
    local monsterIDList = monsterWaveParam:GetWaveMonsterIDArray()
    table.appendArray(self._allWaveMonsterIDs, monsterIDList)
    if k == 1 then
      table.appendArray(self._loadingMonsterIDs, monsterIDList)
    else
      table.appendArray(self._runningMonsterIDs, monsterIDList)
    end
  end
  local preMonsterWave = levelConfigData.PreMonsterWave
  if preMonsterWave then
    local monsterWaveConfig = Cfg.cfg_monster_wave[preMonsterWave]
    if monsterWaveConfig == nil then
      Log.error("LevelMonsterParam:ParseMonsterParam monsterWaveConfig =nil", preMonsterWave)
    end
    local monsterWaveParam = LevelMonsterWaveParam:New(self._world, 0)
    monsterWaveParam:ParseMonsterWaveParam(monsterWaveConfig)
    self._monsterWaveArray[0] = monsterWaveParam
    local monsterIDList = monsterWaveParam:GetWaveMonsterIDArray()
    table.appendArray(self._allWaveMonsterIDs, monsterIDList)
    table.appendArray(self._loadingMonsterIDs, monsterIDList)
  end
end

function LevelMonsterParam:GetIsBoss(waveNum)
  local waveConfig = self:GetWaveConfig(waveNum)
  if waveConfig then
    return waveConfig:IsBossWave()
  end
  return false
end

function LevelMonsterParam:GetBossID(waveNum)
  local waveConfig = self:GetWaveConfig(waveNum)
  if waveConfig then
    return waveConfig:GetBossID()
  end
  return nil
end

function LevelMonsterParam:GetAllMonsterID()
  return self._allWaveMonsterIDs
end

function LevelMonsterParam:GetLoadingMonsterID()
  return self._loadingMonsterIDs
end

function LevelMonsterParam:GetRunningMonsterID()
  return self._runningMonsterIDs
end

function LevelMonsterParam:HitBackParam(waveNum)
  local waveConfig = self:GetWaveConfig(waveNum)
  if waveConfig then
    return waveConfig:HitBackParam()
  end
  return false
end

function LevelMonsterParam:BGMParam(waveNum)
  local waveConfig = self:GetWaveConfig(waveNum)
  if waveConfig then
    return waveConfig:BGMParam()
  end
  return false
end

function LevelMonsterParam:DebugCompleteCondition(nType, nParam)
  for i = 1, #self._monsterWaveArray do
    local waveParam = self._monsterWaveArray[i]
    waveParam:DebugCompleteCondition(nType, nParam)
  end
end

function LevelMonsterParam:GetWaveBoard(waveNum)
  local waveConfig = self:GetWaveConfig(waveNum)
  if waveConfig then
    return waveConfig:GetWaveBoard()
  end
  return nil
end

function LevelMonsterParam:ParseMonsterParamMultiBoard(monsterWaveArray)
  self._monsterWaveArray = {}
  self._allWaveMonsterIDs = {}
  self._loadingMonsterIDs = {}
  self._runningMonsterIDs = {}
  self._monsterWaveCount = #monsterWaveArray
  local affixService = self._world:GetService("Affix")
  for k, monsterWaveID in ipairs(monsterWaveArray) do
    local monsterWaveConfig = Cfg.cfg_monster_wave[monsterWaveID]
    if monsterWaveConfig == nil then
      Log.error("LevelMonsterParam:ParseMonsterParam monsterWaveConfig =nil", monsterWaveID)
    end
    local mazeWaveInfo
    local monsterWaveParam = LevelMonsterWaveParam:New(self._world, k)
    monsterWaveParam:ParseMonsterWaveParam(monsterWaveConfig, mazeWaveInfo)
    if affixService then
      monsterWaveParam = affixService:ChangeWaveMonsterRefreshParam(monsterWaveParam, k)
    end
    self._monsterWaveArray[#self._monsterWaveArray + 1] = monsterWaveParam
    local monsterIDList = monsterWaveParam:GetWaveMonsterIDArray()
    table.appendArray(self._allWaveMonsterIDs, monsterIDList)
    if k == 1 then
      table.appendArray(self._loadingMonsterIDs, monsterIDList)
    else
      table.appendArray(self._runningMonsterIDs, monsterIDList)
    end
  end
end

function LevelMonsterParam:WaveMonsterShowInterval(waveNum)
  local waveConfig = self:GetWaveConfig(waveNum)
  if waveConfig then
    return waveConfig:GetMonsterWaveShowInterval()
  end
  return 0
end
