local FuncJumpManager, Super = System.NewClass("FuncJumpManager", Manager)

function FuncJumpManager:Awake(binder)
  self.binder = binder
  self.feature2UrlMap = {
    [CommonDefine.FeatureId.DrawCard] = Urls.SummonPanel,
    [CommonDefine.FeatureId.DBGCopyGroup] = Urls.DungeonsMainView,
    [CommonDefine.FeatureId.ResCopy] = Urls.DungeonsMainView,
    [CommonDefine.FeatureId.TrinketCopy] = Urls.DungeonsMainView,
    [CommonDefine.FeatureId.DailyChallenge] = Urls.DailyChallengeView,
    [CommonDefine.FeatureId.WeekChallenge] = Urls.DungeonsMainView,
    [CommonDefine.FeatureId.Compose] = Urls.AlchemyMainPanel,
    [CommonDefine.FeatureId.Decompose] = Urls.AlchemyMainPanel,
    [CommonDefine.FeatureId.Recast] = Urls.AlchemyMainPanel,
    [CommonDefine.FeatureId.Exchange] = Urls.AlchemyMainPanel,
    [CommonDefine.FeatureId.Shop] = Urls.MainShopPanel,
    [CommonDefine.FeatureId.BattlePass] = Urls.BattlePassMainPanel,
    [CommonDefine.FeatureId.WeekBossChallenge] = Urls.DungeonsMainView,
    [CommonDefine.FeatureId.TrinketDecompose] = Urls.AlchemyMainPanel,
    [CommonDefine.FeatureId.AlternationSchoolTower] = Urls.DungeonsMainView,
    [CommonDefine.FeatureId.PVP] = Urls.MainPanelPVP,
    [CommonDefine.FeatureId.AbyssChallenge] = Urls.AbyssView,
    [CommonDefine.FeatureId.SmallSubplotTab] = Urls.SubplotGroupView,
    [CommonDefine.FeatureId.LargeSubplotTab] = Urls.SubplotGroupView,
    [CommonDefine.FeatureId.SpecialSubplotTab] = Urls.SubplotGroupView,
    [CommonDefine.FeatureId.ResidentTrial] = Urls.TaskMainView,
    [CommonDefine.FeatureId.Friends] = Urls.SocialRelationMainPanel,
    [CommonDefine.FeatureId.DailyTask] = Urls.DailyTaskView,
    [CommonDefine.FeatureId.GuideNote_DailyTask] = Urls.GuideNoteMainView,
    [CommonDefine.FeatureId.GuideNote_WeekTask] = Urls.GuideNoteMainView,
    [CommonDefine.FeatureId.Activity] = Urls.ActivityMainPanel,
    [CommonDefine.FeatureId.GuideNoteSeason] = Urls.GuideNoteMainView,
    [CommonDefine.FeatureId.RailWayActivity] = Urls.ActivityPermanentsPanel
  }
  self.jumpFeatrueIdFuncMap = {
    [CommonDefine.FeatureId.Task] = System.fn(self, self.JumpToTask),
    [CommonDefine.FeatureId.DrawCard] = System.fn(self, self.JumpToDrawCard),
    [CommonDefine.FeatureId.DBGCopyGroup] = System.fn(self, self.JumpToDBGCopyGroup),
    [CommonDefine.FeatureId.ResCopy] = System.fn(self, self.JumpToResCopy),
    [CommonDefine.FeatureId.TrinketCopy] = System.fn(self, self.JumpToTrinketCopy),
    [CommonDefine.FeatureId.DailyChallenge] = System.fn(self, self.JumpToDailyChallenge),
    [CommonDefine.FeatureId.WeekChallenge] = System.fn(self, self.JumpToWeekChallenge),
    [CommonDefine.FeatureId.Compose] = System.fn(self, self.JumpToCompose),
    [CommonDefine.FeatureId.Decompose] = System.fn(self, self.JumpToDecompose),
    [CommonDefine.FeatureId.Recast] = System.fn(self, self.JumpToRecast),
    [CommonDefine.FeatureId.Exchange] = System.fn(self, self.JumpToExchange),
    [CommonDefine.FeatureId.Shop] = System.fn(self, self.JumpToShop),
    [CommonDefine.FeatureId.BattlePass] = System.fn(self, self.JumpToBattlePass),
    [CommonDefine.FeatureId.WeekBossChallenge] = System.fn(self, self.JumpToWeekBoss),
    [CommonDefine.FeatureId.TrinketDecompose] = System.fn(self, self.JumpToTrinketDecompose),
    [CommonDefine.FeatureId.AlternationSchoolTower] = System.fn(self, self.JumpToAlternationSchoolTower),
    [CommonDefine.FeatureId.PVP] = System.fn(self, self.JumpToPVP),
    [CommonDefine.FeatureId.AbyssChallenge] = System.fn(self, self.JumpToAbyss),
    [CommonDefine.FeatureId.SmallSubplotTab] = System.fn(self, self.JumpSmallSubplotTab),
    [CommonDefine.FeatureId.LargeSubplotTab] = System.fn(self, self.JumpLargeSubplotTab),
    [CommonDefine.FeatureId.SpecialSubplotTab] = System.fn(self, self.JumpSpecialSubplotTabTab),
    [CommonDefine.FeatureId.ResidentTrial] = System.fn(self, self.JumpToResidentTrial),
    [CommonDefine.FeatureId.Friends] = System.fn(self, self.JumpToSocial),
    [CommonDefine.FeatureId.DailyTask] = System.fn(self, self.JumpToDailyTask),
    [CommonDefine.FeatureId.GuideNote_DailyTask] = System.fn(self, self.JumpToGuideNoteDailyTask),
    [CommonDefine.FeatureId.GuideNote_WeekTask] = System.fn(self, self.JumpToGuideNoteWeekTask),
    [CommonDefine.FeatureId.Activity] = System.fn(self, self.JumpToActivity),
    [CommonDefine.FeatureId.GuideNoteSeason] = System.fn(self, self.JumpToGuideNoteSeason),
    [CommonDefine.FeatureId.CollaborationSubplotTab] = System.fn(self, self.JumpToCollaborationSubplotTab),
    [CommonDefine.FeatureId.RailWayActivity] = System.fn(self, self.JumpToRailWayActivity)
  }
  self.jumpAwakerPageFuncMap = {
    [CommonDefine.AwakerJumpPage.Skill] = System.fn(self, self.JumpToAwakerSkill),
    [CommonDefine.AwakerJumpPage.Level] = System.fn(self, self.JumpToAwakerLevel),
    [CommonDefine.AwakerJumpPage.Trinket] = System.fn(self, self.JumpToAwakerTrinket),
    [CommonDefine.AwakerJumpPage.Weapon] = System.fn(self, self.JumpToAwakerWeapon)
  }
  self.jumpStageGroupFuncMap = {
    [CommonDefine.StageGroupType.MainCopy] = System.fn(self, self.JumpToMainCopy),
    [CommonDefine.StageGroupType.MainCopyHard] = System.fn(self, self.JumpToMainCopyHard),
    [CommonDefine.StageGroupType.CopyEntry] = System.fn(self, self.JumpToCopyEntry)
  }
  self.jumpFuncType2FuncMap = {
    [CommonDefine.JumpFuncType.AwakerDetail] = {
      JumpFunc = System.fn(self, self.JumpFuncAwakerDetail),
      CheckFunc = System.fn(self, self.CanJumpAwakerDetail)
    },
    [CommonDefine.JumpFuncType.Stage] = {
      JumpFunc = System.fn(self, self.JumpFuncStage),
      CheckFunc = System.fn(self, self.CanJumpStage)
    },
    [CommonDefine.JumpFuncType.StageNoDetail] = {
      JumpFunc = System.fn(self, self.JumpFuncStage),
      CheckFunc = System.fn(self, self.CanJumpStage)
    },
    [CommonDefine.JumpFuncType.ItemConversion] = {
      JumpFunc = System.fn(self, self.JumpFuncItemConversion),
      CheckFunc = System.fn(self, self.CanJumpItemConversion)
    },
    [CommonDefine.JumpFuncType.Trinket] = {
      JumpFunc = System.fn(self, self.JumpFuncBagTrinket),
      CheckFunc = System.fn(self, self.CanJumpFuncBagTrinket)
    },
    [CommonDefine.JumpFuncType.Settings] = {
      JumpFunc = System.fn(self, self.JumpToSettingsUniqueName),
      CheckFunc = function()
        return true
      end
    },
    [CommonDefine.JumpFuncType.MaterialDecompose] = {
      JumpFunc = System.fn(self, self.JumpFuncMaterialDecompose),
      CheckFunc = System.fn(self, self.CanJumpMaterialDecompose)
    }
  }
