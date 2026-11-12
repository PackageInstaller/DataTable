local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local BreakOutData = class("BreakOutData", ActivityDataBase)
local LocalData = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")
local RedDotManager = require("GameCore.RedDot.RedDotManager")
local BreakOutLevelData = require("GameCore.Data.DataClass.Activity.BreakOutLevelData")
local ModuleManager = require("GameCore.Module.ModuleManager")

function BreakOutData:Init()
  self.allLevelData = {}
  self.cacheEnterLevelList = {}
  self.BreakOutLevelData = BreakOutLevelData.new()
  self.tempData = nil
  self.ActEnd = self:IsActTimeEnd()
  self:AddListeners()
end

function BreakOutData:AddListeners()
  EventManager.Add("MilkoutCharacterUnlock", self, self.On_BreakoutCharacter_Unlock)
  EventManager.Add("ClearAllLevels", self, self.OnEvent_GMClearAllLevels)
end

function BreakOutData:RefreshBreakOutData(actId, msgData)
  self:Init()
  self.nActId = actId
  self.mapActData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if self.mapActData ~= nil then
    self.nEndTime = self.mapActData:GetActEndTime() or 0
  end
  if msgData ~= nil then
    self:CacheAllLevelData(msgData.Levels)
    self:CacheAllCharacterData(msgData.Characters)
  end
  local sJson = LocalData.GetPlayerLocalData("BreakOutLevel")
  local tb = decodeJson(sJson)
  if type(tb) == "table" then
    self.cacheEnterLevelList = tb
  end
  self:RefreshRedDot()
end

function BreakOutData:CacheAllCharacterData(UnLockedCharacterData)
  self.tbUnLockedCharacterDataList = {}
  self.tbUnLockedCharacterDataMap = {}
  for _, v in pairs(UnLockedCharacterData) do
    local CharacterData = {
      nId = v.Id,
      nBattleTimes = v.BattleTimes
    }
    table.insert(self.tbUnLockedCharacterDataList, CharacterData)
    self.tbUnLockedCharacterDataMap[v.Id] = CharacterData
  end
end

function BreakOutData:CacheIsUnlocked(CharacterNid)
  if self.tbUnLockedCharacterDataMap[CharacterNid] then
    return true
  end
  return false
end

function BreakOutData:GetDataFromBreakOutCharacter(CharacterNid)
  if self.tbUnLockedCharacterDataMap[CharacterNid] then
    return ConfigTable.GetData("BreakOutCharacter", CharacterNid)
  end
  return nil
end

function BreakOutData:GetSkillData(CharacterNid)
  local tbCharacterData = self:GetDataFromBreakOutCharacter(CharacterNid)
  if tbCharacterData == nil then
    return nil
  else
    return tbCharacterData.SkillId
  end
end

function BreakOutData:GetBattleCount(CharacterNid)
  if self.tbUnLockedCharacterDataMap[CharacterNid] ~= nil then
    return self.tbUnLockedCharacterDataMap[CharacterNid].nBattleTimes
  else
    return 0
  end
end

function BreakOutData:CacheAllLevelData(levelListData)
  self.tbLevelDataList = {}
  self.tbLevelDataMap = {}
  for _, v in pairs(levelListData) do
    local config = ConfigTable.GetData("BreakOutLevel", v.Id)
    local levelData = {
      nId = v.Id,
      bFirstComplete = v.FirstComplete,
      nDifficultyType = config.Type,
      nPreLevelId = config.PreLevelId
    }
    table.insert(self.tbLevelDataList, levelData)
    self.tbLevelDataMap[v.Id] = levelData
  end
end

function BreakOutData:IsAllLevelComplete()
  for _, v in pairs(self.tbLevelDataList) do
    if not v.bFirstComplete then
      return false
    end
  end
  return true
end

function BreakOutData:GetLevelData()
  return self.tbLevelDataList
end

