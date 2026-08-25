local ArtCollectionModel = NewClass("ArtCollectionModel", BaseModel)

function ArtCollectionModel:OnInit()
  self:OnReset()
  self:InitBaseShowData()
end

function ArtCollectionModel:OnReset()
  self:ResetMusicTime()
end

function ArtCollectionModel:ResetMusicTime()
  self.playingMusicId = nil
  self.curPlayingTime = nil
  self.musicPauseTime = nil
  self.startPlayingTime = nil
end

function ArtCollectionModel:InitBaseShowData()
  local collectDatas = {}
  for cfgId, cfg in pairs(DT.CollectionHall) do
    local collectType = cfg.CollectionType
    local subCollect = collectDatas[collectType]
    if nil == subCollect then
      subCollect = {}
      collectDatas[collectType] = subCollect
    end
    local groupId = cfg.CollectionGroup or cfgId
    local groupData
    for _, checkData in ipairs(subCollect) do
      if checkData.groupId == groupId then
        groupData = checkData
        break
      end
    end
    if nil == groupData then
      groupData = {
        groupId = groupId,
        list = {}
      }
      table.insert(subCollect, groupData)
    end
    if nil ~= cfg.CollectionGroup then
      table.insert(groupData.list, cfgId)
    end
  end
  self.collectDatas = collectDatas
  self.id2Collection = {}
end

function ArtCollectionModel:UpdateACData(data)
  if data then
    for cfgId, itemData in pairs(data) do
      self.id2Collection[cfgId] = itemData
    end
  end
end

function ArtCollectionModel:UpdateItemUnlocked(cfgId, isItemUnlocked)
  print("------------------UpdateItemUnlocked", cfgId, isItemUnlocked, table.tostring(self.id2Collection[cfgId]))
  local collectData = self.id2Collection[cfgId]
  if collectData then
    collectData.itemUnlock = isItemUnlocked
    self:Notify(NotifyId.CollectionItemUnlocked, cfgId)
    ArtCollectionRewardModel.Instance:UpdateTaskData()
    self:SetLoadingVideos()
  end
end

function ArtCollectionModel:GetGroupCfgId(collectType)
  local subDatas = self.collectDatas[collectType]
  return subDatas and subDatas.groupId
end

function ArtCollectionModel:GetCollectDatas()
  return self.collectDatas
end

function ArtCollectionModel:GetSubCollectDatasByFeature(featureId, key)
  do return ArtCollectionController.Instance.GetSubCollectDatasByFeature, ArtCollectionController.Instance, featureId end
  return ArtCollectionController.Instance.GetSubCollectDatasByFeature, ArtCollectionController.Instance, featureId, key or 0
end

function ArtCollectionModel:GetSubCollectDatas(collectType)
  local subCollect = self.collectDatas[collectType]
  return subCollect or {}
end

function ArtCollectionModel:SetCollectServerData(data)
  if data and data.id2Collection then
    local id2Collection = {}
    for id, collData in pairs(data.id2Collection) do
      if DT.CollectionHall[id] then
        id2Collection[id] = collData
      else
        Logger.Warn("找不到配置:" .. id)
      end
    end
    self.id2Collection = id2Collection
  end
  self:SetLoadingVideos()
end

function ArtCollectionModel:SetLoadingVideos()
  local gameUpdateVideos = MobileFileDataManager.Instance:GetCommFileValue("GameUpdateVoideos", {})
  local gameUpdateAudios = MobileFileDataManager.Instance:GetCommFileValue("GameUpdateAudios", {})
  for id, data in pairs(self.id2Collection) do
    if data.unlock then
      local cfg = self:GetCfg(id)
      if cfg and cfg.Video then
        local videoName, audioName = self:GetVideoAndAudioFromAvg(cfg.Video)
        if videoName and not table.contains(gameUpdateVideos, videoName) then
          table.insert(gameUpdateVideos, videoName)
          if audioName then
            gameUpdateAudios[videoName] = audioName
          end
        end
      end
    end
  end
  MobileFileDataManager.Instance:SetCommFileValue("GameUpdateVideos", gameUpdateVideos, false)
  MobileFileDataManager.Instance:SetCommFileValue("GameUpdateAudios", gameUpdateAudios, false)
  MobileFileDataManager.Instance:OnSaveCommInfo()
