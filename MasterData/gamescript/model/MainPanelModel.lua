local function createMainPanelModelState(ui)
  local state = {}
  
  state.ui = ui
  state.showAwakerTid = nil
  state.curAwakerVoiceContent = ""
  state.curAwakerVoiceEventName = ""
  state.hideHud = false
  state.btnGroupInTop = true
  return state
end

local function createMainPanelModelViews(data)
  local views = {}
  
  function views:GetCurMainCopyNameFirst()
    local storyLineTid = MainCopyDataUtils.GetLatestStoryLineId(MainCopyDataUtils.GetLatestCopyID(CommonDefine.Difficulty.Normal))
    local stageCfg = DT.Stage[storyLineTid]
    return stageCfg and LT.Text(stageCfg.NameNumber) or "找不到配置"
  end
  
  function views:GetCurMainCopyNameSecond()
    local storyLineTid = MainCopyDataUtils.GetLatestStoryLineId(MainCopyDataUtils.GetLatestCopyID(CommonDefine.Difficulty.Normal))
    local rst = StageCfgUtils.GetStageName(storyLineTid, data.ui.Text_MQ_Level) or "找不到配置"
    return rst
  end
  
  function views:GetMainCopyRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local dataFn
    local showFn = RedPointDataUtils.IsShowMainCopy
    return {
      redType,
      dataFn,
      showFn
    }
  end
  
  function views:GetPVPRedValue()
    local redType = CommonDefine.RedDotType.Dot
    
    local function showFn()
      local redValue
      if RedPointDataUtils.IsShowPVPRankReward() or RedPointDataUtils.IsPVPChallengeTaskReward() or RedPointDataUtils.IsPvpSeasonRotationTaskRewardAvailable() or RedPointDataUtils.IsShowCareerLevelReward(CareerLevelDefine.CareerLevelType.PvpPreBuilt) or RedPointDataUtils.IsShowCareerLevelReward(CareerLevelDefine.CareerLevelType.PvpDraft) then
        redValue = RedPointDataUtils.RedAttrType.Red
      else
        redValue = RedPointDataUtils.IsPVPEmojiNew()
      end
      return redValue
    end
    
    return {
      redType,
      nil,
      showFn
    }
  end
  
  function views:GetAwakerRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local showFn = RedPointDataUtils.ShowMainAwaker
    return {
      redType,
      nil,
      showFn
    }
  end
  
  function views:GetMissionRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local showFn = RedPointDataUtils.IsShowTaskSystemRedPoint
    return {
      redType,
      nil,
      showFn
    }
  end
  
  function views:GetSummonRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local showFn = RedPointDataUtils.IsShowSummon
    return {
      redType,
      nil,
      showFn
    }
  end
  
  function views:GetMailBoxRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local showFn = RedPointDataUtils.IsMailBoxRed
    return {
      redType,
      nil,
      showFn
    }
  end
  
  function views:GetShopFreeGoodsRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local showFn = RedPointDataUtils.HasFreeGoods
    return {
      redType,
      nil,
      showFn
    }
  end
  
  function views:GetBpRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local showFn = RedPointDataUtils.IsShowBp
    return {
      redType,
      nil,
      showFn
    }
  end
  
  function views:GetMainCopyRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local dataFn
    local showFn = RedPointDataUtils.IsShowMainCopy
    return {
      redType,
      dataFn,
      showFn
    }
  end
  
  function views:GetDivingRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local dataFn
    local showFn = RedPointDataUtils.IsShowDailyCopyNew
    return {
      redType,
      dataFn,
      showFn
    }
  end
  
  function views:GetAbyssRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local dataFn
    local showFn = RedPointDataUtils.IsShowAbyssRed
    return {
      redType,
      dataFn,
      showFn
    }
  end
  
  function views:GetBagRedValue()
    local redType = CommonDefine.RedDotType.Dot
    local showFn = RedPointDataUtils.IsShowBagRedPoint
    return {
      redType,
      nil,
      showFn
    }
  end
  
  function views:GetSocialRedValue()
    local showFn = RedPointDataUtils.GetSocialRed
    return {
      nil,
      nil,
      showFn
    }
  end
  
  function views:GetDbgRedValue()
    local redType = CommonDefine.RedDotType.Dot
    
    local function showFn()
      local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.DBGCopyGroup, 0)
      print("[GetDbgRedValue] FeatureId.DBGCopyGroup unlock:", unlock)
      if not unlock then
        print("[GetDbgRedValue] DBGCopyGroup 未解锁，红点不显示")
        return false
      end
      local resRed = RedPointDataUtils.IsShowResCopy()
      local trinketRed = RedPointDataUtils.IsShowTrinketNew()
      local weekCopyRed = RedPointDataUtils.IsShowWeekCopyNew()
      local weekBossRed = RedPointDataUtils.IsShowWeekBossNew()
      local schoolTowerRed = RedPointDataUtils.IsShowSchoolTowerNew()
      local dispatchRed = RedPointDataUtils.IsShowDispatchTaskRed()
      print("[GetDbgRedValue] 红点情况", "ResCopy:", resRed, "Trinket:", trinketRed, "WeekCopy:", weekCopyRed, "WeekBoss:", weekBossRed, "SchoolTower:", schoolTowerRed, "Dispatch:", dispatchRed)
      return resRed or trinketRed or weekCopyRed or weekBossRed or schoolTowerRed or dispatchRed
    end
    
    return {
      redType,
      nil,
      showFn
    }
  end
  
  function views:GetMailBoxLocked()
  end
  
  function views:GetRoleName()
    return DataCenter.playerData.DRole.name
  end
  
  function views:GetPlayerLevel()
    return DataCenter.playerData.DRole.level
  end
  
  function views:IsMaxPlayerLevel()
    local maxLvCfg = PlayerDataUtils.GetMaxAccountLevelCfg()
    return maxLvCfg and maxLvCfg.Level == DataCenter.playerData.DRole.level
  end
  
  function views:GetPlayerATK()
    do return end
    return PlayerDataUtils.GetTotalFight
  end
  
  function views:GetExpFillAmount()
    local curExp = DataCenter.playerData.DRole.exp
    local maxExp = DT.AcountLevelConfig[DataCenter.playerData.DRole.level].Exp
    if not maxExp then
      return 1
    end
    if maxExp <= 0 then
      return 0
    end
    local currPercent = curExp / maxExp
    if currPercent > 1 then
      currPercent = 1
    end
    return currPercent
  end
  
  function views:GetExp()
    local curExp = DataCenter.playerData.DRole.exp
    local maxExp = DT.AcountLevelConfig[DataCenter.playerData.DRole.level].Exp
    if not maxExp or maxExp <= 0 then
      return ""
    end
    return curExp .. "/" .. maxExp
  end
  
  function views:GetAwakerName()
    if not data.showAwakerTid or 0 == data.showAwakerTid then
      return
    end
    do return AwakerDataUtils.GetAwakerName end
    return AwakerDataUtils.GetAwakerName, data.showAwakerTid
  end
  
  function views:GetAwakerTalk()
    return data.curAwakerVoiceContent
  end
  
  return views
