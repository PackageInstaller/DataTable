local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local ThrowGiftData = class("ThrowGiftData", ActivityDataBase)
local LocalData = require("GameCore.Data.LocalData")

function ThrowGiftData:Init()
  self.nActId = 0
  self.mapLevels = {}
  self.mapItems = {}
  self.tbNewLevel = {}
end

function ThrowGiftData:RefreshQuestData(questData)
end

function ThrowGiftData:RefreshThrowGiftData(nActId, msgData)
  self:Init()
  self.nActId = nActId
  for _, mapLevel in ipairs(msgData.Levels) do
    self.mapLevels[mapLevel.LevelId] = mapLevel
  end
  for _, mapItem in ipairs(msgData.Items) do
    self.mapItems[mapItem.ItemId] = mapItem.Count
  end
  self:UpdateNewState()
end

function ThrowGiftData:GetActivityData()
  return {
    nActId = self.nActId,
    mapLevels = clone(self.mapLevels),
    mapItems = clone(self.mapItems)
  }
end

function ThrowGiftData:SettleLevels(nLevelId, nThrowGiftCount, nHitGiftCount, nScore, tbUseItems, bWin, callback)
  local msg = {}
  msg.ActivityId = self.nActId
  msg.LevelId = nLevelId
  msg.ThrowGiftCount = nThrowGiftCount
  msg.HitGiftCount = nHitGiftCount
  msg.Score = nScore
  msg.UseItems = tbUseItems
  msg.Win = bWin
  
  local function msgCallback(_, msgData)
    if self.mapLevels[nLevelId] == nil then
      self.mapLevels[nLevelId] = {
        LevelId = nLevelId,
        MaxScore = nScore,
        FirstComplete = bWin
      }
    else
      if self.mapLevels[nLevelId].MaxScore < nScore then
        self.mapLevels[nLevelId].MaxScore = nScore
      end
      self.mapLevels[nLevelId].FirstComplete = bWin or self.mapLevels[nLevelId].FirstComplete
    end
    for k, v in pairs(tbUseItems) do
      if self.mapItems[v.ItemId] == nil then
        self.mapItems[v.ItemId] = 0
      end
      self.mapItems[v.ItemId] = self.mapItems[v.ItemId] + v.Count
    end
    if callback ~= nil then
      callback(msgData)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_throw_gift_settle_req, msg, nil, msgCallback)
end

function ThrowGiftData:GetDicFirstIn(nDicId)
  local sKey = tostring(self.nActId) .. tostring(nDicId) .. "IsFirst"
  local bIsFirst = LocalData.GetPlayerLocalData(sKey)
  if bIsFirst == nil then
    bIsFirst = true
  end
  if bIsFirst then
    LocalData.SetPlayerLocalData(sKey, false)
  end
  return bIsFirst
end

function ThrowGiftData:GetLevelNewStateInternal(nLevelId)
  local mapLevelCfgData = ConfigTable.GetData("ThrowGiftLevel", nLevelId)
  if mapLevelCfgData == nil then
    return false
  end
  local nOpenTime = self:GetActOpenTime()
  if nOpenTime ~= 0 then
    local nServerTimeStamp = CS.ClientManager.Instance.serverTimeStamp
    local nUnlockTime = mapLevelCfgData.DayOpen * 86400 + nOpenTime
    if nUnlockTime - nServerTimeStamp <= 0 then
      local sKey = tostring(self.nActId) .. tostring(nLevelId) .. "LevelNew"
      local bIsFirst = LocalData.GetPlayerLocalData(sKey)
      if bIsFirst == nil then
        bIsFirst = true
      end
      if bIsFirst then
        return true
      end
    end
  end
  return false
end

function ThrowGiftData:SetLevelNew(nLevelId)
  local idx = table.indexof(self.tbNewLevel, nLevelId)
  if 0 < idx then
    table.remove(self.tbNewLevel, idx)
  end
  local sKey = tostring(self.nActId) .. tostring(nLevelId) .. "LevelNew"
  LocalData.SetPlayerLocalData(sKey, false)
  RedDotManager.SetValid(RedDotDefine.Activity_ThrowGift_NewLevel, {
    self.nActId,
    nLevelId
  }, false)
end

function ThrowGiftData:UpdateNewState()
  self.tbNewLevel = {}
  
  local function foreachLevel(mapData)
    if mapData.ActivityId == self.nActId then
      local bNewState = self:GetLevelNewStateInternal(mapData.Id)
      if bNewState then
        table.insert(self.tbNewLevel, mapData.Id)
      end
      RedDotManager.SetValid(RedDotDefine.Activity_ThrowGift_NewLevel, {
        self.nActId,
        mapData.Id
      }, bNewState)
    end
  end
  
  ForEachTableLine(DataTable.ThrowGiftLevel, foreachLevel)
  local bNew = LocalData.GetPlayerLocalData("Activity_ThrowGift_New")
  RedDotManager.SetValid(RedDotDefine.Activity_ThrowGift_New, {
    self.nActId
  }, bNew ~= true)
end

function ThrowGiftData:GetLevelNewState(nLevelId)
  return table.indexof(self.tbNewLevel, nLevelId) > 0
end

function ThrowGiftData:GetNewLevels()
  return clone(self.tbNewLevel)
end

return ThrowGiftData
