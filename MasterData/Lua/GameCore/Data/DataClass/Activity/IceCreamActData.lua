local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local IceCreamActData = class("IceCreamActData", ActivityDataBase)
local LocalData = require("GameCore.Data.LocalData")
local IceCreamLevelData = require("Game.UI.Play_IceCreamTruck.Play.IceCreamLevelData")
local ClientManager = CS.ClientManager.Instance
local RapidJson = require("rapidjson")

function IceCreamActData:Init()
  self.mapLevelData = {}
  self.tbLevelList = {}
  self.tbLevelByType = {}
  self.tbSkipNewLevel = {}
  self.tbNewLevel = {}
  self:ParseConfig()
  self:AddListeners()
end

function IceCreamActData:AddListeners()
  EventManager.Add("ClearAllIceLevels", self, self.OnEvent_GMClearAllIceLevels)
end

function IceCreamActData:ParseConfig()
  local function foreach_level(data)
    if data.ActivityId ~= self.nActId then
      return
    end
    table.insert(self.tbLevelList, {
      nId = data.Id,
      nLevelType = data.LevelType
    })
    local bucket = self.tbLevelByType[data.LevelType]
    if bucket == nil then
      bucket = {}
      self.tbLevelByType[data.LevelType] = bucket
    end
    table.insert(bucket, data.Id)
  end
  
  ForEachTableLine(DataTable.ActivityIceCreamLevel, foreach_level)
  table.sort(self.tbLevelList, function(a, b)
    if a.nLevelType ~= b.nLevelType then
      return a.nLevelType < b.nLevelType
    end
    return a.nId < b.nId
  end)
  for _, bucket in pairs(self.tbLevelByType) do
    table.sort(bucket, function(a, b)
      return a < b
    end)
  end
  local sJson = LocalData.GetPlayerLocalData("IceCreamLevel")
  local tb = decodeJson(sJson)
  if type(tb) == "table" then
    self.tbSkipNewLevel = tb
  end
end

function IceCreamActData:RefreshIceCreamActData(nActId, msgData)
  self.nActId = nActId
  self:CacheLevelData(msgData)
end

function IceCreamActData:CacheLevelData(msgData)
  local LeveList = self:GetLevelList()
  for _, v in ipairs(LeveList) do
    self.mapLevelData[v.nId] = {nScore = 0, bFirstComplete = false}
  end
  if msgData ~= nil then
    tbLevel = msgData.Levels
    for _, v in ipairs(tbLevel) do
      self.mapLevelData[v.LevelId] = {
        nScore = v.Score,
        bFirstComplete = v.FirstComplete
      }
    end
  end
  self:RefreshLevelRedDot()
end

function IceCreamActData:CacheLevelData_GM(msgData)
  local LeveList = self:GetLevelList()
  for _, v in ipairs(LeveList) do
    self.mapLevelData[v.nId] = {nScore = 0, bFirstComplete = false}
  end
  if msgData ~= nil then
    tbLevel = msgData.levels
    for _, v in ipairs(tbLevel) do
      self.mapLevelData[v.LevelId] = {
        nScore = v.Score,
        bFirstComplete = v.FirstComplete
      }
    end
  end
  self:RefreshLevelRedDot()
end

function IceCreamActData:GetLevelList()
  return self.tbLevelList
end

function IceCreamActData:GetLevelTypeTable()
  return self.tbLevelByType
end

function IceCreamActData:GetLevelsByType(index)
  if self.tbLevelByType then
    return self.tbLevelByType[index]
  end
  return nil
end

function IceCreamActData:GetNextIslandIsLock(index)
  if self.tbLevelByType then
    local nLevelIds = self.tbLevelByType[index + 1]
    if nLevelIds and nLevelIds[1] then
      return self:CheckLevelIsLockByTime(nLevelIds[1])
    end
  end
  return true
end

function IceCreamActData:CheckLevelLock(nLevelId)
  local bLock = self:CheckLevelIsLockByTime(nLevelId)
  if bLock then
    return bLock
  end
  bLock = self:CheckLevelLockByPrev(nLevelId)
  return bLock
end

function IceCreamActData:CheckLevelIsLockByTime(nLevelId)
  local nRemain = self:GetLevelStartTime(nLevelId) - ClientManager.serverTimeStamp
  local bLock = 0 < nRemain
  return bLock, nRemain
end

function IceCreamActData:CheckLevelLockByPrev(nLevelId)
  local mapCfg = ConfigTable.GetData("ActivityIceCreamLevel", nLevelId)
  if not mapCfg then
    return true
  end
  local nPrev = mapCfg.PreLevelId
  if nPrev == 0 then
    return false
  end
  return not self.mapLevelData[nPrev].bFirstComplete
end

function IceCreamActData:GetLevelData(nId)
  return self.mapLevelData[nId] or {nScore = 0, bFirstComplete = false}
end

function IceCreamActData:GetLevelMapData(nLevelId)
  local mapCfg = ConfigTable.GetData("ActivityIceCreamLevel", nLevelId)
  if not mapCfg then
    return nil
  end
  return mapCfg