end

function FuncJumpManager.JumpToFuncPanel(jumpCallBack, panelOpenFunc, showDetail)
  if panelOpenFunc then
    panelOpenFunc()
  end
  if jumpCallBack then
    jumpCallBack()
  end
end

function FuncJumpManager:JumpFunc(jumpToId, params)
  local itemGetConfig = DT.ItemGets[jumpToId]
  local jumpFunc = itemGetConfig and itemGetConfig.JumpFunc or 0
  local settingCfg = DT.Setup[jumpFunc]
  if settingCfg then
    local paramTab = settingCfg.SetupTab or CommonDefine.SettingTab.System
    self:JumpToSettings(paramTab)
  elseif self.jumpFuncType2FuncMap[jumpFunc] then
    self.jumpFuncType2FuncMap[jumpFunc].JumpFunc(jumpFunc, params, itemGetConfig)
  else
    self:JumpFuncFeature(jumpFunc, params, itemGetConfig)
  end
end

function FuncJumpManager:JumpFuncFeature(jumpFunc, params, itemGetConfig)
  local featureConfig = DT.FeatureUnlock[jumpFunc]
  local feature = featureConfig.Feature
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(feature, featureConfig.Key or 0)
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(feature, featureConfig.Key or 0)
    return
  end
  if self:IsTargetFeatureOpened(feature) then
    return
  end
  if self.jumpFeatrueIdFuncMap[feature] then
    self.jumpFeatrueIdFuncMap[feature](featureConfig, feature, params, itemGetConfig)
  end
