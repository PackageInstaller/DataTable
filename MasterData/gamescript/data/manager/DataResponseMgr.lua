local tableInsert = table.insert
local DataResponseMgr, Super = System.NewClass("DataResponseMgr", Manager)

function DataResponseMgr:ctor()
  Super.ctor(self)
end

function DataResponseMgr:Awake(binder)
  Super.Awake(self)
  binder:BindResponse(self, "Role", "OnOverseaCommitEvent", System.fn(self, self.OnOverseaCommitEvent))
  binder:BindResponse(self, "Role", "OnSyncSchoolTower", System.fn(self, self.OnSyncSchoolTower))
  binder:BindResponse(self, "Role", "OnSyncFeatureUnlock", System.fn(self, self.OnSyncFeatureUnlock))
  binder:BindResponse(self, "Role", "OnSyncSwitchData", System.fn(self, self.OnSyncSwitchData))
  binder:BindResponse(self, "Role", "OnSyncSocialData", System.fn(self, self.OnSyncSocialData))
  binder:BindResponse(self, "Role", "OnSyncSettingData", System.fn(self, self.OnSyncSettingData))
  binder:BindResponse(self, "Role", "OnSyncBPData", System.fn(self, self.OnSyncBPData))
  binder:BindResponse(self, "Role", "OnUpdatePvpSeasonCollectTimes", System.fn(self, self.OnUpdatePvpSeasonCollectTimes))
  binder:BindResponse(self, "Role", "OnSyncSaveAccountJson", System.fn(self, self.OnSyncSaveAccountJson))
  binder:BindResponse(self, "Role", "OnSyncEnergy", System.fn(self, self.OnSyncEnergy))
  binder:BindResponse(self, "Role", "OnSyncMainShopGoodsRefresh", System.fn(self, self.OnSyncMainShopGoodsRefresh))
  binder:BindResponse(self, "Role", "OnSyncPlayerLevelExp", System.fn(self, self.OnSyncPlayerLevelExp))
  binder:BindResponse(self, "Role", "OnSyncItems", System.fn(self, self.OnSyncItems))
  binder:BindResponse(self, "Role", "OnInitItems", System.fn(self, self.OnInitItems))
  binder:BindResponse(self, "Role", "OnRedPointNotice", System.fn(self, self.OnRedPointNotice))
  binder:BindResponse(self, "Role", "OnRemoveRedPointNotice", System.fn(self, self.OnRemoveRedPointNotice))
  binder:BindResponse(self, "Role", "OnSyncRoleIcon", System.fn(self, self.OnSyncRoleIcon))
  binder:BindResponse(self, "Role", "OnReplaceRole", System.fn(self, self.OnReplaceRole))
  binder:BindResponse(self, "Role", "OnServerNotice", System.fn(self, self.OnServerNotice))
  binder:BindResponse(self, "Role", "OnSyncDefaultCard", System.fn(self, self.OnSyncDefaultCard))
  binder:BindResponse(self, "Role", "OnNoticeShowNewAwaker", System.fn(self, self.OnNoticeSummonGainShowItem))
  binder:BindResponse(self, "Role", "OnSyncTicket", System.fn(self, self.OnSyncTicket))
  binder:BindResponse(self, "Role", "OnSyncShopData", System.fn(self, self.OnSyncMainShop))
  binder:BindResponse(self, "Role", "OnSyncAwakerData", System.fn(self, self.OnSyncAwakerData))
  binder:BindResponse(self, "Role", "OnSyncLotteryPools", System.fn(self, self.OnSyncLotteryPools))
  binder:BindResponse(self, "Role", "SyncEffectList", System.fn(self, self.SyncEffectList))
  binder:BindResponse(self, "Role", "OnSyncAwakerFavorLvUpGrade", System.fn(self, self.OnSyncAwakerFavorLvUpGrade))
  binder:BindResponse(self, "Role", "OnSyncEquips", System.fn(self, self.OnSyncEquips))
  binder:BindResponse(self, "Role", "OnSyncStageInfos", System.fn(self, self.OnSyncStageInfos))
  binder:BindResponse(self, "Role", "OnSyncWeekBossData", System.fn(self, self.OnSyncWeekBossData))
  binder:BindResponse(self, "Role", "OnSyncTaskData", System.fn(self, self.OnSyncTaskData))
  binder:BindResponse(self, "Role", "OnSyncGuideNoteData", System.fn(self, self.OnSyncGuideNoteData))
  binder:BindResponse(self, "Role", "UpdateInviteeFinishTask", System.fn(self, self.UpdateInviteeFinishTask))
  binder:BindResponse(self, "Role", "OnSyncCollectionChange", System.fn(self, self.OnSyncCollectionChange))
  binder:BindResponse(self, "Role", "OnRefreshTimeNotice", System.fn(self, self.OnRefreshTimeNotice))
  binder:BindResponse(self, "Role", "OnSyncPools", System.fn(self, self.OnSyncSummonPools))
  binder:BindResponse(self, "Role", "OnSyncEmail", System.fn(self, self.OnSyncMail))
  binder:BindResponse(self, "Role", "OnSyncLives", System.fn(self, self.OnSyncLives))
  binder:BindResponse(self, "Role", "OnSyncMatchRejects", System.fn(self, self.OnSyncMatchRejects))
  binder:BindResponse(self, "Role", "OnSyncRechargeData", System.fn(self, self.OnSyncRechargeData))
  binder:BindResponse(self, "Role", "OnSyncPvpMatchRst", System.fn(self, self.OnSyncPvpMatchRst))
  binder:BindResponse(self, "Role", "PvpDraftChoices", System.fn(self, self.OnPvpDraftChoices))
  binder:BindResponse(self, "Role", "OnSyncPvpBattleSettleData", System.fn(self, self.OnSyncPvpBattleSettleData))
  binder:BindResponse(self, "Role", "OnCancelMatch", System.fn(self, self.OnCancelMatch))
  binder:BindResponse(self, "Role", "OnNoticeAddiction", System.fn(self, self.OnNoticeAddiction))
  binder:BindResponse(self, "Role", "OnReceiveGood", System.fn(self, self.OnReceiveGood))
  binder:BindResponse(self, "Role", "SyncActivityData", System.fn(self, self.OnSyncActivityData))
  binder:BindResponse(self, "Role", "SyncActivityWorldBossPass", System.fn(self, self.OnSyncActivityWorldBossPass))
  binder:BindResponse(self, "Role", "OnSyncTutorialEntry", System.fn(self, self.OnSyncTutorialEntry))
  binder:BindResponse(self, "Role", "OnPvpRankChange", System.fn(self, self.OnPvpRankChange))
  binder:BindResponse(self, "Role", "OnSyncPasswordData", System.fn(self, self.OnSyncPasswordData))
  binder:BindResponse(self, "Role", "OnSyncExpiredItems", System.fn(self, self.OnSyncExpiredItems))
  binder:BindResponse(self, "Role", "OnSyncBacktrack", System.fn(self, self.OnSyncBacktrack))
  binder:BindResponse(self, "Role", "SyncProduceBox", System.fn(self, self.OnSyncProduceBox))
  binder:BindResponse(self, "Role", "OnMoreGameInvite", System.fn(self, self.OnMoreGameInvite))
  binder:BindResponse(self, "Role", "OnMoreGameResp", System.fn(self, self.OnMoreGameResp))
  binder:BindResponse(self, "Role", "OnCancelMoreGameInvite", System.fn(self, self.OnCancelMoreGameInvite))
  binder:BindResponse(self, "World", "OnSyncPlayerAttrs", System.fn(self, self.OnSyncPlayerAttrs))
  binder:BindResponse(self, "World", "OnAddAwaker", System.fn(self, self.OnAddAwaker))
  binder:BindResponse(self, "World", "OnSyncCurrency", System.fn(self, self.OnSyncCurrency))
  binder:BindResponse(self, "World", "OnSyncCard", System.fn(self, self.OnSyncCard))
  binder:BindResponse(self, "World", "OnSyncRelic", System.fn(self, self.OnSyncRelic))
  binder:BindResponse(self, "World", "OnSyncCopiesItems", System.fn(self, self.OnSyncCopiesItems))
  binder:BindResponse(self, "World", "OnWorldExit", System.fn(self, self.OnWorldExit))
  binder:BindResponse(self, "World", "OnClearFog", System.fn(self, self.OnClearFog))
  binder:BindResponse(self, "World", "OnSyncAwakerAddLike", System.fn(self, self.OnSyncAwakerAddLike))
  binder:BindResponse(self, "World", "OnSyncAreaData", System.fn(self, self.OnSyncAreaData))
  binder:BindResponse(self, "World", "OnSyncTips", System.fn(self, self.OnSyncWorldTips))
  binder:BindResponse(self, "World", "OnSyncCopyRolesAttrs", System.fn(self, self.OnSyncCopyRolesAttrs))
  binder:BindResponse(self, "World", "OnSyncUpdateArgs", System.fn(self, self.OnSyncUpdateArgs))
  binder:BindResponse(self, "World", "OnSyncShopData", System.fn(self, self.OnSyncShopData))
  binder:BindResponse(self, "World", "OnRespawn", System.fn(self, self.OnRespawn))