function BreakOutData:GetLevelDataById(nId)
  if self.tbLevelDataMap[nId] ~= nil then
    return self.tbLevelDataMap[nId]
  else
    printLog(nId .. ":Id不存在对应关卡数据")
    return nil
  end
end

function BreakOutData:UpdateLevelData(levelData)
  for _, v in pairs(self.tbLevelDataList) do
    if v.nId == levelData.Id then
      v.bFirstComplete = levelData.FirstComplete
      break
    end
  end
  local levelConfig = ConfigTable.GetData("BreakOutLevel", levelData.Id)
  if levelConfig == nil then
    return
  end
  if not self:GetPlayState() or self:IsLevelUnlocked(levelData.Id) then
  end
end

function BreakOutData:UpdateCharacterData(CharacterData)
  if self.tbUnLockedCharacterDataMap[CharacterData.CharacterNid] ~= nil then
    self.tbUnLockedCharacterDataMap[CharacterData.CharacterNid].nBattleTimes = self.tbUnLockedCharacterDataMap[CharacterData.CharacterNid].nBattleTimes + 1
    EventManager.Hit("RefreshCharacterBattleTimes")
  end
end

function BreakOutData:GetDetailLevelDataById(nId)
  if self.tbLevelDataMap[nId] then
    return ConfigTable.GetData("BreakOutLevel", nId)
  end
  return nil
end

function BreakOutData:GetDetailFloorDataById(nId)
  if self.tbLevelDataMap[nId] then
    local nFloorId = ConfigTable.GetData("BreakOutLevel", nId).FloorId
    return ConfigTable.GetData("BreakOutFloor", nFloorId)
  end
  return nil
end

function BreakOutData:GetLevelsByTab(nTabIndex)
  local levelData = {}
  for _, v in pairs(self.tbLevelDataList) do
    if v.nDifficultyType == nTabIndex then
      table.insert(levelData, ConfigTable.GetData("BreakOutLevel", v.nId))
    end
  end
  table.sort(levelData, function(a, b)
    return a.Difficulty < b.Difficulty
  end)
  return levelData
end

function BreakOutData:GetBreakoutLevelTypeNum()
  local nNum = 0
  for _, _ in pairs(GameEnum.ActivityBreakoutLevelType) do
    nNum = nNum + 1
  end
  return nNum
end

function BreakOutData:GetBreakoutPreLevelIdName(nLevelId)
  local LevelData = ConfigTable.GetData("BreakOutLevel", nLevelId)
  if LevelData == nil then
    return
  else
    local nPreLevelId = ConfigTable.GetData("BreakOutLevel", nLevelId).PreLevelId
    local PreLevelIdName = ConfigTable.GetData("BreakOutLevel", nPreLevelId).Name
    return PreLevelIdName
  end
end

function BreakOutData:GetBreakoutLevelDifficult(nLevelId)
  local LevelData = ConfigTable.GetData("BreakOutLevel", nLevelId)
  if LevelData == nil then
    return
  else
    return LevelData.Type
  end
end

function BreakOutData:GetCurrentSelectedTabIndex()
  local EasyDifficultyType = GameEnum.ActivityBreakoutLevelType.Expert
  for _, levelData in ipairs(self.tbLevelDataList) do
    if not levelData.bFirstComplete and EasyDifficultyType >= levelData.nDifficultyType then
      EasyDifficultyType = levelData.nDifficultyType
    end
  end
  return EasyDifficultyType
end

function BreakOutData:RefreshRedDot()
  if self.tbLevelDataList == nil then
    return
  end
  local bRedDot = false
  local nActivityGroupId = ConfigTable.GetData("Activity", self.nActId).MidGroupId
  for _, levelData in ipairs(self.tbLevelDataList) do
    if self:IsLevelTimeUnlocked(levelData.nId) then
      if self.ActEnd then
        bRedDot = false
      else
        bRedDot = self:GetLevelIsNew(levelData.nId)
      end
      RedDotManager.SetValid(RedDotDefine.Activity_BreakOut_DifficultyTap_Level, {
        nActivityGroupId,
        levelData.nId
      }, bRedDot)
    end
  end
