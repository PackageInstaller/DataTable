local PlayerDataUtils = {}
local KeyFeatureMap, KeyFeatureCfgMap

function PlayerDataUtils.RestAll()
  DataCenter.playerData.DRole.uid = 0
end

function PlayerDataUtils.ResetDaily()
  DataCenter.playerData.statsData.daily = {}
end

function PlayerDataUtils.InitBaseData(baseServerData)
  if not baseServerData then
    return
  end
  for k, v in pairs(baseServerData) do
    DataCenter.playerData.DRole[k] = v
  end
end

function PlayerDataUtils.InitFeatureUnlockDataBySvrData(featureServerData)
  if not featureServerData then
    return
  end
  for tid, v in pairs(featureServerData) do
    if type(v) == "table" then
      for typeKey, unlockData in pairs(v) do
        local unlock = not unlockData.lock
        local show = not unlockData.notShow
        PlayerDataUtils.UpdateFeatureUnlock(tid, typeKey, unlock, show)
      end
    end
  end
end

function PlayerDataUtils.IsPassedFinalStage()
  local savedPlayerUid = MobileFileDataManager.Instance:GetCommFileValue("playerUid")
  local savedFinalStagePlayerUid = MobileFileDataManager.Instance:GetCommFileValue("finalStagePlayerUid")
  return savedPlayerUid and savedFinalStagePlayerUid and savedPlayerUid == savedFinalStagePlayerUid
end

function PlayerDataUtils.SavePassedFinalStage()
  MobileFileDataManager.Instance:SetCommFileValue("finalStagePlayerUid", PlayerDataUtils.GetPlayerUid(), true)
end

function PlayerDataUtils.GetAccountLevelCfgByLevel(level)
  for _, cfg in pairs(DT.AcountLevelConfig) do
    if cfg.Level == level then
      return cfg
    end
  end
  return nil
end

function PlayerDataUtils.GetAccountLevelConfig(tid)
  if not tid then
    return
  end
  return DT.AcountLevelConfig[tid]
end

function PlayerDataUtils.IsInAprileFool()
  if not IntroductionDataUtils.IsFinish() then
    return false
  end
  local range = DT.GetOriginalConstant(CommonDefine.AvatarReplacementTimeRangeKey)
  if not range or type(range) ~= "table" or #range < 2 then
    return false
  end
  local now = TimeUtils.GetServerTime()
  return now >= (range[1] or 0) and now <= (range[2] or 0)
end

function PlayerDataUtils.GetAprileFoolReplaceItem()
  do return DT.GetConstant, CommonDefine.AvatarReplacementItemIdKey end
  return DT.GetConstant, CommonDefine.AvatarReplacementItemIdKey, 78731
end

function PlayerDataUtils.GetAprileFoolReplaceMapAvatarRes()
  do return DT.GetConstant, "HeadFoolsDay" end
  return DT.GetConstant, "HeadFoolsDay", "MUnit/MUnit_02/Role/MUnit_Role_002/Texture/MScene_002_Role.png"
end

function PlayerDataUtils.GetRoleHeadImg()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  if avatarItemTid and ItemDataUtils.IsAvatarItem(avatarItemTid) then
    do return ItemDataUtils.GetAvatarIcon end
    return ItemDataUtils.GetAvatarIcon, avatarItemTid
  end
  do return end
  return GenderDataUtils.GetMainCharacterAvatarRes, avatarItemTid
end

function PlayerDataUtils.GetRoleHeadFrameImg()
  local frameItemTid = PlayerDataUtils.GetDRoleByField("avatarFrame")
  do return ItemDataUtils.GetItemIcon end
  return ItemDataUtils.GetItemIcon, frameItemTid
end

function PlayerDataUtils.GetExpBonusPercent()
  local expBonus = PlayerDataUtils.GetDRoleByField("expBonus") or 0
  do return math.floor end
  return math.floor, expBonus * 100
end

function PlayerDataUtils.GetBonusExpNum(withoutBonusNum)
  local expBonus = PlayerDataUtils.GetDRoleByField("expBonus") or 0
  do return math.ceil, withoutBonusNum * expBonus end
  return math.ceil, withoutBonusNum * expBonus, 0
end

function PlayerDataUtils.GetRoleData()
  return DataCenter.playerData.DRole
end

function PlayerDataUtils.GetRoleDayExpLimit()
  local hasActivity = ActivityManager.Instance:IsActivityOpenByType(ActivityDefine.ActivityType.DoubleExp)
  local cfgList = DT.GetOriginalConstant("PVPandDailyChallengeRewardLimit")
  local dayLimit = cfgList[2]
  local inDoubleExpActivity = hasActivity and CommonDefine.DoubleExpActivityTimes or 1
  return dayLimit * inDoubleExpActivity
