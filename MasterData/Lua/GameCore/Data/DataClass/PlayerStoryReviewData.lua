local ActivityStoryDataBase = require("GameCore.Data.DataClass.Activity.ActivityStoryDataBase")
local PlayerStoryReviewData = class("PlayerStoryReviewData", ActivityStoryDataBase)
local ClientManager = CS.ClientManager.Instance
local LocalData = require("GameCore.Data.LocalData")

function PlayerStoryReviewData:Init()
  ActivityStoryDataBase.Init(self)
  self.mapReviewChapters = {}
  self.mapLoadedChapterIds = {}
  self.bOnlyShowUnRead = false
  self:InitConfig()
end

function PlayerStoryReviewData:InitConfig()
  self.mapReviewChapters = {}
  
  local function funcForeachSection(mapData)
    CacheTable.SetData("_ActivityStoryChapter", mapData.ChapterId, mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityStoryChapter"), funcForeachSection)
end

function PlayerStoryReviewData:CheckStoryInReview(nChapterId)
  local mapCfg = CacheTable.GetData("_ActivityStoryChapter", nChapterId)
  if mapCfg ~= nil then
    local nActivityId = mapCfg.Id
    local mapActCfg = ConfigTable.GetData("Activity", nActivityId)
    if mapActCfg ~= nil and mapActCfg.EndType == GameEnum.activityEndType.Date then
      local nEndTime = ClientManager:ISO8601StrToTimeStamp(mapActCfg.EndTime)
      local nCurTime = ClientManager.serverTimeStamp
      if nEndTime > nCurTime then
        return false
      end
    end
  end
  return true
end

function PlayerStoryReviewData:GetAllStoryReview()
  local tbLineChapters = {}
  self.mapReviewChapters = {}
  
  local function funcForeachSection(mapData)
    local nActivityId = mapData.Id
    local mapActCfg = ConfigTable.GetData("Activity", nActivityId)
    if mapActCfg ~= nil and mapActCfg.EndType == GameEnum.activityEndType.Date then
      local nEndTime = ClientManager:ISO8601StrToTimeStamp(mapActCfg.EndTime)
      local nCurTime = ClientManager.serverTimeStamp
      if nEndTime <= nCurTime then
        self.mapReviewChapters[mapData.ChapterId] = mapData
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityStoryChapter"), funcForeachSection)
  for nChapterId, mapCfg in pairs(self.mapReviewChapters) do
    local nLineId = mapCfg.StoryLineId
    if tbLineChapters[nLineId] == nil then
      tbLineChapters[nLineId] = {}
    end
    table.insert(tbLineChapters[nLineId], nChapterId)
  end
  for _, tbIds in pairs(tbLineChapters) do
    table.sort(tbIds, function(a, b)
      local cfgA = CacheTable.GetData("_ActivityStoryChapter", a)
      local cfgB = CacheTable.GetData("_ActivityStoryChapter", b)
      return (cfgA and cfgA.SortOrder or 0) < (cfgB and cfgB.SortOrder or 0)
    end)
  end
  return tbLineChapters
end

function PlayerStoryReviewData:GetSortedStoryLineIds()
  local tbLineIds = {}
  local tbSeen = {}
  for _, mapCfg in pairs(self.mapReviewChapters) do
    local nLineId = mapCfg.StoryLineId
    if not tbSeen[nLineId] then
      tbSeen[nLineId] = true
      table.insert(tbLineIds, nLineId)
    end
  end
  table.sort(tbLineIds, function(a, b)
    local cfgA = ConfigTable.GetData("ActivityStoryLine", a)
    local cfgB = ConfigTable.GetData("ActivityStoryLine", b)
    return (cfgA and cfgA.SortOrder or 0) < (cfgB and cfgB.SortOrder or 0)
  end)
  return tbLineIds
end

function PlayerStoryReviewData:GetLastReadChapterId()
  if self.nLastChapterId == nil then
    self.nLastChapterId = LocalData.GetPlayerLocalData("StoryReview_LastRead_ChapterId") or 0
  end
  if self.nLastChapterId ~= 0 and self:CheckChapterRead(self.nLastChapterId) then
    self:SetLastReadChapterId(0)
  end
  return self.nLastChapterId
end

function PlayerStoryReviewData:GetOnlyShowUnRead()
  return self.bOnlyShowUnRead == true
end

function PlayerStoryReviewData:SetOnlyShowUnRead(bOnlyShowUnRead)
  self.bOnlyShowUnRead = bOnlyShowUnRead == true
end

function PlayerStoryReviewData:SetLastReadChapterId(nChapterId)
  self.nLastChapterId = nChapterId
  LocalData.SetPlayerLocalData("StoryReview_LastRead_ChapterId", nChapterId)
end

function PlayerStoryReviewData:GetChapterActivityId(nChapterId)
  local mapCfg = CacheTable.GetData("_ActivityStoryChapter", nChapterId)
  if mapCfg ~= nil then
    return mapCfg.Id
  end
  return 0
end

function PlayerStoryReviewData:IsChapterLoaded(nChapterId)
  return self.mapLoadedChapterIds[nChapterId] == true
end

function PlayerStoryReviewData:IsChapterRead(nChapterId)
  local bRead = true
  local tbStoryIds = self:GetChapterStoryNumIds(nChapterId)
  if tbStoryIds ~= nil then
    for _, v in ipairs(tbStoryIds) do
      bRead = bRead and self:IsStoryReaded(v)
    end
  end
  return bRead
end

function PlayerStoryReviewData:GetChapterHandBookId(nChapterId)
  local mapCfg = CacheTable.GetData("_ActivityStoryChapter", nChapterId)
  if mapCfg == nil then
    return 0
  end
  return mapCfg.HandBookId or 0
end

function PlayerStoryReviewData:IsChapterReadByHandbook(nChapterId)
  local nHandBookId = self:GetChapterHandBookId(nChapterId)
  if nHandBookId <= 0 then
    return false
  end
  return PlayerData.Handbook:CheckHandbookUnlock(nHandBookId)
end

function PlayerStoryReviewData:CheckChapterRead(nChapterId)
  if self:IsChapterLoaded(nChapterId) then
    return self:IsChapterRead(nChapterId)
  end
  return self:IsChapterReadByHandbook(nChapterId)
end

function PlayerStoryReviewData:GetChapterReadProgress(nChapterId)
  local tbStoryNumIds = self:GetChapterStoryNumIds(nChapterId)
  local nTotal = tbStoryNumIds ~= nil and #tbStoryNumIds or 0
  if not self:IsChapterLoaded(nChapterId) then
    return self:IsChapterReadByHandbook(nChapterId) and nTotal or 0, nTotal
  end
  local nRead = 0
  for _, nStoryNumId in ipairs(tbStoryNumIds) do
    if self:IsStoryReaded(nStoryNumId) then
      nRead = nRead + 1
    end
  end
  return nRead, nTotal
end

function PlayerStoryReviewData:GetChapterLastStoryNumId(nChapterId)
  local tbStoryNumIds = self:GetChapterStoryNumIds(nChapterId)
  if tbStoryNumIds == nil then
    return 0
  end
  for _, nStoryNumId in ipairs(tbStoryNumIds) do
    local mapCfg = ConfigTable.GetData("ActivityStory", nStoryNumId)
    if mapCfg ~= nil and mapCfg.IsLast == true then
      return nStoryNumId
    end
  end
  return 0
end

function PlayerStoryReviewData:TryOpenStoryChapter(nChapterId)
  local mapCfg = CacheTable.GetData("_ActivityStoryChapter", nChapterId)
  if mapCfg == nil then
    return
  end
  local nPanelId = mapCfg.PanelId
  local nActId = mapCfg.Id
  
  local function openPanel()
    EventManager.Hit(EventId.OpenPanel, nPanelId, nActId, true)
  end
  
  if self:IsChapterLoaded(nChapterId) then
    openPanel()
  else
    self:SendGetChapterInfo(nChapterId, openPanel)
  end
end

function PlayerStoryReviewData:_GetApplyMsgId(nActivityId)
  return NetMsgId.Id.activity_archive_story_apply_req
end

function PlayerStoryReviewData:_GetSettleMsgId(nActivityId)
  return NetMsgId.Id.activity_archive_story_settle_req, true
end

function PlayerStoryReviewData:IsOpen(sAvgId, nActivityId)
  return true, 0
end

function PlayerStoryReviewData:RefreshAvgRedDot()
  for nLineId, tbChapterIds in pairs(self:GetAllStoryReview()) do
    for _, nChapterId in ipairs(tbChapterIds) do
      local bValid = not self:IsChapterReadByHandbook(nChapterId)
      RedDotManager.SetValid(RedDotDefine.StoryReview_Chapter, {nLineId, nChapterId}, bValid)
    end
  end
end

function PlayerStoryReviewData:SendMsg_STORY_ENTER(nActivityId, nStoryId, nBuildId, bNewestStory)
  ActivityStoryDataBase.SendMsg_STORY_ENTER(self, nActivityId, nStoryId, nBuildId, bNewestStory)
  local mapChapterCfg = self:GetChapterIdByActivityId(nActivityId)
  if mapChapterCfg ~= nil then
    self:SetLastReadChapterId(mapChapterCfg.ChapterId)
  end
end

function PlayerStoryReviewData:_GetLocalReadKey(nActId, nStoryId)
  return "Review_Story_Read_" .. tostring(nActId) .. tostring(nStoryId)
end

function PlayerStoryReviewData:IsActivityAvgUnlock(nActivityId, nStoryId)
  return true, true, 0
end

function PlayerStoryReviewData:IsActivityAvgReaded(nActivityId, nStoryId)
  return true
end

function PlayerStoryReviewData:IsNew(nActivityId, nStoryId)
  return false
end

function PlayerStoryReviewData:GetRecentAcvitityIndex(nActivityId)
  return 1
end

function PlayerStoryReviewData:SendGetChapterInfo(nChapterId, callback)
  local function netCallback(_, netData)
    local chapter = netData
    
    if chapter ~= nil and chapter.ChapterId ~= nil then
      local nActivityId = self:GetChapterActivityId(nChapterId)
      if 0 < nActivityId then
        self:CacheAvgData(chapter, nActivityId)
      end
      self.mapLoadedChapterIds[nChapterId] = true
    end
    if callback ~= nil then
      callback(chapter)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_archive_story_info_req, {Value = nChapterId}, nil, netCallback)
