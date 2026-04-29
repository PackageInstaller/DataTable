_class("LLConfigMng", Singleton)
LLConfigMng = LLConfigMng

function LLConfigMng:Constructor()
  self._levelCfgData = LLLevelConfigData:New(self)
  self._petCfgDataDic = {}
  self._monsterCfgDataDic = {}
  self._buildingCfgDataDic = {}
  self._affixCfgDataDic = {}
  self._buffCfgDataDic = {}
end

function LLConfigMng:Dispose()
  self._levelCfgData = nil
end

function LLConfigMng:Init(missionID)
  self._levelCfgData:ParseLevelConfig(missionID)
end

function LLConfigMng:GetLevelConfigData()
  return self._levelCfgData
end

function LLConfigMng:GetPetConfigData(ID)
  if self._petCfgDataDic[ID] ~= nil then
    return self._petCfgDataDic[ID]
  end
  local cfgData = LLPetConfigData:New(ID)
  self._petCfgDataDic[ID] = cfgData
  return cfgData
end

function LLConfigMng:GetMonsterConfigData(ID)
  if self._monsterCfgDataDic[ID] ~= nil then
    return self._monsterCfgDataDic[ID]
  end
  local cfgData = LLMonsterConfigData:New(ID)
  self._monsterCfgDataDic[ID] = cfgData
  return cfgData
end

function LLConfigMng:GetBuildingConfigData(ID)
  if self._buildingCfgDataDic[ID] ~= nil then
    return self._buildingCfgDataDic[ID]
  end
  local cfgData = LLBuildingConfigData:New(ID)
  self._buildingCfgDataDic[ID] = cfgData
  return cfgData
end

function LLConfigMng:GetAffixConfigData(ID)
  if self._affixCfgDataDic[ID] ~= nil then
    return self._affixCfgDataDic[ID]
  end
  local cfgData = LLAffixConfigData:New(ID)
  self._affixCfgDataDic[ID] = cfgData
  return cfgData
end

function LLConfigMng:GetBuffConfigData(buffID)
  if self._buffCfgDataDic[buffID] ~= nil then
    return self._buffCfgDataDic[buffID]
  end
  local buffConfigData = LLBuffConfigData:New(buffID)
  self._buffCfgDataDic[buffID] = buffConfigData
  return buffConfigData
end

function LLConfigMng:GetReDrawCost(reDrawCount, roundCount)
  local cfg = Cfg.cfg_luckland_client_redraw_cost({RoundCount = roundCount})
  cfg = cfg or Cfg.cfg_luckland_client_redraw_cost({
    RoundCount = LuckLandConst.CFGMaxCount
  })
  local cosCfg = cfg[1]
  local maxCount = #cosCfg.Cost
  local cost = cosCfg.Cost[maxCount]
  if reDrawCount < maxCount then
    cost = cosCfg.Cost[reDrawCount]
  end
  local rate = self._levelCfgData:GetReDrawCostRate()
  cost = cost * rate
  if cost < 1 then
    return 1
  end
  return math.ceil(cost)
end

function LLConfigMng:GetDeleteCardCost(delCount)
  local cfg = Cfg.cfg_luckland_client_delete_cost({Count = delCount})
  cfg = cfg or Cfg.cfg_luckland_client_delete_cost({
    Count = LuckLandConst.CFGMaxCount
  })
  local cost = cfg[1].Cost
  if cost < 1 then
    return 1
  end
  return math.ceil(cost)
end