end

function PlayerDataUtils.GetName()
  return DataCenter.playerData.DRole.name
end

function PlayerDataUtils.GetGender()
  return DataCenter.playerData.DRole.gender
end

function PlayerDataUtils.SetGender(numVal)
  if not numVal then
    return
  end
  DataCenter.playerData.DRole.gender = numVal
end

function PlayerDataUtils.GetOtherGender()
  local curGender = PlayerDataUtils.GetGender()
  return 1 == curGender and 2 or 1
end

function PlayerDataUtils.GetGenderStr(gender)
  gender = gender or DataCenter.playerData.DRole.gender
  return 1 == gender and DT.CommonID.Gender_Boy.ID or DT.CommonID.Gender_Girl.ID
end

function PlayerDataUtils.GetGenderName(gender)
  local genderId = PlayerDataUtils.GetGenderStr(gender)
  do return LT.Text end
  return LT.Text, DT.CommonID[genderId] and DT.CommonID[genderId].Desc or ""
end

function PlayerDataUtils.IsMale()
  return 1 == PlayerDataUtils.GetGender()
end

function PlayerDataUtils.GetDRoleByField(field)
  return DataCenter.playerData.DRole[field]
end

function PlayerDataUtils.GetHideReview()
  return DataCenter.playerData.hideReview
end

function PlayerDataUtils.SetHideReview(numVal)
  DataCenter.playerData.hideReview = numVal
end

function PlayerDataUtils.GetUsingEmojiList()
  return DataCenter.playerData.DRole.useEmojiList or {}
end

function PlayerDataUtils.SetUsingEmojiList(list)
  DataCenter.playerData.DRole.useEmojiList = list
end

function PlayerDataUtils.SetIcon(icon)
  if not icon then
    return
  end
  DataCenter.playerData.DRole.icon = icon
  SocialDataUtils.UpdateMyPlayerFacade({icon = icon})
end

function PlayerDataUtils.SetAccountName(strVal)
  DataCenter.playerData.accountName = strVal
end

function PlayerDataUtils.GetAccountName()
  return DataCenter.playerData.accountName
end

function PlayerDataUtils.SetRoleId(roleId)
  if not roleId then
    return
  end
  DataCenter.playerData.DRole.uid = roleId
  MobileFileDataManager.Instance:SetCommFileValue("playerUid", roleId, true)
end

function PlayerDataUtils.GetPlayerUid()
  return DataCenter.playerData.DRole.uid
end

function PlayerDataUtils.GetCreateTime()
  return DataCenter.playerData.DRole.createTime
end

function PlayerDataUtils.SetServerZone(zone)
  DataCenter.playerData.zone = zone
  Logger.ReportApusInfo("Set Server Zone " .. zone)
end

function PlayerDataUtils.GetServerZone()
  return DataCenter.playerData.zone or version.GetFeatureZone()
end

function PlayerDataUtils.IsJpZone()
  return PlayerDataUtils.GetServerZone() == cd.Zone.JP
end

function PlayerDataUtils.IsGlobalZone()
  return PlayerDataUtils.GetServerZone() == cd.Zone.Global
end

function PlayerDataUtils.SetPlayerToken(token)
  if not token then
    return
  end
  DataCenter.playerData.DRole.token = token
end

function PlayerDataUtils.GetPlayerToken()
  return DataCenter.playerData.DRole.token
end

function PlayerDataUtils.GetBgCfgId()
  if ClientDataUtils.GetData(cd.ClientDataMainKey.AVG, "MainBgTid") then
    do return ClientDataUtils.GetData, cd.ClientDataMainKey.AVG end
    return ClientDataUtils.GetData, cd.ClientDataMainKey.AVG, "MainBgTid"
  end
  return DataCenter.playerData.DRole.mainInterfaceCG
end

function PlayerDataUtils.SetFirstRedemptionCode(isFirst)
  DataCenter.playerData.DRole.firstRedemptionCode = isFirst
end

function PlayerDataUtils.GetAttrTypeName(tp)
  local attrConfig = DT.ActorAttrType[tp]
  if attrConfig then
    return attrConfig.Name
  end
end

function PlayerDataUtils.GetAttrType(name)
  for _, v in pairs(DT.ActorAttrType) do
    if v.ID == name then
      return v.ID
    end
  end
  return name
end

function PlayerDataUtils.GetHpMultiplier(level)
  local cfg = PlayerDataUtils.GetAccountLevelCfgByLevel(level)
  return cfg and cfg.HpMultiplier or nil
end