end

function BreakOutData:IsActTimeEnd()
  local isEnd = false
  if self.nActId then
    local LevelEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(ConfigTable.GetData("Activity", self.nActId).EndTime)
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    if LevelEndTime ~= nil then
      return LevelEndTime < nCurTime
    else
      printError("config 表：" .. "BreakOut_LevelClosed" .. " Value数据为空")
    end
  end
  return isEnd
end

function BreakOutData:GetLevelIsNew(levelId)
  local bResult = false
  local levelData = self:GetLevelDataById(levelId)
  if levelData ~= nil and levelData.bFirstComplete == false and table.indexof(self.cacheEnterLevelList, levelId) == 0 then
    bResult = true
  end
  return bResult
end

function BreakOutData:EnterLevelSelect(nLevelId)
  local levelData = ConfigTable.GetData("BreakOutLevel", nLevelId)
  if levelData == nil then
    return
  end
  local nActivityGroupId = ConfigTable.GetData("Activity", levelData.ActivityId).MidGroupId
  if table.indexof(self.cacheEnterLevelList, nLevelId) == 0 or RedDotManager.GetValid(RedDotDefine.Activity_BreakOut_DifficultyTap_Level, {nActivityGroupId, nLevelId}) then
    table.insert(self.cacheEnterLevelList, nLevelId)
    local tbLocalSave = {}
    for _, v in ipairs(self.cacheEnterLevelList) do
      table.insert(tbLocalSave, v)
    end
    RedDotManager.SetValid(RedDotDefine.Activity_BreakOut_DifficultyTap_Level, {nActivityGroupId, nLevelId}, false)
    LocalData.SetPlayerLocalData("BreakOutLevel", RapidJson.encode(tbLocalSave))
    self:RefreshRedDot()
  end
end

function BreakOutData:IsLevelUnlocked(nLevelId)
  local bTimeUnlock, bPreComplete = false, false
  local mapData = self:GetDetailLevelDataById(nLevelId)
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local openTime = CS.ClientManager.Instance:GetNextRefreshTime(self.nOpenTime) - 86400
  local remainTime = openTime + mapData.DayOpen * 86400 - curTime
  local nPreLevelId = mapData.PreLevelId or 0
  local bIsLevelComplete = self:IsLevelComplete(nPreLevelId)
  bTimeUnlock = remainTime <= 0
  bPreComplete = nPreLevelId == nil or bIsLevelComplete
  return bTimeUnlock, bPreComplete
end

function BreakOutData:IsLevelTimeUnlocked(nLevelId)
  local bTimeUnlock = false
  local remainTime = self:GetLevelStartTime(nLevelId)
  if remainTime then
    bTimeUnlock = remainTime <= 0
  end
  return bTimeUnlock
end

function BreakOutData:GetLevelStartTime(nLevelId)
  local mapData = self:GetDetailLevelDataById(nLevelId)
  if mapData == nil then
    return nil
  end
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local openTime = CS.ClientManager.Instance:GetNextRefreshTime(self.nOpenTime) - 86400
  local remainTime = openTime + mapData.DayOpen * 86400 - curTime
  return remainTime
end

function BreakOutData:IsPreLevelComplete(nLevelId)
  local tbLevelData = ConfigTable.GetData("BreakOutLevel", nLevelId)
  if tbLevelData == nil then
    printLog(nLevelId .. ":Id不存在对应关卡数据")
    return false
  end
  local nPreLevelId = tbLevelData.PreLevelId
  if nPreLevelId == 0 then
    return true
  end
  return self:GetLevelDataById(nPreLevelId).bFirstComplete
end