end

function DataResponseMgr:OnSyncMainShopGoodsRefresh(data)
  Logger.Info("OnSyncMainShopGoodsRefresh ===> data:" .. table.tostring(data))
  local newShopData = MainShopDataUtils.SortAllGoods(data)
  for key, val in pairs(newShopData) do
    MainShopDataUtils.SetShopDataByShopType(key, val)
  end
end

function DataResponseMgr:OnRespawn(data)
  WorldStageManager.Instance:UpdateStageRespawnedNum(data.respawnedNum, data.isRespawn, data.lives)
end

function DataResponseMgr:OnSyncSummonPools(data)
  SummonDataUtils.SyncSummonPool(data)
  EventMgr.Instance.OnSummonRefresh:Dispatch()
end

function DataResponseMgr:OnSyncShopData(data)
  Logger.Info("OnSyncShopData ===> data:" .. table.tostring(data))
  ShopDataUtils.OnShopData(data)
end

function DataResponseMgr:OnSyncCurrency(data)
  Logger.Debug("OnSyncCurrency ===> data:" .. table.tostring(data))
  for _, currency in pairs(data) do
    if currency.type == CommonDefine.MoneyVariable.CopiesMoney then
      WorldstageDMoneyDataUtils.SetGold(currency.value)
    elseif currency.type == CommonDefine.MoneyVariable.ExclusiveMoney then
      WorldstageDMoneyDataUtils.SetExclusiveGold(currency.value)
    end
  end