function PlayerDataUtils.GetStageGrow(level)
  local cfg = PlayerDataUtils.GetAccountLevelCfgByLevel(level)
  return cfg and cfg.StageGrow or nil
end

function PlayerDataUtils.SyncPlayerAttr(data)
  print("------------------PlayerDataUtils sync player attr", table.tostring(data))
  local playerAttrs = DataCenter.playerData.DRole.attrs or {}
  for attrType, attrData in pairs(data) do
    if attrData then
      playerAttrs[attrType] = attrData
    end
  end
  DataCenter.playerData.DRole.attrs = playerAttrs
  if KeeperSkillModel and KeeperSkillModel.Instance then
    KeeperSkillModel.Instance:OnPlayerAttrsSynced(data)
  end
end

function PlayerDataUtils.ResetPlayerAttr()
  DataCenter.playerData.DRole.attrs = {}
end

function PlayerDataUtils.GetMaxAccountLevelCfg()
  local max = math.mininteger
  for lv, _ in pairs(DT.AcountLevelConfig) do
    if lv > max then
      max = lv
    end
  end
  return DT.AcountLevelConfig[max]
end

function PlayerDataUtils.GetDailyAppointNumByLevel(level)
  for _, data in pairs(DT.AcountLevelConfig) do
    if data.Level == level then
      return data.DailyAppointNum
    end
  end
  return 0
end

function PlayerDataUtils.GetGoldShopRefeshGroup(level)
  for _, data in pairs(DT.AcountLevelConfig) do
    if data.Level == level then
      return data.GoldShopRefresh
    end
  end
  return {}
end

function PlayerDataUtils.GetTotalFight()
  local awakerMap = DataCenter.awakerData.awakerMap
  local totalFight = 0
  for _, awaker in pairs(awakerMap) do
    totalFight = totalFight + (awaker.fighting or 0)
  end
  return totalFight
end

function PlayerDataUtils.ShowInvestigatorLevelUpPanel(callback, oldLevel)
  local panelData = {oldLevel = oldLevel, confirmCallback = callback}
  PublicUIController.Instance:OnOpenInvestigatorLevelUp(panelData)
end

function PlayerDataUtils.GetAccountUpgradeExp(level)
  if not level then
    return
  end
  local config = DT.AcountLevelConfig[level]
  if not config then
    local exp = 0
    local maxLvCfg = PlayerDataUtils.GetMaxAccountLevelCfg()
    if maxLvCfg and level > maxLvCfg.Level then
      exp = maxLvCfg.Exp
    end
    Logger.Info("找不到账号等级配置, tid=>", level)
    return exp
  end
  return config.Exp
end

function PlayerDataUtils.GetEnergy()
  do return ItemDataUtils.GetItemNum end
  return ItemDataUtils.GetItemNum, CommonDefine.CurrencyType.Energy
end

function PlayerDataUtils.GetLevel()
  return DataCenter.playerData.DRole.level
end

function PlayerDataUtils.GetEnergyNaturalRecoverLimit(level)
  if not level then
    return
  end
  local config = DT.AcountLevelConfig[level]
  if not config then
    local maxEnergy = 0
    local maxLvCfg = PlayerDataUtils.GetMaxAccountLevelCfg()
    if maxLvCfg and level > maxLvCfg.Level then
      maxEnergy = maxLvCfg.EnergyLimit
    end
    Logger.Info("找不到账号等级配置, tid=>", level)
    return maxEnergy
  end
  return config.EnergyLimit
end

function PlayerDataUtils.GetMaxEnergyLimit()
  do return DT.GetConstant end
  return DT.GetConstant, "Energy_Max"
end

function PlayerDataUtils.GetEnergyRestoreNum(level)
  if not level then
    return
  end
  local config = DT.AcountLevelConfig[level]
  if not config then
    local maxBuyTimes = 0
    local maxLvCfg = PlayerDataUtils.GetMaxAccountLevelCfg()
    if maxLvCfg and level > maxLvCfg.Level then
      maxBuyTimes = maxLvCfg.BuyEnergyNum
    end
    Logger.Info("找不到账号等级配置, tid=>", level)
    return maxBuyTimes
  end
  return config.BuyEnergyNum
end

function PlayerDataUtils.GetEnergyBuyTimes()
  return DataCenter.playerData.DRole.energyBuyTimes
end

function PlayerDataUtils.GetEnergyMaxBuyTimes()
  local maxBuyTimes = 0
  local priceList = table.deepclone(DT.Constant.EnergyBuyPrice.Data)
  table.remove(priceList, 1)
  for times, _ in pairs(priceList) do
    if times > maxBuyTimes then
      maxBuyTimes = times
    end
  end
  return maxBuyTimes
end