end

function FuncJumpManager:IsTargetFeatureOpened(feature)
  local url = self.feature2UrlMap[feature]
  if not url then
    return false
  end
  return UIManager.Instance:GetWindow(url) ~= nil
end

function FuncJumpManager:JumpFuncAwakerDetail(_, _, itemGetConfig)
  local jumpPage = itemGetConfig.Param1
  self.jumpAwakerPageFuncMap[jumpPage]()
end

function FuncJumpManager:JumpFuncStage(jumpFunc, _, itemGetConfig)
  local stageId = itemGetConfig.Param1
  if not stageId then
    self.jumpStageGroupFuncMap[CommonDefine.StageGroupType.CopyEntry]()
    return
  end
  local stageConfig = DT.Stage[stageId]
  local stageGroupId = stageConfig.BelongGroup
  local stageGroupConfig = DT.StageGroup[stageGroupId]
  local stageGroupType = stageGroupConfig.Type
  local noShowDetail = jumpFunc == CommonDefine.JumpFuncType.StageNoDetail
  self.jumpStageGroupFuncMap[stageGroupType](stageId, stageGroupId, noShowDetail)
end

function FuncJumpManager:JumpFuncBagTrinket(_, itemTid, _)
  BagController.Instance:OnOpenBagView(CommonDefine.ItemType.Trinket, itemTid)
end

function FuncJumpManager:JumpFuncItemConversion(jumpFunc, _, itemGetConfig)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Compose, 0)
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.Compose, 0)
    return
  end
  local conversionId = itemGetConfig.Param1
  local itemTid = DT.ItemConversion[conversionId].ItemsGet[1]
  self:JumpToCompose(nil, CommonDefine.FeatureId.Compose, itemTid)
end

local taskLabelMap = {
  [1] = CommonDefine.TaskServerIndex.Appoint,
  [2] = CommonDefine.TaskServerIndex.Daily,
  [3] = CommonDefine.TaskServerIndex.Career,
  [4] = CommonDefine.TaskServerIndex.Achivement
}

