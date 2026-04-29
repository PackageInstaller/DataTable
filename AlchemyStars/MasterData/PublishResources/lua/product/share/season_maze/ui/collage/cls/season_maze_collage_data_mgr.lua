local SeasonMazeCollageType = {
  Relic = 1,
  Card = 2,
  Bead = 3,
  Prop = 4
}
_enum("SeasonMazeCollageType", SeasonMazeCollageType)
_class("SeasonMazeCollageDataMgr", UICustomWidget)
SeasonMazeCollageDataMgr = SeasonMazeCollageDataMgr

function SeasonMazeCollageDataMgr:Constructor()
  self._mazeComponentId = nil
  self._mazMoneyLv = -1
  self._collageData = {}
end

function SeasonMazeCollageDataMgr:GetData(type)
  return self._collageData[type]
end

function SeasonMazeCollageDataMgr:Init(mazeComponentId)
  if self._mazeComponentId == mazeComponentId then
    return
  end
  self._mazeComponentId = mazeComponentId
  table.clear(self._collageData)
  self:_InitRelic()
  self:_InitCard()
  self:_InitBead()
  self:_InitProp()
end

function SeasonMazeCollageDataMgr:_InitRelic()
  local list = {}
  self._collageData[SeasonMazeCollageType.Relic] = list
  local cfgs = Cfg.cfg_component_season_maze_relic_group({
    ComponentID = self._mazeComponentId
  })
  for k, subCfg in pairs(cfgs) do
    local cfg = Cfg.cfg_item_relic[subCfg.RelicID]
    local d = SeasonMazeCollageData:New()
    d:SetData(subCfg.RelicID, SeasonMazeCollageType.Relic, cfg, subCfg.BookSaveLv or 0)
    table.insert(list, d)
  end
end

function SeasonMazeCollageDataMgr:_InitCard()
  local list = {}
  self._collageData[SeasonMazeCollageType.Card] = list
  local cfgs = Cfg.cfg_component_season_maze_hand({
    ComponentID = self._mazeComponentId
  })
  for k, subCfg in pairs(cfgs) do
    local d = SeasonMazeCollageData:New()
    d:SetData(subCfg.ID, SeasonMazeCollageType.Card, subCfg, subCfg.BookSaveLv or 0)
    table.insert(list, d)
  end
end

function SeasonMazeCollageDataMgr:_InitBead()
  local list = {}
  self._collageData[SeasonMazeCollageType.Bead] = list
  local cfgs = Cfg.cfg_component_season_maze_autobead({
    ComponentID = self._mazeComponentId
  })
  for k, subCfg in pairs(cfgs) do
    if subCfg.Quality == 1 then
      local d = SeasonMazeCollageData:New()
      d:SetData(subCfg.ID, SeasonMazeCollageType.Bead, subCfg, subCfg.BookSaveLv or 0)
      table.insert(list, d)
    end
  end
end

function SeasonMazeCollageDataMgr:_InitProp()
  local list = {}
  self._collageData[SeasonMazeCollageType.Prop] = list
  local cfgs = Cfg.cfg_component_season_maze_once({
    ComponentID = self._mazeComponentId
  })
  for k, subCfg in pairs(cfgs) do
    local d = SeasonMazeCollageData:New()
    d:SetData(subCfg.ID, SeasonMazeCollageType.Prop, subCfg, subCfg.BookSaveLv or 0)
    table.insert(list, d)
  end
end

function SeasonMazeCollageDataMgr:Refresh(moneyLv)
  for type, listData in pairs(self._collageData) do
    local preCondition = self:_CheckPreUnlockCondition(type)
    for _, subData in pairs(listData) do
      subData:CheckState(moneyLv, preCondition)
    end
    table.sort(listData, function(a, b)
      local lockA = a:GetUnlock() and 1 or 0
      local lockB = b:GetUnlock() and 1 or 0
      if lockA ~= lockB then
        return lockA > lockB
      end
      local orderA = a:GetShowOrder() or 0
      local orderB = b:GetShowOrder() or 0
      if orderA ~= orderB then
        return orderA > orderB
      end
      local idA = a:GetCfgId()
      local idB = b:GetCfgId()
      return idA > idB
    end)
  end
end

function SeasonMazeCollageDataMgr:HasNewCollage()
  for k, listData in pairs(self._collageData) do
    for _, subData in pairs(listData) do
      if subData:GetNew() then
        return true
      end
    end
  end
  return false
end

function SeasonMazeCollageDataMgr:HasNewCollageByType(type)
  local listData = self._collageData[type]
  for _, subData in pairs(listData) do
    if subData:GetNew() then
      return true
    end
  end
  return false
end

function SeasonMazeCollageDataMgr:_CheckPreUnlockCondition(type)
  local ret = {OK = true, UnlockLevel = 0}
  if type == SeasonMazeCollageType.Bead then
    local openHardNum = 0
    local comp = GameGlobal.GetModule(SeasonMazeModule):GetSeasonMazeComponent()
    if comp then
      local compInfo = comp:GetComponentInfo()
      openHardNum = table.count(compInfo.hard_num)
    end
    local componentId = GameGlobal.GetModule(SeasonMazeModule):GetSeasonMazeComponentId()
    local cfgs = Cfg.cfg_component_season_maze({ComponentID = componentId})
    local unlockCfg
    if cfgs then
      for k, subCfg in pairs(cfgs) do
        if 0 < subCfg.BeadSlotCnt then
          if unlockCfg then
            if subCfg.Hard < unlockCfg.Hard then
              unlockCfg = subCfg
            end
          else
            unlockCfg = subCfg
          end
        end
      end
    end
    if unlockCfg then
      ret.UnlockLevel = unlockCfg.Hard
      local curTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
      local openTime = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(unlockCfg.LockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      if curTime < openTime then
        ret.OK = false
      elseif openHardNum < unlockCfg.Hard then
        ret.OK = false
      end
    end
    return ret
  else
    return ret
  end
end