function PlayerDataUtils.GetEnergyLeftBuyTimes()
  local currBuyTimes = PlayerDataUtils.GetEnergyBuyTimes()
  local maxBuyTimes = PlayerDataUtils.GetEnergyMaxBuyTimes()
  return maxBuyTimes - currBuyTimes
end

function PlayerDataUtils.GetCurrentBuyEnergyCost()
  local currBuyTimes = PlayerDataUtils.GetEnergyBuyTimes() + 1
  local maxBuyTimes = PlayerDataUtils.GetEnergyMaxBuyTimes()
  local priceList = table.deepclone(DT.Constant.EnergyBuyPrice.Data)
  table.remove(priceList, 1)
  if currBuyTimes > maxBuyTimes then
    return priceList[maxBuyTimes]
  end
  return priceList[currBuyTimes]
end

function PlayerDataUtils.ShowEnergyRestorePanel(_, _)
  UIManager.Instance:Reopen(Urls.ReplenishEnergyView)
end

function PlayerDataUtils.GetEnergyRestoreLeftTime()
  local now = TimeUtils.GetServerTime()
  local leftTime = DataCenter.playerData.DRole.nextEnergyRestoreTimeStamp - now
  if leftTime < 0 then
    leftTime = 0
  end
  return leftTime
end

function PlayerDataUtils.GetMaxStoreEnergy()
  do return tonumber, DT.GetConstant("Energy_Max") end
  return tonumber, DT.GetConstant("Energy_Max")
end

function PlayerDataUtils.UpdateTicketData(svrData)
  if not svrData then
    return
  end
  for k, v in pairs(svrData) do
    DataCenter.playerData.DRole[k] = v
  end
end

function PlayerDataUtils.GetMaxTicketRestoreNum()
  return 0
end

function PlayerDataUtils.GetTicketNum()
  do return ItemDataUtils.GetItemNum end
  return ItemDataUtils.GetItemNum, CommonDefine.CurrencyType.Ticket
end

function PlayerDataUtils.GetTicketBuyTimes()
  return DataCenter.playerData.DRole.ticketBuyTimes
end

function PlayerDataUtils.GetTicketRestoreLeftTime()
  local now = TimeUtils.GetServerTime()
  local leftTime = DataCenter.playerData.DRole.ticketRestoredTimestamp - now
  if leftTime < 0 then
    leftTime = 0
  end
  return leftTime
end

function PlayerDataUtils.UpdateLivesData(svrData)
  if not svrData then
    return
  end
  DataCenter.playerData.DRole.livesRestoredTimestamp = svrData.livesRestoredTimestamp
end

function PlayerDataUtils.GetFeatureConfig(tid)
  if not tid then
    return
  end
  return DT.FeatureUnlock[tid]
end

function PlayerDataUtils.GetFeatureConfigByField(field, tid)
  local config = PlayerDataUtils.GetFeatureConfig(tid)
  if not config then
    return
  end
  return config[field]
end

function PlayerDataUtils.GetFeatureConfigByFeatureId(featureId, subFeatureId)
  for _, cfg in pairs(DT.FeatureUnlock) do
    if cfg.Feature == featureId and (not subFeatureId or (cfg.Key or 0) == subFeatureId) then
      return cfg
    end
  end
  return nil
end

local singleKey = 0

function PlayerDataUtils.GetFeatureConfigList(featureType)
  if not featureType then
    return DT.FeatureUnlock
  end
  local retList = {}
  for _, cfg in pairs(DT.FeatureUnlock) do
    if cfg.Feature == featureType then
      table.insert(retList, cfg)
    end
  end
  return retList
end

function PlayerDataUtils.GetFeatureConfigByTypeAndKey(featureType, key)
  for _, cfg in pairs(DT.FeatureUnlock) do
    local defaultKey = PlayerDataUtils.GetFeatureMainTypeKey()
    local featureKey = cfg.Key or defaultKey
    if cfg.Feature == featureType and featureKey == key then
      return cfg
    end
  end
end

function PlayerDataUtils.InitFeatureUnlockData()
  local cfgList = PlayerDataUtils.GetFeatureConfigList()
  for _, cfg in pairs(cfgList) do
    if not DataCenter.playerData.featuresData[cfg.Feature] then
      DataCenter.playerData.featuresData[cfg.Feature] = {}
    end
    local featureData = DataCenter.playerData.featuresData[cfg.Feature]
    local typeKey = cfg.Key or singleKey
    featureData[typeKey] = {
      Id = cfg.Feature,
      typeKey = typeKey,
      unlock = cfg.UnlockCondition == nil,
      show = nil == cfg.ShowCondition,
      cfg = table.deepclone(cfg)
    }
  end
end

