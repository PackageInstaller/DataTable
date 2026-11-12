local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local LocalData = require("GameCore.Data.LocalData")
local MathParkourActData = class("MathParkourActData", ActivityDataBase)
local RapidJson = require("rapidjson")
local RedDotManager = require("GameCore.RedDot.RedDotManager")

function MathParkourActData:Init()
  self:AddListeners()
end

function MathParkourActData:AddListeners()
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  EventManager.Add("ClearAllMathParkourLevels", self, self.OnEvent_GMClearAllLevels)
end

function MathParkourActData:OnEvent_NewDay()
end

function MathParkourActData:OnEvent_GMClearAllLevels(mapMsgData)
  if mapMsgData == nil then
    return
  end
  if mapMsgData.ActivityId ~= nil and mapMsgData.ActivityId ~= 0 and mapMsgData.ActivityId ~= self.nActId then
    return
  end
  local tbLevels = mapMsgData.Levels or mapMsgData.levels
  if tbLevels ~= nil then
    self:CacheAllLevelData(tbLevels)
    self:RefreshNewLevelRedDot()
  end
  EventManager.Hit("MathParkourLevelUpdate")
end

function MathParkourActData:CacheAllLevelData(LevelDataList)
  self.tbLevelData = {}
  self.cacheEnterLevelList = {}
  local sJson = LocalData.GetPlayerLocalData("MathParkourLevel")
  local tb = decodeJson(sJson)
  if type(tb) == "table" then
    self.cacheEnterLevelList = tb
  end
  
  local function GetLevelData(lineData)
    if lineData.ActivityId == self.nActId then
      local levelData = {
        nId = lineData.Id,
        nScore = 0,
        nStar = 0
      }
      self.tbLevelData[levelData.nId] = levelData
    end
  end
  
  ForEachTableLine(DataTable.MathParkourLevel, GetLevelData)
  for _, v in pairs(LevelDataList) do
    if self.tbLevelData[v.LevelId] == nil then
      local levelData = {
        nId = v.LevelId,
        nScore = 0,
        nStar = 0
      }
      self.tbLevelData[levelData.nId] = levelData
    end
    self.tbLevelData[v.LevelId].nScore = v.Score
    self.tbLevelData[v.LevelId].nStar = v.Star
  end
end

function MathParkourActData:GetLevelData(nLevelId)
  return self.tbLevelData[nLevelId]
end

function MathParkourActData:GetAllLevelData()
  local tbLevelList = {}
  for _, v in pairs(self.tbLevelData) do
    table.insert(tbLevelList, v)
  end
  table.sort(tbLevelList, function(a, b)
    return a.nId < b.nId
  end)
  return tbLevelList
end

function MathParkourActData:GetLevelUnlock(nLevelId)
  local tbLevelList = self:GetAllLevelData()
  local nLevelIndex = 1
  local levelData = self.tbLevelData[nLevelId]
  if levelData == nil then
    return false
  end
  nLevelIndex = table.indexof(tbLevelList, levelData)
  if nLevelIndex == 1 then
    return true
  else
    return tbLevelList[nLevelIndex - 1].nStar > 0
  end
end

function MathParkourActData:GetNextLevelId(nLevelId)
  local tbLevelList = self:GetAllLevelData()
  local nLevelIndex = 1
  for i, v in ipairs(tbLevelList) do
    if v.nId == nLevelId then
      nLevelIndex = i
      break
    end
  end
  if nLevelIndex == #tbLevelList then
    return nil
  else
    return tbLevelList[nLevelIndex + 1].nId
  end
end

function MathParkourActData:RefreshMathParkourActData(actId, msgData)
  self:Init()
  self.nActId = actId
  self:CacheAllLevelData(msgData.Levels)
  self:RefreshNewLevelRedDot()
end

function MathParkourActData:RefreshNewLevelRedDot()
  local tbLevelList = self:GetAllLevelData()
  for _, v in ipairs(tbLevelList) do
    if table.indexof(self.cacheEnterLevelList, v.nId) == 0 and self:GetLevelUnlock(v.nId) then
      RedDotManager.SetValid(RedDotDefine.Activity_MathParkour_New_Level, {
        self.nActId,
        v.nId
      }, true)
    else
      RedDotManager.SetValid(RedDotDefine.Activity_MathParkour_New_Level, {
        self.nActId,
        v.nId
      }, false)
    end
  end
end

function MathParkourActData:OpenTempChangeInfo()
  if self.tempChangeInfo ~= nil then
    UTILS.OpenReceiveByChangeInfo(self.tempChangeInfo)
  end
  self.tempChangeInfo = nil
end

function MathParkourActData:GetCacheLevelId()
  return self.cacheLevelId
end

function MathParkourActData:ClearCacheLevelId()
  self.cacheLevelId = nil
end

function MathParkourActData:EnterLevel(nLevelId)
  if table.indexof(self.cacheEnterLevelList, nLevelId) == 0 then
    table.insert(self.cacheEnterLevelList, nLevelId)
  end
  LocalData.SetPlayerLocalData("MathParkourLevel", RapidJson.encode(self.cacheEnterLevelList))
  self:RefreshNewLevelRedDot()
end

function MathParkourActData:GetLevelIsNew(nLevelId)
  if table.indexof(self.cacheEnterLevelList, nLevelId) == 0 then
    return true
  end
  return false
end

function MathParkourActData:DoResult(nLevelId, bResult, nScore, nStar, nPropCount)
  self.cacheLevelId = nLevelId
  local msgData = {
    ActivityId = self.nActId,
    LevelId = nLevelId,
    TotalScore = bResult == true and nScore or 0,
    State = bResult,
    PropCount = nPropCount
  }
  
  local function callback(_, callbackData)
    if bResult then
      local levelData = self:GetLevelData(nLevelId)
      levelData.nScore = math.max(levelData.nScore, nScore)
      levelData.nStar = math.max(levelData.nStar, nStar)
      self.tempChangeInfo = callbackData.Change
      EventManager.Hit("MathParkourLevelUpdate")
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_math_parkour_level_settle_req, msgData, nil, callback)
end

return MathParkourActData
