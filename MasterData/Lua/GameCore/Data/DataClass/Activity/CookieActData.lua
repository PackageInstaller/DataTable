local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local CookieActData = class("CookieActData", ActivityDataBase)
local LocalData = require("GameCore.Data.LocalData")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
local nLastPath = 0

function CookieActData:GetCookieControlCfg(...)
  if not self.tbConfig then
    self.tbConfig = ConfigTable.GetData("CookieControl", self.nActId)
  end
  return self.tbConfig
end

function CookieActData:GetLevelCfg(nPlayGroupId)
  local mapConfig = ConfigTable.GetData("CookieLevel", nPlayGroupId)
  if mapConfig == nil then
    return nil
  end
  return mapConfig
end

function CookieActData:Init()
  self.nTotalScore = 0
  self.nActCredit = 0
  self.nActId = 0
  self.nNightmareModeHighScore = 0
  self.tbLevelScore = {}
  self.tbLevelBox = {}
  self.tbModeComp = {}
  self.tbModeBox = {}
  self.tbModePerfect = {}
  self.tbModeExcellent = {}
  self.tbModeCookie = {}
  self:AddListeners()
  self.tbLevelDataList = {}
  self.tbQuestDataList = {}
end

function CookieActData:AddListeners()
  EventManager.Add("Cookie_Game_Complete", self, self.OnEvent_GameComplete)
  EventManager.Add("Cookie_Quest_Claim", self, self.OnEvent_QuestClaim)
end

function CookieActData:RefreshCookieGameActData(actId, msgData)
  self:Init()
  self.nActId = actId
  self.mapActData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if self.mapActData ~= nil then
    self.nEndTime = self.mapActData:GetActEndTime() or 0
    self.nOpenTime = self.mapActData:GetActOpenTime() or 0
  end
  if msgData ~= nil then
    self:CacheAllQuestData(msgData.Quests)
    self:CacheAllLevelData(msgData.Levels)
  end
  if self.nActId == 0 then
    printError("CookieActDataInit: ActivityId is 0!!!")
  end
end

function CookieActData:CacheAllQuestData(questListData)
  self.tbQuestDataList = {}
  for _, v in pairs(questListData) do
    local questData = {
      nId = v.Id,
      nStatus = self:QuestServer2Client(v.Status),
      progress = {
        Cur = #v.Progress > 0 and v.Progress[1].Cur or 1,
        Max = #v.Progress > 0 and v.Progress[1].Max or 1
      }
    }
    table.insert(self.tbQuestDataList, questData)
  end
end

function CookieActData:GetQuestData()
  local tbData = {}
  for _, v in pairs(self.tbQuestDataList) do
    table.insert(tbData, v)
  end
  return tbData
end

function CookieActData:CacheAllLevelData(levelListData)
  self.tbLevelDataList = {}
  for _, v in pairs(levelListData) do
    local levelData = {
      nId = v.LevelId,
      nMaxScore = v.MaxScore or 0,
      bFirstComplete = v.FirstComplete
    }
    table.insert(self.tbLevelDataList, levelData)
  end
end

function CookieActData:GetLevelData()
  return self.tbLevelDataList
end

function CookieActData:GetLevelDataById(nId)
  local levelData
  for _, v in pairs(self.tbLevelDataList or {}) do
    if v.nId == nId then
      levelData = v
      break
    end
  end
  return levelData
end

function CookieActData:SetLevelData(nLevelId, nLevelScore)
  local oldLevelData = self:GetLevelDataById(nLevelId)
  if oldLevelData == nil then
    return
  end
  oldLevelData.nMaxScore = math.max(oldLevelData.nMaxScore or 0, nLevelScore or 0)
  local mapCfg = self:GetLevelCfg(nLevelId)
  local bFirstComplete = nLevelScore >= (mapCfg and mapCfg.FirstCompletionScore or 0)
  oldLevelData.bFirstComplete = oldLevelData.bFirstComplete or bFirstComplete
end

function CookieActData:GetQuestDataById(nId)
  local questData
  if self.tbQuestDataList ~= nil then
    for _, v in pairs(self.tbQuestDataList) do
      if v.nId == nId then
        questData = v
        break
      end
    end
  end
  return questData
end

function CookieActData:RefreshQuestData(questData)
  local oldQuestData = self:GetQuestDataById(questData.Id)
  if oldQuestData == nil then
    return
  end
  oldQuestData.nStatus = self:QuestServer2Client(questData.Status)
  oldQuestData.progress = {
    Cur = questData.Progress[1].Cur,
    Max = questData.Progress[1].Max
  }
  EventManager.Hit("CookieQuestUpdate")
end

function CookieActData:RefreshQuestReddot()
  local bTabReddot = false
  if next(self.tbQuestDataList) ~= nil then
    for _, v in pairs(self.tbQuestDataList) do
      local bReddot = v.nStatus == AllEnum.ActQuestStatus.Complete
      RedDotManager.SetValid(RedDotDefine.Activity_Cookie_Quest, v.nId, bReddot)
      bTabReddot = bTabReddot or bReddot
    end
  end
  RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nActId, bTabReddot or self.bIsFirst)
