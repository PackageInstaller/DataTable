local PlayerStorySetData = class("PlayerStorySetData")

function PlayerStorySetData:Init()
  self.tbChapter = {}
  self.bGetData = false
  self:InitConfig()
end

function PlayerStorySetData:InitConfig()
  local function funcForeachSection(mapData)
    if nil == self.tbChapter[mapData.ChapterId] then
      self.tbChapter[mapData.ChapterId] = {}
      
      self.tbChapter[mapData.ChapterId].tbSectionList = {}
      self.tbChapter[mapData.ChapterId].bUnlock = false
    end
    table.insert(self.tbChapter[mapData.ChapterId].tbSectionList, {
      nId = mapData.Id,
      nSortId = mapData.SortId,
      nStatus = AllEnum.StorySetStatus.Lock
    })
  end
  
  ForEachTableLine(ConfigTable.Get("StorySetSection"), funcForeachSection)
  for _, v in pairs(self.tbChapter) do
    if v.tbSectionList ~= nil then
      table.sort(v.tbSectionList, function(a, b)
        return a.nId < b.nId
      end)
    end
  end
end

function PlayerStorySetData:UnInit()
end

function PlayerStorySetData:UpdateStorySetState(bState)
  RedDotManager.SetValid(RedDotDefine.Story_Set_Server, nil, bState)
end

function PlayerStorySetData:CacheStorySetData(netMsg)
  if netMsg.Chapters ~= nil then
    local nChapterId = -1
    for _, data in ipairs(netMsg.Chapters) do
      if self.tbChapter[data.ChapterId] ~= nil then
        self.tbChapter[data.ChapterId].bUnlock = true
        local nCurIndex = data.SectionIndex or 0
        nCurIndex = nCurIndex + 1
        local bShow = false
        local mapChapterCfg = ConfigTable.GetData("StorySetChapter", data.ChapterId)
        if mapChapterCfg ~= nil then
          bShow = mapChapterCfg.IsShow
        end
        for nIndex, v in ipairs(self.tbChapter[data.ChapterId].tbSectionList) do
          if nIndex <= nCurIndex then
            v.nStatus = AllEnum.StorySetStatus.UnLock
          end
          if 0 < table.indexof(data.RewardedIds, v.nId) then
            v.nStatus = AllEnum.StorySetStatus.Received
          end
          local mapCfg = ConfigTable.GetData("StorySetChapter", data.ChapterId)
          RedDotManager.SetValid(RedDotDefine.Story_Set_Section, {
            mapCfg.TabId,
            data.ChapterId,
            v.nId
          }, v.nStatus == AllEnum.StorySetStatus.UnLock and bShow)
        end
        local mapCfg = ConfigTable.GetData("StorySetChapter", data.ChapterId)
        local chapterHasRedDot = RedDotManager.GetValid(RedDotDefine.Story_Set_Chapter, {
          mapCfg.TabId,
          data.ChapterId
        })
        if chapterHasRedDot == true then
          if nChapterId < 0 then
            nChapterId = data.ChapterId
          else
            nChapterId = math.min(nChapterId, data.ChapterId)
          end
        end
        self:SetRecentChapterId(nChapterId)
      end
    end
  end
end

function PlayerStorySetData:UnlockNewChapter(nId)
  if self.tbChapter[nId] ~= nil then
    self.tbChapter[nId].bUnlock = true
    local bShow = false
    local mapCfg = ConfigTable.GetData("StorySetChapter", nId)
    if mapCfg ~= nil then
      bShow = mapCfg.IsShow
    end
    for k, v in ipairs(self.tbChapter[nId].tbSectionList) do
      if k == 1 then
        v.nStatus = AllEnum.StorySetStatus.UnLock
        RedDotManager.SetValid(RedDotDefine.Story_Set_Section, {
          mapCfg.TabId,
          nId,
          v.nId
        }, bShow)
        break
      end
    end
  end
end

function PlayerStorySetData:GetAllChapterList(nType, bOnlyShowUnRead)
  local tbChapter = {}
  local tabCfg = ConfigTable.GetData("StorySetTab", nType)
  for nId, v in pairs(self.tbChapter) do
    local mapCfg = ConfigTable.GetData("StorySetChapter", nId)
    if mapCfg ~= nil and mapCfg.IsShow and (mapCfg.TabId == nType or tabCfg.IsAll) then
      local bShow = true
      if bOnlyShowUnRead == true then
        local chapterHasRedDot = RedDotManager.GetValid(RedDotDefine.Story_Set_Chapter, {
          mapCfg.TabId,
          mapCfg.Id
        })
        if chapterHasRedDot ~= true then
          bShow = false
        end
      end
      if bShow == true then
        table.insert(tbChapter, {
          nId = nId,
          tbSectionList = v.tbSectionList,
          bUnlock = v.bUnlock
        })
      end
    end
  end
  table.sort(tbChapter, function(a, b)
    return a.nId < b.nId
  end)
  return tbChapter