function FuncJumpManager:JumpToTask(featureConfig)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Task, featureConfig.Key)
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.Task, featureConfig.Key)
    return
  end
  if featureConfig.Key == CommonDefine.TaskServerIndex.Appoint then
    TaskDataUtils.OpenDispatchPanel()
    return
  end
  if featureConfig.Key == CommonDefine.TaskServerIndex.Daily then
    return
  end
  TaskModel.Instance:SetCurTaskPage(taskLabelMap[featureConfig.Key])
  if UIManager.Instance:GetWindow(Urls.TaskMainPanel) then
    EventMgr.Instance.TaskSwitchPage:Dispatch(taskLabelMap[featureConfig.Key])
  else
    TaskDataUtils.OpenTaskMainPanel(function()
      EventMgr.Instance.TaskSwitchPage:Dispatch(taskLabelMap[featureConfig.Key])
    end)
  end
end

function FuncJumpManager:JumpToSettings(targetTab)
  local settingPanel = UIManager.Instance:Reopen(Urls.SettingMainPanel)
  if not settingPanel then
    return
  end
  settingPanel:SwitchToTab(targetTab)
end

function FuncJumpManager:JumpToSettingsUniqueName(_, _, itemGetConfig)
  local uniqueName = itemGetConfig.Param1
  local func = SettingManager.Instance.SettingFuncMap[uniqueName or ""]
  if func then
    func()
  end
end

function FuncJumpManager:JumpToDrawCard(_, feature)
  UIManager.Instance:Reopen(Urls.SummonPanel)
end

function FuncJumpManager:JumpToDBGCopyGroup(_, feature)
  UIManager.Instance:Reopen(Urls.DungeonsMainView, CommonDefine.DBGEntryPage.MaterialPanel)
end

function FuncJumpManager:JumpToResCopy(featureConfig, feature)
  DungeonMaterialModel.Instance:SetStageGroupType(CommonDefine.StageGroupType.MaterialCopy)
  DungeonMaterialModel.Instance:SetStageGroupId(featureConfig.Key)
  UIManager.Instance:Reopen(Urls.DungeonsMainView, CommonDefine.DBGEntryPage.MaterialPanel)
end

function FuncJumpManager:JumpToWeekBoss(featureConfig, feature, params)
  WeekBossExtModel.Instance:SetSelectedStageGroupId(featureConfig.Key)
  UIManager.Instance:Reopen(Urls.DungeonsMainView, CommonDefine.DBGEntryPage.WeekBossPanel)
end

function FuncJumpManager:JumpToTrinketCopy(_, feature)
  DungeonMaterialModel.Instance:SetStageGroupType(CommonDefine.StageGroupType.TrinketCopy)
  UIManager.Instance:Reopen(Urls.DungeonsMainView, CommonDefine.DBGEntryPage.TrinketPanel)
end

function FuncJumpManager:JumpToDailyChallenge(_, feature)
  UIManager.Instance:Reopen(Urls.DailyChallengeView)
end

function FuncJumpManager:JumpToWeekChallenge(_, feature)
  UIManager.Instance:Reopen(Urls.DungeonsMainView, CommonDefine.DBGEntryPage.WeekBossPanel)
end

function FuncJumpManager:JumpToAbyss(_, feature)
  UIManager.Instance:Reopen(Urls.AbyssView)
end

function FuncJumpManager:JumpToResidentTrial()
  UIManager.Instance:Reopen(Urls.TaskMainView, CommonDefine.TaskPage.AwakerTrial)
end

function FuncJumpManager:JumpToSocial()
  SocialDataUtils.OpenSocialRelationMainPanel()
end

function FuncJumpManager:JumpToDailyTask()
  TaskDataUtils.OpenDailyTaskView()
end

function FuncJumpManager:JumpToGuideNoteDailyTask()
  GuideNoteDataUtils.OpenMainView(GuideNoteDefine.Page.DailyTraining)
end

function FuncJumpManager:JumpToGuideNoteWeekTask()
  GuideNoteDataUtils.OpenMainView(GuideNoteDefine.Page.WeeklyTraining)