function PlayerDataUtils.CreateFeatureUnlockData(tid, typeKey, unlock, show, cfg)
  if not cfg then
    local cfgList = PlayerDataUtils.GetFeatureConfigList(tid)
    for _, v in pairs(cfgList) do
      if typeKey == singleKey and v.Key == nil then
        cfg = table.deepclone(v)
        break
      end
    end
  end
  local data = {
    Id = tid,
    typeKey = typeKey,
    unlock = unlock,
    show = show,
    cfg = cfg
  }
  return data
end

function PlayerDataUtils.GetFeatureMainTypeKey()
  return singleKey
end

function PlayerDataUtils.UpdateFeatureUnlock(tid, typeKey, unlock, show)
  if not tid or not typeKey then
    return
  end
  local datas = DataCenter.playerData.featuresData[tid]
  if not datas then
    DataCenter.playerData.featuresData[tid] = {}
    datas = DataCenter.playerData.featuresData[tid]
  end
  if not datas[typeKey] then
    datas[typeKey] = PlayerDataUtils.CreateFeatureUnlockData(tid, typeKey, unlock, show)
  else
    datas[typeKey].unlock = unlock
    datas[typeKey].show = show
  end
end

function PlayerDataUtils.IsFeatureUnlock(tid, typeKey, is0Key)
  if not PlayerDataUtils.GetFeatureConfigByFeatureId(tid) then
    return false
  end
  local data = PlayerDataUtils.GetFeatureUnlockData(tid, typeKey)
  if data then
    return data.show, data.unlock
  end
  if typeKey and typeKey > 0 and (is0Key or nil == is0Key) then
    do return PlayerDataUtils.IsFeatureUnlock, tid end
    return PlayerDataUtils.IsFeatureUnlock, tid, 0
  end
  return true, true
end

function PlayerDataUtils.IsFeatureTidUnlock(featureTid)
  local featureCfg = DT.FeatureUnlock[featureTid]
  if not featureCfg then
    return false
  end
  local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(featureCfg.Feature, featureCfg.Key or 0)
  return isUnlock
end

function PlayerDataUtils.GetFeatureSwitchSvrValue(feature)
  local lockFeatureId = ZoneFeatureUtils.GetFeatureId(feature)
  if not lockFeatureId then
    return nil
  end
  return DataCenter.playerData.FeatureSwitch[lockFeatureId]
end

function PlayerDataUtils.GetFeatureLogicUnlockTips(tid, typeKey)
  local data = PlayerDataUtils.GetFeatureUnlockData(tid, typeKey)
  if not data then
    Logger.Info("找不到功能解锁配置 -> tid = %d, typeKey = %d", tid, typeKey)
    return nil
  end
  return data.cfg.LockTip and LT.Text(data.cfg.LockTip)
end

function PlayerDataUtils.AlertLockedTips(tid, typeKey, cb)
  local function callback()
    if cb then
      cb()
    end
  end
  
  local tipText = PlayerDataUtils.GetFeatureLogicUnlockTips(tid, typeKey)
  if not tipText then
    callback()
    return
  end
  Alert.ShowStr(tipText)
  callback()
end

function PlayerDataUtils.GetFeatureUnlockData(tid, typeKey)
  local datas = DataCenter.playerData.featuresData[tid]
  typeKey = typeKey or PlayerDataUtils.GetFeatureMainTypeKey()
  if not datas then
    Logger.Info("Can't find featureType = %d", tid)
    return false
  end
  return datas[typeKey]
end

function PlayerDataUtils.GetFeatureByKey(featureKey)
  if not featureKey then
    return
  end
  if KeyFeatureMap then
    return KeyFeatureMap[featureKey]
  end
  KeyFeatureMap = {}
  for _, cfg in pairs(DT.FeatureUnlock) do
    if cfg and cfg.Key and cfg.Feature then
      KeyFeatureMap[cfg.Key] = cfg.Feature
    end
  end
  return KeyFeatureMap[featureKey]
end

function PlayerDataUtils.GetFeatureTidByKey(featureKey)
  if not featureKey then
    return
  end
  if KeyFeatureCfgMap then
    return KeyFeatureCfgMap[featureKey]
  end
  KeyFeatureCfgMap = {}
  for featureTid, cfg in pairs(DT.FeatureUnlock) do
    if cfg and cfg.Key and cfg.Feature then
      KeyFeatureCfgMap[cfg.Key] = featureTid
    end
  end
  return KeyFeatureCfgMap[featureKey]
end

