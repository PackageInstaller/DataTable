local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local LocalData = require("GameCore.Data.LocalData")
local GoldenSpyData = class("GoldenSpyData", ActivityDataBase)
local GoldenSpyLevelData = require("Game.UI.Activity.GoldenSpy.GoldenSpyLevelData")
local ClientManager = CS.ClientManager.Instance
local RapidJson = require("rapidjson")
local RedDotManager = require("GameCore.RedDot.RedDotManager")

function GoldenSpyData:Init()
  self.GoldenSpyLevelData = GoldenSpyLevelData.new()
  self.cacheEnterGroupList = {}
  self.tbLevelGroupData = {}
  self.tbLevelData = {}
  self.cacheEnterFloorList = {}
  self:AddListeners()
  self.nGroupId = 0
  self.nLevelId = 0
end

function GoldenSpyData:AddListeners()
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function GoldenSpyData:OnEvent_NewDay()
end

function GoldenSpyData:RefreshGoldenSpyActData(actId, msgData)
  self:Init()
  self.nActId = actId
  self.tbLevelGroupData = {}
  self.tbLevelData = {}
  local sJson = LocalData.GetPlayerLocalData("GoldenSpyGroupData")
  local tb = decodeJson(sJson)
  if type(tb) == "table" then
    self.cacheEnterGroupList = tb
  end
  local sfloorJson = LocalData.GetPlayerLocalData("GoldenSpyFloorData")
  local tbFloor = decodeJson(sfloorJson)
  if type(tbFloor) == "table" then
    self.cacheEnterFloorList = tbFloor
  end
  self:CacheAllLevelData(msgData.Levels)
end

function GoldenSpyData:CacheAllLevelData(msgData)
  local controllCfg = ConfigTable.GetData("GoldenSpyControl", self.nActId)
  if controllCfg == nil then
    return
  end
  for _, v in ipairs(controllCfg.LevelGroupList) do
    local levelGroupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", v)
    if levelGroupCfg ~= nil then
      local levelGroupData = {
        nId = levelGroupCfg.Id,
        nStartTime = self:GetGroupStartTime(levelGroupCfg.Id)
      }
      self.tbLevelGroupData[levelGroupCfg.Id] = levelGroupData
      for _, v in ipairs(levelGroupCfg.LevelList) do
        local levelCfg = ConfigTable.GetData("GoldenSpyLevel", v)
        if levelCfg ~= nil then
          local levelData = {
            nId = levelCfg.Id,
            nMaxScore = 0,
            bFirstComplete = false
          }
          self:UpdateLevelData(levelData)
        end
      end
    end
  end
  if msgData ~= nil then
    for _, v in ipairs(msgData) do
      local levelData = {
        nId = v.LevelId,
        nMaxScore = v.MaxScore or 0,
        bFirstComplete = v.FirstComplete
      }
      self:UpdateLevelData(levelData)
    end
  end
  self:RefreshRedDot()
end

function GoldenSpyData:UpdateLevelData(levelData)
  self.tbLevelData[levelData.nId] = levelData
end

function GoldenSpyData:GetLevelDataById(levelId)
  return self.tbLevelData[levelId]
end

function GoldenSpyData:CheckPreLevelPassById(levelId)
  local levelCfg = ConfigTable.GetData("GoldenSpyLevel", levelId)
  if levelCfg == nil then
    return false
  end
  local preLevelId = levelCfg.PreLevelId
  if preLevelId == 0 then
    return true
  end
  local preLevelData = self:GetLevelDataById(preLevelId)
  if preLevelData == nil then
    return true
  end
  return preLevelData.bFirstComplete
end

function GoldenSpyData:GetGroupIsNew(groupId)
  if table.indexof(self.cacheEnterGroupList, groupId) == 0 then
    return true
  end
  return false
end