end

function FuncJumpManager:JumpToActivity(_, _)
  UIManager.Instance:Reopen(Urls.ActivityMainPanel)
end

function FuncJumpManager:JumpSmallSubplotTab(_, feature, _, itemGetConfig)
  local targetStageGroupTid = itemGetConfig and itemGetConfig.Param1
  local extraParam = {targetStageGroupTid = targetStageGroupTid}
  UIManager.Instance:Reopen(Urls.CopyMainView, CommonDefine.MainCopyPanelPage.SmallSubplot, nil, extraParam)
  if CopyDataUtils.CanOpenSubPlotGroupPanel(targetStageGroupTid) then
    CopyDataUtils.OpenSubPlotGroupPanel(targetStageGroupTid)
  end
end

function FuncJumpManager:JumpLargeSubplotTab(_, feature, _, itemGetConfig)
  local targetStageGroupTid = itemGetConfig and itemGetConfig.Param1
  local extraParam = {targetStageGroupTid = targetStageGroupTid}
  UIManager.Instance:Reopen(Urls.CopyMainView, CommonDefine.MainCopyPanelPage.LargeSubplot, nil, extraParam)
  if CopyDataUtils.CanOpenSubPlotGroupPanel(targetStageGroupTid) then
    CopyDataUtils.OpenSubPlotGroupPanel(targetStageGroupTid)
  end
end

function FuncJumpManager:JumpSpecialSubplotTabTab(_, feature, _, itemGetConfig)
  local targetStageGroupTid = itemGetConfig and itemGetConfig.Param1
  local extraParam = {targetStageGroupTid = targetStageGroupTid}
  UIManager.Instance:Reopen(Urls.CopyMainView, CommonDefine.MainCopyPanelPage.SpecialSubplot, nil, extraParam)
  if CopyDataUtils.CanOpenSubPlotGroupPanel(targetStageGroupTid) then
    CopyDataUtils.OpenSubPlotGroupPanel(targetStageGroupTid)
  end
end

function FuncJumpManager:JumpToCollaborationSubplotTab(_, feature, _, itemGetConfig)
  local targetStageGroupTid = itemGetConfig and itemGetConfig.Param1
  local extraParam = {targetStageGroupTid = targetStageGroupTid}
  UIManager.Instance:Reopen(Urls.CopyMainView, CommonDefine.MainCopyPanelPage.LinkageActivity, nil, extraParam)
  if CopyDataUtils.CanOpenSubPlotGroupPanel(targetStageGroupTid) then
    CopyDataUtils.OpenSubPlotGroupPanel(targetStageGroupTid)
  end
end

function FuncJumpManager:_IsRailWayActivityUnlockedByPlayer()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Activity, 0)
  return true == unlocked
end

function FuncJumpManager:_IsRailWayActivityJumpable()
  for activityTid, activityCfg in pairs(DT.Activity) do
    if activityCfg.ActivityType == ActivityDefine.ActivityType.RailWayActivity and ActivityDataUtils.IsActivityOpen(activityTid) then
      return true
    end
  end
  local permanentActivityTidList = ActivityDataUtils.GetShowingPermanentActivityTidList()
  for _, permanentActivityTid in ipairs(permanentActivityTidList) do
    local activityType = ActivityCfgUtils.GetCfgField("ActivityType", permanentActivityTid)
    if activityType == ActivityDefine.ActivityType.RailWayActivity and ActivityDataUtils.IsActivityClosed(permanentActivityTid) then
      return true
    end
  end
  return false
end

function FuncJumpManager:JumpToRailWayActivity(featureConfig)
  local featureKey = featureConfig and featureConfig.Key or 0
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.RailWayActivity, featureKey)
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.RailWayActivity, featureKey)
    return
  end
  if not self:_IsRailWayActivityUnlockedByPlayer() then
    local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(CommonDefine.FeatureId.Activity, 0)
    if not string.isempty(tips) then
      Alert.ShowStr(tips)
    else
      Alert.ShowStr(LT.Text("MainShopSingleBuyConfirmPanel_Lock"))
    end
    return
  end
  if not self:_IsRailWayActivityJumpable() then
    Alert.Show(20183)
    return
  end
  ActivityController.Instance:OpenActivityPermanentsPanel()