end

function ArtCollectionModel:SetPlayingMusic(musicId)
  self:ResetMusicTime()
  self.playingMusicId = musicId
  if musicId then
    self.startPlayingTime = TimerManager.totalTime
  else
    self.startPlayingTime = nil
  end
  self:Notify(NotifyId.OSTMusicChange)
end

function ArtCollectionModel:SetMusicPause(isPause)
  if not self.startPlayingTime then
    return
  end
  local curTime = TimerManager.totalTime
  if isPause then
    self.curPlayingTime = (self.curPlayingTime or 0) + curTime - self.startPlayingTime
    AudioManager.Instance:PostSoundEvent("Pause_Mus")
  else
    self.startPlayingTime = curTime
    AudioManager.Instance:PostSoundEvent("Resume_Mus")
  end
  self.musicPauseTime = isPause and curTime or nil
  self:Notify(NotifyId.OSTMusicChange)
end

function ArtCollectionModel:GetVideoAndAudioFromAvg(avgId)
  local avgCfg = DT.AvgDialog[avgId]
  if avgCfg then
    local data = avgCfg.data_list and avgCfg.data_list[1]
    local videoName
    if data.Sequence then
      local pattern = "PlayVideo%(([^,]+),"
      videoName = string.match(data.Sequence, pattern)
    end
    local audioName = data.ShortAudioEffect[1]
    return videoName, audioName
  end
end

function ArtCollectionModel:GetGroupCfgId(collectType)
  local subDatas = self.collectDatas[collectType]
  return subDatas and subDatas.groupId
end

function ArtCollectionModel:GetSubCollectDatas(collectType)
  local subCollect = self.collectDatas[collectType]
  return subCollect or {}
end

function ArtCollectionModel:GetBgCfgId()
  return PlayerDataUtils.GetBgCfgId() or DT.GetConstant("DefaultDormitoryBgTid")
end

function ArtCollectionModel:GetBgActivityDefine()
  local cfgId = self:GetBgCfgId()
  local cfg = self:GetCfg(cfgId)
  if not cfg or not cfg.ActivityType then
    return
  end
  local activityDefine = ActivityDefine.ActivityCompClsInfo[cfg.ActivityType]
  if not activityDefine or not activityDefine.resPath then
    return
  end
  return activityDefine
end

function ArtCollectionModel:GetCfg(tid)
  if not tid then
    return
  end
  return DT.CollectionHall[tid]
end

function ArtCollectionModel:GetPictureByActivity(activityTid)
  local activityCfg = DT.Activity[activityTid]
  if not activityCfg then
    return
  end
  for _, cfg in pairs(DT.CollectionHall) do
    if cfg.ActivityType == activityCfg.ActivityType then
      return cfg.Picture
    end
  end
end

function ArtCollectionModel:GetCfgByField(field, tid)
  local config = self:GetCfg(tid)
  if not config then
    return
  end
  return config[field]
end

function ArtCollectionModel:GetDomitoryBg()
  local bgTid = self:GetBgCfgId()
  if bgTid then
    local cfg = self:GetCfg(bgTid)
    if cfg and cfg.Picture then
      return cfg.Picture
    end
  end
end

function ArtCollectionModel:GetTrinketCollectionTidList()
  local collectDatas = self:GetSubCollectDatasByFeature(CommonDefine.FeatureId.CollectionTrinket)
  return collectDatas and collectDatas[1] and collectDatas[1].list or {}
end

