_class("UISeasonCollageData", Object)
UISeasonCollageData = UISeasonCollageData

function UISeasonCollageData:Constructor(seasonID)
  self._seasonID = seasonID
  self._collections = {}
  self._cgs = {}
  self._musics = {}
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._bookModule = GameGlobal.GetModule(BookModule)
  local prefix = GameGlobal.GetModule(RoleModule):GetPstId() .. "_" .. self._seasonID .. "_"
  self._collectionKey = prefix .. "_Collection_"
  self._cgKey = prefix .. "_CG_"
  self._musicKey = prefix .. "_Music_"
  self:_InitCollections()
  self:_InitCGs()
  self:_InitMusic()
end

function UISeasonCollageData:_InitCollections()
  local cfgs = Cfg.cfg_item_season_collection({
    SeasonID = self._seasonID
  })
  if not cfgs or #cfgs == 0 then
    Log.error("cfg_item_season_collection中不包含赛季:", self._seasonID)
    return
  end
  for i, cfg in ipairs(cfgs) do
    local id = cfg.ID
    local c = UISeasonCollageData_Collection:New()
    c._Index = i
    c._ID = id
    self._collections[i] = c
  end
  self:FlushCollection()
end

function UISeasonCollageData:_InitCGs()
  local cfgs = Cfg.cfg_cg_book({
    Type = BookCGType.Season,
    SeasonID = self._seasonID
  })
  if not cfgs or #cfgs == 0 then
    Log.error("cfg_cg_book中不包含赛季数据:", self._seasonID)
    return
  end
  for i, cfg in ipairs(cfgs) do
    local id = cfg.ID
    local cg = UISeasonCollageData_CG:New(id)
    cg._Index = i
    cg._ID = id
    self._cgs[i] = cg
  end
  self:FlushCG()
  table.sort(self._cgs, function(a, b)
    return a._ID < b._ID
  end)
  for i, c in ipairs(self._cgs) do
    c._Index = i
  end
end

function UISeasonCollageData:_InitMusic()
  local cfgs = Cfg.cfg_role_music({
    Tag = 5,
    SeasonID = self._seasonID
  })
  if not cfgs or #cfgs == 0 then
    Log.error("cfg_role_music中不包含赛季数据:", self._seasonID)
    return
  end
  for i, cfg in ipairs(cfgs) do
    local id = cfg.ID
    local music = UISeasonCollageData_Music:New(id)
    music._Index = i
    music._ID = id
    self._musics[i] = music
  end
  self:FlushMusic()
  table.sort(self._musics, function(a, b)
    return a._ID < b._ID
  end)
  for i, c in ipairs(self._musics) do
    c._Index = i
  end
end

function UISeasonCollageData:GetSeasonID()
  return self._seasonID
end

function UISeasonCollageData:CollageHasNew()
  if self:CollectionHasNew() or self:CGHasNew() or self:MusicHasNew() then
    return true
  end
  return false
end

function UISeasonCollageData:GetTotalGotCount()
  local count1, total1 = self:GetCollectionProgress()
  local count2, total2 = self:GetCgProgress()
  local count3, total3 = self:GetMusicProgress()
  return count1 + count2 + count3
end

function UISeasonCollageData:FlushAllCollages()
  self:FlushCollection()
  self:FlushCG()
  self:FlushMusic()
end

function UISeasonCollageData:CollectionCancelNew(data)
  local id = data._ID
  if not data._IsNew then
    Log.error("收藏品没有new标记,无法取消:", id)
    return
  end
  if data then
    LocalDB.SetInt(self._collectionKey .. id, 1)
    data._IsNew = nil
  end
end

function UISeasonCollageData:CollectionHasNew()
  for i, c in ipairs(self._collections) do
    if c._IsNew then
      return true
    end
  end
  return false
end

function UISeasonCollageData:GetCollectionCount()
  return #self._collections
end

function UISeasonCollageData:GetCollectionByIndex(index)
  return self._collections[index]
end

function UISeasonCollageData:FlushCollection()
  local finalStoryQuestId
  local seasonClientCfg = Cfg.cfg_season_campaign_client[self._seasonID]
  if seasonClientCfg then
    finalStoryQuestId = seasonClientCfg.FinalStoryQuestID
  end
  local needSetUsedList = {}
  for i, c in ipairs(self._collections) do
    local id = c._ID
    c._IsGot = false
    local items = self._itemModule:GetItemByTempId(id)
    if items and table.count(items) > 0 then
      c._IsGot = true
    end
    c._IsComposeUsed = false
    c._IsFinalPlotItem = false
    c._IsNew = false
    if c._IsGot then
      local item
      for key, value in pairs(items) do
        item = value
        break
      end
      c._GetTime = item:GetGainTime()
      c._IsNew = LocalDB.GetInt(self._collectionKey .. id, 0) == 0
      local cfg = Cfg.cfg_item_season_collection[id]
      local composeBy = cfg.ComposeBy
      if composeBy and 0 < #composeBy then
        table.appendArray(needSetUsedList, composeBy)
      end
      local composeQuestID = cfg.ComposeQuestID
      if composeQuestID and finalStoryQuestId and finalStoryQuestId == composeQuestID then
        c._IsFinalPlotItem = true
      end
    end
    self._collections[i] = c
  end
  for comIndex, useID in ipairs(needSetUsedList) do
    for index, data in ipairs(self._collections) do
      if data._ID == useID then
        data._IsComposeUsed = true
        break
      end
    end
  end
  table.sort(self._collections, function(a, b)
    local aWeight = 0
    local bWeight = 0
    if a:IsGot() then
      if a:IsFinalPlotItem() then
        aWeight = 4
      elseif a:IsComposeUsed() then
        aWeight = 2
      else
        aWeight = 3
      end
    end
    if b:IsGot() then
      if b:IsFinalPlotItem() then
        bWeight = 4
      elseif b:IsComposeUsed() then
        bWeight = 2
      else
        bWeight = 3
      end
    end
    if aWeight == bWeight then
      return a:ID() < b:ID()
    else
      return aWeight > bWeight
    end
  end)
  for i, c in ipairs(self._collections) do
    c._Index = i
  end