end

function FuncJumpManager:JumpToCompose(_, feature, params)
  local itemTid = params
  UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.Compose, itemTid)
end

function FuncJumpManager:JumpToDecompose(_, feature)
  UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.Decompose)
end

function FuncJumpManager:JumpToRecast(_, feature)
  UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.Recast)
end

function FuncJumpManager:JumpToExchange(_, feature, params)
  local itemTid = params
  UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.Exchange, itemTid)
  UIManager.Instance:Reopen(Urls.AlchemyExchangeItemBagView)
end

function FuncJumpManager:JumpToTrinketDecompose(_, feature)
  UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.TrinketDecompose)
end

function FuncJumpManager:JumpFuncMaterialDecompose(jumpFunc, _, itemGetConfig)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.MaterialDecompose, 0)
  if not unlocked then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.MaterialDecompose, 0)
    return
  end
  local itemConversionTid = itemGetConfig.Param1
  UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.ItemDecompose, itemConversionTid)
end

function FuncJumpManager:JumpToAlternationSchoolTower(_, feature)
  UIManager.Instance:Reopen(Urls.DungeonsMainView, CommonDefine.DBGEntryPage.SchoolTowerPanel)
end

function FuncJumpManager:JumpToPVP()
  UIManager.Instance:Reopen(Urls.MainPanelPVP)
end

function FuncJumpManager:JumpToShop(featureConfig, feature, itemTid)
  local MainShopDataUtils = require("Data.MainShopDataUtils")
  local key = featureConfig.Key
  local shopData = MainShopDataUtils.GetShopGoodDataByItemTid(key, itemTid)
  if shopData and shopData.tid and MainShopDataUtils.GetShopItemLockedReason(shopData.tid) then
    Alert.ShowStr(MainShopDataUtils.GetLockShopStr(shopData.tid))
    return
  end
  local shopType2OpenFuncMap = {
    [MainShopDataUtils.GetShopTypeIDByTag(CommonDefine.MainShopTypeTag.Recharge)] = function()
      UIManager.Instance:Reopen(Urls.ChargeMainPanel)
    end
  }
  if shopType2OpenFuncMap[key] then
    shopType2OpenFuncMap[key]()
    return
  end
  UIManager.Instance:Reopen(Urls.MainShopPanel, MainShopDataUtils.GetShopTabType(featureConfig.Key))
end

function FuncJumpManager:JumpToBattlePass(_, feature)
  BattlePassDataUtils.OpenBattlePassPanel()
end

function FuncJumpManager:JumpToGuideNoteSeason()
  GuideNoteDataUtils.OpenMainView(GuideNoteDefine.Page.PermTraining)
end

function FuncJumpManager:JumpToAwakerPage(awakerBasePanelData)
  local function panelOpenFunc()
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end
  
  FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
end

function FuncJumpManager:JumpToAwakerSkill()
  local awakerBasePanelData = {}
  awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Skill
  self:JumpToAwakerPage(awakerBasePanelData)
end

function FuncJumpManager:JumpToAwakerLevel(awakerTid)
  local awakerBasePanelData = {}
  awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
  awakerBasePanelData.selectAwakerId = awakerTid
  self:JumpToAwakerPage(awakerBasePanelData)
end

function FuncJumpManager:JumpToAwakerTrinket()
  local awakerBasePanelData = {}
  awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Trinket
  self:JumpToAwakerPage(awakerBasePanelData)
end

function FuncJumpManager:JumpToAwakerWeapon()
  local awakerBasePanelData = {}
  awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Weapon
  self:JumpToAwakerPage(awakerBasePanelData)
end

function FuncJumpManager:JumpToMainCopy(stageId, stageGroupId, noShowDetail)
  if not self.IsMainCopyUnlock() then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.MainCopy, PlayerDataUtils.GetFeatureMainTypeKey())
    return
  end
  if not self.IsMainStageGroupUnlock(stageGroupId) then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.MainCopy, stageGroupId)
    return
  end
  self.JumpToCopy(stageId, stageGroupId, noShowDetail)