end

function DataResponseMgr:OnSyncSchoolTower(data)
  Logger.Debug("OnSyncSchoolTower ===> data:" .. table.tostring(data))
  for stageGroupId, info in pairs(data) do
    SchoolTowerDataUtils.UpdateByServerData(info)
  end
end

function DataResponseMgr:OnSyncMainShop(data)
  MainShopDataUtils.OnFreshShop(data)
  ShopDataUtils.UpdateShopDataRed(data)
end

function DataResponseMgr:OnSyncRechargeData(data)
  Logger.Debug("OnSyncRechargeData ===> data:" .. table.tostring(data))
  MainShopDataUtils.OnRefreshChargeData(data)
end

function DataResponseMgr:OnSyncCard(data)
  for _, card in pairs(data) do
    if card.type == "add" then
      CardDataUtils.AddCard(card)
    elseif card.type == "remove" then
      CardDataUtils.RemoveCard(card.uid)
    elseif card.type == "update" then
      CardDataUtils.UpdateCard(card.uid, card)
    end
  end
end

function DataResponseMgr:OnSyncRelic(data)
  Logger.Info("OnSyncRelic ===> data:" .. table.tostring(data))
  local relics = {}
  local relicsRmv = {}
  for _, value in ipairs(data) do
    local relicData = value.relicData
    if relicData.tid == DT.GetConstant("RelicKey") then
      do
        local stageData = WorldStageManager.Instance:GetCurStageData()
        if not stageData.specialItemBag then
          stageData.specialItemBag = {}
        end
        table.insert(stageData.specialItemBag, {
          tid = relicData.tid,
          uid = relicData.uid
        })
      end
    elseif value.type == "add" then
      tableInsert(relics, relicData.uid)
      RelicDataUtils.AddRelic(relicData, true)
    elseif value.type == "update" then
      RelicDataUtils.UpdateRelic(relicData)
    elseif value.type == "remove" then
      tableInsert(relicsRmv, relicData.tid)
      RelicDataUtils.RemoveRelic(relicData.uid)
    end
  end