function BreakOutData:IsLevelComplete(nLevelId)
  if nLevelId == 0 then
    return true
  end
  local nLevelData = self:GetLevelDataById(nLevelId)
  if nLevelData == nil then
    return false
  end
  return nLevelData.bFirstComplete
end

function BreakOutData:GetUnFinishEasyLevel()
  local EasyDifficultyType = GameEnum.ActivityBreakoutLevelType.Expert
  local levelId
  for _, levelData in ipairs(self.tbLevelDataList) do
    if not levelData.bFirstComplete and EasyDifficultyType >= levelData.nDifficultyType then
      EasyDifficultyType = levelData.nDifficultyType
      levelId = levelData.nId
    end
  end
  return levelId
end

function BreakOutData:RequestFinishLevel(arrayData, cb)
  self:UpdateCharacterData({
    CharacterNid = arrayData.CharId
  })
  EventManager.Hit("SetPlayFinishState", true)
  if self:IsActivityClosed() then
    self:ShowActivityClosedAlert()
    return
  end
  if not arrayData.Win then
    local mapMsg = arrayData
    
    local function failCallback()
      if cb ~= nil then
        cb()
      end
    end
    
    EventManager.Hit(EventId.ClosePanel, PanelId.BreakOutLevelDetailPanelS4)
    HttpNetHandler.SendMsg(NetMsgId.Id.milkout_settle_req, mapMsg, nil, failCallback)
    return
  end
  self:CreateTempData(arrayData.LevelId, arrayData.Win)
  local mapMsg = arrayData
  
  local function successCallback(_, mapMainData)
    cb(mapMainData)
    self:UpdateLevelData({
      Id = arrayData.LevelId,
      FirstComplete = arrayData.Win
    })
  end
  
  EventManager.Hit(EventId.ClosePanel, PanelId.BreakOutLevelDetailPanelS4)
  HttpNetHandler.SendMsg(NetMsgId.Id.milkout_settle_req, mapMsg, nil, successCallback)
end

function BreakOutData:CreateTempData(nLevelId, bResult)
  self.tempData = {nLevelId = nLevelId, bResult = bResult}
end

function BreakOutData:GetTempData()
  return self.tempData
end

function BreakOutData:ClearTempData()
  self.tempData = nil
end

function BreakOutData:On_BreakoutCharacter_Unlock(mapMsgData)
  if self.nActId ~= mapMsgData.ActivityId then
    return
  end
  self:RefreshCharacterData(mapMsgData.CharId)
end

function BreakOutData:RefreshCharacterData(charId)
  local bIsLock = true
  for _, v in pairs(self.tbUnLockedCharacterDataList) do
    if v.nId == charId then
      bIsLock = false
      break
    end
  end
  if bIsLock then
    local CharacterData = {nId = charId, nBattleTimes = 0}
    table.insert(self.tbUnLockedCharacterDataList, CharacterData)
    self.tbUnLockedCharacterDataMap[charId] = CharacterData
  end
end

function BreakOutData:OnEvent_GMClearAllLevels(mapMsgData)
  if mapMsgData ~= nil then
    self:CacheAllLevelData(mapMsgData.Levels)
  end
end

function BreakOutData:IsActivityClosed()
  if self == nil or self.CheckActivityOpen == nil then
    return false
  end
  return not self:CheckActivityOpen()
end

function BreakOutData:ShowActivityClosedAlert()
  local msg = {
    nType = AllEnum.MessageBox.Alert,
    sContent = ConfigTable.GetUIText("Activity_End_Notice"),
    callbackConfirm = function()
      self:ForceExitOnFinishFail()
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function BreakOutData:ForceExitOnFinishFail()
  local bInAdventure = ModuleManager.GetIsAdventure()
  if bInAdventure then
    CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
  else
    EventManager.Hit(EventId.ClosePanel, PanelId.BreakOutPlayPanelS4)
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.BreakOutLevelDetailPanelS4)
end

return BreakOutData