end

function FuncJumpManager:JumpToMainCopyHard(stageId, stageGroupId, noShowDetail)
  if not self.IsHardCopyUnlock() then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.MainCopyHard, PlayerDataUtils.GetFeatureMainTypeKey())
    return
  end
  if not self.IsHardStageGroupUnlock(stageGroupId) then
    PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.MainCopyHard, stageGroupId)
    return
  end
  self.JumpToCopy(stageId, stageGroupId, noShowDetail)
end

function FuncJumpManager.JumpToCopy(stageId, stageGroupId, noShowDetail)
  local stageAllData = DataCenter.MainCopyData.allPlots[stageGroupId]
  local stageData
  for _, data in pairs(stageAllData.stageList) do
    if data.stageID == stageId then
      if not data.unlocked then
        Alert.Show(10569)
        return
      else
        stageData = data
      end
    end
  end
  
  local function panelOpenFunc()
    MainCopyDataUtils.OpenMainCopyChapterPanel(stageGroupId, stageData, noShowDetail)
  end
  
  FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
end

function FuncJumpManager:JumpToCopyEntry()
  UIManager.Instance:Reopen(Urls.CopyMainView)
end

function FuncJumpManager:JumpToActivityMainPanel(activityTid)
  local function panelOpenFunc()
    local data = {targetActivityTid = activityTid}
    
    UIManager.Instance:Reopen(Urls.ActivityMainPanel, data)
  end
  
  FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
end

function FuncJumpManager:FindNewestUnlockStage(stageGroupType)
  local returnStageData, returnStageGroupId, curStageList
  for _, data in pairs(DataCenter.MainCopyData.allPlots) do
    if DT.StageGroup[data.stageGroupID].Type == stageGroupType then
      if data.open == false then
        break
      end
      returnStageGroupId = data.stageGroupID
      curStageList = data.stageList
    end
  end
  for _, data in pairs(curStageList) do
    if data.unlocked then
      returnStageData = data
    end
  end
  return returnStageData, returnStageGroupId
end

function FuncJumpManager:CanJump(itemGetsId, param)
  if not DT.ItemGets[itemGetsId] then
    return false
  end
  local itemGetsCfg = DT.ItemGets[itemGetsId]
  local jumpFunc = itemGetsCfg.JumpFunc
  if self.jumpFuncType2FuncMap[jumpFunc] then
    do return self.jumpFuncType2FuncMap[jumpFunc].CheckFunc, itemGetsCfg end
    return self.jumpFuncType2FuncMap[jumpFunc].CheckFunc, itemGetsCfg, param, nil
  end
  do return self.CanJumpFeature, self, itemGetsCfg end
  return self.CanJumpFeature, self, itemGetsCfg, param
end

function FuncJumpManager:CanJumpFuncBagTrinket()
  return true
end

function FuncJumpManager:CanJumpAwakerDetail()
  return true
end

function FuncJumpManager:CanJumpItemConversion(itemGetsCfg, param)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Compose, 0)
  if not unlocked then
    return false
  end
  return true
end

function FuncJumpManager:CanJumpMaterialDecompose(itemGetsCfg, param)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.MaterialDecompose, 0)
  if not unlocked then
    return false
  end
  return true
end

function FuncJumpManager:CanJumpFeature(itemGetsCfg, param)
  local jumpFunc = itemGetsCfg.JumpFunc
  local featureConfig = DT.FeatureUnlock[jumpFunc]
  if not featureConfig then
    return true
  end
  local feature = featureConfig.Feature
  if feature == CommonDefine.FeatureId.Task then
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Task, featureConfig.Key)
    if not unlocked then
      return false
    end
  else
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(feature, featureConfig.Key or 0)
    if not unlocked then
      return false
    end
    if feature == CommonDefine.FeatureId.Shop and featureConfig.Key and param then
      local shopData = MainShopDataUtils.GetShopGoodDataByItemTid(featureConfig.Key, param)
      if shopData and shopData.tid and MainShopDataUtils.GetShopItemLockedReason(shopData.tid) then
        return false
      end
    end
    if feature == CommonDefine.FeatureId.RailWayActivity then
      if not self:_IsRailWayActivityUnlockedByPlayer() then
        return false
      end
      if not self:_IsRailWayActivityJumpable() then
        return false
      end
    end
  end
  return true
