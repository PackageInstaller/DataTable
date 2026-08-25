local GameEssentialDataRequestor = NewClass("GameEssentialDataRequestor")

function GameEssentialDataRequestor:ctor()
  self.requestList = {
    self.__RequestGmData,
    self.__ReqSummonPoolData,
    self.__RequestTaskData,
    self.__RequestProductList,
    self.__RequestActivityData,
    self.__RequestTutorialData,
    self.__RequestAlchemyData,
    self.__RequestAllResonanceData,
    self.__RequestDailyChallengeData,
    self.__RequestAbyssData,
    self.__RequestPvPTeamBuildData,
    self.__RequestPvPSeasonData,
    self.__RequestTrinketPlanData,
    self.__ReqLargeSubplotGroupResonanceDatas,
    self.__RequestPVPCollectionData,
    self.__RequestArtCollectionData,
    self.__RequestSchoolTowerData,
    self.__ReqDonationBoxData,
    self.__ReqOpenClientData,
    self.__ReqEquipItemDatas,
    self.__ReqWeaponItemDatas,
    self.__RequestAwakersData,
    self.__ReqShopData
  }
end

function GameEssentialDataRequestor:__ReqShopData()
  local _, isOpen = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Shop, PlayerDataUtils.GetFeatureMainTypeKey())
  if isOpen then
    MainShopDataUtils.ReqShopData()
  end
end

function GameEssentialDataRequestor:__RequestAwakersData()
  AwakerDataUtils.RequestAwakersData()
end

function GameEssentialDataRequestor:__ReqWeaponItemDatas()
  ItemDataUtils.ReqWeaponItemDatas()
end

function GameEssentialDataRequestor:__ReqEquipItemDatas()
  ItemDataUtils.ReqEquipItemDatas()
end

function GameEssentialDataRequestor:__ReqDonationBoxData()
  DonationBoxController.Instance:ReqDonationBoxData()
end

function GameEssentialDataRequestor:__ReqOpenClientData()
  ClientDataUtils.ReqOpenClientData()
end

function GameEssentialDataRequestor:__RequestGmData()
  if ApplicationUtils.is_open_gm() then
    GmClientUtils.RequestGmData()
  end
end

function GameEssentialDataRequestor:__ReqSummonPoolData()
  SummonDataUtils.ReqSummonPoolData()
end

function GameEssentialDataRequestor:__RequestTaskData()
  TaskController.Instance:ReqOnTaskOpen()
end

function GameEssentialDataRequestor:__RequestProductList()
  SdkMgr.Instance:ReqProductList()
end

function GameEssentialDataRequestor:__RequestActivityData()
  ActivityDataUtils.ReqActivityData()
end

function GameEssentialDataRequestor:__RequestTutorialData()
  TutorialDataUtils.ReqTutorialData()
end

function GameEssentialDataRequestor:__RequestAlchemyData()
  AlchemyDataUtils.ReqAlchemyData(AlchemyDefine.AlchemyType.Recast)
end

function GameEssentialDataRequestor:__RequestAllResonanceData()
  ResonanceDataUtils.ReqAllResonanceData()
end

function GameEssentialDataRequestor:__RequestDailyChallengeData()
  DailyChallengeController.Instance:ReqOnOpenDailyChallenge()
end

function GameEssentialDataRequestor:__RequestAbyssData()
  AbyssController.Instance:ReqAbyssData()
end

function GameEssentialDataRequestor:__RequestPvPTeamBuildData()
  PvPTeamBuildDataUtils.ReqOnOpenTeam()
end

function GameEssentialDataRequestor:__RequestArtCollectionData()
  ArtCollectionController.Instance:ReqArtCollectionData()
end

function GameEssentialDataRequestor:__RequestPVPCollectionData()
  PVPCollectionDataUtils.InitCollectionDataMap()
end

function GameEssentialDataRequestor:__RequestPvPSeasonData()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.PVP, 0)
  if unlocked then
    PvPSeasonDataUtils.ReqOnOpen()
  end
end

function GameEssentialDataRequestor:__RequestSchoolTowerData()
  SchoolTowerDataUtils.InitSchoolTowerData()
end

function GameEssentialDataRequestor:__RequestTrinketPlanData()
  AwakerTrinketController.Instance:ReqTrinketSuitPlans()
end

function GameEssentialDataRequestor:__ReqLargeSubplotGroupResonanceDatas()
  ResonanceDataUtils.ReqLargeSubplotGroupResonanceDatas()
end

function GameEssentialDataRequestor:Start(isRecoonected)
  self.isRunning = true
  self.curIndex = 0
  self.totalCount = #self.requestList
  self.isRecoonected = isRecoonected
  WaitingView.Instance:Show(self)
  if isRecoonected then
    ReconnectMgr.Instance:SetCustomDoReconnectFunc(nil)
  else
    ReconnectMgr.Instance:SetCustomDoReconnectFunc(function()
      self:_OnDisconnected()
    end)
  end
end

function GameEssentialDataRequestor:Update()
  if not self.isRunning then
    return
  end
  self.curIndex = self.curIndex + 1
  if self.curIndex <= self.totalCount then
    local curFun = self.requestList[self.curIndex]
    curFun(self)
  end
  if self.curIndex >= self.totalCount then
    local lastReq, lastFunName = ProtoManager.Instance:GetLatestReqProto()
    NetBlockMgr.Instance:WaitForProto(lastReq, lastFunName, function()
      return false
    end, function()
      self:_OnDataRequestedFinished(self.isRecoonected)
    end)
    self:Stop()
  end
end

function GameEssentialDataRequestor:Stop()
  self.isRunning = false
  self.curIndex = 0
  WaitingView.Instance:Hide(self)
end

function GameEssentialDataRequestor:_OnDataRequestedFinished(isRecoonected)
  ReconnectMgr.Instance:SetCustomDoReconnectFunc(nil)
  if not isRecoonected then
    PlayerDataRequestor.Instance:Start()
    LoginMgr.Instance:EnterGame()
  else
    PlayerDataRequestor.Instance:Start()
  end
end

function GameEssentialDataRequestor:_OnDisconnected()
  self:Stop()
  ReconnectMgr.Instance:Disable()
  RpcMgr.Instance:Disconnect()
  DataCenter.playerData.netDelayTime = 0
  LoginMgr.Instance:ResetAllData()
  NetBlockMgr.Instance:ClearBlockedMsgs()
  WaitingView.Instance:CancelAll()
  Alert.Show(10108)
  EventMgr.Instance.LoginErrorEvent:Dispatch()
end

GameEssentialDataRequestor.Instance = GameEssentialDataRequestor()
return GameEssentialDataRequestor