function GoldenSpyData:EnterGroupSelect(groupId)
  local actGroupId = ConfigTable.GetData("Activity", self.nActId).MidGroupId
  if table.indexof(self.cacheEnterGroupList, groupId) == 0 then
    table.insert(self.cacheEnterGroupList, groupId)
    LocalData.SetPlayerLocalData("GoldenSpyGroupData", RapidJson.encode(self.cacheEnterGroupList))
    RedDotManager.SetValid(RedDotDefine.Activity_GoldenSpy_Group, {actGroupId, groupId}, false)
    self:RefreshRedDot()
  end
end

function GoldenSpyData:GetLevelGroupDataById(groupId)
  return self.tbLevelGroupData[groupId]
end

function GoldenSpyData:GetAllLevelGroupData()
  return self.tbLevelGroupData
end

function GoldenSpyData:CheckPreGroupPassByGroupId(groupId)
  local tbGroupList = ConfigTable.GetData("GoldenSpyControl", self.nActId).LevelGroupList
  local nIndex = table.indexof(tbGroupList, groupId)
  if nIndex == 1 then
    return true
  end
  local preGroupId = tbGroupList[nIndex - 1]
  local preGroupData = self:GetLevelGroupDataById(preGroupId)
  if preGroupData == nil then
    return false
  end
  local groupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", preGroupId)
  if groupCfg == nil then
    return false
  end
  local bAllLevelPass = true
  for _, levelId in ipairs(groupCfg.LevelList) do
    local levelData = self:GetLevelDataById(levelId)
    local levelCfg = ConfigTable.GetData("GoldenSpyLevel", levelId)
    if levelData == nil then
      bAllLevelPass = false
      break
    end
    if not levelData.bFirstComplete then
      bAllLevelPass = false
      break
    end
  end
  return bAllLevelPass
end

function GoldenSpyData:GetGroupStartTime(groupId)
  local groupConfig = ConfigTable.GetData("GoldenSpyLevelGroup", groupId)
  if groupConfig == nil then
    return 0
  end
  local openActDayNextTime = ClientManager:GetNextRefreshTime(self.nOpenTime)
  local nTempDay = 0
  if openActDayNextTime > self.nOpenTime then
    nTempDay = 1
  end
  local nDay = (ClientManager.serverTimeStamp - openActDayNextTime) // 86400 + nTempDay
  if nDay >= groupConfig.DayOpen then
    return 0
  end
  local openDayNextTime = ClientManager:GetNextRefreshTime(ClientManager.serverTimeStamp)
  return openDayNextTime + (groupConfig.DayOpen - nDay - 1) * 86400
end

function GoldenSpyData:GetGoldenSpyLevelData()
  return self.GoldenSpyLevelData
end

function GoldenSpyData:GetGoldenSpyFloorData()
  return self.GoldenSpyLevelData:GetFloorData()
end

function GoldenSpyData:RefreshRedDot()
  if not self:GetPlayState() then
    return
  end
  local actGroupId = ConfigTable.GetData("Activity", self.nActId).MidGroupId
  for _, groupData in pairs(self.tbLevelGroupData) do
    local isOpen = self:CheckActivityOpen()
    if not isOpen then
      RedDotManager.SetValid(RedDotDefine.Activity_GoldenSpy_Group, {
        actGroupId,
        groupData.nId
      }, false)
    elseif CS.ClientManager.Instance.serverTimeStamp < groupData.nStartTime and groupData.nStartTime ~= 0 then
      RedDotManager.SetValid(RedDotDefine.Activity_GoldenSpy_Group, {
        actGroupId,
        groupData.nId
      }, false)
    elseif not self:CheckPreGroupPassByGroupId(groupData.nId) then
      RedDotManager.SetValid(RedDotDefine.Activity_GoldenSpy_Group, {
        actGroupId,
        groupData.nId
      }, false)
    else
      RedDotManager.SetValid(RedDotDefine.Activity_GoldenSpy_Group, {
        actGroupId,
        groupData.nId
      }, self:GetGroupIsNew(groupData.nId))
    end
  end
end

function GoldenSpyData:StartLevel(groupId, levelId)
  self.nGroupId = groupId
  self.nLevelId = levelId
  self.GoldenSpyLevelData:InitData()
  self.GoldenSpyLevelData:StartLevel(levelId)
  local config = ConfigTable.GetData("GoldenSpyControl", self.nActId)
  if config == nil then
    return
  end
  EventManager.Hit(EventId.OpenPanel, config.LevelPanelId, self.nActId, self.nGroupId, levelId)