end

function PlayerStoryReviewData:SendChapterPass(nChapterId, callback)
  local nLastStoryNumId = self:GetChapterLastStoryNumId(nChapterId)
  if nLastStoryNumId <= 0 then
    printError("ActivityStory 没配 IsLast 的收尾剧情，无法发送章节完成，章节 id：" .. tostring(nChapterId))
    return
  end
  
  local function netCallback(_, netData)
    self:RefreshAvgRedDot()
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_archive_story_chapter_pass_req, {ChapterId = nLastStoryNumId}, nil, netCallback)
end

function PlayerStoryReviewData:_MockChapterInfo(nChapterId)
  local tbStoryNumIds = self:GetChapterStoryNumIds(nChapterId) or {}
  local tbStories = {}
  local tbEvidences = {}
  local tbSeenEv = {}
  for _, nStoryId in ipairs(tbStoryNumIds) do
    local mapStoryCfg = ConfigTable.GetData("ActivityStory", nStoryId)
    if mapStoryCfg ~= nil then
      local mapCondCfg = ConfigTable.GetData("ActivityStoryCondition", mapStoryCfg.ConditionId)
      if mapCondCfg ~= nil then
        if mapCondCfg.EvIds_a ~= nil then
          for _, nEvNumId in ipairs(mapCondCfg.EvIds_a) do
            if not tbSeenEv[nEvNumId] then
              tbSeenEv[nEvNumId] = true
              table.insert(tbEvidences, nEvNumId)
            end
          end
        end
        if mapCondCfg.EvIds_b ~= nil then
          for _, nEvNumId in ipairs(mapCondCfg.EvIds_b) do
            if not tbSeenEv[nEvNumId] then
              tbSeenEv[nEvNumId] = true
              table.insert(tbEvidences, nEvNumId)
            end
          end
        end
      end
      table.insert(tbStories, {
        Id = nStoryId,
        Major = {},
        Personality = {},
        Receive = true
      })
    end
  end
  return {
    ChapterId = nChapterId,
    Build = {Type = 0, BuildId = 0},
    Evidences = tbEvidences,
    Stories = tbStories
  }
end

return PlayerStoryReviewData