function PlayerDataUtils.GetSceneFeatureUnlockDatas()
  local datas = {}
  for _, unlockDatas in pairs(DataCenter.playerData.featuresData) do
    for _, unlockData in pairs(unlockDatas) do
      if unlockData and unlockData.cfg.FeatureEntranceParam then
        datas[unlockData.cfg.FeatureEntranceParam] = unlockData
      end
    end
  end
  return datas
end

function PlayerDataUtils.GetFeatureUnlockShowQueue()
  return DataCenter.playerData.unlockShowQueue
end

function PlayerDataUtils.AddFeatureUnlockShowQueue(tid, typeKey)
  local featureData = PlayerDataUtils.GetFeatureUnlockData(tid, typeKey)
  if featureData and featureData.cfg and featureData.cfg.UnlockDesc then
    local showData = {
      title = LT.Text(featureData.cfg.FeatureName),
      desc = LT.Text(featureData.cfg.UnlockDesc),
      icon = featureData.cfg.Icon
    }
    table.insert(DataCenter.playerData.unlockShowQueue, showData)
  end
  PlayerDataUtils.AddBtnUnlockFxQueue(tid, typeKey)
end

function PlayerDataUtils.AddBtnUnlockFxQueue(tid, typeKey)
  local mainBtnCfg = MainPanelDefine.BtnCfg
  local PlayUnlockAnimation = DT.GetOriginalConstant("PlayUnlockAnimation", {})
  for btnName, cfg in pairs(mainBtnCfg) do
    if cfg.FeatureId == tid and (cfg.SubFeatureId or 0) == typeKey then
      local featureConfig = PlayerDataUtils.GetFeatureConfigByFeatureId(cfg.FeatureId, cfg.SubFeatureId or 0)
      local featureTid = featureConfig.ID
      if not PlayerDataUtils.IsBtnInUnlockQueue(btnName) and table.contains(PlayUnlockAnimation, featureTid) then
        table.insert(DataCenter.playerData.mainBtnUnlockQueue, {btnName = btnName, featureTid = featureTid})
      end
    end
  end
end

function PlayerDataUtils.IsBtnInUnlockQueue(btnName)
  for _, v in pairs(DataCenter.playerData.mainBtnUnlockQueue) do
    if v.btnName == btnName then
      return true
    end
  end
  return false
end

function PlayerDataUtils.PopBtnUnlockFx()
  do return table.remove, DataCenter.playerData.mainBtnUnlockQueue end
  return table.remove, DataCenter.playerData.mainBtnUnlockQueue, 1
end

function PlayerDataUtils.OpenIllustrate(titleOrNil, content)
  UIManager.Instance:Reopen(Urls.CommonillustrateView, titleOrNil, content)
end

function PlayerDataUtils.OpenFirstTimeIllustrate(panelName, title, content, cb)
  local isNeedOpen = table.contains(DT.GetOriginalConstant("PopupIllustratePanels", {}), panelName)
  local isOpened = ClientDataUtils.GetData(cd.ClientDataMainKey.OpenIllustrate, panelName)
  if isNeedOpen and not isOpened then
    FrameWaiter.OnNextFrame(function()
      ClientDataUtils.SetData(cd.ClientDataMainKey.OpenIllustrate, panelName, 1)
      if "MainPanelPVP" == panelName then
        UIManager.Instance:Reopen(Urls.PvpillustratePanel)
      elseif content then
        PlayerDataUtils.OpenIllustrate(title, content)
      end
      if cb then
        cb()
      end
    end, 10)
  end
end

function PlayerDataUtils.OpenFirstTimeTutorial(panelName, tutorialTid, withoutConstCfg)
  local isNeedOpen = table.contains(DT.GetOriginalConstant("PopupIllustratePanels", {}), panelName)
  if withoutConstCfg then
    isNeedOpen = true
  end
  local isOpened = ClientDataUtils.GetData(cd.ClientDataMainKey.OpenIllustrate, panelName)
  if isNeedOpen and not isOpened and tutorialTid and DT.Tutorial[tutorialTid] then
    FrameWaiter.OnNextFrame(function()
      ClientDataUtils.SetData(cd.ClientDataMainKey.OpenIllustrate, panelName, 1)
      UIManager.Instance:Reopen(Urls.TutorialSimpleView, tutorialTid)
    end, 10)
  end
end

function PlayerDataUtils.ClearUnlockShowQueue()
  DataCenter.playerData.unlockShowQueue = {}
  DataCenter.playerData.mainBtnUnlockQueue = {}
end

function PlayerDataUtils.PopFeatureUnlockShowQueue()
  local queue = PlayerDataUtils.GetFeatureUnlockShowQueue()
  if queue and #queue <= 0 then
    return
  end
  local data = queue[1]
  table.remove(queue, 1)
  return data
end

