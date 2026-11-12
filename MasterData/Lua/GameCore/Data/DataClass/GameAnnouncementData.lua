local GameAnnouncementData = class("GameAnnouncementData")
local LocalData = require("GameCore.Data.LocalData")
local htmlConfigId = 1

function GameAnnouncementData:ctor()
end

function GameAnnouncementData:Init()
  self.tbLastAnnList = LocalData.GetLocalData("Announcement_", "LastList") or {}
  self.tbCurAnnList = {}
  EventManager.Add("AllAnnDataRequestDone", self, self.AllAnnResponse)
  EventManager.Add("AnnContentRequestDone", self, self.AnnContentResponse)
  EventManager.Add("AllAnnDataRequestFail", self, self.AllAnnResponse_Fail)
end

function GameAnnouncementData:ClearCache()
  self.tbTypeList = {}
  self.tbAnnBaseInfo = {}
  self.tbAnnContentCache = {}
end

function GameAnnouncementData:SetAutoOpen(autoOpen)
  LocalData.SetLocalData("Announcement_", "AutoOpen", autoOpen)
end

function GameAnnouncementData:GetAutoOpen()
  local bAutoOpen = true
  if LocalData.GetLocalData("Announcement_", "AutoOpen") == nil then
    bAutoOpen = true
  else
    bAutoOpen = LocalData.GetLocalData("Announcement_", "AutoOpen")
  end
  local nTime = CS.ClientManager.Instance.serverTimeStamp
  local nLastTime = LocalData.GetLocalData("Announcement_", "Time") or 0
  if nTime > nLastTime then
    if not self:IsSameWeek(nTime, nLastTime) then
      bAutoOpen = true
    end
    LocalData.SetLocalData("Announcement_", "Time", nTime)
  else
  end
  return bAutoOpen
end

function GameAnnouncementData:GetTodayisOpen()
  local bTodayIsOpen = false
  local nTime = CS.ClientManager.Instance.serverTimeStamp
  local nLastOpenTime = LocalData.GetLocalData("Announcement_", "LastOpenTime") or 0
  if self:IsSameDay(nTime, nLastOpenTime) then
    if LocalData.GetLocalData("Announcement_", "TodayOpened") == nil then
      bTodayIsOpen = false
    else
      bTodayIsOpen = LocalData.GetLocalData("Announcement_", "TodayOpened")
    end
  else
    bTodayIsOpen = false
  end
  return bTodayIsOpen
end

function GameAnnouncementData:GetIsNeedAutoOpen()
  local bHasNew = self:CheckHasNewAnn()
  if bHasNew then
    return true
  end
  return self:GetAutoOpen() and not self:GetTodayisOpen()
end

function GameAnnouncementData:GetAnnInfoByType(nType)
  if self.tbTypeList[nType] == nil then
    return nil
  end
  return self.tbTypeList[nType]
end

function GameAnnouncementData:HasAnnouncement()
  if self.tbTypeList == {} or self.tbTypeList == nil then
    return false
  end
  if #self.tbTypeList > 4 or #self.tbTypeList < 2 then
    return false
  end
  return true
end

function GameAnnouncementData:GetHtmlData(nId)
  if self.tbAnnContentCache[nId] ~= nil then
    return self.tbAnnContentCache[nId]
  else
    self:SendAnnContentQuest(nId)
    return nil
  end
end

function GameAnnouncementData:SetAnnRead(nType, nId)
  if nId == 0 then
    local list = self.tbTypeList[nType]
    if list ~= nil then
      for _, v in pairs(list) do
        RedDotManager.SetValid(RedDotDefine.Announcement_Content, {
          nType,
          v.Id
        }, false)
        LocalData.SetLocalData("AnnouncementIsRead", tostring(v.Id), true)
      end
    end
  else
    RedDotManager.SetValid(RedDotDefine.Announcement_Content, {nType, nId}, false)
    LocalData.SetLocalData("AnnouncementIsRead", tostring(nId), true)
  end
