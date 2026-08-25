return function(loginResponseData)
  local mainContainer = Main.Instance.coreContainer
  if not mainContainer:GetComponent(DataResponseMgr) then
    mainContainer:AddComponent(DataResponseMgr)
  end
  local playerProfileData = loginResponseData.playerProfile
  DiamondShopDataUtils.SetDiamondExchangeStates(playerProfileData.Recharge)
  PlayerDataUtils.InitBaseData(playerProfileData.base)
  CareerLevelModel.Instance:UpdateBySvrData(playerProfileData.base.careerReward)
  if playerProfileData.itembag then
    ItemDataUtils.InitItems(playerProfileData.itembag)
  end
  if playerProfileData.timeZone then
    TimeUtils.SetServerTimeZone(playerProfileData.timeZone)
  end
  print("----------------playerProfileData.serverTime", playerProfileData.serverTime, playerProfileData.timeZone)
  if playerProfileData.serverTime then
    TimeUtils.SetServerTime(playerProfileData.serverTime, 0, playerProfileData.timeZone or 0)
  end
  if playerProfileData.zone then
    PlayerDataUtils.SetServerZone(playerProfileData.zone)
  end
  if playerProfileData.versionMeta then
    DataCenter.gameData.serverVersion = playerProfileData.versionMeta
    if playerProfileData.versionMeta.version and playerProfileData.versionMeta.version ~= version() then
      Alert.Show(10737)
    end
  end
  if playerProfileData.Statistics then
    PlayerDataUtils.SetStatsData(playerProfileData.Statistics)
  end
  PlayerDataUtils.InitFeatureUnlockDataBySvrData(playerProfileData.feature)
  DBGMainCopyDataUtils.InitHardStageData(playerProfileData.hardPlots)
  DBGMainCopyDataUtils.InitMainCopyDataByServerData(playerProfileData.plots)
  MainCopyDataUtils.InitServerPlots(playerProfileData.plots, playerProfileData.hardPlots, playerProfileData.crazyPlots)
  CopyController.Instance:ReqBattleTeachingStageData()
  FreeTrialModel.Instance:InitTrailStageIdList()
  IntroductionDataUtils.InitIntroData(playerProfileData.intro)
  RedPointDataUtils.InitPlayerData()
  RedPointDataUtils.InitClientRedData(playerProfileData.redPoint)
  SubplotRedUtils.Init()
  local recoverWorld = playerProfileData.recoverWorld
  local recoverWorldType = playerProfileData.worldType
  if 0 == WorldRecoveryManager.Instance:GetWorldTid() and recoverWorld and recoverWorld > 0 then
    WorldRecoveryManager.Instance:SetRecoverData(recoverWorld, recoverWorldType)
    Logger.Info("OnLoginSuccess Recover Copies", recoverWorld, recoverWorldType)
  end
  if playerProfileData.Effect then
    TalentDataUtils.UpdateTalentDatas(playerProfileData.Effect.effectList)
  end
  if playerProfileData.battlePass then
    BattlePassDataUtils.InitBPData(playerProfileData.battlePass)
  end
  AwakerDataUtils.InitAwakerMapByServerData(playerProfileData.awakers)
  PlayerDataUtils.SetRoleId(loginResponseData.roleId)
  PlayerDataUtils.SetFirstRedemptionCode(true)
  CopyDataUtils.UpdateWeekBossData(playerProfileData.WeekBoss)
  PlayerDataUtils.ShareRewardFinish(playerProfileData.shareReward)
  PlayerDataUtils.BindPhoneRewardFinish(playerProfileData.BindPhoneReward)
  
  local function _GetSurveyData()
    SdkMgr.Instance:GetSurveyList(MailDataUtils.OnHandleSurveyData)
  end
  
  DBGTeamDataUtils.ReqShowTeam(CommonDefine.TeamType.Normal)
  SocialDataUtils.ReqOnGetSocialBasicInfo(function(svrData)
    local assistAwakerData = svrData.facade.team and svrData.facade.team.assistAwaker
    if assistAwakerData and assistAwakerData.tid and 0 ~= assistAwakerData.tid then
      SocialDataUtils.ReqQueryAwaker(DataCenter.playerData.DRole.uid, assistAwakerData.tid, function(data)
        SocialDataUtils.SetPreviewAwakerData(data)
      end)
    end
  end)
  if playerProfileData.Backtrack then
    BackTrackDataUtils.UpdateBackTrack(playerProfileData.Backtrack, true)
  end
  SdkMgr.Instance:SetPlayerInfoCallback(_GetSurveyData)
  Logger.Info("SetPlayerInfoCallback success ")
  local pvpData = playerProfileData.Pvp or {}
  Logger.Info("playerProfileData.Pvp ", table.tostring(pvpData, 5))
  Logger.Info("playerProfileData.BattleFlow ", table.tostring(playerProfileData.BattleFlow))
  local pwdGameInfo = pvpData.passwordGameInfo
  if pwdGameInfo and table.next(pwdGameInfo) then
    PvpPasswordController.Instance:SetLoginPasswordInfo(pwdGameInfo)
  else
    PvPMatchDataUtils.SetIsMatching(pvpData.isMatching)
  end
  PvPMatchDataUtils.SetIsPvpPreparing(pvpData.isPvpPreparing)
  PvPMatchDataUtils.SetDraftScoreCond(pvpData.draftScoreCond)
  PvpPasswordModel.Instance:SetRejectMap(pvpData.pwMatchRejects)
  PvPMatchDataUtils.SetPvpBattleInfo(playerProfileData.BattleFlow and playerProfileData.BattleFlow.battleInfo)
  SocialDataUtils.SetFirstRequestStranger(true)
  AlchemyDataUtils.ReqOnConversionRemainCountGet()
  SettingController.Instance:ReqChangeLanguage(DataCenter.gameData.CurrTextLanguage)
  PopupQueManager.Instance:ClearMonthCardModel()
  AwakerVoiceController.Instance:ReqGetPvpOpeningVoices()
  CommentController.Instance:ReqOnOpen()
  PlayerDataUtils.SetHideReview(playerProfileData.CopyReview and playerProfileData.CopyReview.hideReview or 0)
end