function PlayerDataUtils.CanShowUnlockPanel()
  return DataCenter.playerData.enabledShowTips
end

function PlayerDataUtils.SetEnabledShow(enabled)
  DataCenter.playerData.enabledShowTips = enabled
end

function PlayerDataUtils.ClearPostion()
  DataCenter.playerData.pos.x = 0
  DataCenter.playerData.pos.y = 0
  DataCenter.playerData.pos.z = 0
end

function PlayerDataUtils.ShareRewardFinish(finish)
  DataCenter.gameData.ShareRewardFinish = finish
end

function PlayerDataUtils.BindPhoneRewardFinish(finish)
  DataCenter.gameData.BindPhoneReward = finish or false
end

function PlayerDataUtils.GetStatsData()
  return DataCenter.playerData.statsData
end

function PlayerDataUtils.SetStatsData(data)
  if not data or type(data) ~= "table" then
    return
  end
  Logger.Info("PlayerDataUtils.SetStatsData ", table.tostring(data))
  Logger.Info("PlayerDataUtils.SetStatsData global", table.tostring(data.global))
  DataCenter.playerData.statsData = data
end

function PlayerDataUtils.GetStatsDataByKey(key)
  if not key or type(key) ~= "string" then
    return
  end
  return DataCenter.playerData.statsData[key]
end

function PlayerDataUtils.GetAttentionCommunityKey(communityName)
  return CommonDefine.PlayerStatsType.AttentionCommunity .. "_" .. communityName
end

function PlayerDataUtils.GetAttentionCommunityStatsData(communityName)
  local statsKey = PlayerDataUtils.GetAttentionCommunityKey(communityName)
  return DataCenter.playerData.statsData.base[statsKey]
end

function PlayerDataUtils.SetAttentionCommunityStatsData(communityName, numVal)
  local statsKey = PlayerDataUtils.GetAttentionCommunityKey(communityName)
  DataCenter.playerData.statsData.base[statsKey] = numVal or 1
end

function PlayerDataUtils.GetTranslateGratitudeRewardStatsData()
  local statsKey = CommonDefine.PlayerStatsType.TranslateGratitudeReward
  return DataCenter.playerData.statsData.base[statsKey]
end

function PlayerDataUtils.SetTranslateGratitudeRewardStatsData(numVal)
  local statsKey = CommonDefine.PlayerStatsType.TranslateGratitudeReward
  DataCenter.playerData.statsData.base[statsKey] = numVal or 1
end

function PlayerDataUtils.GetDailyStatsData(key)
  local daily = DataCenter.playerData.statsData.daily
  return daily and daily[key]
end

function PlayerDataUtils.GetGlobalBaseStatsData(key)
  local global = DataCenter.playerData.statsData.global
  if not global or not global.base then
    return
  end
  return global.base[key]
end

function PlayerDataUtils.GetBaseStatsData(key)
  return DataCenter.playerData.statsData.base and DataCenter.playerData.statsData.base[key]
end

function PlayerDataUtils.SetBaseStatsData(key, value)
  if not key or type(key) ~= "string" or not value then
    return
  end
  DataCenter.playerData.statsData.base[key] = value
end

function PlayerDataUtils.GetRevivalItemUseNum()
  return PlayerDataUtils.GetBaseStatsData("RevivalItemUseNum") or 0
end

function PlayerDataUtils.SetStatsDataByKey(key, data)
  if not (key and type(key) == "string" and data) or type(data) ~= "table" then
    return
  end
  DataCenter.playerData.statsData[key] = data
end

function PlayerDataUtils.SetStatsDataByKeyType(statsKey, statsType, statVal)
  if not (statsKey and type(statsKey) == "string" and statsType) or type(statsType) ~= "string" or not statVal then
    return
  end
  if statsKey == cd.PlayerStatsKey.global then
    PlayerDataUtils.UpdateGlobalStats(statVal)
    return
  end
  if not DataCenter.playerData.statsData[statsKey] then
    DataCenter.playerData.statsData[statsKey] = {}
  end
  DataCenter.playerData.statsData[statsKey][statsType] = statVal
end

function PlayerDataUtils.UpdateGlobalStats(data)
  if not DataCenter.playerData.statsData then
    DataCenter.playerData.statsData = {}
  end
  if not DataCenter.playerData.statsData.global then
    DataCenter.playerData.statsData.global = {}
  end
  if not DataCenter.playerData.statsData.global[data.type] then
    DataCenter.playerData.statsData.global[data.type] = {}
  end
  DataCenter.playerData.statsData.global[data.type][data.key] = data.num
end