end

function FuncJumpManager:CanJumpStage(itemGetsCfgOrStageId)
  local stageId = tonumber(itemGetsCfgOrStageId)
  if not stageId and type(itemGetsCfgOrStageId) == "table" then
    stageId = itemGetsCfgOrStageId.Param1
  end
  if not stageId then
    return true
  end
  local stageConfig = DT.Stage[stageId]
  local stageGroupId = stageConfig.BelongGroup
  local stageGroupConfig = DT.StageGroup[stageGroupId]
  local stageGroupType = stageGroupConfig.Type
  local rst = false
  if stageGroupType == CommonDefine.StageGroupType.MainCopy then
    rst = self.IsMainCopyUnlock() and self.IsMainStageGroupUnlock(stageGroupId)
  elseif stageGroupType == CommonDefine.StageGroupType.MainCopyHard then
    rst = self.IsHardCopyUnlock() and self.IsHardStageGroupUnlock(stageGroupId)
  end
  if not rst then
    return false
  end
  local stageAllData = DataCenter.MainCopyData.allPlots[stageGroupId]
  for _, data in pairs(stageAllData.stageList) do
    if data.stageID == stageId and not data.unlocked then
      return false
    end
  end
  return true
end

function FuncJumpManager.IsMainCopyUnlock()
  local _, rst = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.MainCopy, PlayerDataUtils.GetFeatureMainTypeKey())
  return rst
end

function FuncJumpManager.IsMainStageGroupUnlock(stageGroupId)
  local _, rst = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.MainCopy, stageGroupId)
  return rst
end

function FuncJumpManager.IsHardCopyUnlock()
  local _, rst = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.MainCopyHard, PlayerDataUtils.GetFeatureMainTypeKey())
  return rst
end

function FuncJumpManager.IsHardStageGroupUnlock(stageGroupId)
  local _, rst = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.MainCopyHard, stageGroupId)
  return rst
end

function FuncJumpManager:OnDestroy()
  Super.OnDestroy(self)
end

function FuncJumpManager:IsJustShow(jumpId)
  local SceneMgr = require("Managers.Scene.SceneMgr")
  local rst = false
  local jumpFunc = DT.ItemGets[jumpId].JumpFunc
  if SceneMgr.Instance:IsInTown() then
    rst = false
  elseif UIManager.Instance:GetWindow(Urls.WorldStageMainPanel) or UIManager.Instance:GetWindow(Urls.DbgBattlePanel) then
    rst = true
  else
    if type(jumpFunc) == "number" then
      local featureConfig = DT.FeatureUnlock[jumpFunc]
      if not self:_IsAlwaysCanJumpFeatrue(featureConfig.Feature) and featureConfig.Key and DT.StageGroup[featureConfig.Key] or self:_IsBattleEntryFeature(featureConfig.Feature) then
        rst = true
      end
    end
    if jumpFunc == CommonDefine.JumpFuncType.Stage or jumpFunc == CommonDefine.JumpFuncType.StageNoDetail then
      rst = true
    end
  end
  return rst
end

function FuncJumpManager:_IsAlwaysCanJumpFeatrue(feature)
  do return table.contains, {
    CommonDefine.FeatureId.Task,
    CommonDefine.FeatureId.Shop
  } end
  return table.contains, {
    CommonDefine.FeatureId.Task,
    CommonDefine.FeatureId.Shop
  }, feature, CommonDefine.FeatureId.Shop
end

function FuncJumpManager:_IsBattleEntryFeature(feature)
  do return table.contains, {
    CommonDefine.FeatureId.DBGCopyGroup,
    CommonDefine.FeatureId.DailyChallenge
  } end
  return table.contains, {
    CommonDefine.FeatureId.DBGCopyGroup,
    CommonDefine.FeatureId.DailyChallenge
  }, feature, CommonDefine.FeatureId.DailyChallenge
end

return FuncJumpManager