end

function UISeasonCollageData:RefreshCgShareState(cpt)
  for i, cg in ipairs(self._cgs) do
    cg._CanShare = false
    if cg._Valid and cg._IsUnlock and cpt then
      local cfg = Cfg.cfg_cg_book[cg._ID]
      if cfg.SeasonShareStoryID and not cpt:IsStoryReceived(cfg.SeasonShareStoryID) then
        cg._CanShare = true
        local storyCfg = Cfg.cfg_campaign_story[cfg.SeasonShareStoryID]
        cg._ShareAwardCount = storyCfg.RewardList[1][2]
      end
    end
  end
end

function UISeasonCollageData:CGCancelNew(data)
  local id = data._ID
  if not data._IsNew then
    Log.error("cg没有new标记,无法取消:", id)
    return
  end
  if data then
    LocalDB.SetInt(self._cgKey .. id, 1)
    data._IsNew = nil
  end
end

function UISeasonCollageData:CGHasNew()
  for i, cg in ipairs(self._cgs) do
    if cg._IsNew then
      return true
    end
  end
  return false
end

function UISeasonCollageData:GetCGCount()
  return #self._cgs
end

function UISeasonCollageData:GetCGByIndex(index)
  return self._cgs[index]
end

function UISeasonCollageData:FlushCG()
  local now = GetSvrTimeNow()
  for i, cg in ipairs(self._cgs) do
    local id = cg._ID
    local cfg = Cfg.cfg_cg_book[id]
    cg._Valid = true
    if cfg.UnlockTime then
      cg._Valid = now > cfg.UnlockTime
    end
    if cg._Valid then
      local k, isUnlock = self._bookModule:GetSeasonStory(cfg)
      cg._IsUnlock = isUnlock
    end
    if cg._IsUnlock then
      cg._IsNew = LocalDB.GetInt(self._cgKey .. id, 0) == 0
    end
  end
end

function UISeasonCollageData:MusicCancelNew(data)
  local id = data._ID
  if not data._IsNew then
    Log.error("cg没有new标记,无法取消:", id)
    return
  end
  if data then
    LocalDB.SetInt(self._musicKey .. id, 1)
    data._IsNew = nil
  end
end

function UISeasonCollageData:MusicHasNew()
  for i, music in ipairs(self._musics) do
    if music._IsNew then
      return true
    end
  end
  return false
end

function UISeasonCollageData:GetMusicCount()
  return #self._musics
end

function UISeasonCollageData:GetMusicByIndex(index)
  return self._musics[index]
end

function UISeasonCollageData:GetCollectionProgress()
  local obtainedCount = 0
  local totalCount = self:GetCollectionCount()
  for i = 1, totalCount do
    local c = self:GetCollectionByIndex(i)
    if c:IsGot() then
      obtainedCount = obtainedCount + 1
    end
  end
  return obtainedCount, totalCount
end

function UISeasonCollageData:GetCgProgress()
  local obtainedCount = 0
  local totalCount = self:GetCGCount()
  for i = 1, totalCount do
    local cg = self:GetCGByIndex(i)
    if cg:IsUnlock() then
      obtainedCount = obtainedCount + 1
    end
  end
  return obtainedCount, totalCount
end

function UISeasonCollageData:GetMusicProgress()
  local obtainedCount = 0
  local totalCount = self:GetMusicCount()
  for i = 1, totalCount do
    local music = self:GetMusicByIndex(i)
    if music:IsUnlock() then
      obtainedCount = obtainedCount + 1
    end
  end
  return obtainedCount, totalCount
end

function UISeasonCollageData:FlushMusic()
  local now = GetSvrTimeNow()
  for i, music in ipairs(self._musics) do
    local id = music._ID
    local cfg = Cfg.cfg_role_music[id]
    music._Valid = true
    if cfg.UnlockTime then
      music._Valid = now > music.UnlockTime
    end
    if music._Valid then
      music._IsUnlock = true
      if cfg.LockCondition then
        music._IsUnlock = not self._roleModule:UI_CheckMusicLock(cfg.LockCondition)
      end
    end
    if music._IsUnlock then
      music._IsNew = LocalDB.GetInt(self._musicKey .. id, 0) == 0
    end
  end
end