end

function DataResponseMgr:OnSyncEnergy(data)
  local addEnergy = data.energy - data.oldEnergy
  addEnergy = addEnergy > 0 and addEnergy or 0
  DataCenter.playerData.DRole.oldEnergy = data.oldEnergy
  DataCenter.playerData.DRole.nextEnergyRestoreTimeStamp = data.nextRestoreTimeStamp
  DataCenter.playerData.DRole.energyBuyTimes = data.energyBuyTimes
end

function DataResponseMgr:OnSyncTicket(data)
  Logger.Info("OnSyncTicket => ", table.tostring(data))
  PlayerDataUtils.UpdateTicketData(data)
end

function DataResponseMgr:OnSyncLives(data)
  Logger.Info("OnSyncLives => ", table.tostring(data))
  PlayerDataUtils.UpdateLivesData(data)
end

function DataResponseMgr:OnSyncFeatureUnlock(retData)
  Logger.Info("OnSyncFeatureUnlock rsp data ==> ", table.tostring(retData))
  for tid, unlockDatas in pairs(retData) do
    for typeKey, data in pairs(unlockDatas) do
      local unlock = not data.lock
      local show = not data.notShow
      PlayerDataUtils.UpdateFeatureUnlock(tid, typeKey, unlock, show)
      if unlock then
        PlayerDataUtils.AddFeatureUnlockShowQueue(tid, typeKey)
      end
    end
  end
  EventMgr.Instance.FeatureUnlockEvent:Dispatch(retData)
end

function DataResponseMgr:OnSyncSwitchData(retData)
  Logger.Proto("OnSyncSwitchData rsp data ==> ", table.tostring(retData))
  DataCenter.playerData.FeatureSwitch = retData[1]
end

function DataResponseMgr:OnSyncSocialData(retData)
  SocialDataUtils.OnSyncSocialData(retData)
end

function DataResponseMgr:OnSyncSettingData(retData)
  Logger.Proto("OnSyncSettingData rsp data ==> ", table.tostring(retData))
  SettingManager.Instance:InitServerUseSetting(retData)
end

function DataResponseMgr:OnUpdatePvpSeasonCollectTimes(retData)
  Logger.Info("OnUpdatePvpSeasonCollectTimes rsp data ==> ", table.tostring(retData))
  PvPSeasonDataUtils.InitPvpCollectTimesList(retData[1])
end

function DataResponseMgr:OnSyncBPData(retData)
  local loadServerData = {}
  for _, data in ipairs(retData) do
    for key, val in pairs(data) do
      loadServerData[key] = val
    end
  end
  BattlePassDataUtils.OnSyncBPData(loadServerData)
  EventMgr.Instance.BpSyncData:Dispatch()
end

function DataResponseMgr:OnOverseaCommitEvent(data)
  SdkMgr.Instance:OverSeaCommitEvent(data.eventName)
end

function DataResponseMgr:OnSyncSaveAccountJson(accountData)
  self.accountLen = (self.accountLen or 0) + string.len(accountData.data)
  Logger.Info("OnSyncSaveAccountJson data = ", self.accountLen)
  if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.WindowsEditor then
    Alert.ShowStr("please output acount data at PC platform")
    return
  end
  if 1 == accountData.isFinish and self.saveAccountData then
    self.saveAccountData = self.saveAccountData .. (accountData.data or "")
    UIManager.Instance:Reopen(Urls.GmAccountJsonRenamePanel, self.saveAccountData)
  else
    if not self.saveAccountData then
      self.saveAccountData = ""
    end
    self.saveAccountData = self.saveAccountData .. (accountData.data or "")
  end
end

