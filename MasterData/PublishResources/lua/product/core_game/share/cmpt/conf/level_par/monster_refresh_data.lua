_class("MonsterRefreshData", Object)
MonsterRefreshData = MonsterRefreshData

function MonsterRefreshData:Constructor(id, type, param, world)
  self._refreshID = id
  self._refreshType = type
  self._refreshParam = param
  self._hadRefreshRound = {}
  self._refreshCount = 1
  self._waveInternalRefreshParam = LevelMonsterRefreshParam:New(world)
  local cfg = Cfg.cfg_refresh[self._refreshID]
  if not cfg then
    Log.fatal("Cfg MonsterRefreshData Not Find ID:", self._refreshID)
  end
  local monsterRefreshID = cfg.MonsterRefreshIDList[1]
  local trapRefreshID = cfg.TrapRefreshIDList[1]
  self._monsterInternalIDList = {}
  self._trapInternalIDList = {}
  if self._refreshType ~= MonsterWaveInternalRefreshType.None then
    if 0 < monsterRefreshID then
      local monsterRefCfg = Cfg.cfg_refresh_monster[monsterRefreshID]
      if not monsterRefCfg then
        Log.fatal("Cfg monsterWaveConfig.WaveInternalRefreshID Not Find ID:", self._refreshID)
      end
      self._monsterInternalIDList = table.cloneconf(self._waveInternalRefreshParam:ParseMonsterRefreshParam(monsterRefCfg))
    end
    if 0 < trapRefreshID then
      local trapRefCfg = Cfg.cfg_refresh_trap[trapRefreshID]
      if not trapRefCfg then
        Log.fatal("Cfg monsterWaveConfig.WaveInternalRefreshID Not Find ID:", self._refreshID)
      end
      self._trapInternalIDList = table.cloneconf(self._waveInternalRefreshParam:ParseTrapRefreshParam(trapRefCfg))
    end
  end
  local limitCount
  if self._refreshType == MonsterWaveInternalRefreshType.WatchTarget then
    limitCount = tonumber(self._refreshParam[3])
  elseif self._refreshType == MonsterWaveInternalRefreshType.AllMonsterDead then
    limitCount = tonumber(self._refreshParam[1])
  elseif self._refreshType == MonsterWaveInternalRefreshType.RoundResultWatchTarget then
    limitCount = tonumber(self._refreshParam[3])
  elseif self._refreshType == MonsterWaveInternalRefreshType.RoundResultCheckMonsterCount then
    limitCount = tonumber(self._refreshParam[3])
  end
  if limitCount and 0 < limitCount then
    self._refreshCount = limitCount
  end
  self._showInterval = 0
end

function MonsterRefreshData:AddRefreshRound(key, round)
  local curRefreshRound = self._hadRefreshRound[key]
  curRefreshRound = curRefreshRound or {}
  if not table.intable(curRefreshRound, round) then
    table.insert(curRefreshRound, round)
  end
  self._hadRefreshRound[key] = curRefreshRound
end

function MonsterRefreshData:GetHadRefreshRound(key)
  local curRefreshRound = self._hadRefreshRound[key]
  if not curRefreshRound then
    curRefreshRound = {}
    self._hadRefreshRound[key] = curRefreshRound
  end
  return curRefreshRound
end

function MonsterRefreshData:SetChangeGapTiles(gapTiles)
  self._newGapTiles = gapTiles
end

function MonsterRefreshData:GetGapTiles()
  return self._newGapTiles
end

function MonsterRefreshData:GetInternalRefreshID()
  return self._refreshID
end

function MonsterRefreshData:GetInternalRefreshType()
  return self._refreshType
end

function MonsterRefreshData:GetInternalRefreshParam()
  return self._refreshParam
end

function MonsterRefreshData:GetInternalMonsterIDDic()
  return self._monsterInternalIDList
end

function MonsterRefreshData:GetInternalTrapIDDic()
  return self._trapInternalIDList
end

function MonsterRefreshData:GetMonsterRefreshParam()
  return self._waveInternalRefreshParam
end

function MonsterRefreshData:GetMonsterRefreshCount()
  return self._refreshCount
end

function MonsterRefreshData:SetMonsterRefreshShowInterval(interval)
  self._showInterval = interval
end

function MonsterRefreshData:GetMonsterRefreshShowInterval()
  return self._showInterval
end