end

function GoldenSpyData:GetLastLevelData()
  return self.nGroupId, self.nLevelId
end

function GoldenSpyData:FinishLevel(levelId, data, callback)
  local items = {}
  for _, v in pairs(data.tbItems) do
    local data = {
      ItemId = v.itemId,
      PickCount = v.itemCount
    }
    table.insert(items, data)
  end
  local skills = {}
  for k, v in pairs(data.tbSkills) do
    local data = {SkillId = k, UseCount = v}
    table.insert(skills, data)
  end
  local mapMsg = {
    ActivityId = self.nActId,
    LevelId = levelId,
    Floor = data.nFloor,
    Score = data.nScore,
    CompletedTaskCount = data.nTaskCompleteCount,
    Items = items,
    Skills = skills
  }
  
  local function msgCallback(_, msgData)
    local oldLevelData = self:GetLevelDataById(levelId)
    local levelCfg = ConfigTable.GetData("GoldenSpyLevel", levelId)
    local levelData = {
      nId = levelId,
      nMaxScore = math.max(oldLevelData.nMaxScore, data.nScore),
      bFirstComplete = oldLevelData.bFirstComplete or data.nScore >= levelCfg.Score
    }
    self:UpdateLevelData(levelData)
    if callback ~= nil then
      callback(msgData)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_gds_settle_req, mapMsg, nil, msgCallback)
end

function GoldenSpyData:EnterFloor(floorId)
  if table.indexof(self.cacheEnterFloorList, floorId) == 0 then
    table.insert(self.cacheEnterFloorList, floorId)
    LocalData.SetPlayerLocalData("GoldenSpyFloorData", RapidJson.encode(self.cacheEnterFloorList))
  end
end

function GoldenSpyData:GetFloorIsNew(floorId)
  if table.indexof(self.cacheEnterFloorList, floorId) == 0 then
    return true
  end
  return false
end

function GoldenSpyData:GetNextLevel(nGroupId, nCurLevelId)
  local groupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", nGroupId)
  if groupCfg == nil then
    return nil, nil
  end
  local levelList = groupCfg.LevelList
  local nIndex = table.indexof(levelList, nCurLevelId)
  if nIndex == 0 then
    return nil, nil
  end
  if nIndex < #levelList then
    return nGroupId, levelList[nIndex + 1]
  end
  local nNextGroupId = self:GetNextGroup(nGroupId)
  if nNextGroupId == nil then
    return nil, nil
  end
  local nextGroupData = self:GetLevelGroupDataById(nNextGroupId)
  if nextGroupData == nil then
    return nil, nil
  end
  local nextGroupConfig = ConfigTable.GetData("GoldenSpyLevelGroup", nNextGroupId)
  if nextGroupConfig == nil then
    return nil, nil
  end
  if CS.ClientManager.Instance.serverTimeStamp < nextGroupData.nStartTime and nextGroupData.nStartTime ~= 0 then
    return nil, nil
  elseif not self:CheckPreGroupPassByGroupId(nNextGroupId) then
    return nil, nil
  else
    return nNextGroupId, nextGroupConfig.LevelList[1]
  end
end

function GoldenSpyData:GetNextGroup(nCurGroupId)
  local tbGroupList = ConfigTable.GetData("GoldenSpyControl", self.nActId).LevelGroupList
  local nIndex = table.indexof(tbGroupList, nCurGroupId)
  if nIndex == #tbGroupList then
    return nil
  end
  return tbGroupList[nIndex + 1]
end

function GoldenSpyData:GetPreGroup(nCurGroupId)
  local tbGroupList = ConfigTable.GetData("GoldenSpyControl", self.nActId).LevelGroupList
  local nIndex = table.indexof(tbGroupList, nCurGroupId)
  if nIndex == 1 then
    return nil
  end
  return tbGroupList[nIndex - 1]
end

return GoldenSpyData