function DataResponseMgr:OnSyncPlayerLevelExp(data)
  DataCenter.playerData.DRole.oldExp = DataCenter.playerData.DRole.exp
  DataCenter.playerData.DRole.exp = data.exp
  DataCenter.playerData.DRole.originExp = data.originExp
  DataCenter.playerData.DRole.bonusExp = data.bonusExp
  DataCenter.playerData.DRole.dayExp = data.dayExp
  if data.level ~= DataCenter.playerData.DRole.oldLevel then
    DataCenter.playerData.DRole.oldLevel = DataCenter.playerData.DRole.level
    DataCenter.playerData.DRole.level = data.level
    RedPointDataUtils.UpdateAwakerRed()
  end
end

function DataResponseMgr:OnSyncItems(data)
  Logger.Proto("OnSyncItems ===> data:" .. table.tostring(data))
  ItemDataUtils.SyncItemList(data)
end

function DataResponseMgr:OnInitItems(data)
  ItemDataUtils.InitItems(data)
  ActivityDataUtils.CheckNeedReqActivityData()
end

function DataResponseMgr:OnRedPointNotice(data)
  Logger.Info("[Red]OnRedPointNotice")
  RedPointDataUtils.AddRedpointDataByServerNotice(data)
end

function DataResponseMgr:OnRemoveRedPointNotice(data)
  Logger.Info("[Red]OnRemoveRedPointNotice", data.type, data.tid, data.attrType)
  RedPointDataUtils.RemoveData(data.type, data.tid, data.attrType)
end

function DataResponseMgr:OnSyncRoleIcon(data)
  Logger.Info("OnSyncRoleIcon")
  DataCenter.playerData.DRole.icon = data.avatarTid
end

function DataResponseMgr:OnSyncTutorialEntry(data)
  Logger.Info("OnSyncTutorialEntry ===> data:" .. table.tostring(data))
  local popTidGroup = {}
  for sortWeight, tutorialItemData in pairs(data) do
    if type(sortWeight) ~= "number" then
      sortWeight = nil
    end
    TutorialDataUtils.UpdateTutorialItemData(tutorialItemData, sortWeight)
    local tutorialCfg = TutorialDataUtils.GetConfigByTid(tutorialItemData.tid)
    if tutorialItemData.state == CommonDefine.TutorialItemState.Receive and tutorialCfg.Prompt and 1 == tutorialCfg.Prompt then
      table.insert(popTidGroup, tutorialItemData.tid)
    end
  end
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Tutorial, 0)
  if unlock then
    PopTipsManager.Instance:InsertTutorialPopCache(popTidGroup)
  end
end

function DataResponseMgr:OnPvpRankChange(data)
  SeasonRotationController.Instance:OnPvpRankChange(data)
  local preBuiltSeasonData = data.seasonData and data.seasonData[PvpDefine.PvpType.PreBuilt] or nil
  PvPSettleDataUtils.UpdateScore(preBuiltSeasonData and preBuiltSeasonData.score or 0)
  EventMgr.Instance.OnPVPRankChange:Dispatch(data)
end

function DataResponseMgr:OnSyncPasswordData(data)
  PvpPasswordController.Instance:OnSyncPasswordData(data)
end

function DataResponseMgr:OnSyncExpiredItems(data)
  local list = {}
  for uid, item in pairs(data) do
    table.insert(list, item)
  end
  if UIManager.Instance:GetWindow(Urls.BagView) then
    if #list > 0 then
      UIManager.Instance:Show(Urls.ItemExpiredPanel, list)
    else
      ItemDataUtils.UpdateaExpiredItems(list)
    end
  else
    ItemDataUtils.UpdateaExpiredItems(list)
  end
end

function DataResponseMgr:OnSyncBacktrack(data)
  Logger.Proto("OnSyncBacktrack", table.tostring(data))
  BackTrackDataUtils.UpdateBackTrack(data)
  if 0 == data.endTs then
    local allRedData = DataCenter.redPointData
    local backTrackOnce = RedTypeDefine.RedType.BackTrackOnce
    if not allRedData[backTrackOnce] then
      allRedData[backTrackOnce] = {}
    end
    for tid, value in pairs(allRedData[backTrackOnce]) do
      allRedData[backTrackOnce][tid].red = nil
      local cacheKey = CommonDefine.LocalSaveKey.BackTrackOnce .. tid
      MobileFileDataManager.Instance:SetPlayerFileValue(cacheKey, nil)
    end
    MobileFileDataManager.Instance:OnSavePlayerFileInfo()
    RedPointDataUtils.UpdateAwakerRed()
  end