end

function GameAnnouncementData:UpdateLastAnnData()
  self.tbLastAnnList = self.tbCurAnnList
  LocalData.SetLocalData("Announcement_", "LastList", self.tbLastAnnList)
  LocalData.SetLocalData("Announcement_", "TodayOpened", true)
  local nTime = CS.ClientManager.Instance.serverTimeStamp
  LocalData.SetLocalData("Announcement_", "LastOpenTime", nTime)
end

function GameAnnouncementData:CheckHasNewAnn()
  if self.tbCurAnnList == nil then
    return false
  end
  for _, value in pairs(self.tbCurAnnList) do
    if table.keyof(self.tbLastAnnList, value) == nil then
      return true
    end
  end
  return false
end

function GameAnnouncementData:AllAnnResponse(listData)
  self.tbAnnBaseInfo = {}
  self.tbTypeList = {}
  self.tbAnnContentCache = {}
  self.tbCurAnnList = {}
  for i = 0, listData.Activity.Length - 1 do
    local v = listData.Activity[i]
    if UTILS.CheckChannelList(v.Channel) and v.ContentUrl ~= "" then
      self.tbAnnBaseInfo[v.Id] = {
        info = v,
        nType = AllEnum.AnnType.ActivityAnn
      }
      if self.tbTypeList[AllEnum.AnnType.ActivityAnn] == nil then
        local list = {}
        table.insert(list, v)
        self.tbTypeList[AllEnum.AnnType.ActivityAnn] = list
      else
        table.insert(self.tbTypeList[AllEnum.AnnType.ActivityAnn], v)
      end
      local bIsRead = false
      if LocalData.GetLocalData("AnnouncementIsRead", tostring(v.Id)) == nil then
        bIsRead = false
      else
        bIsRead = LocalData.GetLocalData("AnnouncementIsRead", tostring(v.Id))
      end
      RedDotManager.SetValid(RedDotDefine.Announcement_Content, {
        AllEnum.AnnType.ActivityAnn,
        v.Id
      }, not bIsRead)
    end
    table.insert(self.tbCurAnnList, v.Id)
  end
  for i = 0, listData.System.Length - 1 do
    local v = listData.System[i]
    if UTILS.CheckChannelList(v.Channel) and v.ContentUrl ~= "" then
      self.tbAnnBaseInfo[v.Id] = {
        info = v,
        nType = AllEnum.AnnType.SystemAnn
      }
      if self.tbTypeList[AllEnum.AnnType.SystemAnn] == nil then
        local list = {}
        table.insert(list, v)
        self.tbTypeList[AllEnum.AnnType.SystemAnn] = list
      else
        table.insert(self.tbTypeList[AllEnum.AnnType.SystemAnn], v)
      end
      local bIsRead = false
      if LocalData.GetLocalData("AnnouncementIsRead", tostring(v.Id)) == nil then
        bIsRead = false
      else
        bIsRead = LocalData.GetLocalData("AnnouncementIsRead", tostring(v.Id))
      end
      RedDotManager.SetValid(RedDotDefine.Announcement_Content, {
        AllEnum.AnnType.SystemAnn,
        v.Id
      }, not bIsRead)
      table.insert(self.tbCurAnnList, v.Id)
    end
  end
  for i = 0, listData.Other1.Length - 1 do
    local v = listData.Other1[i]
    if UTILS.CheckChannelList(v.Channel) and v.ContentUrl ~= "" then
      self.tbAnnBaseInfo[v.Id] = {
        info = v,
        nType = AllEnum.AnnType.Other1
      }
      if self.tbTypeList[AllEnum.AnnType.Other1] == nil then
        local list = {}
        table.insert(list, v)
        self.tbTypeList[AllEnum.AnnType.Other1] = list
      else
        table.insert(self.tbTypeList[AllEnum.AnnType.Other1], v)
      end
      local bIsRead = false
      if LocalData.GetLocalData("AnnouncementIsRead", tostring(v.Id)) == nil then
        bIsRead = false
      else
        bIsRead = LocalData.GetLocalData("AnnouncementIsRead", tostring(v.Id))
      end
      RedDotManager.SetValid(RedDotDefine.Announcement_Content, {
        AllEnum.AnnType.Other1,
        v.Id
      }, not bIsRead)
    end
    table.insert(self.tbCurAnnList, v.Id)
  end
  for i = 0, listData.Other2.Length - 1 do
    local v = listData.Other2[i]
    if UTILS.CheckChannelList(v.Channel) and v.ContentUrl ~= "" then
      self.tbAnnBaseInfo[v.Id] = {
        info = v,
        nType = AllEnum.AnnType.Other2
      }
      if self.tbTypeList[AllEnum.AnnType.Other2] == nil then
        local list = {}
        table.insert(list, v)
        self.tbTypeList[AllEnum.AnnType.Other2] = list
      else
        table.insert(self.tbTypeList[AllEnum.AnnType.Other2], v)
      end
      local bIsRead = false
      if LocalData.GetLocalData("AnnouncementIsRead", tostring(v.Id)) == nil then
        bIsRead = false
      else
        bIsRead = LocalData.GetLocalData("AnnouncementIsRead", tostring(v.Id))
      end
      RedDotManager.SetValid(RedDotDefine.Announcement_Content, {
        AllEnum.AnnType.Other2,
        v.Id
      }, not bIsRead)
    end
    table.insert(self.tbCurAnnList, v.Id)
  end
  if self.requestAllDataCallback then
    self.requestAllDataCallback()
    self.requestAllDataCallback = nil
  end
  self.bLoadAllData = false
  EventManager.Hit("AnnAllDataReady")