function PlayerDataUtils.GetStatsDataByKeyType(statsKey, statsType)
  if not (statsKey and type(statsKey) == "string" and statsType) or type(statsType) ~= "string" then
    return 0
  end
  if not DataCenter.playerData.statsData[statsKey] then
    return 0
  end
  return DataCenter.playerData.statsData[statsKey][statsType] or 0
end

function PlayerDataUtils.GetBanItemType(tid)
  if DT.AwakerConfig[tid] then
    return cd.UseTimesLimitType.Awaker
  else
    local itemCfg = ItemDataUtils.GetItemConfig(tid)
    if itemCfg and itemCfg.Type == CommonDefine.ItemType.KeeperSkill then
      return cd.UseTimesLimitType.KeyToken
    end
    if itemCfg and itemCfg.Type == CommonDefine.ItemType.Weapon then
      return cd.UseTimesLimitType.Weapon
    end
  end
end

function PlayerDataUtils.IsBanTidByStageType(stageType, tid)
  local limitType = PlayerDataUtils.GetBanItemType(tid)
  if not limitType then
    return
  end
  if limitType == cd.UseTimesLimitType.Awaker and not table.contains(DT.GetOriginalConstant("AwakerUseTimesLimitByStageGroupType", {}), stageType) then
    return
  end
  if limitType == cd.UseTimesLimitType.Weapon and not table.contains(DT.GetOriginalConstant("WeaponUseTimesLimitByStageGroupType", {}), stageType) then
    return
  end
  if limitType == cd.UseTimesLimitType.KeyToken and not table.contains(DT.GetOriginalConstant("KeyTokenUseTimesLimitByStageGroupType", {}), stageType) then
    return
  end
  local limitKey = string.format("%s_%s_%s_%s", "StageGroupTypeWinUnitCount", stageType, limitType, tid)
  local daily = DataCenter.playerData.statsData.daily or {}
  return nil ~= daily[limitKey]
end

function PlayerDataUtils:GetUnitStatisticKeys(stageGroupType, unitTid)
  local keys = {}
  for useTimesLimitType in pairs(cd.UseTimesLimitType) do
  end
  return keys
end

function PlayerDataUtils.GetAvatarIconTid()
  return DataCenter.playerData.DRole.icon
end

function PlayerDataUtils.GetAvatarIcon()
  local avatarItemTid = DataCenter.playerData.DRole.icon
  do return ItemDataUtils.GetAvatarIcon end
  return ItemDataUtils.GetAvatarIcon, avatarItemTid
end

function PlayerDataUtils.ReqOnRoleOpen()
  ProtoManager.Instance:ReqServer("GameRequest", "OnRoleOpen", function(data)
    Logger.Info("OnRoleOpen Successful ", table.tostring(data))
    DataCenter.playerData.DRole.expBonus = data.expBonus
    DataCenter.playerData.DRole.originExp = data.originExp
    DataCenter.playerData.DRole.bonusExp = data.bonusExp
  end, function(data)
    Logger.Info("OnRoleOpen failed ", table.tostring(data))
  end)
end

function PlayerDataUtils.GetGenderChangeTimes()
  return DataCenter.playerData.DRole.genderChangeTimes or 0
end

function PlayerDataUtils.SetGenderChangeTimes(numVal)
  if not numVal then
    return
  end
  DataCenter.playerData.DRole.genderChangeTimes = numVal
end

function PlayerDataUtils.IsFirstTimeOpenNextStageChapter()
  local firstChapterFinishFeature = cd.FeatureId.FirstChapterFinish
  local _, isUnlocked = PlayerDataUtils.IsFeatureUnlock(firstChapterFinishFeature, 0)
  if isUnlocked and not ClientDataUtils.GetData(cd.ClientDataMainKey.AVG_Feature, firstChapterFinishFeature) then
    return true
  end
end

function PlayerDataUtils.ReqOnSetAge(year, month, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnSetAge", function(data)
    Logger.Info("OnSetAge Successful ", table.tostring(data))
    if callback then
      callback()
    end
    local ageAuthentication = PlayerDataUtils.ConcatAgeAuthentication(year, month)
    PlayerDataUtils.SetAgeAuthentication(ageAuthentication)
  end, function(data)
    Logger.Info("OnSetAge failed ", table.tostring(data))
  end, year, month)
end

function PlayerDataUtils.ConcatAgeAuthentication(year, month)
  do return string.format, "%s-%s", year end
  return string.format, "%s-%s", year, month
end

function PlayerDataUtils.GetAgeAuthentication()
  return DataCenter.playerData.DRole.ageAuthentication
end

function PlayerDataUtils.SetAgeAuthentication(str)
  if not str or type(str) ~= "string" then
    return
  end
  DataCenter.playerData.DRole.ageAuthentication = str
end

return PlayerDataUtils