end

function DataResponseMgr:OnSyncActivityData(data)
  print("活动数据同步 ==> ", table.tostring(data))
  if data then
    ActivityDataUtils.UpdateActivityData(data)
    EventMgr.Instance.OnActivityDataSynced:Dispatch(data)
    PopupQueManager.Instance:OnActivityChange()
  end
end

function DataResponseMgr:OnSyncActivityWorldBossPass(data)
  if not data then
    return
  end
  local entries = ActivityRaidUtils.CollectWorldBossKillSyncEntries(data)
  if 0 == #entries then
    return
  end
  local syncMap = {}
  for _, entry in ipairs(entries) do
    local activityTid = entry.activityTid
    local group2Num = entry.group2Num
    if activityTid and type(group2Num) == "table" then
      ActivityRaidUtils.UpdateWorldBossKillCountMap(activityTid, entry)
      EventMgr.Instance.OnActivityWorldBossKillSynced:Dispatch(activityTid)
      syncMap[activityTid] = {}
    end
  end
  if next(syncMap) then
    EventMgr.Instance.OnActivityDataSynced:Dispatch(syncMap)
  end
end

function DataResponseMgr:OnSyncProduceBox(data)
  print("募捐箱数据同步 ==> ", table.tostring(data))
  if data then
    DonationBoxController.Instance:OnSyncProduce(data)
  end
end

function DataResponseMgr:OnMoreGameInvite(data)
  PvPSettleDataUtils.OpenPvPMoreGameInvitedTips(data.name, data.uid)
end

function DataResponseMgr:OnMoreGameResp(data)
  EventMgr.Instance.PvpMoreGameBeRefuse:Dispatch(data)
  UIManager.Instance:CloseByUrl(Urls.AlertConfirm2Panel)
  Alert.ShowStr(LT.Text("PvPMoreGameBeRefusedTips"))
end

function DataResponseMgr:OnCancelMoreGameInvite(data)
  UIManager.Instance:CloseByUrl(Urls.AlertConfirm2Panel)
  Alert.ShowStr(LT.Text("PvPMoreGameBeCancelTips"))
end

function DataResponseMgr:OnSyncPlayerAttrs(data)
  if data[0] then
    PlayerDataUtils.SyncPlayerAttr(data[0])
  end
  CopyAwakerDataUtils.UpdateAwakerAttrs(data)
  WorldStageManager.Instance:UpdatePlayerAttrs(data)
end

function DataResponseMgr:OnSyncUpdateArgs(data)
  WorldStageManager.Instance:UpdateSchoolArgs(data.schoolArgs)
  for awakerTid, args in pairs(data.ultiSkillArgs or {}) do
    WorldStageManager.Instance:UpdateUltiArgs(awakerTid, args.descArgs)
  end
  WorldStageManager.Instance:UpdateKeeperArgs(data.keeperSkillDescArgs or data.keeperSkillArgs)
end

function DataResponseMgr:OnAddAwaker(data)
  Logger.Debug("OnAddAwaker  == %s ", table.tostring(data))
  WorldStageManager.Instance:OnAddAwaker(data)
end

function DataResponseMgr:OnSyncDefaultCard(_)
  AwakerDataUtils.RequestAwakersData()
end

function DataResponseMgr:OnSyncWorldTips(tipsId)
  Alert.Show(tipsId)
end

function DataResponseMgr:OnSyncCopyRolesAttrs(data)
  AwakerDataUtils.UpdateAwakerAttrs(data)
end

function DataResponseMgr:OnSyncCopiesItems(data)
  Logger.Debug("OnSyncGainItems  == %s ", table.tostring(data))
  CopiesDataUtils.CheckBackpackItem(data)
