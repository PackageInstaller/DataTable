local View = require("UIMainUI/UIMainUIView")
local ViewFunction = require("UIMainUI/UIMainUIViewFunction")
local Controller = require("UIMainUI/UIMainUIController")
local DataModel = require("UIMainUI/UIMainUIDataModel")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local TradeController = require("UIHome/UIHomeTradeController")
local MapDataModel = require("UIHome/UIHomeMapDataModel")
local MapController = require("UIHome/UIHomeMapController")
local HomeController = require("UIHome/UIHomeController")
local HomeCoachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
local HomeCoachController = require("UIHomeCoach/UIHomeCoachController")
local Timer = require("Common/Timer")
local RenderSettingController = require("UIMainUI/UIMainUIRenderSettingController")
local liveController = require("UINewHomeLive/UINewHomeLiveController")
local emergencyDataModel = require("UIHomeEmergency/UIHomeEmergencyDataModel")
local homeFoodController = require("UIHomeFood/UIHomeFoodController")
local passengerDataModel = require("UIPassenger/UIPassengerDataModel")
local StageQuestDataModel = require("UIStageQuest/UIStageQuestDataModel")

local function RefreshMissIonRed()
  View.Group_Common.Group_TopRight.Btn_Mission.Img_Remind:SetActive(false)
  if PlayerData:GetAllBattlePassRedState() then
    View.Group_Common.Group_TopRight.Btn_Mission.Img_Remind:SetActive(true)
  end
end

local function OpenPanelCallBack(prefabUrl)
  if prefabUrl == "UI/MainUI/MainUI" then
    local remainTime = DataModel.RushServerTime - TimeUtil:GetServerTimeStamp()
    if remainTime == nil or remainTime <= 0 then
      Controller.SetRushEffectState()
      Controller.SetRushState(false)
    elseif remainTime < 18 and 0 < remainTime then
      Controller.SetRushState(false)
    end
  end
end

local BackgroundGravityMove = {
  _CurrentAcceleration = nil,
  _Config = {
    speed = 500,
    lerp = 0.05,
    xMaxDistance = 150,
    yMaxDistance = 80,
    kEpsilonSqrt = 50
  },
  InitParams = function(self)
    self._CurrentAcceleration = Input.acceleration
    local user_info = PlayerData:GetUserInfo()
    local Group_TopLeft = View.Group_TopLeft
    local Group_Left = View.Group_TopLeft
    if user_info == nil then
      Group_Left.Btn_Commander.Txt_Lv.Txt_Num_0:SetText(1)
      Group_Left.Btn_Commander.Txt_Name:SetText("")
      Group_Left.Btn_Commander.Txt_UID.Txt_Num_3:SetText("")
      Group_TopLeft.Btn_Diamond.Txt_Num:SetText(0)
      Group_TopLeft.Btn_Energy.Txt_Num:SetText(0)
      Group_TopLeft.Btn_Gold.Txt_Num:SetText(0)
    else
      Group_Left.Btn_Commander.Txt_Lv.Txt_Num_0:SetText(user_info.lv or 1)
      if user_info.role_name == nil then
        Group_Left.Btn_Commander.Txt_Name:SetText("")
      else
        Group_Left.Btn_Commander.Txt_Name:SetText(user_info.role_name)
      end
      Group_Left.Btn_Commander.Txt_UID.Txt_Num_3:SetText(user_info.uid)
      Group_TopLeft.Btn_Diamond.Txt_Num:SetText(user_info.bm_rock or 0)
      if user_info.max_energy then
        Group_TopLeft.Btn_Energy.Txt_Num:SetText(user_info.energy .. "/" .. user_info.max_energy or 0)
      else
        Group_TopLeft.Btn_Energy.Txt_Num:SetText(user_info.energy or 0)
      end
      Group_TopLeft.Btn_Gold.Txt_Num:SetText(user_info.gold or 0)
      local endExp = PlayerData:GetMaxExp()
      Group_Left.Btn_Commander.Group_ExpBar.Img_Bar:SetFilledImgAmount(user_info.exp / endExp)
    end
    local count, state = PlayerData:GetUnreadMailNum()
    View.Group_BottomLeft.Btn_Mail.Img_Remind.self:SetActive(state)
    View.Group_BottomLeft.Btn_Mail.Img_Remind.Txt_Num:SetText(count)
    View.Group_BottomLeft.Btn_Friends.Img_Remind.self:SetActive(false)
  end,
  GetPosition = function(self, currentPos)
    local x_move = Input.acceleration.x - self._CurrentAcceleration.x
    local y_move = Input.acceleration.y - self._CurrentAcceleration.y
    local position = Vector3()
    position.x = MathEx.Clamp(x_move * self._Config.speed, -self._Config.xMaxDistance, self._Config.xMaxDistance)
    position.y = MathEx.Clamp(y_move * self._Config.speed, -self._Config.yMaxDistance, self._Config.yMaxDistance)
    if (currentPos - position).sqrMagnitude > self._Config.kEpsilonSqrt then
      return Vector3.Lerp(currentPos, position, self._Config.lerp)
    end
    self._CurrentAcceleration = Input.acceleration
    return currentPos
  end
}

