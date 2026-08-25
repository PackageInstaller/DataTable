return function(reconnectResponseData)
  PlayerDataUtils.SetPlayerToken(reconnectResponseData.token)
  local playerProfileData = reconnectResponseData.playerProfile
  if playerProfileData then
    PlayerDataUtils.InitBaseData(playerProfileData.base)
    if playerProfileData.itembag then
      ItemDataUtils.InitItems(playerProfileData.itembag)
    end
    PlayerDataUtils.InitFeatureUnlockDataBySvrData(playerProfileData.feature)
    DBGMainCopyDataUtils.InitHardStageData(playerProfileData.hardPlots)
    DBGMainCopyDataUtils.InitMainCopyDataByServerData(playerProfileData.plots)
    MainCopyDataUtils.InitServerPlots(playerProfileData.plots, playerProfileData.hardPlots, playerProfileData.crazyPlots)
    CopyController.Instance:ReqBattleTeachingStageData()
    IntroductionDataUtils.InitIntroData(playerProfileData.intro)
    RedPointDataUtils.AddRedpointDataByServerNotice(playerProfileData.redPoint)
    AwakerDataUtils.InitAwakerMapByServerData(playerProfileData.awakers)
  end
end