end

function DataResponseMgr:OnReplaceRole(notice)
  local reason
  if type(notice) == "table" then
    reason = notice.reason
  end
  DataCenter.gameData.IsReplaceRole = true
  RpcMgr.Instance:Close()
  if "RepeatedOnline" == reason then
    Alert.Show(20003, nil, function()
      SceneMgr.Instance:EnterLogin()
    end)
  elseif "Shutdown" == reason then
    Alert.Show(20086, nil, function()
      SceneMgr.Instance:EnterLogin()
    end)
  elseif "PlatformKick" == reason then
    Alert.Show(10631, nil, function()
      SceneMgr.Instance:EnterLogin()
    end)
  elseif "KickCopy" == reason then
    Alert.Show(10650, nil, function()
      SceneMgr.Instance:EnterLogin()
    end)
  else
    Alert.Show(20004, nil, function()
      SceneMgr.Instance:EnterLogin()
    end)
  end
end

function DataResponseMgr:OnWorldExit(data)
  CopiesDataUtils.SetSettleDataByProto(data)
  AwakerDataUtils.RevertAwakerAttrExitWorld(data.revertAttrs or {})
  local success, err = xpcall(function()
    CopySettleModel.Instance:UpdateBySvrData(data)
  end, debug.traceback)
  if not success then
    Logger.Error("DataResponseMgr:OnWorldExit UpdateBySvrData failed: %s", tostring(err))
  end
  EventMgr.Instance.OnWorldExit:Dispatch(data)
end

function DataResponseMgr:OnClearFog(data)
  Logger.Info("clearfog", table.tostring(data))
  CopiesDataUtils.ClearFog(data)
end

function DataResponseMgr:OnRecoverWorld(data)
end

function DataResponseMgr:OnServerNotice(data)
  if data.tip then
    Alert.Show(data.tip)
  end
end

function DataResponseMgr:OnDestroy()
  Super.OnDestroy(self)
end

function DataResponseMgr:OnSyncAwakerAddLike(data)
  CopiesDataUtils.OnSyncAwakerAddLike(data)
end

function DataResponseMgr:OnSyncAreaData(data)
  Logger.Debug("OnSyncAreaData", table.tostring(data))
end

function DataResponseMgr:OnNoticeSummonGainShowItem(data)
  Logger.Debug("OnNoticeSummonGainShowItem", table.tostring(data))
  EventMgr.Instance.SummonGainItem:Dispatch(data)
end

function DataResponseMgr:OnSyncAwakerData(data)
  Logger.Info("OnSyncAwakerData", table.tostring(data))
  for tid, v in pairs(data) do
    if not v.tid then
      v.tid = tid
    end
    AwakerDataUtils.UpdateAwakerData(v, v.isAll)
    if v.isAll then
      local specialSkillTid = AwakerDataUtils.GetSpeciallSkillIdByAwaker(tid)
      RedPointDataUtils.AddSpecialSkillRedData(tid, specialSkillTid)
    end
  end
  EventMgr.Instance.AwakerAttrChangeEvent:Dispatch()
end

function DataResponseMgr:OnSyncLotteryPools(svrData)
  ActivityDrawPrizeModel.Instance:UpdateAllPrizePoolDataBySvrData(svrData)
end

function DataResponseMgr:SyncEffectList(data)
  TalentDataUtils.UpdateTalentDatas(data)
end

function DataResponseMgr:OnSyncAwakerFavorLvUpGrade(data)
  CopiesDataUtils.OnSyncAwakerFavorLvUpGrade(data)
end

function DataResponseMgr:OnSyncEquips(data)
  for k, v in pairs(data) do
    if type(v) == "boolean" and not v then
      ItemDataUtils.RemoveEquip(k)
    else
      ItemDataUtils.UpdateEuqipData(k, v)
    end
  end
end