local function AutoUseBullet()
  if not DataModel.isRun then
    return
  end
  if not DataModel.autoUseBullet then
    return
  end
  if PlayerData:GetHomeInfo().readiness.fuel.fuel_num <= 0 then
    return
  end
  if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Coach or DataModel.CurSceneName == DataModel.SceneNameEnum.Home then
    return
  end
  Controller.Rush()
end

local Luabehaviour = {
  serialize = function()
    local t = {}
    t.ShowPosterGirl = DataModel.isPosterGirlShow
    t.IsGoHomeCoach = DataModel.IsGoHomeCoach
    t.isGoMapStation = DataModel.isGoMapStation
    return Json.encode(t)
  end,
  deserialize = function(initParams)
    Controller.InitScrollAd()
    if PlayerData.ServerData.furnitureCount == nil then
      TimerHelper.StartOnce("GetFurnitureCount", 2, function()
        Net:SendProto("furniture.furniture", function(netData)
          PlayerData.ServerData.furnitureCount = {}
          for k, v in pairs(netData.furniture) do
            local curCount = PlayerData.ServerData.furnitureCount[v.id] or 0
            PlayerData.ServerData.furnitureCount[v.id] = curCount + 1
          end
        end)
      end)
    end
    View.Group_Common.Btn_Safe:SetSprite(GetResPath(88300295))
    local forceShowPosterGirl = false
    DataModel.IsActivity = false
    if initParams ~= nil then
      local data = Json.decode(initParams)
      if data then
        if data.ShowPosterGirl ~= nil and DataModel.isPosterGirlShow then
          forceShowPosterGirl = data.ShowPosterGirl
        end
        if data.IsGoHomeCoach ~= nil then
          DataModel.IsGoHomeCoach = true
        end
        if data.isActivity then
          DataModel.IsActivity = true
        end
        if data.isGoMapStation then
          DataModel.initMapStation = data.isGoMapStation
        end
      end
    end
    View.Group_Common.Btn_StageQuest:SetActive(PlayerData:GetFactoryData(99900001).isStageQuest)
    if PlayerData:GetFactoryData(99900001).isStageQuest then
      View.Group_Common.Btn_StageQuest.Img_Red:SetActive(StageQuestDataModel:GetRedPoint(nil))
    end
    View.Group_Common.Btn_BlackMoon.Img_Red:SetActive(RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. 40300012) > 0)
    DataModel.CurFrame = 0
    DataModel.FirstFrame = true
    DataModel.GetCurShowSceneInfo()
    DataModel.roleId = ""
    Controller:ShowPosterGirl(false)
    DataModel.CurSceneName = MainManager.bgSceneName
    View.self:SetEnableAnimator(true)
    DataModel.isOpenView = true
    Controller:Init()
    Controller:InitCommonShow()
    Controller:ChangeDashBoard()
    DataModel.curTimeEffect = ""
    PlayerData.FreeCameraIndex = PlayerData.FreeCameraIndex or 1
    TradeDataModel.CurRemainDistance = TrainManager.RemainDistance
    if PlayerData.TempCache.FirstLogin then
      if not TrainManager.IsRunning then
        DataModel.RefreshData(PlayerData.ServerData.user_home_info.coach)
        TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.FirstLogin)
        Controller.ChangeDriveBtnState()
      end
      PlayerData.TempCache.FirstLogin = false
    end
    if PlayerData.TempCache.EventFinish then
      Controller.MainLineEventShow(DataModel.TrainEventId, false, false)
      Controller:RunBtnState(true)
      Controller.OpenBattleLoss()
      MapController:SetPolluteLines()
    else
      Controller.MainLineEventShow(DataModel.TrainEventId, true, false)
    end
    Controller:PlayBGM()
    Controller.SetSpeedAddShow()
    Controller.ShowWarning(false)
    TradeDataModel.RefreshStockInfo()
    MapDataModel.TravelLineWayPoints = {}
    MapDataModel.HomeMapType = 1
    MapController:ShowDetailMap(false, true)
    Controller.ChangeDriveBtnState()
    Controller:InitDrinkBuffShow()
    Controller:InitSpeedUpBuffShow()
    Controller:InitBattleUpBuffShow()
    Controller.RefreshTrainMove(true)
    if PlayerData.TempCache.MainUIShowState ~= 0 then
      Controller:SwitchTab(PlayerData.TempCache.MainUIShowState, true)
    end
    if DataModel.CurSceneName == DataModel.SceneNameEnum.Main then
      TradeDataModel.DelayPer = 0
      local guideId = GuideManager:GetCurrentClientGuideNO()
      if guideId == -1 then
        guideId = PlayerData:GetUserInfo().newbie_step
      end
      if 5 < guideId then
        Controller.isInitEffect = false
        TradeDataModel.SetTrainMode(function()
          View.Group_Common.Group_Position.self:SetActive(TradeDataModel.GetInTravel())
          Controller:InitCheDengLight()
          if Controller.isInitEffect == false then
            Controller:InitTrainEffect()
          end
          Controller.SetTrainBreakEffect()
          PlayerData:GetPolluteTurntable()
          if TrainManager.CurrTrainState == TrainState.Event then
            Controller.SetCamera(2)
          else
            Controller.SetCamera(PlayerData.FreeCameraIndex)
          end
          if PlayerData.BattleInfo.BattleResult and PlayerData.BattleInfo.BattleResult.isWin and PlayerData.BattleInfo.battleStageId then
            local sessionController = require("UIMapSession/UIMapSessionDataModelController")
            sessionController:ExitToSession(tonumber(PlayerData.BattleInfo.battleStageId))
          end
        end)
        if PlayerData.TempCache.MainUIShowState == 0 then
          Controller:SwitchTab(DataModel.UIShowEnum.OutSide, true)
        end
      end
    elseif DataModel.CurSceneName == DataModel.SceneNameEnum.Home then
      HomeCoachDataModel.InitRoomData()
      HomeCharacterManager:ReShowAll(true)
      CharacterUtil.InitCharacterOp()
      passengerDataModel.InitPassengerSit(true)
      if PlayerData.TempCache.MainUIShowState == 0 then
        Controller:SwitchTab(DataModel.UIShowEnum.Coach, true)
      end
    end
    if LoadingManager.isLoading then
      LoadingManager:SetLoadingPercent(1)
    end
    Controller.SetQuestTrace()
    DataModel:InitRoleTrustData()
    Controller.ShowHelpButton()
    for i = 1, 10 do
      local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. i]
      if viewGroup == nil then
        break
      end
      local isShowGetTrustBtn = TimeUtil:GetServerTimeStamp() - PlayerData:GetUserInfo().receptionist_ts[1] > 3600 and false
      viewGroup.Viewport.Content.Group_PosterGirl.Btn_GetTrust:SetActive(isShowGetTrustBtn)
    end
    RefreshMissIonRed()
    Controller.ReachNewCityRoleTip()
    if forceShowPosterGirl and not DataModel.isPosterGirlShow then
      Controller:ShowPosterGirl(true, true)
    end
    Controller.FuncActive()
    Controller.RepRedPointCheck()
    PlayerData:SetTargetFrameRate()
    if UseGSDK then
      GSDKManager:OnRequestProductInfo()
    end
    if DataModel.TrailerCityId then
      Controller.BackShow(false)
    end
    View.timer_2 = Timer.New(2, function()
      CommonTips.OpenMainUITips()
      View.timer_2:Stop()
      View.timer_2 = nil
    end)
    View.timer_2:Start()
    PlayerData:SetSound()
    Controller.ShowEndActive(PlayerData:GetHomeInfo().station_info.is_arrived == 1)
    if PlayerData:GetPlayerPrefs("int", "IsAutoBuyRoad") == 1 and PlayerData:GetHomeInfo().drive_setup.money ~= 1 then
      PlayerData:GetHomeInfo().drive_setup.money = 1
    end
    if PlayerData:GetPlayerPrefs("int", "autoUseBullet") == 1 and PlayerData:GetHomeInfo().drive_setup.rush ~= 1 then
      PlayerData:GetHomeInfo().drive_setup.rush = 1
    end
    if PlayerData:GetPlayerPrefs("int", "IsAutoStrike") == 1 and PlayerData:GetHomeInfo().drive_setup.assault ~= 1 then
      PlayerData:GetHomeInfo().drive_setup.assault = 1
    end
    if PlayerData:GetPlayerPrefs("int", "IsAutoFight") == 1 and PlayerData:GetHomeInfo().drive_setup.bar ~= 1 then
      PlayerData:GetHomeInfo().drive_setup.bar = 1
    end
    DataModel.autoUseBullet = PlayerData:GetHomeInfo().drive_setup.rush ~= 0
    if PlayerData.TempCache.MainUIShowState ~= 4 and (DataModel.initMapStation or DataModel.isGoMapStation) then
      local stationId = DataModel.initMapStation
      if stationId == nil and DataModel.isFlierSuccess then
        stationId = DataModel.isGoMapStation
      end
      if stationId then
        MapController:AutoToClickStation(stationId, true)
      end
      DataModel.isGoMapStation = nil
      DataModel.initMapStation = nil
    end
    DataModel.isFlierSuccess = nil
    Controller.ClosePrisonScene()
    if View.Obj_AdBoard ~= nil and not View.Obj_AdBoard:IsNull() then
      local adBoard = View.Obj_AdBoard:GetComponent(typeof(CS.AdBoardView))
      if adBoard then
        DataModel.UpdateAdvList(adBoard)
      end
    end
    local worldBossCfg = PlayerData:GetFactoryData(86000117)
    if worldBossCfg and TimeUtil:IsActive(worldBossCfg.startTime, worldBossCfg.endTime) and PlayerData:GetActivityAct(86000117) then
      Net:SendProto("activity.get_boss_info", function(json)
        PlayerData.ServerData.all_activities.ing["86000117"] = json.activity
        PlayerData.ServerData.all_activities.ing["86000117"].world_bosses = json.world_bosses
        Controller.FuncActive_WorldBoss()
      end, 86000117)
    end
    Controller.GuideAsset()
  end,
  awake = function()
    if CS.UIManager.persistantList:Contains("UI/Witches/Main/WitchMain") ~= true then
      CS.UIManager.persistantList:Add("UI/Witches/Main/WitchMain")
    end
    MapDataModel.InitLineInfo()
    TradeDataModel.SpeedRatio = PlayerData:GetFactoryData(99900014, "ConfigFactory").speedRatio
    View.timer = Timer.New(3, function()
      if not LoadingManager.isLoading and MapDataModel.HomeMapType ~= 2 then
        Controller:RandomPlayRoleSound()
      else
        View.timer.delay = 2
      end
    end)
    if not UIManager:IsPanelOpened("UI/GloablePanel/GloablePanel") then
      UIManager:OpenSpecialUI("UI/GloablePanel/GloablePanel")
    end
  end,
  start = function()
    DataModel.cameraTween = true
    DataModel.GetCurShowSceneInfo()
    DataModel.RefreshData(PlayerData.ServerData.user_home_info.coach)
    View.Btn_Revenue:SetActive(false)
    Controller:RefreshHomeMap()
    if MainManager.bgSceneName == DataModel.SceneNameEnum.Main then
      TrainCameraManager:SetPostProcessing(1, DataModel.CurShowSceneInfo.postProcessingPath)
      if PlayerData.TempCache.MainUIShowState ~= DataModel.UIShowEnum.OutSide and PlayerData.TempCache.MainUIShowState ~= DataModel.UIShowEnum.Passenger then
        Controller:SwitchTab(DataModel.UIShowEnum.OutSide)
      end
      Controller.InitTrain(false)
    elseif MainManager.bgSceneName == DataModel.SceneNameEnum.Home then
      if PlayerData.TempCache.MainUIShowState ~= DataModel.UIShowEnum.Coach then
        Controller:SwitchTab(DataModel.UIShowEnum.Coach)
      end
      TrainCameraManager:OpenCamera(2)
      CommonCoachData.InitCoachBagTagId()
      CommonCoachData.RefreshData()
      HomeController:RefreshTrains()
      HomeCoachController:InitEnvironment()
      HomeCoachDataModel.InitRoomData()
      HomeCoachDataModel.InitPresetData(PlayerData.ServerData.user_home_info.pre_dress_up)
      HomeCoachDataModel.CalcCurrentCharacter()
      HomeCoachDataModel.CalcCurrentPet()
      HomeCoachDataModel.RemoveNoEmptyRoomCharacter()
      passengerDataModel.CreateHomePassenger()
      passengerDataModel.InitPassengerSit()
      HomeCharacterManager:CreateAll(HomeCoachDataModel.characterData, HomeCoachDataModel.petData)
      CharacterUtil.InitCharacterOp()
      HomeManager:OpenHome(0)
    end
    View.touchCamera = nil
    DataModel.aniGroupColorTime = 30
    DataModel.aniGroupColor = false
    DataModel.groupColorRotation = View.Group_Common.Group_MB.Group_PollutionIndex.Img_Mask.Group_Color.self.transform.rotation.z
    if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
      Controller.SetTouchCamera()
      DataModel:GetNextSoundTime()
      View.timer:Start()
      if PlayerData:GetHomeInfo().station_info.is_arrived == 1 or PlayerData.showPosterGirl == -1 then
        View.timer:Pause()
      end
    end
  end,
  update = function()
    if DataModel.FirstFrame then
      DataModel.FirstFrame = false
      MapController:ReSizeMapToView()
      CommonTips.OpenADPop()
    end
    if Controller.scrollAd then
      Controller.scrollAd:OnUpdate()
    end
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local totalDis = math.floor(TradeDataModel.GetCurrTravelDis() * homeConfig.disRatio)
    local mainConfig = PlayerData:GetFactoryData(99900034, "ConfigFactory")
    totalDis = totalDis > mainConfig.mileageMax and mainConfig.mileageMax or totalDis
    View.Group_Common.Group_MB.Img_Speed.Txt_Num:SetText(totalDis)
    if TradeDataModel.GetIsTravel() then
      MapController:RefreshStationPosImmediately()
      if MapDataModel.HomeMapType == 1 then
        MapController:RefreshViewToTrain()
      end
      Controller.RefreshTrainMove()
      if TrainManager.CurrTrainState == TrainState.Running or TrainManager.CurrTrainState == TrainState.Rush then
        if TrainManager.CurrSpeed == TrainManager.TargetSpeed then
          if Time.fixedUnscaledTime >= DataModel.FixedTime + 1 then
            DataModel.FixedTime = Time.fixedUnscaledTime
            local currSpeed = math.random(-4, 4) + TrainManager.CurrSpeed * TradeDataModel.SpeedRatio
            Controller.SetSpeedShow(currSpeed, true)
          end
        else
          Controller.SetSpeedShow(TrainManager.CurrSpeed * TradeDataModel.SpeedRatio)
        end
      else
        Controller.SetSpeedShow(TrainManager.CurrSpeed * TradeDataModel.SpeedRatio)
      end
      if DataModel.GetTrainEventId() and (TrainManager.CurrStrikeState == StrikeState.Ready or TrainManager.CurrStrikeState == StrikeState.Start) then
        local percent = DataModel.GetStrikeSuccessPercent(DataModel.GetTrainEventId(), DataModel.GetTrainLineId())
        View.Group_Common.Group_MB.Img_Durability.Group_Start.Txt_Success:SetText(percent .. "%")
        View.Group_Common.Group_MB.Group_Strike.Group_Start.Txt_Success:SetText(percent .. "%")
      end
      Controller:JudgementReachArea()
      Controller:JudgementReachAttraction()
      if View.Obj_AdBoard ~= nil and View.Obj_AdBoard:IsNull() then
        View.Obj_AdBoard = nil
      end
      View.Btn_AdBoard:SetActive(false)
    else
      if PlayerData.TempCache.IsTrailer and PlayerData.TempCache.IsBlackOver and not DataModel.IsShow then
        DataModel.IsShow = true
        CommonTips.OnPrompt("80601271", "80600068", "80600067", function()
          PlayerData.TempCache.IsTrailer = false
          PlayerData.TempCache.IsBlackOver = false
          PlayerData.TempCache.IsHelp = false
          DataModel.IsShow = false
          local CarriageDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
          local FixDataModel = require("UIHomeCarriageeditor/UIFixDataModel")
          local t = {
            CurrTag = CarriageDataModel.TagType.Fix,
            ChildTag = FixDataModel.TagType.Repair
          }
          CommonTips.OpenToHomeCarriageeditor(t)
        end, function()
          PlayerData.TempCache.IsBlackOver = false
          PlayerData.TempCache.IsTrailer = false
          PlayerData.TempCache.IsHelp = false
          DataModel.IsShow = false
        end)
      end
      if View.Obj_AdBoard == nil or View.Obj_AdBoard:IsNull() then
        View.Obj_AdBoard = CS.UnityEngine.GameObject.Find("AD_Board")
        if View.Obj_AdBoard ~= nil and not View.Obj_AdBoard:IsNull() then
          local adBoard = View.Obj_AdBoard:GetComponent(typeof(CS.AdBoardView))
          if adBoard then
            DataModel.UpdateAdvList(adBoard)
          end
        end
      end
      local adBoardObj = View.Obj_AdBoard
      if MainManager.bgSceneName == "Main" and adBoardObj ~= nil and PlayerData:GetHomeInfo().station_info.stop_info[2] == -1 then
        local cam = TrainCameraManager:GetCamera(1)
        local pos1 = cam:WorldToScreenPoint(adBoardObj.transform.position)
        local pos2 = UIManager.UICamera:ScreenToWorldPoint(Vector3(pos1.x, pos1.y, 100))
        View.Btn_AdBoard:SetActive(true)
        View.Btn_AdBoard.transform.position = Vector3(pos2.x, pos2.y, View.Btn_AdBoard.transform.position.z)
      else
        View.Btn_AdBoard:SetActive(false)
      end
    end
    Controller.RefreshTrainMove()
    if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home and View.timer and PlayerData:GetHomeInfo().station_info.is_arrived == 2 then
      View.timer:Update()
    end
    if View.timer_2 then
      View.timer_2:Update()
    end
    MapController.RefreshSoftMaskPosition()
    MapController:HandleScaleMap()
    Controller:CheckDrinkBuffShow()
    Controller:CheckSpeedUpBuffShow()
    Controller:CheckBattleUpBuffShow()
    if DataModel.aniGroupColor == true then
      DataModel.aniGroupColorTime = DataModel.aniGroupColorTime - 1
      local Group_Color = View.Group_Common.Group_MB.Group_PollutionIndex.Img_Mask.Group_Color
      if DataModel.groupColorRotation < DataModel.average_value then
        DataModel.groupColorRotation = DataModel.groupColorRotation + (DataModel.average_value - DataModel.groupColorRotation) / 30
      end
      if DataModel.groupColorRotation > DataModel.average_value then
        DataModel.groupColorRotation = DataModel.groupColorRotation - (DataModel.groupColorRotation - DataModel.average_value) / 30
      end
      Group_Color:SetLocalEulerAngles(DataModel.groupColorRotation)
      if DataModel.aniGroupColorTime <= 0 then
        Group_Color:SetLocalEulerAngles(DataModel.average_value)
        DataModel.aniGroupColor = false
        DataModel.aniGroupColorTime = 30
      end
    end
    Controller:RefreshFestivalGift()
    Controller:UpdateView()
    if MainManager.bgSceneName == DataModel.SceneNameEnum.Home then
      liveController.RefreshAllAutoSleep()
      liveController.RoleSleepTimeUpdate()
    end
    Controller.SpineBgFollow()
    MapController:UpdateMapNeedleIcon()
    Controller.RefreshRevenueRedPoint()
    Controller.UpdateGuideAsset()
  end,
  ondestroy = function()
    if Controller.scrollAd then
      Controller.scrollAd:Dispose()
    end
    DataModel.roleId = ""
    DataModel.isOpenView = false
    MapDataModel.MapDetailMask = nil
    MapDataModel.MapCanvasGroup = nil
    MapDataModel.MapScrollRect = nil
    MapDataModel.trainDirection = nil
    MapController:CleanPolluteLinesData()
    MapController.ClearMapNeedle()
    if DataModel.CacheQuestAwardCo then
      View.self:StopC(DataModel.CacheQuestAwardCo)
      DataModel.CacheQuestAwardCo = nil
    end
    if DataModel.passengerCoroutine then
      View.self:StopC(DataModel.passengerCoroutine)
      DataModel.passengerCoroutine = nil
    end
    PlayerData.TempCache.ADPopInfo.StopOpen = false
  end,
  enable = function()
    EventMgr:SendEvent("event_uimainui_enable")
    SdkReporter.TrackBackMainUI()
    print_r("==============ENABLE=====================")
    print_r(MainManager.bgSceneName)
    if MainManager.bgSceneName == DataModel.SceneNameEnum.Main then
      if not TradeDataModel.GetInTravel() then
        PlayerData.TempCache.MainUIOpenCamera = true
        TrainCameraManager:OpenCamera(1)
      else
        TrainCameraManager:OpenCamera(0)
      end
    else
      TrainCameraManager:OpenCamera(2)
    end
    ListenerManager.AddListener(ListenerManager.Enum.SetQuestTrace, "MainUI", function(id)
      Controller.SetQuestTrace()
    end)
    ListenerManager.AddListener(ListenerManager.Enum.CompleteQuestInQuestTrace, "MainUI", function(id)
      Controller.SetQuestTrace()
    end)
    View.Group_Adjutant.Btn_Achieve.Img_Red:SetActive(0 < RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.AchievementUI))
    RedpointTree:SetCallBack(RedpointTree.NodeNames.AchievementUI, "AchievementUI", function(redpointCnt)
      View.Group_Adjutant.Btn_Achieve.Img_Red:SetActive(0 < redpointCnt)
    end)
    View.Group_OutSide.Group_Station.Btn_Achieve.Img_Red:SetActive(RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.AchievementUI) > 0)
    RedpointTree:SetCallBack(RedpointTree.NodeNames.AchievementUI, "AchievementUI", function(redpointCnt)
      View.Group_OutSide.Group_Station.Btn_Achieve.Img_Red:SetActive(0 < redpointCnt)
    end)
    EventManager:AddOpenPanelEvent(OpenPanelCallBack)
  end,
  disenable = function()
    Controller.StopPosterGirlAudioSource()
    EventMgr:SendEvent("event_uimainui_disenable")
    print_r("==============DISABLE=====================")
    print_r(DataModel.CurSceneName)
    if DataModel.CurSceneName == DataModel.SceneNameEnum.Main and not DataModel.MainToESC then
      TrainCameraManager:OpenCamera(-1)
    end
    ListenerManager.RemoveListener(ListenerManager.Enum.SetQuestTrace, "MainUI")
    ListenerManager.RemoveListener(ListenerManager.Enum.CompleteQuestInQuestTrace, "MainUI")
    if View.coroutineSound then
      View.self:StopC(View.coroutineSound)
      View.coroutineSound = nil
    end
    MapController:CleanPolluteLinesData()
    MapController.ClearMapNeedle()
    RedpointTree:SetCallBack(RedpointTree.NodeNames.AchievementUI, "AchievementUI", nil)
    if View.passengerCoroutine then
      View.self:StopC(View.passengerCoroutine)
      View.passengerCoroutine = nil
    end
    DataModel.MainToESC = false
    EventManager:RemoveOpenPanelEvent(OpenPanelCallBack)
  end,
  onAppResume = function()
    local needGetOffLineInfo = false
    if TrainManager.IsInTrainMap and PlayerData:GetHomeInfo().station_info.npc_index == nil and (TrainManager.TrainCtrl.Owner.EventCtrl.LevelCtrl.CurrEvent ~= nil or TradeDataModel.ExitLineEvent()) and (PlayerData:GetHomeInfo().drive_setup.bar == 1 or PlayerData:GetHomeInfo().drive_setup.assault == 1) then
      if TrainManager.CurrTrainState == TrainState.Stop or TrainManager.CurrTrainState == TrainState.None or TrainManager.CurrTrainState == TrainState.Astern or TrainManager.CurrTrainState == TrainState.Arrive or TrainManager.CurrTrainState == TrainState.Arriving or TrainManager.CurrTrainState == TrainState.Event or TrainManager.CurrTrainState == TrainState.EventFinish or TrainManager.CurrTrainState == TrainState.Backing or TrainManager.CurrTrainState == TrainState.Back then
        needGetOffLineInfo = false
      else
        needGetOffLineInfo = true
      end
    end
    
    local function cb()
      BugLogReporter:AddTail(BugLogReporter.ReportNames.TrainLineEvents, "MainUI:\229\136\135\229\177\143\229\144\142\230\129\162\229\164\141")
      DataModel.RefreshData(PlayerData.ServerData.user_home_info.coach)
      CommonCoachData.RefreshData()
      DataModel.SetRushNumber()
      TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.ApplicationQuit)
      TradeDataModel.CurRemainDistance = TrainManager.RemainDistance
      TradeDataModel.RefreshRushStatus()
      Controller.RefreshTrainMove(true)
      MapController:RefreshStationPos()
      MapController:RefreshViewToTrain()
      MapDataModel.trainDirection = nil
    end
    
    if needGetOffLineInfo then
      if TrainManager and TrainManager.TrainCtrl and TrainManager.TrainCtrl.CurrInfo and TrainManager.TrainCtrl.CurrInfo.events then
        TrainManager.TrainCtrl.Owner.EventCtrl.LevelCtrl.EventIndex = 99999
      else
        logError(string.format("\230\138\165\231\169\186\228\186\134 TrainManager:%s TrainCtrl:%s PathInfo:%s Events:%s", tostring(TrainManager == nil), tostring(TrainManager.TrainCtrl == nil), tostring(TrainManager.TrainCtrl.CurrInfo == nil), tostring(TrainManager.TrainCtrl.CurrInfo.events == nil)))
      end
      Controller.SetCamera(1)
      Net:SendProto("station.off_line_drive", function(json)
        if json.drive_distance then
          PlayerData:GetHomeInfo().drive_distance = json.drive_distance
        end
        if json.drive_time then
          PlayerData:GetHomeInfo().drive_time = json.drive_time
        end
        cb()
        local strike = PlayerData.GetStrike()
        if json.ram_damage == 1 then
          PlayerData.RemoveStrike(strike.u_bid)
        else
          local st = PlayerData:GetBatteryByID(strike.id)
          if st and st.hp then
            st.hp = math.max(0, st.hp - (json.minus_ram_hp or 0))
          end
        end
      end)
    else
      cb()
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