end

local function createMainPanelModelActions(data)
  local actions = {}
  
  function actions:SetShowAwaker(awakerTid)
    if not awakerTid then
      return
    end
    data.showAwakerTid = awakerTid
  end
  
  function actions:SetBtnGroupInTop(boolVal)
    if nil == boolVal then
      return
    end
    data.btnGroupInTop = boolVal
  end
  
  function actions:SetHideHud(val)
    if nil == val then
      return
    end
    data.hideHud = val
  end
  
  function actions:OnClickPlayerLevel(obj)
    Alert.ShowToolTips(40005, obj)
  end
  
  function actions:OnClickMailBox()
    MailController.Instance:OpenMailView()
  end
  
  function actions:OnClickDbgMainCopy()
  end
  
  function actions:OnBtnNotice()
    AnnouncementDataUtils.OpenAnnouncementPanel()
  end
  
  function actions:OnBtnSocial()
    SocialDataUtils.OpenSocialRelationMainPanel()
  end
  
  function actions:OnBtnGuest()
    UIManager.Instance:Reopen(Urls.SelectShowingAwakerPanel, data)
  end
  
  function actions:OnBtnStore()
    MainShopDataUtils.OnOpenShop()
  end
  
  function actions:OnBtnDungeonNote()
    GuideNoteDataUtils.OpenMainView(GuideNoteDefine.Page.DailyTraining)
  end
  
  function actions:OnBtnFriend()
    UIManager.Instance:Reopen(Urls.ActivityMainPanel)
  end
  
  function actions:OnBtnActivity()
    ActivityDataUtils.OpenActivityMainPanel()
    RedPointDataUtils.ReqRemoveData(RedTypeDefine.RedType.ActivityServer, RedPointDataUtils.RedAttrType.IsNew, 0)
  end
  
  function actions:OnBtnCommunity()
    UIManager.Instance:Reopen(Urls.CommunityJumpPanel)
  end
  
  function actions:OnBtnBp()
    local startCountDown = BattlePassDataUtils.GetStartCountDown()
    if startCountDown then
      Alert.ShowStr(LT.Text(startCountDown))
    else
      BattlePassDataUtils.OpenBattlePassPanel()
    end
  end
  
  function actions:OnBtnPassport()
    local activityList = ActivityManager.Instance.model:GetGamePassports()
    if #activityList > 0 then
      UIManager.Instance:Reopen(Urls.ActivityGamePassportPanel, activityList)
    else
      Alert.Show("BattlePassAllCompleteTips")
    end
  end
  
  function actions:OnBtnRecall()
    ActivityController.Instance:OpenActivityPermanentsPanel()
  end
  
  function actions:OnBtnDiving()
    UIManager.Instance:Reopen(Urls.DailyChallengeView)
  end
  
  function actions:OnBtnAbyss()
    UIManager.Instance:Reopen(Urls.AbyssView)
  end
  
  function actions:OnBtnCollection()
    ArtCollectionController.Instance:OpenArtCollectionView()
  end
  
  function actions:SetCurAwakerVoice(content, eventName)
    data.curAwakerVoiceContent = content
    data.curAwakerVoiceEventName = eventName
  end
  
  function actions:RequestNextRenameTimestamp(callback)
    ProtoManager.Instance:ReqServer("GameRequest", "OnChangeNameTime", function(svrData)
      callback(svrData.expireTime)
    end)
  end
  
  function actions:RequestRename(name, callback)
    ProtoManager.Instance:ReqServer("GameRequest", "OnChangeName", function()
      callback()
    end, nil, name)
  end
  
  function actions:GetRecallEndTime()
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Activity, 0)
    if not unlocked then
      return nil
    end
    local isSeasonTaskDone = SeasonRotationCfgUtils.isSeasonTaskDoneForGameplay(cd.SeasonGameplayType.ConsciousnessRailway)
    if isSeasonTaskDone then
      return nil
    end
    local consciousnessRailwaySeasonId = SeasonRotationModel.Instance:GetSeasonId(cd.SeasonGameplayType.ConsciousnessRailway)
    local timeStamp = consciousnessRailwaySeasonId and SeasonRotationCfgUtils.GetEndTime(consciousnessRailwaySeasonId, cd.SeasonGameplayType.ConsciousnessRailway)
    return timeStamp
  end
  
  function actions:GetDivingEndTime()
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.DailyChallenge, 0)
    if not unlocked then
      return nil
    end
    local isSeasonTaskDone = SeasonRotationCfgUtils.isSeasonTaskDoneForGameplay(cd.SeasonGameplayType.ConsciousnessDiving)
    if isSeasonTaskDone then
      return nil
    end
    local divingSeasonId = SeasonRotationModel.Instance:GetSeasonId(cd.SeasonGameplayType.ConsciousnessDiving)
    local timeStamp = divingSeasonId and SeasonRotationCfgUtils.GetEndTime(divingSeasonId, cd.SeasonGameplayType.ConsciousnessDiving)
    return timeStamp
  end
  
  function actions:GetPvpEndTime()
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.PVP, 0)
    if not unlocked then
      return nil
    end
    local pvpPreSeasonId = SeasonRotationModel.Instance:GetSeasonId(cd.SeasonGameplayType.PvpPreBuilt)
    local pvpDraftSeasonId = SeasonRotationModel.Instance:GetSeasonId(cd.SeasonGameplayType.PvpDraft)
    local pvpPreTimeStamp = pvpPreSeasonId and not SeasonRotationCfgUtils.isSeasonTaskDoneForGameplay(cd.SeasonGameplayType.PvpPreBuilt) and SeasonRotationCfgUtils.GetEndTime(pvpPreSeasonId, cd.SeasonGameplayType.PvpPreBuilt)
    local pvpDraftTimeStamp = pvpDraftSeasonId and not SeasonRotationCfgUtils.isSeasonTaskDoneForGameplay(cd.SeasonGameplayType.PvpDraft) and SeasonRotationCfgUtils.GetEndTime(pvpDraftSeasonId, cd.SeasonGameplayType.PvpDraft)
    local timeStamp = pvpPreTimeStamp and pvpDraftTimeStamp and math.min(pvpPreTimeStamp, pvpDraftTimeStamp) or pvpPreTimeStamp or pvpDraftTimeStamp
    return timeStamp
  end
  
  function actions:GetAbyssEndTime()
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.AbyssChallenge, 0)
    if not unlocked then
      return nil
    end
    local isJoin = AbyssExtModel.Instance:GetMaxScore() >= DT.GetOriginalConstant("AbyssChallengeNoCountdownScore")
    local timeStamp = not isJoin and AbyssExtModel.Instance:GetEndTime()
    return timeStamp
  end
  
  function actions:GetStoreEndTime()
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.Shop, 0)
    if not unlocked then
      return nil
    end
    local timeStamp = LimitTimeGiftUtils.GetShortestEndTime()
    return timeStamp
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindToRaw(function(_, awakerTid)
    if not awakerTid then
      return
    end
    model:SetShowAwaker(awakerTid)
  end, function()
    local boardAwakerTid = DataCenter.playerData.DRole.boardAwaker
    if not boardAwakerTid or 0 == boardAwakerTid then
      DataCenter.playerData.DRole.boardAwaker = DT.GetConstant("DefaultMascotGirl")
    end
    return DataCenter.playerData.DRole.boardAwaker
  end)
end

local MainPanelModel = Vue.model("MainPanelModel", createMainPanelModelState):views(createMainPanelModelViews):actions(createMainPanelModelActions):setup(onSetup)
return MainPanelModel