function DataResponseMgr:OnSyncStageInfos(data)
  CopyDataUtils.UpdateCopyData(data)
  EventMgr.Instance.CopyDataUpdateEvent:Dispatch(data)
  DBGMainCopyDataUtils.UpdateStageData(data)
  MainCopyDataUtils.UpdateStageData(data)
  for _, stageGroupData in pairs(data) do
    if stageGroupData and stageGroupData.curPassStageTid and stageGroupData.curPassStageTid > 0 then
      EventMgr.Instance.OnStagePassEvent:Dispatch()
    end
    SubplotRedUtils.UpdateRed(stageGroupData)
  end
  EventMgr.Instance.OnSyncStageInfoEvent:Dispatch()
end

function DataResponseMgr:OnSyncWeekBossData(data)
  CopyDataUtils.UpdateWeekBossData(data)
end

function DataResponseMgr:OnSyncTaskData(data)
  if data.refreshCount then
    TaskDataUtils.SetAppointRefreshCount(data.refreshCount)
  end
  for uid, _ in pairs(data.delList or {}) do
    TaskDataUtils.DeleteTask(uid)
  end
  for _, datainfo in pairs(data.addList or {}) do
    datainfo = TaskProtoCodec.TaskDataToKeyValue(datainfo)
    TaskDataUtils.UpdateTask(datainfo)
    TaskDataUtils.LoadAchievementTaskPopUpTips(datainfo)
  end
  RedPointDataUtils.UpdateAwakerRed()
  RedPointDataUtils.UpdateFreeTrialRed()
end

function DataResponseMgr:OnSyncGuideNoteData(data)
  if not (data and GuideNoteModel) or not GuideNoteModel.Instance then
    return
  end
  GuideNoteModel.Instance:UpdateGuideNoteData(data)
end

function DataResponseMgr:UpdateInviteeFinishTask(inviteeUid, taskMap)
  print("UpdateInviteeFinishTask", inviteeUid, table.tostring(taskMap))
  InvitationCodeController.Instance:UpdateInviteFinishTask(inviteeUid, taskMap, true)
end

function DataResponseMgr:OnSyncCollectionChange(data)
  ArtCollectionModel.Instance:UpdateACData(data)
end

function DataResponseMgr:OnRefreshTimeNotice(data)
  Logger.Debug("OnRefreshTimeNotice data ", table.tostring(data))
  for key, value in pairs(data) do
    if "type" == key and "today" == value then
      PvPTeamBuildDataUtils.Reset()
      PlayerDataUtils.ResetDaily()
      PvPSeasonDataUtils.ClearOpenPvpCache()
      ActivityDataUtils.OnDayRefresh()
      EventMgr.Instance.OnDayRefresh:Dispatch()
    end
  end
end

function DataResponseMgr:OnSyncMail(data)
  if not data then
    return
  end
  EventMgr.Instance.OnMailSyncEvent:Dispatch(data)
end

function DataResponseMgr:OnNoticeAddiction(config)
  SdkMgr.Instance:ShowPopUpWithConfig(config)
end

function DataResponseMgr:OnSyncMatchRejects(data)
  PvpPasswordModel.Instance:UpdateRejectMap(data)
end

function DataResponseMgr:OnSyncPvpMatchRst(data)
  Logger.Info("OnSyncPvpMatchRst => ", table.tostring(data))
  PvPMatchDataUtils.InitBySvrData(data)
  EventMgr.Instance.PvPMatchEnded:Dispatch()
end

function DataResponseMgr:OnPvpDraftChoices(data)
  Logger.Info("OnPvpDraftChoices => ", table.tostring(data))
  PvpDraftModel.Instance:UpdateBySvrData(data)
end

function DataResponseMgr:OnSyncPvpBattleSettleData(data)
  Logger.ReportApusInfo("收到 OnSyncPvpBattleSettleData " .. table.tostring(data and data.statsData or {}))
  PvPSettleDataUtils.InitByServerData(data)
  PvpController.Instance:OnPvpDraftResult(data)
end

function DataResponseMgr:OnCancelMatch(data)
  Logger.Info("OnCancelMatch => ", table.tostring(data))
  PvPMatchDataUtils.SetIsMatching(false)
end

function DataResponseMgr:OnReceiveGood(data)
  Logger.Info("OnReceiveGood => ", table.tostring(data))
  EventMgr.Instance.SocialReceiveGood:Dispatch()
end

return DataResponseMgr
