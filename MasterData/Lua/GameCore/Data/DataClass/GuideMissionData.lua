local GuideMissionData = class("GuideMissionData")

function GuideMissionData:Init()
  self.tbChapter = {}
  self.tbServerUnlockTime = {}
  self:InitConfig()
end

function GuideMissionData:CacheServerUnlockTime(nChapterId, nUnlockTime)
  self.tbServerUnlockTime[nChapterId] = nUnlockTime
end

function GuideMissionData:UnInit()
end

function GuideMissionData:InitConfig()
  local function forEachChapter(mapData)
    table.insert(self.tbChapter, mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("GuideMissionChapter"), forEachChapter)
  table.sort(self.tbChapter, function(a, b)
    return a.Id < b.Id
  end)
end

function GuideMissionData:GetChapterList()
  return self.tbChapter
end

function GuideMissionData:IsChapterUnlock(nChapterId)
  local mapChapter
  for _, v in ipairs(self.tbChapter) do
    if v.Id == nChapterId then
      mapChapter = v
      break
    end
  end
  if mapChapter == nil then
    return false, nil
  end
  local unlockTime = self.tbServerUnlockTime[mapChapter.Id]
  if unlockTime == nil then
    unlockTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapChapter.UnlockTime)
  end
  if unlockTime ~= nil and 0 < unlockTime then
    local nServerTimeStamp = CS.ClientManager.Instance.serverTimeStamp
    if unlockTime > nServerTimeStamp then
      local remainTime = unlockTime - nServerTimeStamp
      return false, self:GetChapterUnlockTimeText(remainTime)
    end
  end
  if mapChapter.PreChapterId ~= nil and mapChapter.PreChapterId ~= 0 and not self:IsChapterComplete(mapChapter.PreChapterId) then
    return false, orderedFormat(ConfigTable.GetUIText("Guide_Mission_PreChapter_UnComplete") or "", mapChapter.PreChapterId)
  end
  local storyConfig = ConfigTable.GetData_Story(mapChapter.StoryIdx)
  if storyConfig ~= nil then
    local bStoryReaded = PlayerData.Avg:IsStoryReaded(storyConfig.Id)
    if not bStoryReaded then
      return false, orderedFormat(ConfigTable.GetUIText("Story_UnlockPreId") or "", storyConfig.Title)
    end
  end
  return true, nil
end

function GuideMissionData:GetChapterUnlockTimeText(remainTime)
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    return orderedFormat(ConfigTable.GetUIText("GuideMission_UnlockTime_Sec") or "", "08d3d4", sec)
  elseif remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    return orderedFormat(ConfigTable.GetUIText("GuideMission_UnlockTime_Min") or "", "08d3d4", min)
  elseif remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    return orderedFormat(ConfigTable.GetUIText("GuideMission_UnlockTime_Hour") or "", "08d3d4", hour)
  else
    local day = math.floor(remainTime / 86400)
    return orderedFormat(ConfigTable.GetUIText("GuideMission_UnlockTime_Day") or "", "08d3d4", day)
  end
end

function GuideMissionData:IsChapterComplete(nChapterId)
  local tbGroupList = PlayerData.Quest:GetGuideMissionQuestGroupByChapter(nChapterId)
  if tbGroupList == nil or next(tbGroupList) == nil then
    return false
  end
  for _, mapGroup in pairs(tbGroupList) do
    local tbQuestList = PlayerData.Quest:GetGuideMissionQuestListByGroup(mapGroup.Id)
    if tbQuestList == nil or next(tbQuestList) == nil then
      return false
    end
    for _, mapQuest in pairs(tbQuestList) do
      local mapQuestData = PlayerData.Quest:GetGuideMissionQuestDataById(mapQuest.Id)
      local nStatus = mapQuestData ~= nil and mapQuestData.nStatus or 0
      if nStatus ~= 2 then
        return false
      end
    end
  end
  return true
end

function GuideMissionData:HasReceivableQuest(nGroupId)
  local tbQuestList = PlayerData.Quest:GetGuideMissionQuestListByGroup(nGroupId)
  if tbQuestList == nil then
    return false
  end
  for _, mapQuest in pairs(tbQuestList) do
    local mapQuestData = PlayerData.Quest:GetGuideMissionQuestDataById(mapQuest.Id)
    if mapQuestData ~= nil and mapQuestData.nStatus == 1 then
      return true
    end
  end
  return false
end

function GuideMissionData:FindReceivableChapter()
  for _, mapChapter in ipairs(self.tbChapter) do
    local bChapterUnlock = self:IsChapterUnlock(mapChapter.Id)
    if bChapterUnlock then
      local tbGroupListRef = PlayerData.Quest:GetGuideMissionQuestGroupByChapter(mapChapter.Id)
      if tbGroupListRef ~= nil then
        for _, mapGroup in pairs(tbGroupListRef) do
          local bGroupUnlock = self:IsGroupUnlock(mapChapter.Id, mapGroup.Id)
          if bGroupUnlock and self:HasReceivableQuest(mapGroup.Id) then
            return mapChapter.Id
          end
        end
      end
    end
  end
  return nil
end

function GuideMissionData:IsGroupUnlock(nChapterId, nGroupId)
  local mapChapter
  for _, v in ipairs(self.tbChapter) do
    if v.Id == nChapterId then
      mapChapter = v
      break
    end
  end
  if mapChapter == nil then
    return false
  end
  local mapGroup = ConfigTable.GetData("GuideMissionQuestGroup", nGroupId)
  if mapGroup == nil then
    return false
  end
  local unlockTime = self.tbServerUnlockTime[mapChapter.Id]
  if unlockTime == nil then
    unlockTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapChapter.UnlockTime)
  end
  if unlockTime == nil or unlockTime <= 0 then
    return true, 0
  end
  local nDayOpen = mapGroup.DayOpen or 0
  local nGroupUnlockTime = unlockTime
  for _i = 1, nDayOpen do
    nGroupUnlockTime = CS.ClientManager.Instance:GetNextRefreshTime(nGroupUnlockTime)
  end
  local nServerTimeStamp = CS.ClientManager.Instance.serverTimeStamp
  return nGroupUnlockTime <= nServerTimeStamp, nGroupUnlockTime
end

return GuideMissionData
