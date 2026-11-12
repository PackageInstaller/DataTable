local PopUpData = class("PopUpData")
local LocalData = require("GameCore.Data.LocalData")

function PopUpData:Init()
  self.tbPopUpConfig = {}
  self.tbPopUpData = {}
  self.tbCachedPopUpData = {}
  self:ParseConfig()
end

function PopUpData:ParseConfig()
  local function foreachPopup(mapData)
    self:CachedPopUpConfig(mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("PopUp"), foreachPopup)
end

function PopUpData:CachedPopUpConfig(mapData)
  if mapData.PopUpType == GameEnum.PopUpType.Activity or mapData.PopUpType == GameEnum.PopUpType.ActivityGroup then
    self.tbPopUpConfig[mapData.ActivityId] = mapData.Id
  elseif mapData.PopUpType == GameEnum.PopUpType.OwnPopUP then
    self.tbPopUpConfig[mapData.Id] = mapData.Id
  end
end

function PopUpData:RefreshPopUp()
  for k, v in pairs(self.tbPopUpConfig) do
    local cfg = ConfigTable.GetData("PopUp", v)
    if cfg.PopUpType == GameEnum.PopUpType.OwnPopUP and self:CheckPopUpOpen(cfg) and self:IsNeedOwnPopUp(cfg.Id) and table.indexof(self.tbPopUpData, cfg.Id) <= 0 and 0 >= table.indexof(self.tbCachedPopUpData, v) then
      table.insert(self.tbPopUpData, cfg.Id)
      table.insert(self.tbCachedPopUpData, cfg.Id)
    end
  end
  if #self.tbPopUpData > 0 then
    table.sort(self.tbPopUpData, function(a, b)
      if self.tbPopUpConfig[a] ~= nil and self.tbPopUpConfig[b] ~= nil then
        local cfgA = ConfigTable.GetData("PopUp", self.tbPopUpConfig[a])
        local cfgB = ConfigTable.GetData("PopUp", self.tbPopUpConfig[b])
        return cfgA.SortId < cfgB.SortId
      end
      return false
    end)
    PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.ActivityFaceAnnounce, self.tbPopUpData)
    self.tbPopUpData = {}
  end
end

function PopUpData:CheckPopUpOpen(mapData)
  local localData = LocalData.GetPlayerLocalData("Act_PopUp_DontShow" .. mapData.Id)
  if localData then
    return false
  end
  local bUnlock = false
  if mapData.StartCondType == GameEnum.activityAcceptCond.WorldClassSpecific then
    local nWorldCalss = PlayerData.Base:GetWorldClass()
    if nWorldCalss >= mapData.StartCondParams[1] then
      bUnlock = true
    end
  else
    bUnlock = true
  end
  if bUnlock then
    local bOpen = false
    local nStartTime = 0
    local nEndTime = 0
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    if mapData.StartType == GameEnum.PopUpOpenType.Date then
      nStartTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapData.StartTime)
    else
      bOpen = true
    end
    if mapData.EndType == GameEnum.PopUpEndType.Date then
      nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapData.EndTime)
    elseif mapData.EndType == GameEnum.activityEndType.TimeLimit then
      nEndTime = nStartTime + mapData.EndDuration * 86400
    else
      bOpen = true
    end
    if 0 < nStartTime and 0 < nEndTime and curTime >= nStartTime and curTime <= nEndTime then
      bOpen = true
    end
    return bOpen
  end
  return false
end

function PopUpData:InsertPopUpQueue(tbPopUpList)
  for k, v in pairs(tbPopUpList) do
    if table.indexof(self.tbPopUpData, v) <= 0 and 0 >= table.indexof(self.tbCachedPopUpData, v) then
      table.insert(self.tbPopUpData, v)
      table.insert(self.tbCachedPopUpData, v)
    end
  end
  self:RefreshPopUp()
end

local function GetCurrentYearInfo(time_s)
  local day = os.date("%d", time_s)
  local weekIndex = os.date("%W", time_s)
  local month = os.date("%m", time_s)
  local yearNum = os.date("%Y", time_s)
  return {
    year = yearNum,
    month = month,
    weekIdx = weekIndex,
    day = day
  }
end

function PopUpData:IsNeedActPopUp(actId)
  if self.tbPopUpConfig[actId] ~= nil then
    local popupId = self.tbPopUpConfig[actId]
    local localData = LocalData.GetPlayerLocalData("Act_PopUp" .. actId)
    return self:IsNeedPopUp(popupId, localData)
  end
  return false
end

function PopUpData:IsNeedOwnPopUp(popUpId)
  if self.tbPopUpConfig[popUpId] ~= nil then
    local localData = LocalData.GetPlayerLocalData("Act_PopUp" .. popUpId)
    return self:IsNeedPopUp(popUpId, localData)
  end
  return false
end

function PopUpData:IsNeedPopUp(popupId, localData)
  local cfg = ConfigTable.GetData("PopUp", popupId)
  if cfg == nil then
    return false
  end
  if cfg.PopRefreshType == GameEnum.PopRefreshType.WholeFirst then
    if nil == localData then
      return cfg.PopUpRes ~= nil
    else
      return false
    end
  elseif cfg.PopRefreshType == GameEnum.PopRefreshType.DailyFirst then
    if nil == localData then
      return cfg.PopUpRes ~= nil
    else
      local curTime = CS.ClientManager.Instance.serverTimeStamp
      local dateA = GetCurrentYearInfo(tonumber(localData))
      local dateB = GetCurrentYearInfo(curTime)
      local isSameDay = dateA.day == dateB.day and dateA.month == dateB.month and dateA.year == dateB.year
      return not isSameDay and cfg.PopUpRes ~= nil
    end
  elseif cfg.PopRefreshType == GameEnum.PopRefreshType.WeeklyFirst then
    if nil == localData then
      return cfg.PopUpRes ~= nil
    else
      local nextTime = tonumber(localData)
      local curTime = CS.ClientManager.Instance.serverTimeStamp
      return nextTime <= curTime
    end
  end
  return cfg.PopUpRes ~= nil
end

function PopUpData:GetPopUpConfigData(actId)
  if self.tbPopUpConfig[actId] ~= nil then
    local cfg = ConfigTable.GetData("PopUp", self.tbPopUpConfig[actId])
    return cfg
  end
  return nil
end

function PopUpData:ReleaseCachedPopUpData(popupId)
  for i, v in ipairs(self.tbCachedPopUpData) do
    if v == popupId then
      table.remove(self.tbCachedPopUpData, i)
      break
    end
  end
end

return PopUpData