function ArtCollectionModel:GetWeaponCollectionTidList()
  local collectDatas = self:GetSubCollectDatasByFeature(CommonDefine.FeatureId.CollectionWeapon)
  return collectDatas and collectDatas[1] and collectDatas[1].list or {}
end

function ArtCollectionModel:GetRelicCollectionTidList()
  local collectDatas = self:GetSubCollectDatasByFeature(CommonDefine.FeatureId.CollectionRelic)
  return collectDatas and collectDatas[1] and collectDatas[1].list or {}
end

function ArtCollectionModel:GetEventCollectionTidList()
  local collectDatas = self:GetSubCollectDatasByFeature(CommonDefine.FeatureId.CollectionEvent)
  return collectDatas and collectDatas[1] and collectDatas[1].list or {}
end

function ArtCollectionModel:GetStoryCollectionTidList()
  local collectDatas = self:GetSubCollectDatasByFeature(CommonDefine.FeatureId.CollectionStory, CommonDefine.WorldStorySubFeature.History)
  return collectDatas and collectDatas[1] and collectDatas[1].list or {}
end

function ArtCollectionModel:GetAllOstData()
  local ostFeature = CommonDefine.FeatureId.CollectionOST
  do return self.GetSubCollectDatasByFeature, self end
  return self.GetSubCollectDatasByFeature, self, ostFeature
end

function ArtCollectionModel:GetTotalOstProgress()
  local allOstData = self:GetAllOstData()
  local unlockedCount, totalCount = 0, 0
  for _, data in pairs(allOstData) do
    local unlockedOstCount, totalOstCount = self:GetOstProgress(data)
    unlockedCount = unlockedCount + unlockedOstCount
    totalCount = totalCount + totalOstCount
  end
  return unlockedCount, totalCount
end

function ArtCollectionModel:GetOstProgress(ostData)
  local totalCount = #ostData.list
  local unlockedCount = 0
  for _, id in ipairs(ostData.list) do
    if self:IsUnlock(id) and self:IsItemUnlocked(id) then
      unlockedCount = unlockedCount + 1
    end
  end
  return unlockedCount, totalCount
end

function ArtCollectionModel:GetPlayingMusic()
  return self.playingMusicId
end

function ArtCollectionModel:GetStartPlayingTime()
  return self.startPlayingTime
end

function ArtCollectionModel:GetCurPlayingTime()
  if not self.startPlayingTime then
    return 0
  end
  if not self.curPlayingTime then
    return TimerManager.totalTime - self.startPlayingTime
  end
  return self.curPlayingTime
end

function ArtCollectionModel:IsUnlock(cfgId)
  if GmClientUtils.isUnlockAllCg then
    return true
  end
  local collectData = self.id2Collection[cfgId]
  local cfg = DT.CollectionHall[cfgId]
  if cfg.CollectionDisplayDate and TimeUtils.GetServerTime() < cfg.CollectionDisplayDate then
    return false
  end
  return collectData and collectData.unlock or false
end

function ArtCollectionModel:IsItemUnlocked(cfgId)
  if GmClientUtils.isUnlockAllCg then
    return true
  end
  local collectData = self.id2Collection[cfgId] or {}
  if collectData.itemUnlock then
    return true
  end
  local collectCfg = self:GetCfg(cfgId)
  if collectCfg.UnlockConsume and not collectData.itemUnlock then
    return false
  end
  return true
end

function ArtCollectionModel:IsBg(cfgId)
  return self:GetBgCfgId() == cfgId
end

function ArtCollectionModel:IsAllowShowAwaker(tid)
  local cfg = self:GetCfg(tid)
  if not cfg then
    return true
  end
  return cfg.CollectionType == DT.GetConstant("ShowAwakerCgType")
end

function ArtCollectionModel:GetMusicPauseTime()
  return self.musicPauseTime
end

function ArtCollectionModel:IsMusicPause()
  return self.musicPauseTime ~= nil
end

return ArtCollectionModel