end

function CookieActData:SendQuestReceive(nQuestId)
  local function callback(_, msgData)
    UTILS.OpenReceiveByChangeInfo(msgData, nil)
    
    if nQuestId == 0 then
      for _, v in pairs(self.tbQuestDataList) do
        if v.nStatus == AllEnum.ActQuestStatus.Complete then
          v.nStatus = AllEnum.ActQuestStatus.Received
        end
      end
    else
      local questData = self:GetQuestDataById(nQuestId)
      if questData then
        questData.nStatus = AllEnum.ActQuestStatus.Received
      end
    end
    EventManager.Hit("CookieQuestUpdate")
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_cookie_quest_reward_receive_req, {
    ActivityId = self.nActId,
    QuestId = nQuestId
  }, nil, callback)
end

function CookieActData:QuestServer2Client(nStatus)
  if nStatus == 0 then
    return AllEnum.ActQuestStatus.UnComplete
  elseif nStatus == 1 then
    return AllEnum.ActQuestStatus.Complete
  else
    return AllEnum.ActQuestStatus.Received
  end
end

function CookieActData:IsLevelUnlocked(nLevelId)
  local bTimeUnlock, bPreComplete = false, false
  local mapData = self:GetLevelCfg(nLevelId)
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local openTime = CS.ClientManager.Instance:GetNextRefreshTime(self.nOpenTime) - 86400
  local remainTime = openTime + mapData.DayOpen * 86400 - curTime
  local nPreLevelId = mapData.PreLevelId or 0
  local mapLevelStatus = self:GetLevelDataById(nPreLevelId)
  bTimeUnlock = remainTime <= 0
  bPreComplete = nPreLevelId == 0 or mapLevelStatus ~= nil and mapLevelStatus.bFirstComplete
  return bTimeUnlock, bPreComplete
end

function CookieActData:SetLevelReward(changeInfo)
  if changeInfo ~= nil and #changeInfo.Props > 0 then
    self.tbLevelReward = changeInfo
  else
    self.tbLevelReward = nil
  end
end

function CookieActData:GetLevelReward()
  return self.tbLevelReward
end

function CookieActData:GetNMHighScoreToday()
  local bToday = false
  local TipsTime = LocalData.GetPlayerLocalData("Cookie_Nightmare_HighScoreDay")
  local _tipDay = 0
  if TipsTime ~= nil then
    _tipDay = tonumber(TipsTime)
  end
  local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local fixedTimeStamp = curTimeStamp - newDayTime * 3600
  local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
  local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
  local nDay = tonumber(os.date("!%d", fixedTimeStamp))
  local nowD = nYear * 366 + nMonth * 31 + nDay
  if nowD == _tipDay then
    bToday = true
  end
  return bToday
end

function CookieActData:SetNMHighScoreDay()
  local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local fixedTimeStamp = curTimeStamp - newDayTime * 3600
  local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
  local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
  local nDay = tonumber(os.date("!%d", fixedTimeStamp))
  local nDayCount = nYear * 366 + nMonth * 31 + nDay
  LocalData.SetPlayerLocalData("Cookie_Nightmare_HighScoreDay", nDayCount)
end

function CookieActData:RequestLevelResult(nLevelId, nScore, nBoxCount, nCookieCount, nGoodCount, nPerfectCount, nExcellentCount, nMissCount, nActId, callback)
  local function callbackFunc(_, msgData)
    self:SetLevelData(nLevelId, nScore)
    
    self:SetLevelReward(msgData)
    if callback then
      callback(msgData)
    end
  end
  
  if self.nActId == 0 then
    self.nActId = nActId
    printError("RequestCookieLevelResult: ActivityId is 0!!!  -  ActivityId = " .. self.nActId .. ", nLevelId = " .. nLevelId .. ", nScore = " .. nScore)
  end
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_cookie_settle_req, {
    ActivityId = self.nActId,
    LevelId = nLevelId,
    Score = nScore,
    PackageNum = nBoxCount,
    CookieNum = nCookieCount,
    PerfectNum = nPerfectCount,
    ExcellentNum = nExcellentCount,
    MissNum = nMissCount,
    Good = nGoodCount
  }, nil, callbackFunc)
end

function CookieActData:OnEvent_GameComplete(nLevelId, nScore, nBoxCount, nCookieCount, nGoodCount, nPerfectCount, nExcellentCount, nMissCount, nActId, callback)
  self:RequestLevelResult(nLevelId, nScore, nBoxCount, nCookieCount, nGoodCount, nPerfectCount, nExcellentCount, nMissCount, nActId, callback)
end

function CookieActData:OnEvent_QuestClaim(nQuestId)
  self:SendQuestReceive(nQuestId)
end

return CookieActData