end

function GameAnnouncementData:AllAnnResponse_Fail()
  if self.requestAllDataCallback then
    self.requestAllDataCallback()
    self.requestAllDataCallback = nil
  end
  self.bLoadAllData = false
end

function GameAnnouncementData:AnnContentResponse(nId, content)
  self.tbAnnContentCache[nId] = content
  EventManager.Hit("AnnContentReady", nId)
end

function GameAnnouncementData:SendAllDataQuest(callback_success)
  if self.bLoadAllData then
    return
  end
  self.bLoadAllData = true
  self.requestAllDataCallback = callback_success
  CS.HttpNetworkManager:RequestAllAnnData()
end

function GameAnnouncementData:SendAnnContentQuest(nId)
  local annInfo = self.tbAnnBaseInfo[nId]
  CS.HttpNetworkManager.RequestAnnContent(nId, annInfo.info.ContentUrl)
end

function GameAnnouncementData:GetHtmlFrame()
  local htmlFrame = ConfigTable.GetData("HtmlConfig", htmlConfigId)
  if htmlFrame ~= nil then
    return htmlFrame.HtmlFrame
  end
  return ""
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

function GameAnnouncementData:IsSameDay(stampA, stampB, resetHour)
  resetHour = resetHour or 5
  local resetSeconds = resetHour * 3600
  stampA = stampA - resetSeconds
  stampB = stampB - resetSeconds
  stampA = math.max(stampA, 0)
  stampB = math.max(stampB, 0)
  local dateA = GetCurrentYearInfo(stampA)
  local dateB = GetCurrentYearInfo(stampB)
  return dateA.day == dateB.day and dateA.month == dateB.month and dateA.year == dateB.year
end

function GameAnnouncementData:IsSameWeek(stampA, stampB, resetHour)
  resetHour = resetHour or 5
  local resetSeconds = resetHour * 3600
  stampA = stampA - resetSeconds
  stampB = stampB - resetSeconds
  stampA = math.max(stampA, 0)
  stampB = math.max(stampB, 0)
  local dateA = GetCurrentYearInfo(stampA)
  local dateB = GetCurrentYearInfo(stampB)
  return dateA.weekIdx == dateB.weekIdx and dateA.year == dateB.year
end

return GameAnnouncementData