end

function PlayerStorySetData:GetAllTabList()
  local tbTabData = {}
  
  local function foreachFunc(mapData)
    if mapData.IsShow == true then
      local openTime = mapData.OpenTime ~= "" and CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapData.OpenTime) or 0
      local curTime = CS.ClientManager.Instance.serverTimeStamp
      if openTime <= curTime then
        table.insert(tbTabData, mapData)
      end
    end
  end
  
  ForEachTableLine(ConfigTable.Get("StorySetTab"), foreachFunc)
  return tbTabData
end

function PlayerStorySetData:TryOpenStorySetPanel(callback)
  if not self.bGetData then
    self:SendGetStorySetData(callback)
  elseif callback ~= nil then
    callback()
  end
end

function PlayerStorySetData:SetRecentChapterId(chapterId)
  self.nRecentChapterId = chapterId
end

function PlayerStorySetData:GetRecentChapterId()
  return self.nRecentChapterId
end

function PlayerStorySetData:IsChapterUnlock(nChapterId)
  local mapCfg = ConfigTable.GetData("StorySetChapter", nChapterId)
  if mapCfg == nil then
    return false, ""
  end
  if not mapCfg.IsShow then
    return false, ConfigTable.GetUIText("StorySet_Chapter_Empty")
  end
  local chapter = self.tbChapter[nChapterId]
  if chapter == nil or not chapter.bUnlock then
    local sLockText = mapCfg.LockText ~= "" and mapCfg.LockText or ConfigTable.GetUIText("StorySet_Chapter_Lock")
    return false, sLockText
  end
  return true, ""
end

function PlayerStorySetData:IsChapterAllRead(nChapterId)
  if self.tbChapter[nChapterId] == nil then
    return false
  end
  local chapter = self.tbChapter[nChapterId]
  if not chapter.bUnlock then
    return false
  end
  if chapter.tbSectionList == nil or #chapter.tbSectionList == 0 then
    return false
  end
  for _, section in ipairs(chapter.tbSectionList) do
    if section.nStatus ~= AllEnum.StorySetStatus.Received then
      return false
    end
  end
  return true
end

function PlayerStorySetData:SendGetStorySetData(callback)
  local function func_cb(_, netMsg)
    RedDotManager.SetValid(RedDotDefine.Story_Set_Server, nil, false)
    
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.story_set_info_req, {}, nil, func_cb)
end

function PlayerStorySetData:ReceiveStorySetReward(nChapterId, nSectionId, callback)
  local function func_cb(_, netMsg)
    if self.tbChapter[nChapterId] ~= nil then
      local nIndex = 0
      
      for k, v in ipairs(self.tbChapter[nChapterId].tbSectionList) do
        if v.nId == nSectionId then
          nIndex = k
          break
        end
      end
      if nIndex ~= 0 then
        self.tbChapter[nChapterId].tbSectionList[nIndex].nStatus = AllEnum.StorySetStatus.Received
        local mapCfg = ConfigTable.GetData("StorySetChapter", nChapterId)
        RedDotManager.SetValid(RedDotDefine.Story_Set_Section, {
          mapCfg.TabId,
          nChapterId,
          nSectionId
        }, false)
        nIndex = nIndex + 1
      end
      if nIndex <= #self.tbChapter[nChapterId].tbSectionList then
        self.tbChapter[nChapterId].tbSectionList[nIndex].nStatus = AllEnum.StorySetStatus.UnLock
        local bShow = false
        local mapCfg = ConfigTable.GetData("StorySetChapter", nChapterId)
        if mapCfg ~= nil then
          bShow = mapCfg.IsShow
        end
        local nId = self.tbChapter[nChapterId].tbSectionList[nIndex].nId
        local mapCfg = ConfigTable.GetData("StorySetChapter", nChapterId)
        RedDotManager.SetValid(RedDotDefine.Story_Set_Section, {
          mapCfg.TabId,
          nChapterId,
          nId
        }, bShow)
      end
    end
    if callback ~= nil then
      callback(netMsg)
    end
    self:SetRecentChapterId(nChapterId)
    EventManager.Hit("ReceiveStorySetRewardSuc")
  end
  
  local msg = {ChapterId = nChapterId, SectionId = nSectionId}
  local tabEvent = {}
  table.insert(tabEvent, {
    "story_id",
    tostring(nSectionId)
  })
  local _skip = PlayerData.Avg.bSkip == true and "1" or "0"
  table.insert(tabEvent, {"is_skip", _skip})
  table.insert(tabEvent, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  NovaAPI.UserEventUpload("set_story", tabEvent)
  HttpNetHandler.SendMsg(NetMsgId.Id.story_set_reward_receive_req, msg, nil, func_cb)
end

return PlayerStorySetData