end

function IceCreamActData:GetLevelStartTime(nLevelId)
  local mapCfg = ConfigTable.GetData("ActivityIceCreamLevel", nLevelId)
  if not mapCfg then
    return 0
  end
  local openActDayNextTime = ClientManager:GetNextRefreshTime(self.nOpenTime)
  local openTime = openActDayNextTime - 86400
  return openTime + mapCfg.Duration * 86400
end

function IceCreamActData:EnterLevel(nLevelId)
  self.IceCreamLevelData = IceCreamLevelData.new()
  self.IceCreamLevelData:InitData(nLevelId, self.nActId)
end

function IceCreamActData:SetLevelMaxScore(nLevelId, nScore)
  if self.mapLevelData[nLevelId] then
    local nCurrentScore = self.mapLevelData[nLevelId].nScore
    if nScore > nCurrentScore then
      self.mapLevelData[nLevelId].nScore = nScore
    end
  end
end

function IceCreamActData:GetLevelMaxScore(nLevelId)
  if self.mapLevelData[nLevelId].nScore then
    return self.mapLevelData[nLevelId].nScore
  end
  return 0
end

function IceCreamActData:RefreshLevelRedDot()
  self.tbNewLevel = {}
  
  local function foreachLevel(mapData)
    if mapData.ActivityId == self.nActId then
      local bNewState = self:GetLevelNewStateInternal(mapData.Id)
      if bNewState then
        table.insert(self.tbNewLevel, mapData.Id)
      end
      RedDotManager.SetValid(RedDotDefine.Activity_IceCreamTruck_NewLevel, {
        self.nActId,
        mapData.LevelType,
        mapData.Id
      }, bNewState)
    end
  end
  
  ForEachTableLine(DataTable.ActivityIceCreamLevel, foreachLevel)
end

function IceCreamActData:GetLevelNewStateInternal(nLevelId)
  local mapLevelCfgData = ConfigTable.GetData("ActivityIceCreamLevel", nLevelId)
  if mapLevelCfgData == nil then
    return false
  end
  if not self:CheckLevelLock(nLevelId) then
    local sKey = tostring(self.nActId) .. tostring(nLevelId) .. "LevelNew"
    local bIsFirst = LocalData.GetPlayerLocalData(sKey)
    if bIsFirst == nil then
      bIsFirst = true
    else
      bIsFirst = false
    end
    return bIsFirst
  end
  return false
end

function IceCreamActData:SetLevelNew(nLevelType, nLevelId)
  local idx = table.indexof(self.tbNewLevel, nLevelId)
  if 0 < idx then
    table.remove(self.tbNewLevel, idx)
  else
    return
  end
  local sKey = tostring(self.nActId) .. tostring(nLevelId) .. "LevelNew"
  LocalData.SetPlayerLocalData(sKey, false)
  RedDotManager.SetValid(RedDotDefine.Activity_IceCreamTruck_NewLevel, {
    self.nActId,
    nLevelType,
    nLevelId
  }, false)
end

function IceCreamActData:SendActivityIceCreamLevelSettleReq(msgData, bResult, callback)
  if self:IsActivityClosed() then
    self:ShowActivityClosedAlert()
    return
  end
  
  local function ResultCallback(_, mapMainData)
    if callback ~= nil then
      callback(mapMainData)
      if bResult then
        self:UpdateLevelData({
          Id = msgData.LevelId,
          FirstComplete = mapMainData.Passed
        })
      end
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_ice_cream_level_settle_req, msgData, nil, ResultCallback)
end

function IceCreamActData:UpdateLevelData(levelData)
  if self.mapLevelData[levelData.Id] and not self.mapLevelData[levelData.Id].bFirstComplete then
    self.mapLevelData[levelData.Id].bFirstComplete = levelData.FirstComplete
  end
  local nLevelType = self:GetLevelMapData(levelData.Id).LevelType
  self:SetLevelNew(nLevelType, levelData.Id)
  self:RefreshLevelRedDot()
end

function IceCreamActData:IsActivityClosed()
  if self == nil or self.CheckActivityOpen == nil then
    return false
  end
  return not self:CheckActivityOpen()
end

function IceCreamActData:ShowActivityClosedAlert()
  local msg = {
    nType = AllEnum.MessageBox.Alert,
    sContent = ConfigTable.GetUIText("Activity_End_Notice"),
    callbackConfirm = function()
      self:ForceExitOnFinishFail()
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function IceCreamActData:ForceExitOnFinishFail()
  EventManager.Hit(EventId.ClosePanel, PanelId.IceCreamTruckGamePanel)
  EventManager.Hit(EventId.ClosePanel, PanelId.IceCreamLevelsSelectPanel)
end

function IceCreamActData:OnEvent_GMClearAllIceLevels(mapMsgData)
  if mapMsgData ~= nil then
    self:CacheLevelData_GM(mapMsgData)
  end
end

return IceCreamActData
