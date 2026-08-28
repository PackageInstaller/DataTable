local View = require("UIMainUI/UIMainUIView")
local DataModel = require("UIMainUI/UIMainUIDataModel")
local RoomBackDataModel = require("UIChoseBG/UIChoseBGDataModel")
local ChangePosterGirlDataModel = require("UIChangePosterGirl/UIChangePosterGirlDataModel")
local RenderSettingController = require("UIMainUI/UIMainUIRenderSettingController")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local MapDataModel = require("UIHome/UIHomeMapDataModel")
local MapController = require("UIHome/UIHomeMapController")
local TradeController = require("UIHome/UIHomeTradeController")
local CtrlCommon = require("UIMainUI/Controller/UIMainUI_CommonController")
local ActivitySafeDataModel = require("UIActivitySafe/UIActivitySafeDataModel")
local FastBattleDataModel = require("UIFastBattle/UIFastBattleDataModel")
local Controller = {isInitEffect = false}

local function SetActive(node, value)
  if node == nil then
    return
  end
  if node.SetActive then
    node:SetActive(value)
    return
  end
  if node.self and node.self.SetActive then
    node.self:SetActive(value)
  end
end

local function SetSprite(node, value)
  if node == nil or value == nil or value == "" then
    return
  end
  if node.SetSprite then
    node:SetSprite(value)
    return
  end
  if node.self and node.self.SetSprite then
    node.self:SetSprite(value)
  end
end

local function SetNativeSize(node)
  if node == nil then
    return
  end
  if node.SetNativeSize then
    node:SetNativeSize()
    return
  end
  if node.self and node.self.SetNativeSize then
    node.self:SetNativeSize()
  end
end

local function SetLocalPosition(node, x, y)
  if node == nil then
    return
  end
  x = tonumber(x) or 0
  y = tonumber(y) or 0
  if node.SetLocalPosition then
    node:SetLocalPosition(Vector3(x, y, 0))
    return
  end
  if node.SetAnchoredPosition then
    node:SetAnchoredPosition(Vector2(x, y))
    return
  end
  if node.self and node.self.SetLocalPosition then
    node.self:SetLocalPosition(Vector3(x, y, 0))
  end
end

local function RefreshBgPic(group, bgPicList)
  if group == nil then
    return
  end
  local hasPic = false
  bgPicList = bgPicList or {}
  for index = 1, 4 do
    local img = group["Img_" .. index]
    local info = bgPicList[index]
    local show = info ~= nil and info.path ~= nil and info.path ~= ""
    SetActive(img, show)
    if show then
      hasPic = true
      SetSprite(img, info.path)
      SetNativeSize(img)
      SetLocalPosition(img, info.pathX, info.pathY)
    end
  end
  SetActive(group, hasPic)
end

function Controller.RefreshAdjutantRoomBackDisplay(isShow)
  if isShow then
    SetSprite(View.Group_Adjutant and View.Group_Adjutant.Img_BG, RoomBackDataModel.GetCurrentRoomBackBgPath())
    RefreshBgPic(View.Group_Common and View.Group_Common.Group_BgPic, RoomBackDataModel.GetCurrentRoomBackBgPicList())
  else
    RefreshBgPic(View.Group_Common and View.Group_Common.Group_BgPic, nil)
  end
end

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
  if PlayerData:GetPlayerPrefs("int", "autoUseBullet") == 1 then
    local isAuto = 1
    Net:SendProto("home.update_drive_setup", function(json)
      PlayerData:SetPlayerPrefs("int", "autoUseBullet", 0)
      PlayerData:GetHomeInfo().drive_setup.rush = isAuto
      Controller.Rush()
    end, "rush", isAuto)
  else
    Controller.Rush()
  end
end

function Controller.GloableUpdate()
  if TradeDataModel.GetIsTravel() then
    local buffVal = 1
    local buff = PlayerData:GetCurStationStoreBuff(EnumDefine.HomeSkillEnum.AccelerationBrakingPerformance)
    if buff then
      buffVal = buffVal + buff.param
    end
    if DataModel.GetIsWeaponRushShow() then
      if DataModel.GetWeaponRushDuration() <= 0 then
        DataModel.SetIsWeaponRushShow(false)
        Controller.WeaponRush()
      else
        DataModel.SetWeaponRushDuration(DataModel.GetWeaponRushDuration() - Time.fixedDeltaTime)
      end
    end
    local currRatio = TrainManager:GetAccerlationRatio()
    if currRatio ~= buffVal then
      TrainManager:SetAccerlationRatio(buffVal)
    end
    TradeDataModel.CurRemainDistance = TrainManager.RemainDistance
    if TradeDataModel.CurRemainDistance ~= -1 then
      if TradeDataModel.CurRemainDistance <= 1500 and DataModel.GetIsArrivingState() == false then
        local t = TradeDataModel.GetAnnouncementList(EnumDefine.Announcement.Arriving)
        SoundManager:PlaySoundList(t)
        DataModel.SetIsArrivingState(true)
      elseif not DataModel.GetIsArrivingState() then
        DataModel.SetIsArrivingState(false)
      end
    end
    TrainManager:SetTargetSpeed(TradeDataModel.GetServerSpeed())
    TrainManager:SetServerSpeed(TradeDataModel.GetServerSpeed())
    AutoUseBullet()
  else
  end
end

local isHide = false

function Controller:Init()
  CtrlCommon:Init()
  isHide = true
  CommonFilter.RefreshHome()
  local homeCommon = require("Common/HomeCommon")
  homeCommon.DailyCheckBarStoreShopRedPoint()
  Controller:RefreshSafeBtnShow()
  Controller.RefreshLimitShopBannerShow()
end

function Controller.InitScrollAd()
  local cfg = PlayerData:GetFactoryData(99900059, "ConfigFactory")
  Controller.adDataList = {}
  local curTime = tonumber(TimeUtil:GetServerTimeStamp())
  for k, v in pairs(cfg.adMainList) do
    local isShow = true
    local showTime
    if v.UIType == "Store" then
      local param = Json.decode(v.Way3)
      local goodsId
      if param.jumpParams then
        goodsId = string.split(param.jumpParams)[2]
      end
      isShow = require("UIStore/UIStoreDataModel").IsGoodsOpened(param.shopId, goodsId, true)
    elseif v.UIType == "Activity" then
      local activityCfg = PlayerData:GetFactoryData(v.id, "ActivityFactory")
      if activityCfg.openLv <= PlayerData:GetUserInfo().lv then
        if activityCfg.isTriggerTime then
          local openTime = TimeUtil:GetFutureTimeBySomeTimeStamp(0, 5, PlayerData:GetUserInfo().add_time + activityCfg.putTime * 86400)
          if curTime < openTime then
            if 0 >= activityCfg.countDownMax then
              isShow = false
            else
              local startShowTime = openTime - activityCfg.countDownMax * 86400
              if curTime < startShowTime then
                isShow = false
              else
                showTime = openTime - curTime
              end
            end
          elseif 0 >= activityCfg.adShowTime then
            isShow = false
          else
            local endShowTime = openTime + activityCfg.adShowTime * 86400
            if curTime >= endShowTime then
              isShow = false
            end
          end
        elseif activityCfg.isTime and curTime >= TimeUtil:TimeStamp(activityCfg.endTime) then
          isShow = false
        end
      end
      if isShow and v.id == 86000037 then
        isShow = TimeUtil:TodayIsHoliday()
      end
    end
    if isShow then
      table.insert(Controller.adDataList, {
        id = v.id,
        adpicture = v.adpicture,
        UIType = v.UIType,
        Way3 = v.Way3,
        showTime = showTime
      })
    end
  end
  local count = #Controller.adDataList
  if count == 0 then
    View.Group_Common.Group_Advertisement:SetActive(false)
    return
  end
  if Controller.scrollAd == nil then
    Controller.scrollAd = require("Util/InfiniteScroll").New()
  end
  View.Group_Common.Group_Advertisement:SetActive(true)
  Controller.scrollAd:InitRoot(View.Group_Common.Group_Advertisement.Group_Mask, nil, 10)
  View.Group_Common.Group_Advertisement.StaticGrid_Count.grid.self:SetDataCount(count)
  View.Group_Common.Group_Advertisement.StaticGrid_Count.grid.self:RefreshAllElement()
  Controller.scrollAd:SetData(count, function(element, dataIndex)
    local data = Controller.adDataList[dataIndex]
    element.Img_:SetSprite(data.adpicture)
    local _cfg = PlayerData:GetFactoryData(data.id)
    element.Txt_title:SetText(_cfg.name)
    if data.showTime then
      element.Group_time:SetActive(true)
      element.Group_time.Txt_:SetText(TimeUtil:GetActivityOpenLeftTime(data.showTime))
    else
      element.Group_time:SetActive(false)
    end
  end, function(dataIndex)
    if CommonTips.GuideAsset() then
      return
    end
    local data = Controller.adDataList[dataIndex]
    if data.UIType == "Store" then
      local a, b = PlayerData:OpenStoreCondition()
      if a == false then
        CommonTips.OpenTips(b[1].txt)
        return
      end
      if not View.Group_Common.Group_TopRight.Btn_Store.self.IsActive then
        return
      end
      local param = Json.decode(data.Way3)
      local goodsId
      if param.jumpParams then
        goodsId = string.split(param.jumpParams)[2]
      end
      local isOpened = require("UIStore/UIStoreDataModel").IsGoodsOpened(param.shopId, goodsId)
      if not isOpened then
        CommonTips.OpenTips(80611439)
        return
      end
      Net:SendProto("shop.info", function(json)
        Controller:ExitTo("UI/Store/Store", data.Way3)
      end)
    elseif data.UIType == "Activity" then
      local nowTime = TimeUtil:GetServerTimeStamp()
      local activityCfg = PlayerData:GetFactoryData(data.id, "ActivityFactory")
      local closeTime
      if activityCfg.isTriggerTime and activityCfg.closeTime > 0 then
        closeTime = TimeUtil:GetFutureTimeBySomeTimeStamp(0, 5, PlayerData:GetUserInfo().add_time + (activityCfg.putTime + activityCfg.closeTime) * 86400)
        if nowTime >= closeTime then
          CommonTips.OpenTips(80611439)
          return
        end
      elseif activityCfg.isTime and nowTime >= TimeUtil:TimeStamp(activityCfg.endTime) then
        CommonTips.OpenTips(80611439)
        return
      end
      Controller:ExitTo("UI/Activity/ActivityMain", Json.encode({
        id = data.id
      }))
    end
  end, function(dataIndex)
    DataModel.curAdScrollIndex = dataIndex
    View.Group_Common.Group_Advertisement.StaticGrid_Count.grid.self:RefreshAllElement()
    DataModel.curAdScrollIndex = nil
  end)
  Controller.scrollAd:AutoScroll(5)
end

local function HandleHeadRedDot()
  if PlayerData:GetUserInfo().friend_ss == 1 then
    return true
  end
  local funcCommon = require("Common/FuncCommon")
  local isUnlock = funcCommon.FuncActiveCheck(117, false)
  if isUnlock then
    local count, state = PlayerData:GetUnreadMailNum()
    if state then
      return true
    end
  end
  if RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.AchievementUI) > 0 then
    return true
  end
  local now_lv = PlayerData:GetPlayerLevel()
  local lv_cfg = PlayerData:GetFactoryData(99900051).Playerranklist
  local nowIndex = 1
  for i, v in ipairs(lv_cfg) do
    if now_lv >= v.level then
      nowIndex = i
    end
  end
  local can_recv_cnt = nowIndex - #(PlayerData:GetHomeInfo().rank_reward or {})
  if 0 < can_recv_cnt then
    return true
  end
  local isRed = require("UICardBooklet/UICardBookletDataModel").CheckRed()
  if isRed then
    return true
  end
  local dailyRed = require("UIDailyAttendance/UIDailyAttendanceDataModel").GetRedState()
  if dailyRed then
    return true
  end
  if funcCommon.FuncActiveCheck(124, false) then
    isRed = PlayerData.IsEntrustShowRed()
    if isRed then
      return true
    end
  end
  if funcCommon.FuncActiveCheck(102, false) then
    local isRed = require("UIGachaNew/UIGachaNewDataModel").GachaIsRedPoint()
    if isRed then
      return true
    end
  end
  if funcCommon.FuncActiveCheck(111, false) then
    isRed = QuestTrace.CheckQuestCanReceive()
    if isRed then
      return true
    end
  end
  if PlayerData.ServerData.helpData and PlayerData.ServerData.helpData.reward_cnt and 0 < PlayerData.ServerData.helpData.reward_cnt then
    return true
  end
  return false
end

function Controller:UpdateView()
  self:UpdateViewPerSec()
end

function Controller:UpdateViewPerSec()
  local osTime = os.time()
  if self.tsUpdateViewPerSec == nil then
    self.tsUpdateViewPerSec = osTime
  end
  if osTime - self.tsUpdateViewPerSec < 1 then
    return
  end
  self.tsUpdateViewPerSec = osTime
  self:RefreshTimeTxt()
end

function Controller:RefreshTimeTxt()
  if GameSetting.fromRes ~= "EN" then
    return
  end
  local Group_Time = View.Group_Common.Group_Time
  if Group_Time == nil then
    return
  end
  local Txt_Time = View.Group_Common.Group_Time.Txt_Time
  if Txt_Time == nil then
    return
  end
  local strName = TimeUtil:GetSvrTimeFormatStr3()
  Group_Time:SetActive(true)
  Txt_Time:SetText(strName)
end

function Controller:PlayBGM()
  local lineInfo = {}
  local isTravel, configId = MapDataModel.GetTrainCurPos(lineInfo)
  local bgSoundId = 0
  if DataManager:GetFactoryNameById(configId) == "HomeStationFactory" then
    bgSoundId = DataModel.CurShowSceneInfo.bgmId
  else
    local lineCA = PlayerData:GetFactoryData(configId)
    if lineInfo.lastStationId == lineCA.station02 and lineCA.bgmId2 > -1 then
      bgSoundId = lineCA.bgmId2
    else
      bgSoundId = lineCA.bgmId
    end
  end
  if DataModel.TrainEventBgmId ~= nil then
    bgSoundId = DataModel.TrainEventBgmId
  end
  DataModel.nowSoundId = bgSoundId
  local sound = SoundManager:CreateSound(bgSoundId)
  if sound ~= nil then
    sound:Play()
  end
end

function Controller:InitCommonShow()
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  local user_info = PlayerData:GetUserInfo()
  Controller.RefreshGoldInfoShow()
  View.Group_Common.Group_TopLeft.Txt_Name:SetText(user_info.role_name or "")
  View.Group_Common.Group_TopLeft.Txt_UID:SetText(string.format(GetText(80600575), user_info.uid))
  View.Img_Dashboard.Btn_FreindsList:SetActive(MainManager.bgSceneName == DataModel.SceneNameEnum.Home)
  View.Group_Common.Group_TopLeft.Group_LV.Txt_Num:SetText(user_info.lv or 1)
  local endExp = PlayerData:GetMaxExp()
  View.Group_Common.Group_TopLeft.Img_EXPPB:SetFilledImgAmount(user_info.exp / endExp)
  local show_red = HandleHeadRedDot()
  View.Group_Common.Group_TopLeft.Img_Remind:SetActive(show_red)
  if user_info.avatar ~= nil then
    local photoFactory = PlayerData:GetFactoryData(user_info.avatar, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      View.Group_Common.Group_TopLeft.Btn_ProfilePhoto.Img_Client:SetSprite(photoFactory.imagePath)
      CommonTips:SetPlayerHeadShader(View.Group_Common.Group_TopLeft.Btn_ProfilePhoto.Img_spAdd, photoFactory)
      return
    end
  end
  local head = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  if head ~= nil and head.playerHeadList ~= nil then
    View.Group_Common.Group_TopLeft.Btn_ProfilePhoto.Img_Client:SetSprite(head.playerHeadList[user_info.gender + 1].playerHeadPath)
  end
end

function Controller:ShowEnterCityAbout(isShow)
  View.Btn_City.self:SetActive(false)
  View.Btn_Dungeon.self:SetActive(false)
  if isShow then
    local stationCA = PlayerData:GetFactoryData(TradeDataModel.EndCity, "HomeStationFactory")
    View.Btn_City.Txt_CityName:SetText(stationCA.name)
    View.Btn_Dungeon.Txt_CityName:SetText(stationCA.name)
    local HomeCommon = require("Common/HomeCommon")
    local stateInfo = HomeCommon.GetCityStateInfo(TradeDataModel.EndCity)
    if stateInfo ~= nil then
      View.Btn_City.Txt_Name:SetText(stateInfo.name)
      View.Btn_City.self:SetActive(stateInfo.cityMapId > 0)
      View.Btn_Dungeon.self:SetActive(0 < stateInfo.dungeonId)
    end
  end
end

function Controller:SwitchTab(type, calcPosterGirl, isRefreshPoster)
  PlayerData.TempCache.MainUIShowState = type
  Controller:ShowOutSide(false)
  Controller:ShowCoach(false)
  Controller:ShowAdjutant(false)
  local isTravel = PlayerData:GetHomeInfo().station_info.stop_info[2] ~= -1
  View.Btn_Launch.self:SetActive(not isTravel)
  Controller:ShowEnterCityAbout(not isTravel)
  if Controller.scrollAd then
    Controller.scrollAd:SetActive(not isTravel)
  end
  View.Group_Common.self:SetActive(true)
  local stationCA = PlayerData:GetFactoryData(TradeDataModel.CurStayCity, "HomeStationFactory")
  View.Group_OutSide.Group_Station.Btn_HandleG.Img_Lock:SetActive(not PlayerData.IsSolicitFunOpen() or not stationCA.isLeaflet)
  if type ~= PlayerData.TempCache.MainUIShowState and type ~= DataModel.UIShowEnum.OutSide and UIManager:IsPanelOpened("UI/Attraction/Attractions") then
    UIManager:ClosePanel(true, "UI/Attraction/Attractions")
  end
  if type == DataModel.UIShowEnum.OutSide then
    Controller:ShowOutSide()
    local ishow = PlayerData.showPosterGirl == 1
    if DataModel.IsEvent or PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
      ishow = true
    end
    if isRefreshPoster == nil or isRefreshPoster ~= false then
      Controller:ShowPosterGirl(ishow, true)
      local showRt = false
      for k, v in ipairs(DataModel.showSpine2) do
        if v then
          showRt = true
          break
        end
      end
      View.Img_RT:SetActive(showRt)
    end
    Controller:ReopenAttractions()
    Controller.RefreshBtnRevenue(not DataModel.IsEvent)
  elseif type == DataModel.UIShowEnum.Coach then
    Controller:ShowCoach()
    local ishow = false
    if DataModel.IsEvent or PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
      ishow = true
    end
    if isRefreshPoster == nil or isRefreshPoster ~= false then
      Controller:ShowPosterGirl(ishow)
    end
    Controller.RefreshBtnRevenue(not DataModel.IsEvent)
  elseif type == DataModel.UIShowEnum.Adjutant then
    Controller:ShowAdjutant()
    if isRefreshPoster == nil or isRefreshPoster ~= false then
      Controller:ShowPosterGirl(true, true)
    end
    Controller.RefreshBtnRevenue(true)
  elseif type == DataModel.UIShowEnum.Passenger then
    View.Btn_Launch:SetActive(false)
    if Controller.scrollAd then
      Controller.scrollAd:SetActive(false)
    end
    View.Btn_City:SetActive(false)
    View.Img_Dashboard:SetActive(false)
    View.Group_OutSide:SetActive(false)
    View.Group_Common:SetActive(false)
    View.Img_RT:SetActive(true)
    Controller.RefreshBtnRevenue(false)
    if isRefreshPoster == nil or isRefreshPoster ~= false then
      Controller:ShowPosterGirl(false)
    end
  end
end

function Controller.RefreshBtnRevenue(isShow)
  local cfg = PlayerData:GetFactoryData(99900088, "ConfigFactory")
  if not cfg.isRankOpen or not isShow then
    View.Btn_Revenue:SetActive(false)
    return
  end
  if cfg.isRankOpen and isShow then
    Net:SendProto("main.revenue_record", function(json)
      if json.revenue_record then
        local UIRevenueOverviewDataModel = require("UIRevenueOverview/UIRevenueOverviewDataModel")
        local serverTime = UIRevenueOverviewDataModel.GetIncomeTodayTimeStamp()
        local key = os.date("!%Y-%m-%d", serverTime)
        local data = json.revenue_record[key] or {}
        local totalIncome = 0
        for i, v in pairs(data) do
          totalIncome = totalIncome + v
        end
        local isTravel = PlayerData:GetHomeInfo().station_info.stop_info[2] ~= -1
        local posY = isTravel and 290 or 227
        View.Btn_Revenue:SetAnchoredPositionY(posY)
        View.Btn_Revenue:SetActive(true)
        local income = NumThousandsSplit(math.abs(totalIncome))
        if totalIncome < 0 then
          income = "-" .. income
        end
        View.Btn_Revenue.Txt_Num:SetText(income)
        Controller.RefreshRevenueRedPoint()
      end
    end, PlayerData:GetUserInfo().uid)
  end
end

function Controller:ShowOutSide(isShow)
  if isShow == nil then
    isShow = true
  end
  View.Group_OutSide.self:SetActive(isShow)
  View.Group_Common.Group_MB.BtnPolygon_OutSide:SetActive(not isShow)
  local isTravel = PlayerData:GetHomeInfo().station_info.stop_info[2] ~= -1
  View.Group_OutSide.Group_Station.self:SetActive(isShow and not isTravel)
  View.Group_OutSide.Group_Running.self:SetActive(isShow and isTravel)
  if isShow then
    View.Group_Common.Group_MB.BtnPolygon_Adjutant:SetActive(true)
    View.Group_Common.Group_MB.BtnPolygon_Coach:SetActive(true)
    local x = View.Group_Common.Group_MB.BtnPolygon_Coach:GetAnchoredPositionX()
    if x < 0 then
      x = -x
      View.Group_Common.Group_MB.BtnPolygon_Coach:SetAnchoredPositionX(x)
    end
    View.Group_Common.Group_MB.BtnPolygon_Coach.Txt_Left:SetActive(false)
    View.Group_Common.Group_MB.BtnPolygon_Coach.Txt_Right:SetActive(true)
    local isInCoach = DataModel.CurSceneName == DataModel.SceneNameEnum.Home or not TradeDataModel.GetInTravel()
    Controller:ShowMBDurability(isInCoach)
    Controller:ShowMBSpeed(not isInCoach)
    Controller.ShowStrikeTip(false, false)
  end
end

function Controller:ShowCoach(isShow)
  if isShow == nil then
    isShow = true
  end
  View.Group_Coach.self:SetActive(isShow)
  View.Group_Common.Group_MB.BtnPolygon_Coach:SetActive(not isShow)
  if isShow then
    local isTravel = TradeDataModel.GetIsTravel()
    View.Group_OutSide.Group_Station.self:SetActive(isTravel)
    View.Group_Common.Group_MB.BtnPolygon_Adjutant:SetActive(true)
    View.Group_Common.Group_MB.BtnPolygon_OutSide:SetActive(true)
    local x = View.Group_Common.Group_MB.BtnPolygon_OutSide:GetAnchoredPositionX()
    if x < 0 then
      x = -x
      View.Group_Common.Group_MB.BtnPolygon_OutSide:SetAnchoredPositionX(x)
    end
    View.Group_Common.Group_MB.BtnPolygon_OutSide.Txt_Left:SetActive(false)
    View.Group_Common.Group_MB.BtnPolygon_OutSide.Txt_Right:SetActive(true)
    Controller:ShowMBDurability(true)
    Controller.ShowStrikeTip(false, false)
    Controller:ShowMBSpeed(false)
  end
end

function Controller:ShowAdjutant(isShow)
  if isShow == nil then
    isShow = true
  end
  View.Img_RT:SetActive(isShow)
  View.Group_Adjutant.self:SetActive(isShow)
  View.Group_Common.Group_MB.BtnPolygon_Adjutant:SetActive(not isShow)
  View.Group_Adjutant.Img_BG:SetSprite(isShow and RoomBackDataModel.GetCurrentRoomBackBgPath() or "")
  Controller.RefreshAdjutantRoomBackDisplay(isShow)
  self.SetSpeedAddShow()
  if isShow then
    Controller:ShowMBSpeed(false)
    Controller:ShowMBDurability(true)
    Controller.ShowStrikeTip(false, false)
    View.Group_Adjutant.Img_BG:SetActive(true)
    local isInCoach = DataModel.CurSceneName == DataModel.SceneNameEnum.Home
    View.Group_Common.Group_MB.BtnPolygon_Coach:SetActive(true)
    View.Group_Common.Group_MB.BtnPolygon_OutSide:SetActive(true)
    local element1, element2
    if isInCoach then
      element1 = View.Group_Common.Group_MB.BtnPolygon_OutSide
      element2 = View.Group_Common.Group_MB.BtnPolygon_Coach
    else
      element1 = View.Group_Common.Group_MB.BtnPolygon_Coach
      element2 = View.Group_Common.Group_MB.BtnPolygon_OutSide
    end
    local x = element1:GetAnchoredPositionX()
    if x < 0 then
      x = -x
      element1:SetAnchoredPositionX(x)
    end
    element1.Txt_Left:SetActive(false)
    element1.Txt_Right:SetActive(true)
    x = element2:GetAnchoredPositionX()
    if 0 < x then
      x = -x
      element2:SetAnchoredPositionX(x)
    end
    element2.Txt_Left:SetActive(true)
    element2.Txt_Right:SetActive(false)
  end
end

function Controller:ShowMBSpeed(isShow)
  if isShow == nil then
    isShow = true
  end
  View.Group_Common.Group_MB.Img_Speed:SetActive(isShow)
  View.Img_Dashboard:SetActive(not isShow)
end

function Controller:ShowMBDurability(isShow)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  if isShow == nil then
    isShow = true
  end
  if View.Group_Common.Group_MB.Img_Durability ~= nil then
    View.Group_Common.Group_MB.Img_Durability:SetActive(isShow)
  end
  View.Img_Dashboard:SetActive(isShow)
  if isShow then
    local serverRepairInfo = PlayerData:GetHomeInfo().readiness.repair
    local maxDurable = PlayerData.GetCoachMaxDurability()
    if View.Group_Common.Group_MB.Img_Durability ~= nil then
      View.Group_Common.Group_MB.Img_Durability.Txt_Durability:SetText(string.format(GetText(80601848), serverRepairInfo.current_durable, maxDurable))
      local percent = serverRepairInfo.current_durable / maxDurable
      View.Group_Common.Group_MB.Img_Durability.Txt_DurPCT:SetText(math.floor(percent * 100) .. "%")
      View.Group_Common.Group_MB.Img_Durability.Img_PB:SetFilledImgAmount(percent)
    end
  end
end

function Controller:HideAll(forbidShow)
  View.self:PlayAnim("HideAll", function()
    TrainCameraManager:SetCurCameraIgnoreUI(true)
    View.Img_Dashboard:SetActive(false)
    View.Btn_Launch.self:SetActive(false)
    if Controller.scrollAd then
      Controller.scrollAd:SetActive(false)
    end
    View.Btn_City.self:SetActive(false)
    View.Btn_Revenue:SetActive(false)
    View.Btn_Dungeon.self:SetActive(false)
    Controller:ShowCoach(false)
    Controller:ShowOutSide(false)
    View.Btn_ShowUI:SetActive(true)
    Controller.forbidShow = forbidShow
  end)
  for i = 1, 10 do
    Controller.HideAllEffect(i)
  end
end

function Controller:ReShowUI()
  View.Img_Dashboard:SetActive(true)
  View.Btn_ShowUI:SetActive(false)
  Controller:SwitchTab(PlayerData.TempCache.MainUIShowState, nil, false)
  TrainCameraManager:SetCurCameraIgnoreUI(false)
  View.self:PlayAnim("ShowAll")
  Controller.forbidShow = nil
end

function Controller:RefreshFestivalGift()
  if DataModel.CurFrame <= 0 then
    self:CheckFestivalGift()
    DataModel.CurFrame = 90
  end
  DataModel.CurFrame = DataModel.CurFrame - 1
end

function Controller:CheckFestivalGift()
  local isGiftShow
  if PlayerData:GetPlayerLevel() < PlayerData:GetFactoryData(99900015, "ConfigFactory").LevelLimit then
    isGiftShow = false
  elseif DataModel.IsEvent or PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
    isGiftShow = false
  else
    isGiftShow = PlayerData:GetCurFestivalIndex() > 0
  end
  for i = 1, 10 do
    local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. i]
    if viewGroup == nil then
      break
    end
    viewGroup.Viewport.Content.Group_PosterGirl.Btn_FestivalGift.self:SetActive(isGiftShow)
  end
  if isGiftShow then
    if DataModel.isPosterGirlShow ~= true then
      self:ShowPosterGirl(true)
    end
    PlayerData.showPosterGirl = 1
  end
end

local function PlayVideoInsteadSpine(viewGroup, isVideo, videoPath)
  if isVideo and videoPath ~= "" then
    viewGroup.Viewport.Content.Group_PosterGirl.self:SetActive(true)
    viewGroup.Viewport.Content.Group_Video.self:SetActive(true)
    viewGroup.Viewport.Content.Group_Video.Video_play.self:Play(videoPath, true, false, false)
  else
    viewGroup.Viewport.Content.Group_PosterGirl.self:SetActive(true)
    viewGroup.Viewport.Content.Group_Video.self:SetActive(false)
  end
end

function Controller:ShowPosterGirl(isShow, showSpine2, forceDisplay)
  if isShow == nil then
    isShow = true
  end
  if showSpine2 == nil then
    showSpine2 = false
  end
  DataModel.showSpine2 = {}
  DataModel.UnitViewId = {}
  DataModel.UnitViewIdIsSpine = {}
  DataModel.Live2DState = {}
  DataModel.SkinBgState = {}
  DataModel.activeBtnList = {}
  DataModel.offsetX = {}
  DataModel.offsetY = {}
  DataModel.changePosRole = {}
  DataModel.isPosterGirlShow = isShow
  View.Group_Common.Btn_Change.self:SetActive(isShow)
  View.Group_Common.Btn_SwitchSpine:SetActive(isShow)
  local netData = PlayerData.ServerData.user_info
  local idList = ChangePosterGirlDataModel.SetRoleId(DataModel.IsEvent)
  DataModel.roleId = idList
  for i = 1, 10 do
    local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. i]
    if viewGroup == nil then
      break
    end
    local needShow = isShow and i <= #idList and idList[i] ~= ""
    if needShow then
      viewGroup.self:SetActive(true)
      viewGroup.Viewport.Content.transform.localScale = Vector3.one
      viewGroup.Viewport.Content.transform.localPosition = Vector3.zero
      local needShowSpine2 = showSpine2
      local isSysRole = false
      if DataModel.IsEvent and (netData.guardId == nil or netData.guardId == "") then
        needShowSpine2 = false
        isSysRole = true
      end
      local roleId = idList[i]
      local viewId = PlayerData:GetFactoryData(roleId, "UnitFactory").viewId
      local tempViewId = ChangePosterGirlDataModel.GetViewId(roleId, i)
      if tempViewId and tempViewId ~= 0 then
        viewId = tempViewId
      end
      local isSpine2 = ChangePosterGirlDataModel.IsSpine2(roleId, i)
      if ChangePosterGirlDataModel.IsRandomSkin(i) and isSysRole ~= true then
        viewId, isSpine2 = ChangePosterGirlDataModel:GetCRRViewId(roleId, i == 1)
        if isSpine2 == 1 then
          logError(viewId)
        end
      end
      local isVideo, videoPath = Controller:RefreshReceptionistData(i, idList[i], viewId, isSpine2, needShowSpine2)
      PlayVideoInsteadSpine(viewGroup, isVideo, videoPath)
      if DataModel.IsEvent then
        View.Group_Common.Img_DialogBox:SetActive(true)
        View.Group_Common.Btn_Change.self:SetActive(false)
        View.Group_Common.Btn_SwitchSpine:SetActive(false)
      else
        View.Group_Common.Btn_Change.self:SetActive(true)
      end
      View.timer:Resume()
      if PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
        View.Group_Common.Img_DialogBox:SetActive(true)
      end
      Controller.RefreshPosterGirlFixEffect(i)
    else
      viewGroup.self:SetActive(false)
      viewGroup.Viewport.Content.Group_Video.self:SetActive(false)
      Controller.StopPosterGirlAudioSource()
      Controller.HideAllEffect(i)
    end
  end
  Controller.RefreshSwitchBtn()
end

function Controller.LoadSpineBg(index, roleId, viewId)
  local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. index]
  if viewGroup == nil then
    return
  end
  if roleId == nil then
    roleId = DataModel.roleId[index]
  end
  viewId = viewId or DataModel.UnitViewId[index]
  if not viewId then
    local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
    viewId = unitCA.viewId
  end
  local showSpineBg = ChangePosterGirlDataModel.GetBgState(viewId, index)
  local viewCA = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  if viewCA.SpineBackground == "" or DataModel.showSpine2[index] or DataModel.Live2DState[index] == false then
    showSpineBg = false
  end
  if showSpineBg == false then
    viewGroup.Viewport.Content.Group_PosterGirl.Img_SpineBG:SetActive(false)
    return
  end
  if not DataModel.IsEvent and not DataModel.showSpine2[index] and viewCA.SpineBackground and viewCA.SpineBackground ~= "" then
    DataModel.offsetX[index] = viewCA.SpineBGX and viewCA.SpineBGX or 0
    DataModel.offsetY[index] = viewCA.SpineBGY and viewCA.SpineBGY or 0
    viewGroup.Viewport.Content.Group_PosterGirl.Img_SpineBG:SetSprite(viewCA.SpineBackground)
    local x = viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character.transform.localPosition.x - DataModel.offsetX[index]
    local y = DataModel.offsetY[index]
    viewGroup.Viewport.Content.Group_PosterGirl.Img_SpineBG.transform.localPosition = Vector3(x, y, 0)
    local scale = viewCA.SpineBGScale or 1
    viewGroup.Viewport.Content.Group_PosterGirl.Img_SpineBG.transform.localScale = Vector3(scale, scale, 0)
  end
  viewGroup.Viewport.Content.Group_PosterGirl.Img_SpineBG:SetActive(showSpineBg)
end

function Controller.SpineBgFollow()
  if DataModel.offsetX == nil or DataModel.offsetY == nil then
    return
  end
  for i = 1, 10 do
    local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. i]
    if viewGroup == nil then
      break
    end
    if viewGroup.Viewport.Content.Group_PosterGirl.Img_SpineBG.IsActive then
      local x = viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character.transform.localPosition.x - DataModel.offsetX[i]
      local pos = Vector3(x, DataModel.offsetY[i], 0)
      viewGroup.Viewport.Content.Group_PosterGirl.Img_SpineBG.transform.localPosition = pos
    end
  end
end

function Controller:RefreshEffect(index, receptionistData)
  if receptionistData.clickEffectUrl ~= nil and receptionistData.clickEffectUrl ~= "" then
    local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. index]
    local clickEffectCtrl
    if receptionistData.clickEffectLayer == "Front" then
      clickEffectCtrl = viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterEffect
      viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterEffectBottom:SetActive(false)
    elseif receptionistData.clickEffectLayer == "Bottom" then
      clickEffectCtrl = viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterEffectBottom
      viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterEffect:SetActive(false)
    end
    if not clickEffectCtrl then
      return
    end
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      clickEffectCtrl:SetActive(true)
    end))
    clickEffectCtrl:SetData(receptionistData.clickEffectUrl, "")
    clickEffectCtrl:SetLocalScale(Vector3(100, 100, 1))
    local showFront = viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect.IsActive
    local showBottom = viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect.IsActive
    
    local function callback()
      if showFront then
        viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetActive(true)
      end
      if showBottom then
        viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetActive(true)
      end
    end
    
    if receptionistData.clickHideFixEffect == "Front" then
      viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetActive(false)
    elseif receptionistData.clickHideFixEffect == "Bottom" then
      viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetActive(false)
    elseif receptionistData.clickHideFixEffect == "Both" then
      viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetActive(false)
      viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetActive(false)
    end
    clickEffectCtrl:SetAction("effect_click", false, true, function()
      callback()
      clickEffectCtrl:SetActive(false)
    end)
  end
end

function Controller.RefreshSwitchBtn()
  local show = #DataModel.changePosRole > 0
  View.Group_Common.Btn_SwitchSpine:SetActive(show)
end

function Controller.RefreshPosterGirlFixEffect(index)
  local showFrontFixEffect = false
  local showBottomFixEffect = false
  local roleId = DataModel.roleId[index]
  local viewId = PlayerData:GetFactoryData(roleId).viewId
  if ChangePosterGirlDataModel.GetViewId(roleId, index) ~= 0 then
    viewId = ChangePosterGirlDataModel.GetViewId(roleId, index)
  end
  local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. index]
  if viewGroup == nil then
    return
  end
  if roleId then
    local live2D = ChangePosterGirlDataModel.IsLive2D(viewId, DataModel.UnitViewIdIsSpine[index], index)
    if live2D and not DataModel.showSpine2[index] and not DataModel.IsEvent then
      local effectState = ChangePosterGirlDataModel.GetEffectState(viewId, index)
      if effectState then
        local viewCA = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
        local frontFixEffect = viewCA.frontFixEffectUrl
        if frontFixEffect and frontFixEffect ~= "" then
          showFrontFixEffect = true
          viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetData(frontFixEffect, "effect_idle")
          View.self:StartC(LuaUtil.cs_generator(function()
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetActive(true)
          end))
        end
        local bottomFixEffectUrl = viewCA.bottomFixEffectUrl
        if bottomFixEffectUrl and bottomFixEffectUrl ~= "" then
          showBottomFixEffect = true
          viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetData(bottomFixEffectUrl, "effect_idle")
          View.self:StartC(LuaUtil.cs_generator(function()
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetActive(true)
          end))
        end
      else
        viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetActive(false)
        viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetActive(false)
      end
    end
  end
  if not showFrontFixEffect then
    viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetActive(false)
  end
  if not showBottomFixEffect then
    viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetActive(false)
  end
end

function Controller:SetupPosterGirlIdleState(index, viewId, idleName)
  local viewCA = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  local idleListId = viewCA.SpineIdleListId
  if viewCA.extraSpineList and table.count(viewCA.extraSpineList) > 0 then
    local spineIndex = ChangePosterGirlDataModel.GetPosIndex(viewId, index)
    if 0 < spineIndex and spineIndex <= table.count(viewCA.extraSpineList) then
      local extraInfo = viewCA.extraSpineList[spineIndex]
      local unitViewCA = PlayerData:GetFactoryData(extraInfo.id, "UnitViewFactory")
      idleListId = unitViewCA.SpineIdleListId
    end
  end
  local tempCA
  local idleList = {}
  if idleListId ~= nil and 0 < idleListId then
    tempCA = PlayerData:GetFactoryData(idleListId, "ListFactory")
    if tempCA ~= nil then
      idleList = tempCA.posterGirlIdleList
    end
  end
  local btnList = {}
  for k, v in pairs(idleList) do
    if v.idleName == idleName then
      tempCA = PlayerData:GetFactoryData(v.btnListId, "ListFactory")
      if tempCA ~= nil then
        btnList = tempCA.posterGirlBtnList
      end
      break
    end
  end
  local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. index]
  local btn_ChangeAnimation = viewGroup.Viewport.Content.Group_PosterGirl.Btn_ChangeAnimation
  DataModel.activeBtnList[index] = {}
  for k, v in pairs(btnList) do
    if btn_ChangeAnimation[v.clickAct] ~= nil then
      DataModel.activeBtnList[index][v.clickAct] = v
    end
  end
  if btn_ChangeAnimation ~= nil and type(btn_ChangeAnimation) == "table" then
    for k, v in pairs(btn_ChangeAnimation) do
      if k ~= "self" then
        local btnInfo = DataModel.activeBtnList[index][k]
        if btnInfo == nil then
          v:SetActive(false)
        else
          v:SetActive(true)
          v:SetLocalPositionX(btnInfo.localPosX, 0)
          v:SetLocalPositionY(btnInfo.localPosY, 0)
          v:SetWidthHeight(btnInfo.width, btnInfo.height)
        end
      end
    end
  end
  tempCA = nil
  btn_ChangeAnimation = nil
  idleList = nil
  btnList = nil
end

function Controller:PosterGirlBtnClick(index, btn)
  if not DataModel.Live2DState[index] then
    return
  end
  local clickName = btn.transform.name
  local idleName = "idle"
  local btnInfo = DataModel.activeBtnList[index][clickName]
  if btnInfo ~= nil then
    idleName = btnInfo.idleAct
  end
  local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. index]
  viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetClickAction(clickName, function()
    viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetAction(idleName, true, true)
    self:SetupPosterGirlIdleState(index, DataModel.UnitViewId[index], idleName)
  end)
end

function Controller:RefreshReceptionistData(index, roleId, viewId, isSpine2, showSpine2)
  local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. index]
  DataModel.UnitViewId[index] = viewId
  DataModel.UnitViewIdIsSpine[index] = isSpine2
  local viewCA = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterEffect:SetActive(false)
  viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterEffectBottom:SetActive(false)
  viewGroup.Viewport.Content.Group_PosterGirl.Group_Character.self:SetActive(false)
  local live2D = ChangePosterGirlDataModel.IsLive2D(viewId, isSpine2, index)
  local videoPath = viewCA.videoPath
  local isVideo = viewCA.videoSpine and viewCA.videoPath ~= "" and live2D
  if isVideo and viewCA.videoFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
    videoPath = viewCA.videoFemale
  end
  local canShowSpine2 = false
  if showSpine2 and PlayerData:GetRoleById(roleId).resonance_lv == 5 and isSpine2 == 1 then
    canShowSpine2 = true
  end
  local showLive1 = not isVideo and not canShowSpine2 and live2D and viewCA.spineUrl ~= ""
  local showLive2 = not isVideo and canShowSpine2 and live2D and viewCA.spine2Url ~= ""
  DataModel.showSpine2[index] = showLive2
  local show2D = not live2D and not showLive1 and not showLive2 and not isVideo
  DataModel.Live2DState[index] = live2D
  viewGroup.Viewport.Content.Group_PosterGirl.Btn_ChangeAnimation:SetActive(not isVideo and isSpine2 == 0)
  viewGroup.Viewport.Content.Group_PosterGirl.Btn_ChangeAnimation.click:SetActive(false)
  viewGroup.Viewport.Content.Group_PosterGirl.Btn_ChangeAnimation.click2:SetActive(false)
  viewGroup.Viewport.Content.Group_PosterGirl.Btn_ChangeAnimation2:SetActive(not isVideo and isSpine2 == 1)
  viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetActive(showLive1)
  viewGroup.Viewport.Content.Group_PosterGirl.Group_SpineAnimationAlpha:SetActive(showLive1)
  if showLive1 then
    local spineIndex = ChangePosterGirlDataModel.GetPosIndex(viewId, index)
    local idleName = "idle"
    local spineX = viewCA.spineX
    local spineY = viewCA.spineY
    local spineScale = viewCA.spineScale
    local spineUrl = viewCA.spineUrl
    if viewCA.spineFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
      spineUrl = viewCA.spineFemale
    end
    if 0 < spineIndex and spineIndex <= table.count(viewCA.extraSpineList) then
      local extraInfo = viewCA.extraSpineList[spineIndex]
      local unitViewCA = PlayerData:GetFactoryData(extraInfo.id, "UnitViewFactory")
      spineX = unitViewCA.spineX
      spineY = unitViewCA.spineY
      spineScale = unitViewCA.spineScale
      spineUrl = unitViewCA.spineUrl
      if unitViewCA.spineFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
        spineUrl = unitViewCA.spineFemale
      end
      local idleListId = unitViewCA.SpineIdleListId
      if idleListId ~= nil and 0 < idleListId then
        local tempCA = PlayerData:GetFactoryData(idleListId, "ListFactory")
        if tempCA ~= nil then
          idleName = tempCA.posterGirlIdleList[1].idleName
        end
      end
    end
    viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetData(spineUrl)
    viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetLocalScale(Vector3(100 * spineScale, 100 * spineScale, 1))
    viewGroup.Viewport.Content.Group_PosterGirl.SpineSecondMode_Character:SetPrefab("")
    viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character.transform.localPosition = Vector3(-370 + spineX, -1200 + spineY, 0)
    self:SetupPosterGirlIdleState(index, viewId, idleName)
    viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetAction(idleName, true, true)
  else
    viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetData("")
  end
  if not isVideo and isSpine2 == 0 and viewCA.extraSpineList and 0 < table.count(viewCA.extraSpineList) and not table.contains(DataModel.changePosRole, index) then
    table.insert(DataModel.changePosRole, index)
  end
  viewGroup.Viewport.Content.Group_PosterGirl.SpineSecondMode_Character:SetActive(showLive2)
  if showLive2 then
    viewGroup.Viewport.Content.Group_PosterGirl.SpineSecondMode_Character:SetPrefab(viewCA.spine2Url)
    if viewCA.state2Overturn then
      viewGroup.Viewport.Content.Group_PosterGirl.SpineSecondMode_Character:SetLocalScale(Vector3(-1, 1, 1))
    else
      viewGroup.Viewport.Content.Group_PosterGirl.SpineSecondMode_Character:SetLocalScale(Vector3(1, 1, 1))
    end
    viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetData("")
  else
    viewGroup.Viewport.Content.Group_PosterGirl.SpineSecondMode_Character:SetPrefab("")
  end
  local needShowMask = showLive2 or viewCA.videoSpine or viewCA.moveBoolen
  viewGroup.Viewport.Content.Group_PosterGirl.Group_Mask.self:SetActive(needShowMask)
  if needShowMask then
    viewGroup.Viewport.Content.Group_PosterGirl.self:SetActive(true)
  end
  local needShowBg = ChangePosterGirlDataModel.GetBgState(viewId, index)
  if viewCA.SpineBackground == "" or isSpine2 == 1 or isVideo then
    needShowBg = false
  end
  DataModel.SkinBgState[index] = needShowBg
  viewGroup.Viewport.Content.Group_PosterGirl.Img_SpineBG:SetActive(needShowBg)
  if needShowBg then
    Controller.LoadSpineBg(index)
  end
  viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG:SetActive(show2D)
  if show2D then
    if isSpine2 == 1 then
      viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetSprite(viewCA.State2Res)
      viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalPosition(Vector3(0, 0, 0))
      viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalScale(Vector3(1, 1, 1))
    else
      local tempView = viewCA
      local spineIndex = ChangePosterGirlDataModel.GetPosIndex(viewId, index)
      if 0 < spineIndex and spineIndex <= table.count(viewCA.extraSpineList) then
        local extraInfo = viewCA.extraSpineList[spineIndex]
        tempView = PlayerData:GetFactoryData(extraInfo.id, "UnitViewFactory")
      end
      local resPath = tempView.resUrl
      if tempView.pngFemale ~= "" and (PlayerData:GetUserInfo().gender or 1) == 0 then
        resPath = tempView.pngFemale
      end
      if not needShowBg and tempView.SpineBackground ~= "" then
        if (PlayerData:GetUserInfo().gender or 1) == 1 and tempView.singleUrl ~= "" then
          resPath = tempView.singleUrl
        elseif (PlayerData:GetUserInfo().gender or 1) == 0 and tempView.singleFemale ~= "" then
          resPath = tempView.singleFemale
        end
      end
      local resX = tempView.offsetX
      local resY = tempView.offsetY
      local resScale = tempView.offsetScale
      viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetSprite(resPath)
      viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalPosition(Vector3(-370 + resX, resY, 0))
      viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalScale(Vector3(resScale, resScale, resScale))
    end
    viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetNativeSize()
  else
    viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetSprite(viewCA.resUrl)
  end
  if not isVideo and isSpine2 == 0 then
    local scaleNum = ChangePosterGirlDataModel.GetScale(viewId, index)
    scaleNum = scaleNum == 0 and 1 or scaleNum
    viewGroup.Viewport.Content.transform.localScale = Vector3(scaleNum, scaleNum, scaleNum)
    local posX = ChangePosterGirlDataModel.GetPosX(viewId, index)
    local posY = ChangePosterGirlDataModel.GetPosY(viewId, index)
    viewGroup.Viewport.Content.transform.localPosition = Vector3(posX, posY, 0)
  end
  return isVideo, videoPath
end

function Controller:ExitTo(uiName, param, callback, callback2)
  View.self:SetEnableAnimator(true)
  View.self:PlayAnim("Out", function()
    if callback2 then
      callback2()
    end
    UIManager:Open(uiName, param, callback)
  end)
  for i = 1, 10 do
    Controller.HideAllEffect(i)
  end
end

function Controller:Exit(UI, status)
  View.self:SetEnableAnimator(true)
  UIManager:Open(UI, status)
end

function Controller:Exit2(UI, status)
  View.self:SetEnableAnimator(true)
  UIManager:Open(UI, status)
end

function Controller:ChangeDashBoard()
  if TradeDataModel.GetInTravel() then
    local mainUIConfig = PlayerData:GetFactoryData(99900034, "ConfigFactory")
    local curSpeed = PlayerData.GetCoachMaxSpeed() + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddSpeed)
    local cnt = #mainUIConfig.dashboardList
    for i = cnt, 1, -1 do
      local info = mainUIConfig.dashboardList[i]
      if curSpeed >= info.changeSpeed then
        DataModel.MaxDashBoardSpeed = info.maxSpeed
        View.Group_Common.Group_MB.Img_Speed.Img_S:SetSprite(info.dashboardPath)
        break
      end
    end
  end
end

function Controller.RefreshTrains()
  HomeTrainManager:LoadTrains(DataModel.roomSkinIds, DataModel.startHeight, true)
  PlayerData.RefreshStriker()
end

function Controller.InitTrain(isInitEnvironment)
  DataModel.RefreshData(PlayerData.ServerData.user_home_info.coach)
  Controller.RefreshTrains()
  if isInitEnvironment then
    Controller.InitEnvironment()
  end
end

function Controller.InitEnvironment()
  local isTravel, id = MapDataModel.GetTrainCurPos()
  if isTravel then
    local homeLineCA = PlayerData:GetFactoryData(id, "HomeLineFactory")
    if homeLineCA ~= nil then
      HomeSceneManager:InitEnvironment(homeLineCA.sceneGroup)
      return
    end
  else
    HomeSceneManager:InitEnvironment(DataModel.CurShowSceneInfo.sceneGroup)
  end
  HomeSceneManager:InitEnvironment(DataModel.envIDs)
end

function Controller.InitChangeNamePanel()
  View.Group_Info.Group_ChangeName.self:SetActive(true)
  View.Group_Info.Group_ChangeName.InputField_ChangeName.self:SetText("")
end

function Controller.CloseChangeNamePanel()
  View.Group_Info.Group_ChangeName.self:SetActive(false)
end

function Controller.RefreshOnhockPanel(json)
  View.Group_Onhock.self:SetActive(true)
  local awards = DataModel.tempHockReward
  local awardNum = 0
  local tempT = {}
  if awards ~= nil and awards.item ~= nil then
    for k, v in pairs(awards.item) do
      if tonumber(k) == 11400040 then
        awardNum = v.num
      end
      tempT[k] = v.num
    end
  end
  PlayerData:RefreshGetItems(tempT)
  local awards_report = json.awards_report
  View.Group_Onhock.Group_1.Img_GetTips.Txt_GetTips:SetText(string.format(GetText(80600302), awardNum))
  View.Group_Onhock.Group_1.Txt_TotalTips:SetText(string.format(GetText(80600303), math.ceil(awards_report.all_distance)))
  View.Group_Onhock.Group_1.Img_NowTips.Txt_NowTips:SetText(string.format(GetText(80600304), math.ceil(awards_report.this_distance)))
  local rewardTime = awards_report.awards_time
  if 43200 < rewardTime then
    rewardTime = 43200
  end
  local timeTable = TimeUtil:SecondToTable(rewardTime)
  View.Group_Onhock.Group_1.Img_Time.Txt_Time:SetText(string.format(GetText(80600305), timeTable.hour, timeTable.minute, timeTable.second))
  local stationCA = PlayerData:GetFactoryData(TradeDataModel.StartCity, "HomeStationFactory")
  View.Group_Onhock.Group_1.Txt_StartCity:SetText(stationCA.name)
  local curDis = TradeDataModel.GetTrainCurDistance()
  View.Group_Onhock.Group_1.Txt_StartCityKm:SetText(string.format("%.2fkm", curDis))
  stationCA = PlayerData:GetFactoryData(TradeDataModel.EndCity, "HomeStationFactory")
  View.Group_Onhock.Group_1.Txt_GoalCity:SetText(stationCA.name)
  View.Group_Onhock.Group_1.Txt_GoalCityKm:SetText(string.format("%.2fkm", TradeDataModel.StartEndTotalDistance - curDis))
  View.Group_Onhock.Group_1.Txt_Speed:SetText(TradeDataModel.Speed .. "km/h")
  local leftX = -180
  local rightX = 180
  local ratio = 0
  if TradeDataModel.StartEndTotalDistance ~= 0 then
    ratio = curDis / TradeDataModel.StartEndTotalDistance
  end
  if 1 < ratio then
    ratio = 1
  end
  local curX = leftX + (rightX - leftX) * ratio
  View.Group_Onhock.Group_1.Img_ProgressBar.Img_Progress:SetAnchoredPositionX(curX)
end

function Controller.RefreshWornPanel()
  View.Group_Worn.self:SetActive(true)
  local toCity = TradeDataModel.NextCityPath[#TradeDataModel.NextCityPath - 1]
  local stationCA = PlayerData:GetFactoryData(toCity, "HomeStationFactory")
  View.Group_Worn.Group_Schedule.Img_Origin.Txt_City:SetText(stationCA.name)
  View.Group_Worn.Group_Schedule.Txt_ReturnNum:SetText(string.format(GetText(80600299), math.ceil(TradeDataModel.DistanceToLastStation)))
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local coachCount = #DataModel.roomID
  local t = {}
  for k, v in pairs(homeConfig.coachCostList) do
    if t[v.id] == nil then
      t[v.id] = 0
    end
    t[v.id] = t[v.id] + v.num * coachCount
  end
  for k, v in pairs(stationCA.kmCostList) do
    if t[v.id] == nil then
      t[v.id] = 0
    end
    t[v.id] = t[v.id] + v.num * TradeDataModel.DistanceToLastStation
  end
  local cost = 0
  for k, v in pairs(t) do
    cost = v
    break
  end
  DataModel.coachWornCost = math.floor(cost + 0.5)
  View.Group_Worn.Group_ReturnCost.Txt_Cost:SetText("X" .. DataModel.coachWornCost)
  View.Group_Worn.Btn_Return.Txt_Return:SetText(string.format(GetText(80600336), stationCA.name))
  DataModel.coachWornToCityName = stationCA.name
end

function Controller.AutoAddMoveEnergy()
  if PlayerData:GetUserInfo().move_energy == nil then
    return
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local homeCommon = require("Common/HomeCommon")
  local maxEnergy = homeCommon.GetMaxHomeEnergy()
  if maxEnergy <= PlayerData:GetUserInfo().move_energy then
    return
  end
  local onceTime = homeConfig.homeEnergyAddCD
  local onceAdd = homeConfig.homeEnergyAdd
  local id = homeConfig.homeEnergyItemId
  if TimeUtil:GetServerTimeStamp() >= PlayerData:GetUserInfo().move_energy_time + onceTime then
    PlayerData:GetUserInfo().move_energy_time = PlayerData:GetUserInfo().move_energy_time + onceTime
    PlayerData:GetUserInfo().move_energy = PlayerData:GetUserInfo().move_energy + onceAdd
    if maxEnergy < PlayerData:GetUserInfo().move_energy then
      PlayerData:GetUserInfo().move_energy = maxEnergy
    end
    View.Group_Resources.Group_Energy.Txt_Num:SetText(PlayerData:GetUserInfo().move_energy .. "/" .. maxEnergy)
  end
end

function Controller.UpdateCameraEffect()
  if #DataModel.camTimeEffect == 0 then
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    for k, v in pairs(homeConfig.cameraEffectPathList) do
      local t = {}
      local h = tonumber(string.sub(v.time, 1, 2))
      local m = tonumber(string.sub(v.time, 4, 5))
      local s = tonumber(string.sub(v.time, 7, 8))
      t.time = h * 60 * 60 + m * 60 + s
      t.path = v.path
      table.insert(DataModel.camTimeEffect, t)
    end
  end
  local serverTime = TimeUtil:GetServerTimeStamp()
  if DataModel.todayZeroTimeStamp == 0 then
    local dt = os.date("*t", PlayerData.ServerData.server_now)
    DataModel.todayZeroTimeStamp = TimeUtil:TimeStamp(string.format("%d-%2d-%2d 00:00:00", dt.year, dt.month, dt.day))
  end
  local delta = serverTime - DataModel.todayZeroTimeStamp
  if delta >= DataModel.oneDayTimeStamp then
    local dt = os.date("*t", PlayerData.ServerData.server_now)
    DataModel.todayZeroTimeStamp = TimeUtil:TimeStamp(string.format("%d-%2d-%2d 00:00:00", dt.year, dt.month, dt.day))
    delta = 0
  end
  local count = #DataModel.camTimeEffect
  for i = count, 1, -1 do
    local info = DataModel.camTimeEffect[i]
    if delta > info.time then
      if DataModel.curTimeEffect ~= info.path then
        DataModel.curTimeEffect = info.path
        HomeTrainManager:AllTrainShowLight(i == count)
      end
      return
    end
  end
  local info = DataModel.camTimeEffect[count]
  if DataModel.curTimeEffect ~= info.path then
    DataModel.curTimeEffect = info.path
    HomeTrainManager:AllTrainShowLight(true)
  end
end

function Controller.GetOnHockReward(isShowTip)
  if TimeUtil:GetServerTimeStamp() < PlayerData.ServerData.user_home_info.awards.last + 60 then
    if isShowTip then
      CommonTips.OpenTips(80600348)
    end
    return
  end
  Net:SendProto("station.get_awards", function(json)
    PlayerData.ServerData.user_home_info.awards.last = TimeUtil:GetServerTimeStamp()
    DataModel.tempHockReward = json.reward
    View.Group_Onhock.self:SetActive(true)
    Controller.RefreshOnhockPanel(json)
    View.Group_Resources.Group_Weapon.Txt_Num:SetText(PlayerData:GetGoodsById(11400040).num)
  end)
end

function Controller.RefreshTrainMove(force)
  if force or not TradeDataModel.GetIsStop() and PlayerData:GetHomeInfo().station_info.is_arrived ~= 1 then
    local curDis = TradeDataModel.GetTrainCurDistance()
    if TradeDataModel.EndCity > 0 then
      local stationCA = PlayerData:GetFactoryData(TradeDataModel.EndCity, "HomeStationFactory")
      View.Group_Common.Group_Position.Txt_Destination:SetText(string.format(GetText(80600945), stationCA.name))
    end
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local showDis = math.ceil(TradeDataModel.CurRemainDistance * homeConfig.disRatio)
    View.Group_Common.Group_Position.Txt_Distance:SetText(string.format(GetText(80600703), math.max(0, showDis)))
    local leftX = -180
    local rightX = 180
    local ratio = 0
    ratio = curDis / TradeDataModel.TravelTotalDistance
    if 1 < ratio then
      ratio = 1
    end
    local curX = leftX + (rightX - leftX) * ratio
    View.Group_Common.Group_Position.Img_ProcessBar.Img_PositionMark:SetAnchoredPositionX(curX)
    View.Group_Common.Group_Position.Img_ProcessBar.Img_PB:SetFilledImgAmount(ratio)
  end
  if force then
    Controller.ShowAutoDriveTxt(TradeDataModel.DriveState == "Drive" and TradeDataModel.GetIsTravel())
    View.Group_Common.Group_Position.self:SetActive(TradeDataModel.GetInTravel())
  end
end

function Controller.ShowAutoDriveTxt(isShow)
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  if isShow == nil then
    isShow = true
  end
  View.Group_Common.Group_Position.Img_Cruise.self:SetActive(isShow and not View.Group_Common.Group_Back.self.IsActive)
end

function Controller.GetRandomMap(mapData)
  local total = 0
  for i, v in pairs(mapData) do
    v.sum = v.weight + total
    total = v.sum
  end
  local last = 0
  local weight = math.random(0, total)
  local levelid = 0
  for i, v in pairs(mapData) do
    if weight < v.sum and last < weight then
      levelid = v.id
    end
  end
  if levelid == 0 then
    return
  end
  local levelCA = PlayerData:GetFactoryData(levelid, "AdvLevelFactory")
  PlayerPrefs.SetString("MapName", levelCA.mapPath)
end

function Controller.SetQuestTrace()
  if View ~= nil then
    QuestTrace.SetQuestTrace(View.Group_Common.Group_Navigation, 1)
  end
end

function Controller.SwitchBGM(nowSoundId, targetSoundId, minVolume, duration)
  if nowSoundId ~= targetSoundId then
    local resUrl = PlayerData:GetFactoryData(nowSoundId).resUrl
    local audio = SoundManager:GetBgmSource(resUrl)
    local targetSound = SoundManager:CreateSound(targetSoundId)
    if targetSound then
      DOTweenTools.DOFadeSound(audio, duration, minVolume, function()
        targetSound:Play()
        audio = targetSound.audioSource
        local targetVolume = audio.volume
        targetSound:SetVolume(0.1)
        DOTweenTools.DOFadeSound(audio, duration, targetVolume)
      end)
    end
  end
end

function Controller.SetTouchCamera()
  if not View.touchCamera then
    local cam = MainManager.cam
    if cam == nil or cam:IsNull() then
      return
    end
    local envCamera = cam.transform
    if envCamera then
      local touchCamera = envCamera:GetComponent(typeof(CS.TouchCamera))
      if touchCamera == nil then
        touchCamera = envCamera.gameObject:AddComponent(typeof(CS.TouchCamera))
      end
      View.touchCamera = touchCamera
      touchCamera.canDrag = false
    end
  end
  if View.touchCamera then
    if not View.touchCamera:IsNull() then
      local isTravel, configId = MapDataModel.GetTrainCurPos()
      View.touchCamera.enabled = not isTravel
      if not isTravel then
        View.touchCamera._rightx = DataModel.CurShowSceneInfo.sceneWidth or 0
        View.touchCamera._leftx = -View.touchCamera._rightx
        View.touchCamera.canDrag = true
        View.touchCamera:InitPos()
      end
    else
      View.touchCamera = nil
    end
  end
end

function Controller.GoToNewCity(stationId, callback, isTrailer, trailerType, trailerCost)
  if stationId == nil then
    stationId = MapDataModel.CurSelectedId
  end
  if TradeDataModel.EndCity == stationId then
    return
  end
  if PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
    return
  end
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  local lvCheckOk = PlayerData:GetUserInfo().lv >= stationCA.playerLevel
  local levelCheckOk = 0 > stationCA.specifiedLevelId or PlayerData:GetLevelPass(stationCA.specifiedLevelId)
  local questCheckOk = 0 > stationCA.questId or PlayerData.IsQuestComplete(stationCA.questId)
  local canGo = lvCheckOk and levelCheckOk and questCheckOk
  if not canGo then
    CommonTips.OpenTips(80601184)
    return
  end
  local homeCommon = require("Common/HomeCommon")
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if PlayerData:GetUserInfo().move_energy > homeCommon.GetMaxHomeEnergy() + homeConfig.energyOver then
    homeCommon.OpenMoveEnergyUseItem(function()
      homeCommon.SetMoveEnergyElement(View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_HomeEnergy)
    end)
    return
  end
  PlayerData:SetTargetFrameRate()
  PlayerData.FreeCameraIndex = 1
  Controller.SetCamera(PlayerData.FreeCameraIndex)
  
  local function yesFunc()
    BugLogReporter.SendTrainEvent = nil
    BugLogReporter:Clear(BugLogReporter.ReportNames.TrainLineEvents)
    BugLogReporter:AddTail(BugLogReporter.ReportNames.TrainLineEvents, "\228\187\142\231\171\153\231\130\185\229\135\186\229\143\145======")
    
    local function detailDo()
      Controller:RefreshSafeBtnShow()
      Controller:RunBtnState(true)
      Controller.ShowEndActive(false)
      TrainManager:TravelReset()
      DataModel:InitModel()
      PlayerData:SetAutoTrailerIds()
      TradeDataModel.DirectSetDisAtStart = true
      TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.DriveNew)
      PlayerData:RefreshPolluteData()
      TradeDataModel.SetTrainMode(function()
        View.Group_Common.Group_Position.self:SetActive(TradeDataModel.GetInTravel())
        Controller:OpenLight(1)
        if table.count(PlayerData.polluteEffectList) == 0 then
          RenderSettingController.SetSkyRender()
        end
      end)
      Controller:ChangeDashBoard()
      Controller.SetSpeedAddShow()
      Controller.ChangeDriveBtnState()
      Controller.InitEnvironment()
      MapController:ShowDetailMap(false)
      MapDataModel.TravelLineWayPoints = {}
      Controller.SetTouchCamera()
      Controller.ShowAutoDriveTxt(true)
      PlayerData.showPosterGirl = -1
      Controller:SwitchTab(DataModel.UIShowEnum.OutSide, true)
      if not DataModel.FirstFrame then
        Controller.SetQuestTrace()
      end
      local showingSpine2 = false
      for k, v in pairs(DataModel.showSpine2) do
        if v then
          showingSpine2 = true
          break
        end
      end
      if showingSpine2 and View.Img_RT.IsActive == true then
        View.Img_RT:SetActive(false)
      end
      if callback ~= nil and type(callback) == "function" then
        callback()
      end
    end
    
    local function drive()
      local getInTravel = TradeDataModel.GetInTravel()
      local internal = CS.FRef.getProperty(TrainManager, "InternalTrainManager")
      CS.FRef.setProperty(internal.EventCtrl.LevelCtrl, "_isEvent", false)
      local tradeDataModel = require("UIHome/UIHomeTradeDataModel")
      tradeDataModel.lastStopDistance = -1
      
      local function driveSuccess()
        View.Group_Common.Group_MB.Group_PollutionIndex.Img_Mask.Group_Color:SetLocalEulerAngles(0)
        Net:SendProto("unification.world_pollute", function()
          PlayerData:GetPolluteTurntable(1)
        end)
        MapNeedleData.SetNeedleData()
        MapNeedleEventData.SetEventData()
        if DataModel.CurSceneName == DataModel.SceneNameEnum.Home then
          View.self:StartC(LuaUtil.cs_generator(function()
            MainManager:SetTrainViewFilter(30, true)
            coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
            
            local function cb()
              UIManager:Pause(false)
              CBus:ChangeScene("Main", nil, function()
                detailDo()
              end)
            end
            
            CommonTips.OpenLoading(nil, nil, nil, cb)
          end))
        elseif getInTravel then
          detailDo()
          TradeDataModel.SetMapGlobalNeedles()
          local t = TradeDataModel.GetAnnouncementList(EnumDefine.Announcement.Start)
          SoundManager:PlaySoundList(t)
        else
          if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant then
            View.Group_Adjutant.Img_BG:SetActive(false)
            Controller.RefreshAdjutantRoomBackDisplay(false)
          end
          local TimeLine = require("Common/TimeLine")
          local curStayStationCA = PlayerData:GetFactoryData(TradeDataModel.CurStayCity)
          for k, v in pairs(curStayStationCA.timeLineList) do
            TimeLine.RemoveTimeLine(v.id)
          end
          View.Group_Common.SoftMask_HomeMap.Group_MapActive:SetActive(false)
          MapDataModel.HomeMapType = 1
          MapController:ShowDetailMap(false)
          View.self:PlayAnim("MapOut2")
          local trainConfig = PlayerData:GetFactoryData(99900037, "ConfigFactory")
          local sound = SoundManager:CreateSound(trainConfig.whistleSoundId)
          if sound ~= nil then
            sound:Play()
          end
          local loadingConfig = PlayerData:GetFactoryData(99900036, "ConfigFactory")
          local text = ""
          if loadingConfig.bigWorldTipsList and 0 < #loadingConfig.bigWorldTipsList then
            text = loadingConfig.bigWorldTipsList[math.random(1, #loadingConfig.bigWorldTipsList)].tips
          end
          for k, v in pairs(curStayStationCA.pullOutTimeLineList) do
            TimeLine.LoadTimeLine(v.id)
          end
          Controller:ShowPosterGirl(false)
          Controller.RefreshLimitShopBannerShow()
          Controller.RefreshGoldInfoShow()
          HomeTrainManager:MoveTrain(trainConfig.pullOutSpeedMax or 1, trainConfig.pullOutASpeed or 1, trainConfig.pullOutTime or 1, trainConfig.delayTime, function()
            sound = SoundManager:CreateSound(trainConfig.trainSoundId)
            if sound ~= nil then
              sound:Play()
            end
          end, function()
            CommonTips.OpenLoading(function()
              detailDo()
            end, nil, nil, nil, text)
          end)
        end
      end
      
      local coachSkins, completeCb
      if not TradeDataModel.GetInTravel() then
        coachSkins, completeCb = homeCommon.GetOutStationRandomChangeSkin()
      end
      if isTrailer then
        Net:SendProto("station.req_back", function(json)
          if completeCb then
            completeCb()
          end
          local item = PlayerData:GetGoodsById(tostring(11400106))
          item.num = item.num - trailerCost
          Controller.RefreshGoldInfoShow()
          driveSuccess()
          local trailerConfig = PlayerData:GetFactoryData(99900060, "ConfigFactory")
          local trailerItem = PlayerData:GetGoodsById(tostring(trailerConfig.trailerItem))
          trailerItem.num = trailerItem.num - 1
        end, stationId, trailerType, coachSkins)
      else
        Net:SendProto("station.drive", function(json)
          if completeCb then
            completeCb()
          end
          DataModel.IsActivity = false
          DataModel.isGoMapStation = nil
          DataModel.initMapStation = nil
          driveSuccess()
        end, stationId, coachSkins)
      end
    end
    
    local cfg = PlayerData:GetFactoryData("99900007")
    local max = PlayerData.GetMaxFuelNum()
    local buyNum = 0
    if PlayerData:GetPlayerPrefs("int", "IsAutoAddRush") == 1 then
      local remainTime = max - PlayerData:GetHomeInfo().readiness.fuel.fuel_num
      if 0 < remainTime then
        local costItem = cfg.trainRushBuyList
        local have = PlayerData:GetGoodsById(costItem[1].id).num
        local moneyNum = costItem[1] and costItem[1].num or 0
        buyNum = math.min(remainTime, math.floor(have / moneyNum))
      end
    end
    if 0 < PlayerData:GetHomeInfo().readiness.repair.current_durable then
      if 0 < buyNum then
        Net:SendProto("home.refuel", function(json)
          MapController:RefreshAcceNum()
          Controller:InitCommonShow()
          drive()
        end, tostring(buyNum))
      else
        drive()
      end
    else
      CommonTips.OpenTips(80601327)
    end
  end
  
  local stateInfo = homeCommon.GetCityStateInfo(stationId)
  if stateInfo == nil or PlayerData:GetPlayerLevel() >= stateInfo.recommendLevel then
    yesFunc()
  else
    local checkTipParam = {}
    checkTipParam.isCheckTip = true
    checkTipParam.checkTipKey = "StationDriveLevelCheck"
    checkTipParam.checkTipType = 1
    checkTipParam.showDanger = true
    checkTipParam.showSafe = true
    CommonTips.OnPrompt(string.format(GetText(80601216), stateInfo.recommendLevel), nil, nil, yesFunc, nil, nil, nil, nil, checkTipParam)
  end
end

function Controller.TryGoToNewCity()
  if PlayerData:GetHomeInfo().weapon_gift and PlayerData:GetHomeInfo().weapon_gift.ram ~= 1 and PlayerData:GetHomeInfo().coach[1].battery[1] == "" and not PlayerData.CurTrainSkinIsSpecial() then
    local trainWeaponCfg = GetCA(99900044, "ConfigFactory")
    local electricCost = TrainWeaponTag.GetOneWeaponTagAttributesByID(EnumDefine.TrainWeaponTagEnum.ElectricCost, trainWeaponCfg.strikeGiftId, 0)
    if PlayerData:GetHomeInfo().electric_used + electricCost <= PlayerData.GetMaxElectric() and PlayerData.GetQuestState(trainWeaponCfg.strikeQuestId) == EnumDefine.EQuestState.Receive then
      UIManager:Open("UI/MainUI/StrikeGiftTip")
      return
    end
  end
  if PlayerData:GetHomeInfo().station_info.status == -3 then
    Controller.GoToNewCity()
    return
  end
  local stationId = MapDataModel.CurSelectedId
  if TradeDataModel.EndCity == stationId then
    return
  end
  if PlayerData:GetHomeInfo().station_info.status ~= -1 then
    return
  end
  local commonCA = PlayerData:GetFactoryData(99900001)
  local questCheckOk = 0 > commonCA.emptyTipQuest or PlayerData.IsQuestComplete(commonCA.emptyTipQuest)
  if not questCheckOk then
    Controller.GoToNewCity()
    return
  end
  local hasPassengerEmpty = (PlayerData:GetCurPassengerNum() or 0) < (PlayerData:GetMaxPassengerNum() or 0)
  local user_info = PlayerData:GetUserInfo()
  local configCA = PlayerData:GetFactoryData(99900061)
  local user_lv = user_info.lv
  local hasLoadageEmpty = (user_info.space_info.now_train_goods_num or 0) < PlayerData.GetMaxTrainGoodsNum()
  local ignoreLodage = PlayerData:GetPlayerPrefs("int", "isIgnoreTradeEmpty") == 1
  local ignorePassenger = PlayerData:GetPlayerPrefs("int", "isIgnorePassengerEmpty") == 1
  if (not (not ignorePassenger and hasPassengerEmpty) or user_lv < configCA.solicitOpen) and (not hasLoadageEmpty or ignoreLodage) then
    Controller.GoToNewCity()
    return
  end
  local isNoPrompt = false
  local param = PlayerData:GetPlayerPrefs("int", "EmptyTipCheckParam")
  if param == 1 then
    isNoPrompt = PlayerData:GetNoPrompt("EmptyTip", 1)
  elseif param == 2 then
    isNoPrompt = PlayerData:GetNoPrompt("EmptyTip", 2)
  end
  if isNoPrompt then
    Controller.GoToNewCity()
  else
    DataModel.isGoMapStation = MapDataModel.CurSelectedId
    UIManager:Open("UI/MainUI/EmptyTip", Json.encode({
      hasLoadageEmpty = hasLoadageEmpty,
      hasPassengerEmpty = hasPassengerEmpty,
      curCityId = PlayerData:GetHomeInfo().station_info.sid
    }), Controller.GoToNewCity)
  end
end

function Controller.ChangeBtn(btn, cb)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Group_Gear = View.Group_OutSide.Group_Running.Group_Gear
  local Btn_D = Group_Gear.Btn_D
  local Btn_R = Group_Gear.Btn_R
  local Btn_B = Group_Gear.Btn_B
  local img = Group_Gear.Img_Gear
  local t = {
    {btn = Btn_D, angle = 0},
    {btn = Btn_R, angle = 90},
    {btn = Btn_B, angle = 45}
  }
  for i, v in ipairs(t) do
    if v.btn ~= btn then
      v.btn.Group_On:SetActive(false)
      v.btn.Group_Off:SetActive(true)
    else
      v.btn.Group_On:SetActive(true)
      v.btn.Group_Off:SetActive(false)
      local tween = DOTweenTools.DOLocalRotate(img.transform, 0, 0, v.angle, 0.1)
      if cb ~= nil then
        DOTweenTools.DoComplete(tween, cb)
      end
    end
  end
end

function Controller.ArriveRefreshShow(json)
  local bgSoundId = DataModel.CurShowSceneInfo.bgmId or PlayerData:GetFactoryData(TradeDataModel.EndCity).bgmId
  DataModel.nowSoundId = bgSoundId
  local sound = SoundManager:CreateSound(bgSoundId)
  if sound ~= nil then
    sound:Play()
  end
  for k, v in pairs(json.stations) do
    PlayerData:GetHomeInfo().stations[tostring(TradeDataModel.EndCity)][k] = v
  end
  
  local function callback()
    PlayerData.TempCache.EventFinish = true
    Controller.MainLineEventShow(nil, false, false)
    Controller:SwitchTab(DataModel.UIShowEnum.OutSide, true)
    if not DataModel.FirstFrame then
      Controller.SetQuestTrace()
    end
    Controller.SetQuestTrace()
    Controller.RefreshTrainMove(true)
    Controller:InitCommonShow()
    MapController:RefreshStationPos()
    Controller:ShowPosterGirl(PlayerData.showPosterGirl == 1, true)
    Controller.BackShow(false)
    Controller.ShowWarning(false)
    Controller.ShowAutoDriveTxt(false)
    View.Group_Common.Group_Position.self:SetActive(false)
    Controller.SetTouchCamera()
    View.self:PlayAnim("In", function()
      CommonTips.OpenQuestsCompleteTip()
    end)
    local t = TradeDataModel.GetAnnouncementList(EnumDefine.Announcement.Enter)
    SoundManager:PlaySoundList(t)
    CommonTips.OpenRepLvUp()
    Controller.RefreshGoldInfoShow()
    if json.stations[tostring(TradeDataModel.EndCity)].is_first == 0 then
      CommonTips.OpenArriveNewCityTip(TradeDataModel.EndCity)
    end
    if json.fatigue then
      CommonTips.OpenFatigueTip(json.fatigue)
    end
    if json.tran_lv and PlayerData:GetHomeInfo().tran_lv < json.tran_lv then
      UIManager:Open("UI/Passenger/PassagerLvup/TransportLvUp", Json.encode({
        oldLv = PlayerData:GetHomeInfo().tran_lv,
        nowLv = json.tran_lv
      }))
      PlayerData:GetHomeInfo().tran_lv = json.tran_lv
    end
    if json.tran_exp then
      PlayerData:GetHomeInfo().tran_exp = json.tran_exp
    end
    CommonTips.OpenADPop(true)
  end
  
  local function afterDo(isChangeScene)
    TradeDataModel.SetTrainMode(function()
      if not isChangeScene then
        local isReloadCoach = HomeTrainManager:GetCoachSkinState() ~= PosClickHandler.GetCoachDirtyType()
        if isReloadCoach then
          HomeTrainManager:ReloadTrains()
          PlayerData.RefreshStriker()
        end
      end
      callback()
    end)
  end
  
  local function passengerAfterDo(isChangeScene)
    TradeDataModel.SetTrainMode(function()
      if not isChangeScene then
        local isReloadCoach = HomeTrainManager:GetCoachSkinState() ~= PosClickHandler.GetCoachDirtyType()
        if isReloadCoach then
          HomeTrainManager:ReloadTrains()
          PlayerData.RefreshStriker()
        end
      end
      local cam = MainManager.cam
      if cam then
        local envCamera = cam.transform
        local touchCamera = envCamera:GetComponent(typeof(CS.TouchCamera))
        if touchCamera then
          touchCamera:InitPos()
        end
      end
      DataModel.passengerCoroutine = View.self:StartC(LuaUtil.cs_generator(function()
        Controller:SwitchTab(DataModel.UIShowEnum.Passenger, false)
        local TimeLine = require("Common/TimeLine")
        local stationCA = PlayerData:GetFactoryData(TradeDataModel.CurStayCity)
        for k, v in pairs(stationCA.timeLineList) do
          TimeLine.RemoveTimeLine(v.id)
        end
        local passengerDataModel = require("UIPassenger/UIPassengerDataModel")
        passengerDataModel.CreateNpc(false)
        local psgDataModel = require("UIPassenger/UIPassengerDataModel")
        local outPsgIds = psgDataModel.GetOutPassengerList(json, 10)
        MainSceneCharacterManager:CreatePassengers(outPsgIds, false)
        coroutine.yield(CS.UnityEngine.WaitForSeconds(2))
        CommonTips.OpenPassengerRewardTips(json, callback)
        if DataModel.passengerCoroutine then
          View.self:StopC(DataModel.passengerCoroutine)
          DataModel.passengerCoroutine = nil
        end
      end))
    end)
  end
  
  local psgDataModel = require("UIPassenger/UIPassengerDataModel")
  local outPsgIds = psgDataModel.GetOutPassengerList(json)
  MapDataModel.TravelLineWayPoints = {}
  if DataModel.CurSceneName == DataModel.SceneNameEnum.Main then
    if 0 < #outPsgIds then
      passengerAfterDo(false)
    else
      afterDo(false)
    end
    CommonTips.OpenLoading(nil, "UI/Loading/Black_tip", Json.encode(json))
  else
    local function cb()
      UIManager:Pause(false)
      
      CBus:ChangeScene("Main", nil, function()
        if 0 < #outPsgIds then
          passengerAfterDo(true)
        else
          afterDo(true)
        end
      end)
    end
    
    CommonTips.OpenLoading(nil, "UI/Loading/Black_tip", Json.encode(json), cb)
  end
end

function Controller.SetRushEffectState()
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local state = DataModel.GetIsRushing()
  if state then
    View.Group_OutSide.Group_Running.Group_RushEffect:SetDynamicGameObject(DataModel.MainRushEffectPath, 0, 0)
  end
  View.Group_OutSide.Group_Running.Group_RushEffect.self:SetActive(state)
end

function Controller.SetSpeedAddShow()
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  if TrainManager.CurrTrainState == TrainState.Rush then
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing:SetActive(true)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing.Group_RushTime:SetDynamicGameObject(DataModel.RushTimeBtnEffectPath, 0, 0)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing.Group_RushBuyBtn:SetActive(false)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_On:SetActive(false)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Off:SetActive(false)
  else
    local accelerate_num = PlayerData:GetHomeInfo().readiness.fuel.fuel_num
    if TradeDataModel.GetInTravel() then
      local isHave = 0 < accelerate_num
      View.Group_OutSide.Group_Running.Btn_Accelerate.Group_On:SetActive(isHave)
      View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Off:SetActive(not isHave)
    end
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_On.Txt_Num:SetText(accelerate_num)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Off.Txt_Num:SetText(accelerate_num)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing:SetActive(false)
  end
end

function Controller.ChangeDriveBtnState()
  DataModel.isRun = false
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Group_Gear = View.Group_OutSide.Group_Running.Group_Gear
  local Btn_D = Group_Gear.Btn_D
  local Btn_R = Group_Gear.Btn_R
  local Btn_B = Group_Gear.Btn_B
  if TrainManager.CurrTrainState == TrainState.Running or TrainManager.CurrTrainState == TrainState.AddSpeed or TrainManager.CurrTrainState == TrainState.ReduceSpeed or TrainManager.CurrTrainState == TrainState.Rush then
    Controller.ChangeBtn(Btn_D)
    Controller.BackShow(false)
    DataModel.isRun = TrainManager.CurrTrainState ~= TrainState.Rush
  elseif TrainManager.CurrTrainState == TrainState.Astern then
    Controller.ChangeBtn(Btn_R)
    Controller.BackShow(true)
  elseif TrainManager.CurrTrainState == TrainState.Stop or TrainManager.CurrTrainState == TrainState.Stopping or TrainManager.CurrTrainState == TrainState.Event or TrainManager.CurrTrainState == TrainState.Eventing or TrainManager.CurrTrainState == TrainState.EventFinish or TrainManager.CurrTrainState == TrainState.Arrive or TrainManager.CurrTrainState == TrainState.Arriving or TrainManager.CurrTrainState == TrainState.Backing or TrainManager.CurrTrainState == TrainState.Back then
    Controller.ChangeBtn(Btn_B)
    if TrainManager.CurrTrainState == TrainState.Arrive or TrainManager.CurrTrainState == TrainState.Arriving or TrainManager.CurrTrainState == TrainState.Back or TrainManager.CurrTrainState == TrainState.Eventing or TrainManager.CurrTrainState == TrainState.Event then
      Controller.BackShow(false)
    else
      Controller.BackShow(true)
    end
    if TrainManager.CurrTrainState == TrainState.Eventing or TrainManager.CurrTrainState == TrainState.Event then
      Controller.ShowAutoDriveTxt(false)
    end
  end
  if MapNeedleEventData.event then
    Controller.BackShow(true)
    Controller.ShowAutoDriveTxt(true)
  end
end

function Controller.ShowEndActive(isActive)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  
  local function enterStation()
    if PlayerData:GetHomeInfo().drive_setup.money == 1 and isActive then
      local loadingActive = CS.FRef.getProperty(LoadingManager, "_loading")
      if loadingActive ~= nil and loadingActive.gameObject.activeSelf then
        DataModel.WaitEnterStation = true
      else
        MapController:ShowDetailMap(false)
        Controller.enterStation()
      end
    end
  end
  
  if PlayerData:GetPlayerPrefs("int", "IsAutoBuyRoad") == 1 then
    local isAuto = 1
    Net:SendProto("home.update_drive_setup", function(json)
      PlayerData:SetPlayerPrefs("int", "IsAutoBuyRoad", 0)
      PlayerData:GetHomeInfo().drive_setup.money = isAuto
      enterStation()
    end, "money", isAuto)
  else
    enterStation()
  end
  local Group_Running = View.Group_OutSide.Group_Running
  local Group_Common = View.Group_Common
  Group_Common.Btn_Enter.self:SetActive(isActive)
  Group_Common.Btn_Leave.self:SetActive(isActive)
  Group_Running.Btn_Mask:SetActive(isActive)
  View.Group_Common.Btn_ClickFight.self:SetActive(false)
end

function Controller.CheckAutoEnterStation()
  if DataModel.WaitEnterStation then
    DataModel.WaitEnterStation = false
    MapController:ShowDetailMap(false)
    Controller.enterStation()
  end
end

function Controller.enterStation()
  local isBack = TradeDataModel.DriveLine[#TradeDataModel.DriveLine].id == TradeDataModel.EndCity and 3 or 0
  Net:SendProto("station.arrive", function(json)
    DataModel.justArrived = true
    PlayerData:GetHomeInfo().station_info = json.station_info
    DataModel.GetCurShowSceneInfo()
    TrainCameraManager:SetPostProcessing(1, DataModel.CurShowSceneInfo.postProcessingPath)
    if json.station_info and json.station_info.distance then
      PlayerData:GetHomeInfo().station_info.station_info = json.station_info.station_info
      TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.Refresh)
    else
      PlayerData.ServerData.user_home_info.station_info.stop_info = json.station_info.stop_info
      TrainEffectHelper:Dispose()
      TrainManager:TravelOver()
      TradeDataModel.CurRemainDistance = 0
      PlayerData.showPosterGirl = 1
      Controller.SetSpeedShow(0)
      Controller.ArriveRefreshShow(json)
    end
    PlayerData:ClearPollute()
    Controller.ShowEndActive(false)
    Controller:RefreshSafeBtnShow()
    Controller.RefreshLimitShopBannerShow()
    Controller.RefreshGoldInfoShow()
    View.Group_Common.Img_DialogBox:SetActive(false)
    MapNeedleData.ResetData()
    PlayerData:SetStationIsNotFirst(TradeDataModel.EndCity)
    UIManager:CloseTip("UI/Common/GradeUp/GradeUp")
  end, TradeDataModel.EndCity, isBack)
end

function Controller.readyToGo()
  local questId = QuestTrace.HaveMainQuest()
  local teleportQuestId = tonumber(PlayerData:GetHomeInfo().now_teleport) or 0
  if questId ~= 0 and teleportQuestId and teleportQuestId ~= questId then
    local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
    if questCA and questCA.isTeleport == true and questCA.teleportStartStation == TradeDataModel.CurStayCity and PlayerData:GetHomeInfo().station_info.status == -1 then
      local data = {}
      data.endCity = questCA.teleportEndStation
      data.text = questCA.teleportText
      data.questId = questId
      data.arriveType = "quest_teleport"
      Controller.teleportStation(data)
      return
    end
  end
  MapController:ShowDetailMap(true)
end

function Controller.teleportStation(data)
  local isBack = 0
  local ajson = {}
  if data.plotId then
    ajson.plotId = tostring(data.plotId)
  end
  Net:SendProto("station.arrive", function(json)
    if data.questId then
      PlayerData:GetHomeInfo().now_teleport = data.questId
    end
    json.text = data.text or ""
    DataModel.justArrived = true
    PlayerData:GetHomeInfo().station_info = json.station_info
    DataModel.GetCurShowSceneInfo()
    TradeDataModel.EndCity = data.endCity
    TradeDataModel.CurStayCity = TradeDataModel.EndCity
    TrainCameraManager:SetPostProcessing(1, DataModel.CurShowSceneInfo.postProcessingPath)
    if json.station_info and json.station_info.distance then
      PlayerData:GetHomeInfo().station_info.station_info = json.station_info.station_info
      TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.Refresh)
    else
      PlayerData.ServerData.user_home_info.station_info.stop_info = json.station_info.stop_info
      TrainEffectHelper:Dispose()
      TrainManager:TravelOver()
      TradeDataModel.CurRemainDistance = 0
      PlayerData.showPosterGirl = 1
      Controller.SetSpeedShow(0)
      Controller.ArriveRefreshShow(json)
    end
    PlayerData:ClearPollute()
    Controller.ShowEndActive(false)
    View.Group_Common.Img_DialogBox:SetActive(false)
    Controller.RefreshLimitShopBannerShow()
    Controller.RefreshGoldInfoShow()
    Controller:RefreshSafeBtnShow()
    MapNeedleData.ResetData()
    PlayerData:SetStationIsNotFirst(TradeDataModel.EndCity)
    UIManager:CloseTip("UI/Common/GradeUp/GradeUp")
    MapController:RefreshStationPos()
    MapController:RefreshViewToTrain()
  end, data.endCity, isBack, data.arriveType, next(ajson) and Json.encode(ajson) or "{}")
end

function Controller.plotTeleport(endCityId, plotId, textId)
  local data = {}
  data.endCity = tonumber(endCityId)
  data.plotId = tonumber(plotId)
  if textId then
    data.text = GetText(tonumber(textId))
  end
  data.arriveType = "plot_teleport"
  Controller.teleportStation(data)
end

function Controller.SetSpeedShow(speed, isTween)
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  if View and View.self and View.self.IsActive then
    local imgPercent = 0.67
    imgPercent = 0.164 + imgPercent * speed / DataModel.MaxDashBoardSpeed
    local angle = 120 - speed / DataModel.MaxDashBoardSpeed * 240
    angle = math.max(-130, angle)
    if View.Group_Common.Group_MB.Img_Speed.Img_Pointer.IsActive then
      if isTween then
        DOTweenTools.DOLocalRotate(View.Group_Common.Group_MB.Img_Speed.Img_Pointer.transform, 0, 0, angle, 0.5)
        DOTweenTools.DoImgProgressbar(View.Group_Common.Group_MB.Img_Speed.Img_BP, View.Group_Common.Group_MB.Img_Speed.Img_BP.Img.fillAmount, imgPercent, 0.5)
        DOTweenTools.DoTextProgress(View.Group_Common.Group_MB.Img_Speed.Txt_Speed, tonumber(View.Group_Common.Group_MB.Img_Speed.Txt_Speed.Txt.text), speed, 0.5, nil, nil, nil, true, "f0")
      else
        View.Group_Common.Group_MB.Img_Speed.Img_Pointer:SetLocalEulerAngles(angle)
        View.Group_Common.Group_MB.Img_Speed.Img_BP:SetFilledImgAmount(imgPercent)
        View.Group_Common.Group_MB.Img_Speed.Txt_Speed:SetText(math.floor(speed))
      end
    end
  end
end

local function PlayRoleSound(index, soundId, soundContent, cb)
  local time = os.time()
  local sound = SoundManager:CreateSound(soundId)
  if sound ~= nil then
    sound:Play()
    DataModel.soundEndTime = sound.audioSource.clip.length + time + 1
    View.sound = sound
  else
    DataModel.soundEndTime = 3 + time + 1
  end
  DataModel:GetNextSoundTime()
  View.timer:ReTimer(DataModel.nextDelay)
  View.Group_Common.Img_DialogBox:SetActive(true)
  local content = soundContent
  View.Group_Common.Img_DialogBox.Txt_Dialog:SetText(content)
  local txtHeight = View.Group_Common.Img_DialogBox.Txt_Dialog:GetHeight()
  View.Group_Common.Img_DialogBox:SetHeight(txtHeight + 80)
  View.Group_Common.Img_DialogBox.Txt_Dialog:SetHeight(txtHeight)
  View.Group_Common.Img_DialogBox.Txt_Dialog:SetTweenContent(content)
  if View.coroutineSound then
    View.self:StopC(View.coroutineSound)
    View.coroutineSound = nil
  end
  View.coroutineSound = View.self:StartC(LuaUtil.cs_generator(function()
    local soundTime = sound ~= nil and sound.audioSource.clip.length or 3
    coroutine.yield(CS.UnityEngine.WaitForSeconds(soundTime))
    View.Group_Common.Img_DialogBox:SetActive(false)
    View.sound = nil
    if cb then
      cb()
    end
  end))
  local viewId = DataModel.UnitViewId[index]
  local viewCfg = PlayerData:GetFactoryData(viewId)
  if not viewCfg.videoSpine and DataModel.UnitViewIdIsSpine[index] == 0 then
    local defaultCfg = PlayerData:GetFactoryData(99900014)
    local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. index].Viewport.Content
    View.Group_Common.Img_DialogBox.self:SetParent(viewGroup.self.transform)
    View.Group_Common.Img_DialogBox:SetAnchoredPosition(Vector2(defaultCfg.dialogBoxX, defaultCfg.dialogBoxY))
  else
    View.Group_Common.Img_DialogBox.self:SetParent(View.Group_Common.self.transform)
    View.Group_Common.Img_DialogBox:SetAnchoredPosition(Vector2(-670, 0))
  end
end

function Controller:RandomPlayRoleSound(index, forceSound, noWeight)
  DataModel.nextPlaySoundTime = DataModel.nextPlaySoundTime or 0
  local time = os.time()
  if time > DataModel.soundEndTime then
    local roleCount = #DataModel.roleAudioCount
    index = index or math.random(1, roleCount)
    local count = DataModel.roleAudioCount[index]
    if count == 0 then
      return
    end
    local nowId = -1
    local roleAudio
    local isNormalAudio = true
    if forceSound then
      roleAudio = DataModel.roleAudioList[index][2]
      nowId = roleAudio.Audio2
    else
      local idx = 1
      if not noWeight then
        nowId, idx = DataModel.RandomRoleSoundId(index)
        roleAudio = DataModel.roleAudioList[index][idx]
      end
      if nowId == -1 or noWeight == true then
        math.randomseed(time)
        roleAudio = DataModel.roleAudioList[index][math.random(3, count)]
        nowId = roleAudio.Audio2 or roleAudio.audioList
      end
      if roleAudio.audioList then
        isNormalAudio = false
      end
    end
    DataModel.lastRoleSoundId = nowId
    if isNormalAudio then
      PlayRoleSound(index, DataModel.lastRoleSoundId, roleAudio.StoryText)
    else
      DataModel.audioCfg = PlayerData:GetFactoryData(DataModel.lastRoleSoundId, "ListFactory")
      DataModel.audioIndex = 1
      local soundInfo = DataModel.audioCfg.VoiceList[1]
      local tempFunc
      
      function tempFunc()
        if DataModel.audioCfg == nil then
          DataModel.audioIndex = nil
          return
        end
        DataModel.audioIndex = DataModel.audioIndex + 1
        if DataModel.audioIndex > #DataModel.audioCfg.VoiceList then
          DataModel.audioIndex = nil
          DataModel.audioCfg = nil
          return
        end
        local _audioCfg = DataModel.audioCfg.VoiceList[DataModel.audioIndex]
        local tempIndex = 1
        for i = #DataModel.roleId, 1, -1 do
          if tostring(DataModel.roleId[i]) == tostring(_audioCfg.id) then
            tempIndex = i
            break
          end
        end
        PlayRoleSound(tempIndex, _audioCfg.Audio2, _audioCfg.StoryText, tempFunc)
      end
      
      PlayRoleSound(index, soundInfo.Audio2, soundInfo.StoryText, tempFunc)
    end
  end
end

function Controller:InitDrinkBuffShow()
  local drinkBuff = PlayerData:GetCurDrinkBuff()
  DataModel.IsDrinkBuffShow = drinkBuff ~= nil
  View.Group_Common.Group_TopLeft.Group_Buff.Img_Buff.self:SetActive(false)
  View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffWL.self:SetActive(false)
  if DataModel.IsDrinkBuffShow then
    View.Group_Common.Group_TopLeft.Group_Buff.self:SetActive(true)
    local idInt = tonumber(drinkBuff.id)
    local tempBuffList = PlayerData:GetFactoryData(80309368, "ListFactory").drinkBuffList
    for k, v in pairs(tempBuffList) do
      if v.id == idInt then
        View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffWL.self:SetActive(true)
        break
      end
    end
    tempBuffList = PlayerData:GetFactoryData(80300224, "ListFactory").drinkBuffList
    for k, v in pairs(tempBuffList) do
      if v.id == idInt then
        View.Group_Common.Group_TopLeft.Group_Buff.Img_Buff.self:SetActive(true)
        break
      end
    end
  end
end

function Controller:InitSpeedUpBuffShow()
  local buff = PlayerData:GetCurStationStoreBuff(PlayerData:GetCurTrainBuffType())
  DataModel.IsSpeedUpBuffShow = buff ~= nil
  if DataModel.IsSpeedUpBuffShow then
    View.Group_Common.Group_TopLeft.Group_Buff.self:SetActive(true)
  end
  View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffSpeed.self:SetActive(DataModel.IsSpeedUpBuffShow)
end

function Controller:InitBattleUpBuffShow()
  local buff = PlayerData:GetCurStationStoreBuff(EnumDefine.HomeSkillEnum.HomeBattleBuff)
  DataModel.IsBattleBuffShow = buff ~= nil
  if DataModel.IsBattleBuffShow then
    View.Group_Common.Group_TopLeft.Group_Buff.self:SetActive(true)
  end
  View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffBattle.self:SetActive(DataModel.IsBattleBuffShow)
end

function Controller:CheckDrinkBuffShow()
  if DataModel.IsDrinkBuffShow then
    local drinkBuff = PlayerData:GetCurDrinkBuff()
    local curTime = TimeUtil:GetServerTimeStamp()
    if drinkBuff == nil or curTime >= drinkBuff.endTime then
      PlayerData:SetDrinkBuff(nil)
      View.Group_Common.Group_TopLeft.Group_Buff.Img_Buff.self:SetActive(false)
      View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffWL.self:SetActive(false)
      DataModel.IsDrinkBuffShow = false
    end
  end
end

function Controller:CheckSpeedUpBuffShow()
  if DataModel.IsSpeedUpBuffShow then
    local buffType = PlayerData:GetCurTrainBuffType()
    local buff = PlayerData:GetCurStationStoreBuff(buffType)
    local curTime = TimeUtil:GetServerTimeStamp()
    if buff == nil or curTime >= buff.endTime then
      PlayerData:SetStationStoreBuff(nil, buffType)
      View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffSpeed.self:SetActive(false)
      DataModel.IsSpeedUpBuffShow = false
    end
  end
end

function Controller:CheckBattleUpBuffShow()
  if DataModel.IsBattleBuffShow then
    local buffType = EnumDefine.HomeSkillEnum.HomeBattleBuff
    local buff = PlayerData:GetCurStationStoreBuff(buffType)
    local curTime = TimeUtil:GetServerTimeStamp()
    if buff == nil or curTime >= buff.endTime then
      PlayerData:SetStationStoreBuff(nil, buffType)
      View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffBattle.self:SetActive(false)
      DataModel.IsBattleBuffShow = false
    end
  end
end

function Controller:TrainEvent(eventId, isEventEnter)
  Controller.StrikeShow(false)
  if eventId == nil then
    if DataModel.TrainEventId and PlayerData.BattleInfo.BattleResult and not PlayerData.BattleInfo.BattleResult.isWin then
      local t = {
        id = DataModel.TrainEventId
      }
      UIManager:Open("UI/MainUI/BattleLoss", Json.encode(t))
    end
    DataModel.TrainEventId = nil
    DataModel.TrainLevelId = nil
    DataModel.TrainLineId = nil
    DataModel.IsEvent = false
    DataModel.TrainEventBgmId = nil
    Controller.ShowRoleTip(false)
    Controller.SetGroupFightShow(false)
    return
  end
  local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
  if event.mod == "\229\133\179\229\141\161\228\186\139\228\187\182" then
    if MainManager.bgSceneName == DataModel.SceneNameEnum.Main or MainManager.bgSceneName == DataModel.SceneNameEnum.Home then
      if isEventEnter then
        View.self:PlayAnim("BattleStart")
      else
        View.self:PlayAnim("BattleIng")
      end
      View.Group_Common.Btn_Enter:SetActive(false)
      View.Group_Common.Btn_Leave:SetActive(false)
      View.Group_Common.Group_Back.self:SetActive(false)
      View.Group_Common.Group_Fight.Btn_Mask:SetActive(false)
    end
    DataModel.IsEvent = true
    Controller.ShowRoleTip(true)
    local levelId = event.levelId
    DataModel.TrainEventId = eventId
    BugLogReporter:AddTail(BugLogReporter.ReportNames.TrainLineEvents, "2Lua\232\174\190\231\189\174\228\186\139\228\187\182id " .. tostring(eventId))
    DataModel.TrainLevelId = levelId
    if event.isBgm then
      DataModel.TrainEventBgmId = event.bgmId
    end
    Controller.SetGroupFightShow(true)
  elseif event.mod == "\231\130\185\229\135\187\229\133\179\229\141\161" or event.mod == "\230\177\161\230\159\147\231\130\185\229\135\187\228\186\139\228\187\182" then
  end
end

function Controller.SetGroupFightShow(isShow)
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  View.Group_Common.Group_Fight:SetActive(isShow)
  if isShow then
    if UIManager:IsPanelOpened("UI/Attraction/Attractions") then
      UIManager:ClosePanel(true, "UI/Attraction/Attractions")
    end
    Controller.ShowWarning(false)
  else
    Controller:ReopenAttractions()
  end
end

function Controller:RunBtnState(state)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Group_Gear = View.Group_OutSide.Group_Running.Group_Gear
  local Btn_D = Group_Gear.Btn_D
  local Btn_R = Group_Gear.Btn_R
  local Btn_B = Group_Gear.Btn_B
  local Btn_Accelerate = View.Group_OutSide.Group_Running.Btn_Accelerate
  local allBtn = {
    Btn_B,
    Btn_R,
    Btn_D,
    Btn_Accelerate
  }
  for i, v in ipairs(allBtn) do
    v:SetBtnInteractable(state)
  end
end

function Controller.ReachNewCityRoleTip()
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  if PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
    View.Group_Common.Img_DialogBox:SetActive(true)
    View.Group_Common.Group_Position.Txt_Distance:SetText(GetText(80600424))
    Controller:ShowPosterGirl(true, false, true)
    local nowStationName = PlayerData:GetFactoryData(TradeDataModel.CurStayCity).name
    local content = string.format(GetText(80600741), nowStationName)
    View.Group_Common.Img_DialogBox.Txt_Dialog:SetText(content)
    local txtHeight = View.Group_Common.Img_DialogBox.Txt_Dialog:GetHeight()
    View.Group_Common.Img_DialogBox:SetHeight(txtHeight + 80)
    View.Group_Common.Img_DialogBox.Txt_Dialog:SetHeight(txtHeight)
    View.Group_Common.Img_DialogBox.Txt_Dialog:SetTweenContent(content)
  end
end

function Controller.ShowHelpButton()
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  if TradeDataModel.GetInTravel() then
    if PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 and not PlayerData.TempCache.IsHelp then
      View.Group_Common.Btn_Help.self:SetActive(true)
      View.Group_Common.Group_Back.self:SetActive(false)
    else
      View.Group_Common.Btn_Help.self:SetActive(false)
    end
  else
    View.Group_Common.Btn_Help.self:SetActive(false)
  end
end

function Controller.SetTrainBreakEffect()
  if TradeDataModel.GetInTravel() then
    local isBreak = PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 and not PlayerData.TempCache.IsHelp
    TrainManager:SetOutSideTrainBreakEffect(isBreak)
  end
end

function Controller.ShowRoleTip(isShow)
  if PlayerData:GetHomeInfo().station_info.is_arrived == 2 then
    return
  end
  if not isShow and PlayerData.showPosterGirl == 1 then
    return
  end
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  View.Group_Common.Img_DialogBox:SetActive(isShow)
  Controller:ShowPosterGirl(isShow, nil, isShow)
  local content = GetText(80601092)
  View.Group_Common.Img_DialogBox.Txt_Dialog:SetText(content)
  local txtHeight = View.Group_Common.Img_DialogBox.Txt_Dialog:GetHeight()
  View.Group_Common.Img_DialogBox:SetHeight(txtHeight + 80)
  View.Group_Common.Img_DialogBox.Txt_Dialog:SetHeight(txtHeight)
  View.Group_Common.Img_DialogBox.Txt_Dialog:SetTweenContent(content)
end

function Controller.FuncActive()
  local funcTable = {}
  funcTable[100] = function(active)
    View.Group_Common.Group_TopRight.Btn_Mission.self:SetActive(active)
    if active then
      local isOpen = PlayerData:GetNowPassData()
      View.Group_Common.Group_TopRight.Btn_Mission.self:SetActive(isOpen)
    end
  end
  funcTable[101] = function(active)
    View.Group_Common.Group_TopRight.Btn_Store.self:SetActive(active)
    if active then
      local StoreDataModel = require("UIStore/UIStoreDataModel")
      View.Group_Common.Group_TopRight.Btn_Store.Img_Remind.self:SetActive(StoreDataModel.GetStoreRedState())
    end
  end
  funcTable[102] = function(active)
    View.Group_Common.Group_TopRight.Btn_Headhunt.self:SetActive(active)
    if active then
      local red = require("UIGachaNew/UIGachaNewDataModel").GachaIsRedPoint()
      View.Group_Common.Group_TopRight.Btn_Headhunt.Img_Remind.self:SetActive(red)
    end
  end
  funcTable[103] = function(active)
    View.Group_Common.Group_TopRight.Btn_Depot.self:SetActive(active)
  end
  funcTable[104] = function(active)
    View.Group_Common.Group_TopRight.Btn_Member.self:SetActive(active)
    View.Group_Common.Group_TopRight.Btn_Member.Img_Remind.self:SetActive(PlayerData.isAwakeRed)
  end
  funcTable[105] = function(active)
    View.Group_Common.Group_TopRight.Btn_Squads.self:SetActive(active)
  end
  funcTable[106] = function(active)
  end
  funcTable[107] = function(active)
  end
  funcTable[108] = function(active)
    View.Group_OutSide.Group_Station.Btn_Build.Img_Lock:SetActive(not active)
  end
  funcTable[109] = function(active)
  end
  funcTable[110] = function(active)
  end
  funcTable[118] = function(active)
    View.Group_Common.Group_TopRight.Btn_Activity:SetActive(false)
  end
  funcTable[120] = function(active)
    View.Group_Common.Group_TopRight.Btn_ActivityNew:SetActive(true)
    local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
    View.Group_Common.Group_TopRight.Btn_ActivityNew.Img_Remind:SetActive(ActivityMainDataModel.GetMainAllRedState())
  end
  
  local function funcViewShow(activeTable)
    for k, v in pairs(funcTable) do
      v(activeTable[k] ~= nil)
    end
  end
  
  local funcCommon = require("Common/FuncCommon")
  funcCommon.CheckActiveFunc(funcViewShow)
end

function Controller.FuncActive_WorldBoss()
  local funcTable = {}
  funcTable[120] = function(active)
    View.Group_Common.Group_TopRight.Btn_ActivityNew:SetActive(true)
    local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
    View.Group_Common.Group_TopRight.Btn_ActivityNew.Img_Remind:SetActive(ActivityMainDataModel.GetMainAllRedState())
  end
  
  local function funcViewShow(activeTable)
    for k, v in pairs(funcTable) do
      v(activeTable[k] ~= nil)
    end
  end
  
  local funcCommon = require("Common/FuncCommon")
  funcCommon.CheckActiveFunc(funcViewShow)
end

function Controller.ShowCoachQuickJump(isShow, callback)
  if isShow == View.Group_Coach.Group_QuickJump.Btn_Close.IsActive then
    return
  end
  
  local function showUI()
    View.Group_Coach.Group_QuickJump.Btn_DecorateOFF.self:SetActive(not isShow)
    View.Group_Coach.Group_QuickJump.Btn_Close:SetActive(isShow)
    View.Group_Coach.Group_QuickJump.Btn_DecorateON.self:SetActive(isShow)
    View.Group_Coach.Group_QuickJump.Group_Windows.self:SetActive(isShow)
  end
  
  if isShow then
    showUI()
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local maxCoachNum = 0
    local curLv = PlayerData:GetHomeInfo().electric_lv + 1
    for k, v in pairs(homeConfig.electricLevelList) do
      if curLv < v.lv then
        maxCoachNum = k - 1
        break
      end
    end
    if maxCoachNum == 0 then
      maxCoachNum = #homeConfig.electricLevelList
    end
    DataModel.MaxCoachNum = maxCoachNum
    DataModel.CurBanEnterCoachCount = 0
    DataModel.JumpRoomCtrList = {}
    local width = DataModel.MaxCoachNum * 125 + 15
    View.Group_Coach.Group_QuickJump.Group_Windows.Img_Base.StaticGrid_Train.self:SetWidth(width)
    View.Group_Coach.Group_QuickJump.Group_Windows.Img_Base.StaticGrid_Train.grid.self:RefreshAllElement()
    View.Group_Coach.Group_QuickJump.Group_Windows.Img_Base.self:SetWidth(width + 50)
    View.self:PlayAnimOnce("In_Jump", function()
      if callback then
        callback()
      end
    end)
  else
    View.self:PlayAnimOnce("Out_Jump", function()
      showUI()
      if callback then
        callback()
      end
    end)
  end
end

function Controller.ShowManagerTool(isShow, callback)
  if View.Group_Coach.Img_Control.IsActive == isShow then
    return
  end
  if isShow then
    View.Group_Coach.Img_Control.self:SetActive(true)
    View.Group_Coach.Img_Control.Btn_Passenger.Txt_num:SetActive(PlayerData.IsPassageFunOpen())
    View.Group_Coach.Img_Control.Btn_Passenger.Img_Lock:SetActive(not PlayerData.IsPassageFunOpen())
    View.Group_Coach.Img_Control.Btn_Passenger.Txt_num:SetText(string.format("%d/%d", PlayerData:GetCurPassengerNum(), PlayerData:GetMaxPassengerNum()))
    View.Group_Coach.Img_Control.Btn_Prisoner.self:SetActive(PlayerData.ServerData.user_prison_info ~= nil)
    if PlayerData.ServerData.user_prison_info ~= nil then
      local curNum = table.count(PlayerData.ServerData.user_prison_info.carrying_backpack)
      local maxNum = PrisonData.GetPrisonerBagMaxCapacity()
      View.Group_Coach.Img_Control.Btn_Prisoner.Txt_num:SetText(string.format(GetText(80608522), curNum, maxNum))
    end
    View.self:PlayAnimOnce("manage_in", function()
      if callback then
        callback()
      end
    end)
  else
    View.self:PlayAnimOnce("manage_out", function()
      View.Group_Coach.Img_Control.self:SetActive(false)
      if callback then
        callback()
      end
    end)
  end
end

function Controller.Battle(enemyLevel)
  local lineInfo = DataModel.CurrLineInfo
  local minLevel = 1
  local lineBgList = {}
  local lineEnemyLevel = -1
  local lineEnemyRn = -1
  local lineWeatherIdList = {}
  local lineWeatherRateSN = -1
  local areaId
  local enemyWaveStr = ""
  if PlayerData.TempCache.AreaId ~= nil then
    areaId = PlayerData.TempCache.AreaId
  elseif DataModel.TrainEventAreaId ~= nil and DataModel.TrainEventAreaId > 0 then
    areaId = DataModel.TrainEventAreaId
  end
  local isForward
  local stationId = 0
  if TrainManager.TrainCtrl and TrainManager.TrainCtrl.FirstTrain and lineInfo then
    isForward = TrainManager.TrainCtrl.FirstTrain.CurrInfo.isForward
    stationId = isForward and lineInfo.station02 or lineInfo.station01
  end
  local stationInfo = PlayerData:GetHomeInfo().station_info
  local lineEvents
  if stationInfo ~= nil and stationInfo.line_events then
    lineEvents = stationInfo.line_events
  end
  local events
  if lineEvents ~= nil and lineEvents[tostring(stationId)] then
    events = lineEvents[tostring(stationId)].events
  end
  if events ~= nil then
    for i = 1, #events do
      if events[i].id == tostring(DataModel.TrainEventId) then
        if enemyLevel == nil and events[i].lv ~= nil then
          lineEnemyLevel = events[i].lv
        end
        if events[i].waves == nil then
          break
        end
        for j = 1, #events[i].waves do
          if 3 < j then
            goto lbl_121
          end
          if enemyWaveStr ~= "" then
            enemyWaveStr = enemyWaveStr .. ","
          end
          enemyWaveStr = enemyWaveStr .. events[i].waves[j]
        end
        break
      end
    end
  end
  ::lbl_121::
  local idx = PlayerData.TempCache.EventIndex
  if enemyLevel == nil and areaId and lineEnemyLevel <= 0 and idx ~= nil and idx ~= "" then
    local listId = tonumber(string.sub(idx, 1, 8))
    local areaInfo = PlayerData:GetFactoryData(areaId)
    if areaInfo ~= nil then
      local clickList = areaInfo.ClickLevelList
      for i = 1, #clickList do
        if clickList[i].id == listId then
          lineEnemyLevel = math.floor(math.random(clickList[i].levelLvMin, clickList[i].levelLvMax))
          break
        end
      end
    end
  end
  if lineInfo ~= nil then
    minLevel = lineInfo.enemyLevelMin
    lineBgList = lineInfo.lineBgList
    lineEnemyRn = lineInfo.LineEnemyRn
    lineWeatherRateSN = lineInfo.LineWeatherRate
    for i = 1, #lineInfo.LineWeatherList do
      lineWeatherIdList[i] = lineInfo.LineWeatherList[i].LineWTid
    end
  end
  local bgId = -1
  local currPosition = -1
  if TrainManager.TrainCtrl.FirstTrain ~= nil then
    currPosition = TrainManager.TrainCtrl.FirstTrain.Position
  end
  for i = 1, #lineBgList do
    if currPosition < lineBgList[i].distance0 then
      bgId = lineBgList[i].LineBgid
      break
    end
  end
  local trainWeaponParam = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainBattleBuff)
  local weaponSkillList = ""
  for i = 1, #trainWeaponParam do
    local skillData = PlayerData:GetFactoryData(trainWeaponParam[i].weaponSkillId)
    local atLine = false
    if lineInfo ~= nil then
      for i = 1, #skillData.lineidList do
        if skillData.lineidList[i].id == lineInfo.id then
          atLine = true
          break
        end
      end
    end
    if skillData ~= nil and PlayerData:CheckTrainWeaponCondition(skillData.buffType, {
      areaId = areaId,
      isToStation = skillData.stationID == TradeDataModel.EndCity,
      isAtLine = atLine
    }) and skillData.skillBuff ~= nil and 0 < skillData.skillBuff then
      if weaponSkillList ~= "" then
        weaponSkillList = weaponSkillList .. ","
      end
      weaponSkillList = weaponSkillList .. skillData.skillBuff .. ":" .. trainWeaponParam[i].lv + 1
    end
  end
  local homeBuff = PlayerData:GetCurStationStoreBuff(EnumDefine.HomeSkillEnum.HomeBattleBuff)
  local curTime = TimeUtil:GetServerTimeStamp()
  if homeBuff ~= nil and curTime < homeBuff.endTime then
    local buffCA = PlayerData:GetFactoryData(homeBuff.id, "HomeBuffFactory")
    if weaponSkillList ~= "" then
      weaponSkillList = weaponSkillList .. ","
    end
    weaponSkillList = weaponSkillList .. buffCA.battleBuff .. ":1"
  end
  local status = {
    Current = "Chapter",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false,
    levelChainId = nil,
    eventId = DataModel.TrainEventId,
    EventIndex = PlayerData.TempCache.EventIndex,
    minEnemyLevel = enemyLevel or minLevel,
    bgId = bgId,
    enemyLevel = enemyLevel or lineEnemyLevel,
    enemyRn = lineEnemyRn,
    lineWeatherIdList = lineWeatherIdList,
    lineWeatherRateSN = lineWeatherRateSN * SafeMath.safeNumberTime,
    areaId = areaId,
    trainWeaponSkill = weaponSkillList,
    enemy_ids = enemyWaveStr
  }
  print_r(status)
  PlayerData.Last_Chapter_Parms = nil
  PlayerData.BattleInfo.battleStageId = DataModel.TrainLevelId
  PlayerData.BattleCallBackPage = ""
  UIManager:Open("UI/Squads/Squads", Json.encode(status))
end

function Controller.Astern()
  TrainManager:ChangeState(TrainState.Astern, function()
    View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundDownToR:SetActive(true)
    Controller.ChangeDriveBtnState()
    Controller.ShowAutoDriveTxt(false)
  end)
end

function Controller.Stop()
  if TrainManager.CurrTrainState ~= TrainState.Stop and TrainManager.CurrTrainState ~= TrainState.Stopping and TrainManager.CurrTrainState ~= TrainState.Arrive then
    local oldState = TrainManager.CurrTrainState
    TrainManager:ChangeState(TrainState.Stopping, function()
      if oldState == TrainState.Astern then
        View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundDownToB:SetActive(true)
      else
        View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundUpToB:SetActive(true)
      end
      Controller.ChangeDriveBtnState()
      Controller.ShowAutoDriveTxt(false)
    end)
  end
end

function Controller.ImmediatelyStop()
  if TrainManager.CurrTrainState ~= TrainState.Stop and TrainManager.CurrTrainState ~= TrainState.Arrive then
    local oldState = TrainManager.CurrTrainState
    TrainManager:ChangeState(TrainState.Stop, function()
      if oldState == TrainState.Astern then
        View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundDownToB:SetActive(true)
      else
        View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundUpToB:SetActive(true)
      end
      Controller.ChangeDriveBtnState()
      Controller.ShowAutoDriveTxt(false)
    end)
  end
end

function Controller.Drive()
  if TrainManager.CurrTrainState ~= TrainState.Running and TrainManager.CurrTrainState ~= TrainState.AddSpeed then
    local function drive()
      local targetSpeed = TradeDataModel.GetServerSpeed()
      
      TrainManager:Drive(targetSpeed)
      Controller:SwitchTab(DataModel.UIShowEnum.OutSide)
      View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundUpToD:SetActive(true)
      Controller.ChangeDriveBtnState()
      MapDataModel.TravelLineWayPoints = {}
      Controller.ShowAutoDriveTxt(true)
      PlayerData:SetTargetFrameRate()
    end
    
    if TrainManager.CurrTrainState == TrainState.Stopping or PlayerData:GetHomeInfo().station_info.stop_info[2] == -2 then
      drive()
    else
      Net:SendProto("station.drive", function(json)
        drive()
      end, TradeDataModel.EndCity)
    end
  end
end

function Controller.SetRushState(isShow)
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    View.Group_Common.Group_MB.SpineNode_Rush:SetActive(isShow)
    if not isShow then
      View.Group_OutSide.Group_Running.Group_RushEffect:HideDynamicGameObject(DataModel.MainRushEffectPath)
      View.Group_Common.Group_MB.Group_Lighting:HideDynamicGameObject(DataModel.TrainRushEffectPath)
      local isHave = TrainWeaponTag.IsWeaponedById(83100032)
      if isHave then
        local cfg = PlayerData:GetFactoryData(83100032, "HomeWeaponFactory")
        View.Group_Common.Group_MB.Group_Lighting:HideDynamicGameObject(cfg.specialEffects)
      end
    end
  end
end

function Controller.Rush()
  if TrainManager.CurrTrainState == TrainState.Event or TrainManager.CurrTrainState == TrainState.Arrive or TrainManager.CurrTrainState == TrainState.Rush then
    print_r("\228\184\141\229\133\129\232\174\184\229\134\178\229\136\186...\232\176\162\232\176\162")
    return
  end
  if DataModel.GetIsRushClick() then
    return
  end
  if PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
    UIManager:Open("UI/Common/BuyRushTips")
  elseif PlayerData:GetHomeInfo().readiness.fuel.fuel_num > 0 then
    DataModel.SetIsRushClick(true)
    if TrainManager.CurrTrainState ~= TrainState.Rush then
      DataModel.isRun = false
      
      local function cb()
        PlayerData:GetHomeInfo().readiness.fuel.fuel_num = PlayerData:GetHomeInfo().readiness.fuel.fuel_num - 1
        View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing:SetActive(false)
        View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing.Group_RushBuyBtn:SetActive(false)
        View.Group_OutSide.Group_Running.Btn_Accelerate.Group_On:SetActive(false)
        View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Off:SetActive(true)
        local ca = PlayerData:GetFactoryData(99900054).trainCameraList
        local row = ca[PlayerData.FreeCameraIndex]
        local tempTime = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseRushUseTime)[2] or 0
        local totalTime = PlayerData:GetHomeInfo().readiness.fuel.acc_time + tempTime
        DataModel.SetRushNumber()
        Controller.SetRushState(true)
        DataModel.RushServerTime = totalTime + TimeUtil:GetServerTimeStamp()
        TrainManager:Rush(TradeDataModel.Speed, TradeDataModel.Speed + PlayerData:GetHomeInfo().readiness.fuel.acc_speed, totalTime, row.isRushView, row.fieldView)
        Controller.ChangeDriveBtnState()
      end
      
      Net:SendProto("station.accelerate", function(json)
        cb()
      end, function(json)
        DataModel.SetIsRushClick(false)
        DataModel.isRun = true
      end)
    else
      print_r("\230\173\163\229\156\168\229\138\160\233\128\159in...")
    end
  else
    CommonTips.OpenTips(80600793)
  end
end

local function SetUILight(state)
  local Btn_Light = View.Group_OutSide.Group_Running.Btn_Light
  if Btn_Light.Group_Off and not Btn_Light.Group_Off:IsNull() then
    Btn_Light.Group_Off.self:SetActive(state == 0)
    Btn_Light.Group_On.self:SetActive(state == 1)
  end
end

function Controller:InitCheDengLight()
  if TrainManager.CurrTrainState ~= TrainState.None or TrainManager.CurrTrainState == TrainState.Arrive and PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
    PlayerData:SetPlayerPrefs("int", "huoCheLight", PlayerData:GetPlayerPrefs("int", "huoCheLight"))
    local state = PlayerData:GetPlayerPrefs("int", "huoCheLight")
    SetUILight(state)
    if not PlayerData.CurTrainSkinIsSpecial() then
      TrainEffectHelper:LoadEffect(0, TrainEffectHelper.Enum_TrainEffectType.Light, true)
      TrainEffectHelper:SetEffectsActive(TrainEffectHelper.Enum_TrainEffectType.Light, state == 1)
    end
  else
    PlayerData:SetPlayerPrefs("int", "huoCheLight", 0)
    TrainManager:SetHuoInternalCheLeight(false)
  end
end

function Controller:InitTrainEffect()
  Controller.isInitEffect = true
  if not PlayerData.CurTrainSkinIsSpecial() then
    TrainEffectHelper:LoadEffect(0, TrainEffectHelper.Enum_TrainEffectType.Rune, true)
    TrainEffectHelper:SetEffectsActive(TrainEffectHelper.Enum_TrainEffectType.Rune, true)
  end
end

function Controller:OpenLight(isOpen, isNotRefreshUI)
  local state = PlayerData:GetPlayerPrefs("int", "huoCheLight")
  local now_State
  if state == 0 then
    now_State = 1
  else
    now_State = 0
  end
  if isOpen then
    now_State = isOpen
  end
  PlayerData:SetPlayerPrefs("int", "huoCheLight", now_State)
  SetUILight(now_State)
  if isNotRefreshUI then
    PlayerData:SetPlayerPrefs("int", "huoCheLight", state)
    SetUILight(state)
  end
  if not isNotRefreshUI and PlayerData.FreeCameraIndex == 2 then
    return
  end
  if not PlayerData.CurTrainSkinIsSpecial() then
    if now_State == 1 then
      TrainEffectHelper:LoadEffect(0, TrainEffectHelper.Enum_TrainEffectType.Light, true)
    end
    TrainEffectHelper:SetEffectsActive(TrainEffectHelper.Enum_TrainEffectType.Light, now_State == 1)
  end
end

function Controller:JudgementReachArea()
  if not TrainManager.IsInTrainMap then
    return
  end
  if TrainManager.TrainCtrl == nil or TrainManager.TrainCtrl.FirstTrain == nil or TrainManager.TrainCtrl.FirstTrain.CurrInfo == nil then
    return
  end
  local lineId = TrainManager.TrainCtrl.FirstTrain.CurrInfo.lineId
  if DataModel.CurrLineId == nil or DataModel.CurrLineId ~= lineId then
    DataModel.CurrLineId = lineId
    DataModel.AreaTipIndex = 0
    DataModel.CurrLineInfo = PlayerData:GetFactoryData(DataModel.CurrLineId, "HomeLineFactory")
  end
  if #DataModel.CurrLineInfo.AreaTipList == 0 then
    return
  end
  local currPosition = TrainManager.TrainCtrl.FirstTrain.Position
  for i, v in ipairs(DataModel.CurrLineInfo.AreaTipList) do
    local disMin = v.disMin
    local disMax = v.disMax
    if currPosition >= disMin and currPosition <= disMax and DataModel.AreaTipIndex ~= i then
      DataModel.AreaTipIndex = i
      if UIManager:IsTipOpened("UI/MainUI/Group_AreaTip") then
        UIManager:ClosePanel(false, "UI/MainUI/Group_AreaTip")
      end
      UIManager:Open("UI/MainUI/Group_AreaTip", tostring(v.id))
    end
  end
end

function Controller:ReopenAttractions()
  if PlayerData.TempCache.MainUIShowState ~= DataModel.UIShowEnum.OutSide then
    return
  end
  local attrictionHistory = PlayerData:GetAttractionTipHistory()
  if not UIManager:IsPanelOpened("UI/Attraction/Attractions") and attrictionHistory.id ~= nil and attrictionHistory.disMin ~= nil then
    local currPosition = TrainManager.TrainCtrl.FirstTrain.Position
    if currPosition >= attrictionHistory.disMin and currPosition <= attrictionHistory.disMax then
      UIManager:Open("UI/Attraction/Attractions", Json.encode({
        index = attrictionHistory.index,
        id = attrictionHistory.id
      }))
      View.self:RegChildPanel("UI/Attraction/Attractions")
    end
  end
end

function Controller:JudgementReachAttraction()
  if not (DataModel.isGroupFightShow ~= true and not UIManager:IsPanelOpened("UI/Common/DialogBox_Tip") and UIManager:IsPanelOpened("UI/MainUI/MainUI")) or UIManager:IsPanelOpened("UI/Attraction/Attractions") or PlayerData.TempCache.MainUIShowState ~= DataModel.UIShowEnum.OutSide then
    return
  end
  if TrainManager.TrainCtrl == nil or TrainManager.TrainCtrl.FirstTrain == nil or TrainManager.TrainCtrl.FirstTrain.CurrInfo == nil then
    return
  end
  local lineId = TrainManager.TrainCtrl.FirstTrain.CurrInfo.lineId
  if DataModel.CurrLineId == nil or DataModel.CurrLineId ~= lineId then
    DataModel.CurrLineId = lineId
    DataModel.AttractionTipIndex = 0
    DataModel.CurrLineInfo = PlayerData:GetFactoryData(DataModel.CurrLineId, "HomeLineFactory")
  end
  if #DataModel.CurrLineInfo.AttractionList == 0 then
    return
  end
  local currPosition = TrainManager.TrainCtrl.FirstTrain.Position
  local isForward = TrainManager.TrainCtrl.FirstTrain.CurrInfo.isForward
  for i, v in ipairs(DataModel.CurrLineInfo.AttractionList) do
    local disMin = v.disMin
    local disMax = v.disMax
    if (isForward and math.abs(currPosition - disMin) < 50 or not isForward and math.abs(currPosition - disMax) < 50) and DataModel.AttractionTipIndex ~= i and not PlayerData:GetAttractionTipShowed(v.id) then
      PlayerData:SetAttractionTipShowed(v.id)
      DataModel.AttractionTipIndex = i
      PlayerData:SetAttractionTipRange(disMin, disMax)
      UIManager:Open("UI/Attraction/Attractions", Json.encode({
        index = 0,
        id = v.id
      }))
      View.self:RegChildPanel("UI/Attraction/Attractions")
    end
  end
end

function Controller.RepRedPointCheck()
  local homeCommon = require("Common/HomeCommon")
  local stateInfo = homeCommon.GetCityStateInfo(TradeDataModel.EndCity)
  if stateInfo ~= nil then
    local listCA = PlayerData:GetFactoryData(stateInfo.cityMapId, "CityMapFactory")
    View.Btn_City.Img_RedPoint:SetActive(listCA.isShowRep and not homeCommon.IsAllRepValueGet(TradeDataModel.EndCity) or RedPointNodeStr.IsHaveRed("CityMap"))
    if listCA.isShowConstruct and View.Btn_City.Img_RedPoint.IsActive == false then
      View.Btn_City.Img_RedPoint:SetActive(homeCommon.IsAllConstructionValueGet(TradeDataModel.EndCity))
    end
  end
end

function Controller.BackShow(isShow)
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  View.Group_Common.Group_Back.self:SetActive(isShow)
  if isShow then
    View.Group_Common.Group_Position.Img_Cruise:SetActive(false)
  end
  Controller.ShowHelpButton()
end

function Controller.Back()
  TrainManager:ChangeState(TrainState.Back)
end

function Controller.StrikeShow(isShow)
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  if isShow then
    Controller.ShowWarning(false)
  end
end

function Controller.ShowWarning(isShow)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  if isShow == nil then
    isShow = true
  end
  if isShow then
    View.Group_Common.Group_MB.SpineNode_Warning:SetDynamicGameObject(DataModel.WarningEffectPath, 0, 0)
  end
  View.Group_Common.Group_MB.SpineNode_Warning:SetActive(isShow)
end

function Controller.MainLineEventShow(eventId, isShow, isPrepareStrike)
  local Group_Event = View.Group_Common.Group_Event
  
  local function autoStrike()
    Controller.PlayTrainBgm()
    Controller.ShowRoleTip(false)
    Group_Event.self:SetActive(false)
    BugLogReporter:AddTail(BugLogReporter.ReportNames.TrainLineEvents, "AutoStrike")
    TrainManager:ChangeStrikeState(StrikeState.Start)
  end
  
  local isSpecialSkin = PlayerData.CurTrainSkinIsSpecial()
  if isShow and eventId and isPrepareStrike and PlayerData.IsEnergyEnough() and not isSpecialSkin then
    if PlayerData:GetPlayerPrefs("int", "IsAutoStrike") == 1 then
      local isAuto = 1
      Net:SendProto("home.update_drive_setup", function(json)
        PlayerData:SetPlayerPrefs("int", "IsAutoStrike", 0)
        PlayerData:GetHomeInfo().drive_setup.assault = isAuto
        autoStrike()
      end, "assault", isAuto)
      return
    elseif PlayerData:GetHomeInfo().drive_setup.assault == 1 then
      autoStrike()
      return
    end
  end
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  Controller.StopPosterGirlAudioSource()
  if not isShow or eventId == nil then
    if eventId == nil then
      DataModel.SetTrainEventBgmId()
    end
    DataModel.IsEvent = false
    Controller.ShowRoleTip(false)
    Group_Event.self:SetActive(false)
    return
  end
  if eventId then
    local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
    if event.mod == "\229\133\179\229\141\161\228\186\139\228\187\182" then
      if UIManager:IsPanelOpened("UI/Chapter/Battle_Dungeon") then
        UIManager:GoBack()
      end
      if not isPrepareStrike then
      end
      if event.isBgm then
        if MapController.SwitchBGMTween then
          DOTweenTools.KillTween(MapController.SwitchBGMTween)
          MapController.SwitchBGMTween = nil
        end
        DataModel.SetTrainEventBgmId(event.bgmId)
      end
      Controller.PlayTrainBgm()
      DataModel.IsEvent = true
      Controller.ShowWarning(false)
      local Group_Fight = Group_Event.Group_Fight
      local Group_Strike = Group_Event.Group_Strike
      local Group_Buy = Group_Event.Group_Buy
      local Group_Balloon = Group_Event.Group_Balloon
      Group_Event.self:SetActive(true)
      Group_Fight.self:SetActive(true)
      if isPrepareStrike then
        Controller.ShowRoleTip(false)
        Group_Fight.Group_Fight.self:SetActive(true)
        Group_Fight.BtnPolygon_Fight.self:SetActive(false)
        Group_Event.Group_Back.self:SetActive(false)
        if event.tagUse == 12600799 then
          Group_Buy.self:SetActive(false)
          Group_Balloon.self:SetActive(true)
          Group_Balloon.Group_Balloon.self:SetActive(true)
          Group_Balloon.BtnPolygon_Balloon.self:SetActive(false)
        elseif event.tagUse == 12600798 then
          Group_Balloon.self:SetActive(false)
          Group_Buy.self:SetActive(true)
          Group_Buy.Group_Buy.self:SetActive(true)
          Group_Buy.BtnPolygon_Buy.self:SetActive(false)
        else
          Group_Buy.self:SetActive(false)
          Group_Balloon.self:SetActive(false)
        end
        Group_Strike.self:SetActive(true)
        Group_Strike.Group_Strike.self:SetActive(false)
        Group_Strike.BtnPolygon_Strike.self:SetActive(not isSpecialSkin)
        local strike = PlayerData.GetStrike()
        if strike and strike.id then
          local cfg = PlayerData:GetFactoryData(strike.id, "HomeWeaponFactory")
          Group_Strike.BtnPolygon_Strike.Txt_Cost:SetActive(true)
          Group_Strike.BtnPolygon_Strike.Txt_Cost:SetText(string.format(GetText(80601919), cfg.WeaponTired - PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.ReduceEscapeEnergy)))
        else
          Group_Strike.BtnPolygon_Strike.Txt_Cost:SetActive(false)
        end
      else
        Group_Event.Group_Back.self:SetActive(true)
        Controller.ShowRoleTip(true)
        UIManager:CloseTip("UI/MainUI/Strike_Tip")
        Group_Fight.BtnPolygon_Fight.self:SetActive(true)
        Group_Fight.Group_Fight.self:SetActive(false)
        local level = PlayerData:GetFactoryData(event.levelId, "LevelFactory")
        Group_Fight.BtnPolygon_Fight.Txt_Cost:SetText(string.format(GetText(80601918), level.energyEnd))
        local lv = DataModel.GetTrainEventLv() or 0
        lv = MathEx.roundToDecimalPlaces(lv)
        Group_Fight.BtnPolygon_Fight.Txt_Lv:SetText(string.format(GetText(80601819), lv))
        
        local function autoFight()
          if PlayerData:GetHomeInfo().drive_setup.bar == 1 then
            if PlayerData.canAuto == nil then
              View.self:PlayAnim("BattleStart")
            else
              Controller.ShowRoleTip(false)
              Group_Event.self:SetActive(false)
              Controller.Battle()
            end
          else
            View.self:PlayAnim("BattleStart")
          end
        end
        
        if event.isMain then
          View.self:PlayAnim("BattleStart")
          Group_Strike.self:SetActive(false)
          Group_Buy.self:SetActive(false)
          Group_Balloon.self:SetActive(false)
        else
          if event.tagUse == 12600799 then
            Group_Buy.self:SetActive(false)
            Group_Balloon.self:SetActive(true)
            Group_Balloon.Group_Balloon.self:SetActive(false)
            Group_Balloon.BtnPolygon_Balloon.self:SetActive(true)
          elseif event.tagUse == 12600798 then
            Group_Buy.self:SetActive(true)
            Group_Buy.Group_Buy.self:SetActive(false)
            Group_Buy.BtnPolygon_Buy.self:SetActive(true)
            Group_Balloon.self:SetActive(false)
          else
            Group_Buy.self:SetActive(false)
            Group_Balloon.self:SetActive(false)
          end
          if PlayerData:GetPlayerPrefs("int", "IsAutoFight") == 1 then
            local isAuto = 1
            Net:SendProto("home.update_drive_setup", function(json)
              PlayerData:SetPlayerPrefs("int", "IsAutoFight", 0)
              PlayerData:GetHomeInfo().drive_setup.bar = isAuto
              autoFight()
            end, "bar", isAuto)
          else
            autoFight()
          end
          if event.isStrike then
            Group_Strike.self:SetActive(true)
            Group_Strike.Group_Strike.self:SetActive(true)
            Group_Strike.BtnPolygon_Strike.self:SetActive(false and not isSpecialSkin)
          else
            Group_Strike.self:SetActive(false)
          end
        end
      end
    else
      Controller.ShowRoleTip(false)
    end
  end
end

function Controller.SpendMoneyBuyRoad(isAuto)
  local eventCA = PlayerData:GetFactoryData(DataModel.TrainEventId)
  local levelId = eventCA.levelId
  local levelCA = PlayerData:GetFactoryData(levelId)
  local homeLineCA = PlayerData:GetFactoryData(DataModel.TrainLineId)
  local isEnemyLvEquilsPlayer = levelCA.isEnemyLvEquilsPlayer
  local enemyLvOffset = levelCA.enemyLvOffset
  local levelLevel = DataModel.GetTrainEventLv()
  print_r("======levelLevel=========" .. levelLevel)
  local buyRatio = eventCA.buyRatio
  local needGold = 0
  needGold = PlayerData:GetFactoryData(99900014).buyGoldInit * levelLevel * buyRatio
  needGold = needGold * (1 - PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.ReduceBuyPassCost))
  needGold = math.floor(needGold + 0.5)
  local nowGold = PlayerData:GetUserInfo().gold
  if isAuto == true then
    if needGold > nowGold then
      View.self:PlayAnim("BattleStart")
      return
    end
    Controller.ShowRoleTip(false)
    local Group_Event = View.Group_Common.Group_Event
    Group_Event.self:SetActive(false)
    BugLogReporter:AddKeyValueTail(BugLogReporter.ReportNames.TrainLineEvents, tostring(isAuto) .. "\232\175\183\230\177\130\228\185\176\232\183\1752", DataModel.TrainEventId)
    Net:SendProto("events.money_through", function(json)
      PlayerData.TempCache.EventFinish = true
      TrainManager:ChangeState(TrainState.EventFinish, function()
        Controller.ShowWarning(false)
        Controller:InitCommonShow()
        DataModel.SetTrainEventBasicId()
        DataModel.SetTrainEventBgmId()
        Controller.PlayTrainBgm()
        Controller.ShowStrikeTip(false, false)
        Controller:ShowMBDurability(false)
        local curID = BugLogReporter.GetCurEventID()
        BugLogReporter:AddKeyValueTail(BugLogReporter.ReportNames.TrainLineEvents, "\228\185\176\232\183\1752Remove", curID)
        local cityID
        local innerTrainMa = CS.FRef.getProperty(TrainManager, "InternalTrainManager")
        if innerTrainMa and innerTrainMa.PathInfos and innerTrainMa.PathInfos[innerTrainMa.InnerPathIndex] then
          cityID = innerTrainMa.PathInfos[innerTrainMa.InnerPathIndex].targetId
        end
        if curID ~= "nil" and cityID then
          PlayerData.RemoveLineEvent(cityID, curID)
        end
        TrainManager:LevelEventFinish()
        UIManager:Open("UI/MainUI/BuyRoad_Success")
        Controller.MainLineEventShow(DataModel.TrainEventId, false)
        Controller.SetCamera(1)
        Controller:RunBtnState(true)
        Controller.BackShow(true)
        TradeDataModel.StateEnter = EnumDefine.TrainStateEnter.Refresh
        Controller.Drive()
      end)
    end, DataModel.TrainEventId)
  else
    UIManager:Open("UI/MainUI/BuyRoadChoose", Json.encode({
      eventId = DataModel.TrainEventId,
      lineId = DataModel.TrainLineId,
      needGold = needGold
    }))
  end
end

function Controller.OpenBattleLoss()
  if PlayerData.TempCache.consumables then
    UIManager:Open("UI/MainUI/BattleLoss")
  end
end

function Controller.PlayTrainBgm()
  local lineInfo = {}
  local isTravel, configId = MapDataModel.GetTrainCurPos(lineInfo)
  local bgSoundId = 0
  if DataManager:GetFactoryNameById(configId) == "HomeStationFactory" then
    bgSoundId = DataModel.CurShowSceneInfo.bgmId
  else
    local lineCA = PlayerData:GetFactoryData(configId)
    if lineInfo.lastStationId == lineCA.station02 and lineCA.bgmId2 > -1 then
      bgSoundId = lineCA.bgmId2
    else
      bgSoundId = lineCA.bgmId
    end
  end
  if DataModel.TrainEventBgmId ~= nil then
    bgSoundId = DataModel.TrainEventBgmId
  end
  DataModel.nowSoundId = bgSoundId
  local sound = SoundManager:CreateSound(bgSoundId)
  if sound ~= nil then
    sound:Play()
  end
end

function Controller.ShowStrikeTip(isReady, isStart, percent)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  if isReady == nil then
    isReady = false
  end
  if isStart == nil then
    isStart = false
  end
  DataModel.SetIsStrikeStart(isStart)
  View.Group_Common.Group_MB.Img_Durability.Group_Ready:SetActive(isReady)
  View.Group_Common.Group_MB.Img_Durability.Group_Start:SetActive(isStart)
  if isReady then
    View.Group_Common.Group_MB.Img_Durability.SpineAnimation_Box:SetActive(true)
  end
  if DataModel.GetIsStrikeStart() then
    View.Group_Common.Group_MB.Img_Durability.SpineAnimation_Box:SetActive(false)
  else
    View.Group_Common.Group_MB.Img_Durability.SpineAnimation_Box:SetActive(true)
  end
end

function Controller.StrikeStart()
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Group_Gear = View.Group_OutSide.Group_Running.Group_Gear
  local Btn_D = Group_Gear.Btn_D
  local Btn_R = Group_Gear.Btn_R
  local Btn_B = Group_Gear.Btn_B
  local Btn_Accelerate = View.Group_OutSide.Group_Running.Btn_Accelerate
  local allBtn = {
    Btn_B,
    Btn_R,
    Btn_D
  }
  for i, v in ipairs(allBtn) do
    v:SetBtnInteractable(false)
  end
  Btn_Accelerate:SetBtnInteractable(true)
end

function Controller.RushDelayComplete()
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Btn_Accelerate = View.Group_OutSide.Group_Running.Btn_Accelerate
  Btn_Accelerate.Group_Ing:SetActive(true)
  Btn_Accelerate.Group_Ing.Group_RushTime:SetDynamicGameObject(DataModel.RushTimeBtnEffectPath, 0, 0)
  Btn_Accelerate.Group_Ing.Group_RushBuyBtn:SetDynamicGameObject(DataModel.RushBuyBtnEffectPath, 0, 0)
  Btn_Accelerate.Group_Ing.Group_RushBuyBtn:SetActive(true)
  Btn_Accelerate.Group_On:SetActive(false)
  Btn_Accelerate.Group_Off:SetActive(false)
end

local max = 0.9
local min = 0.1

function Controller.Rushing(remainTime, rushTime)
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    local Btn_Accelerate = View.Group_OutSide.Group_Running.Btn_Accelerate
    if 0 < remainTime then
      Btn_Accelerate.Group_Ing.Img_Bar:SetFilledImgAmount(math.max(min, (max - min) / rushTime * remainTime + min))
      local number = math.floor(remainTime)
      if DataModel.GetRushNumber() == nil then
        Btn_Accelerate.Group_Ing.Txt_Time:SetText(string.format("%02d", number))
        Btn_Accelerate.Group_Ing.Txt_Time2:SetText(string.format("%02d", number))
        DataModel.SetRushNumber(number)
      end
      if number < 0 then
        number = 0
      end
      if number <= DataModel.GetRushNumber() then
        View.self:SelectPlayAnim(Btn_Accelerate.Group_Ing.self, "RushTime", function()
          Btn_Accelerate.Group_Ing.Txt_Time:SetText(string.format("%02d", number))
          Btn_Accelerate.Group_Ing.Txt_Time2:SetText(string.format("%02d", number))
        end)
        DataModel.SetRushNumber(number - 1)
      end
    else
      do
        local accelerate_num = PlayerData:GetHomeInfo().readiness.fuel.fuel_num
        DataModel.SetRushNumber()
        DataModel.SetIsRushClick(false)
        if TradeDataModel.GetInTravel() then
          local isHave = 0 < accelerate_num
          Btn_Accelerate.Group_On:SetActive(isHave)
          Btn_Accelerate.Group_Off:SetActive(not isHave)
        end
        Btn_Accelerate.Group_On.Txt_Num:SetText(accelerate_num)
        Btn_Accelerate.Group_Off.Txt_Num:SetText(accelerate_num)
        Btn_Accelerate.Group_Ing:SetActive(false)
        Controller.SetRushEffectState(false)
        Controller.SetRushState(false)
        DataModel.isRun = true
      end
    end
  else
    DataModel.SetRushNumber()
  end
end

function Controller.StrikeSuccess(state)
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    if state then
      local sound = SoundManager:CreateSound(30002604)
      if sound then
        sound:Play()
      end
      View.Group_OutSide.Group_Running.Group_StrikeEffect:SetDynamicGameObject(DataModel.TrainStrikeEffectPath, 0, 0)
    end
    View.Group_OutSide.Group_Running.Group_StrikeEffect:SetActive(state)
  end
end

function Controller.WeaponRush()
  local isShow = DataModel.GetIsWeaponRushShow()
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    local isHave = TrainWeaponTag.IsWeaponedById(83100032)
    View.Group_Common.Group_MB.Group_Lighting.self:SetActive(isShow or isHave)
    if isHave then
      local cfg = PlayerData:GetFactoryData(83100032, "HomeWeaponFactory")
      View.Group_Common.Group_MB.Group_Lighting:SetDynamicGameObject(cfg.specialEffects, 0, 0)
    end
    if isShow then
      View.Group_Common.Group_MB.Group_Lighting:SetDynamicGameObject(DataModel.TrainRushEffectPath, 0, 0)
    end
  end
  TrainManager:SetLightingEffect(isShow)
end

function Controller.WeaponRushOver()
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    View.Group_Common.Group_MB.Group_Lighting.self:SetActive(false)
  end
end

function Controller.BackFunction()
  local cfg = PlayerData:GetFactoryData(TradeDataModel.StartCity)
  CommonTips.OnPrompt(string.format(GetText(80601505), cfg.name), "80600068", "80600067", function()
    Net:SendProto("station.arrive", function(json)
      DataModel.justArrived = true
      TradeDataModel.EndCity = TradeDataModel.StartCity
      PlayerData.FreeCameraIndex = 1
      PlayerData:GetHomeInfo().station_info = json.station_info
      DataModel.GetCurShowSceneInfo()
      TrainCameraManager:SetPostProcessing(1, DataModel.CurShowSceneInfo.postProcessingPath)
      if json.station_info and json.station_info.distance then
        PlayerData:GetHomeInfo().station_info.station_info = json.station_info.station_info
        TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.Refresh)
      else
        PlayerData.ServerData.user_home_info.station_info.stop_info = json.station_info.stop_info
        TrainEffectHelper:Dispose()
        TrainManager:TravelOver()
        PlayerData.showPosterGirl = 1
        TradeDataModel.CurRemainDistance = 0
        Controller.SetSpeedShow(0)
        Controller.ArriveRefreshShow(json)
      end
      PlayerData:ClearPollute()
      if json.drive_distance then
        PlayerData:GetHomeInfo().drive_distance = json.drive_distance
      end
      if json.drive_time then
        PlayerData:GetHomeInfo().drive_time = json.drive_time
      end
      MapController:RefreshStationPos()
      MapController:RefreshViewToTrain()
      Controller.ShowEndActive(false)
      Controller.StrikeShow(false)
      Controller:ShowPosterGirl(false)
      View.Group_Common.Img_DialogBox:SetActive(false)
      MapNeedleData.ResetData()
      DataModel.SetTrainEventBasicId()
      PlayerData:SetStationIsNotFirst(TradeDataModel.StartCity)
      Controller.RefreshLimitShopBannerShow()
      Controller.RefreshGoldInfoShow()
      Controller:RefreshSafeBtnShow()
    end, TradeDataModel.StartCity, 2)
  end, nil)
end

function Controller.StopPosterGirlAudioSource()
  View.timer:Pause()
  if View.sound and View.sound.audioSource then
    View.sound:Stop()
    DataModel.soundEndTime = 0
  end
  View.Group_Common.Img_DialogBox:SetActive(false)
end

function Controller.ResumePosterGirlAudioSource()
  if View.timer then
    View.timer:Resume()
  end
end

function Controller.HideAllEffect(index)
  local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. index]
  if viewGroup == nil then
    return
  end
  viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetActive(false)
  viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetActive(false)
  viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterEffect:SetActive(false)
  viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_CharacterEffectBottom:SetActive(false)
end

function Controller.RefreshRevenueRedPoint()
  if View.Btn_Revenue.IsActive then
    local UIRevenueOverviewDataModel = require("UIRevenueOverview/UIRevenueOverviewDataModel")
    UIRevenueOverviewDataModel.RefreshRankRedPointTime()
    local redPoint = PlayerData:GetPlayerPrefs("int", "RevenueRankRefreshRedPoint")
    View.Btn_Revenue.Img_RedPoint:SetActive(redPoint == 1)
  end
end

function Controller.SetCamera(index)
  local coachHead = PlayerData:GetHomeInfo().coach[1]
  local homeCoachSkinCA = PlayerData:GetFactoryData(coachHead.skin, "HomeCoachSkinFactory")
  local ca
  if homeCoachSkinCA.visualAngle > 0 then
    ca = PlayerData:GetFactoryData(homeCoachSkinCA.visualAngle).trainCameraList
  else
    ca = PlayerData:GetFactoryData(99900054).trainCameraList
  end
  PlayerData.FreeCameraIndex = PlayerData.FreeCameraIndex + 1
  if PlayerData.FreeCameraIndex > table.count(ca) then
    PlayerData.FreeCameraIndex = 1
  end
  if index then
    PlayerData.FreeCameraIndex = index
  end
  local row = ca[PlayerData.FreeCameraIndex]
  local p_x = row.posX
  local p_y = row.posY
  local p_z = row.posZ
  local r_x = row.rotX
  local r_y = row.rotY
  local isCanMove = row.isCanMove
  local nodePath = row.nodePath
  local lastPath
  if PlayerData.cameraNodePath ~= "" and PlayerData.cameraNodePath ~= nodePath then
    lastPath = PlayerData.cameraNodePath
  end
  PlayerData.cameraNodePath = nodePath
  TrainManager:MaskAllEvent(index == 2)
  if PlayerData.FreeCameraIndex == 2 then
    Controller:OpenLight(0, true)
  elseif PlayerData.FreeCameraIndex == 3 or PlayerData.FreeCameraIndex == 1 then
    local state = PlayerData:GetPlayerPrefs("int", "huoCheLight")
    Controller:OpenLight(state)
  end
  UIManager:SetCamera(Vector3(p_x, p_y, p_z), Vector3(r_x, r_y, 0), Vector3(0, row.mainPosY, row.mainPosZ), PlayerData.FreeCameraIndex - 1, lastPath)
  local freeCameraObj = CS.UnityEngine.GameObject.Find("FreeCamera")
  if freeCameraObj ~= nil then
    local f_camera = freeCameraObj:GetComponent(typeof(CS.Gaia.FreeCamera))
    CS.FRef.setProperty(f_camera, "isAdjust", true)
  end
end

function Controller.SetCamera(index)
  local coachHead = PlayerData:GetHomeInfo().coach[1]
  local homeCoachSkinCA = PlayerData:GetFactoryData(coachHead.skin, "HomeCoachSkinFactory")
  local ca
  if homeCoachSkinCA.visualAngle > 0 then
    ca = PlayerData:GetFactoryData(homeCoachSkinCA.visualAngle).trainCameraList
  else
    ca = PlayerData:GetFactoryData(99900054).trainCameraList
  end
  PlayerData.FreeCameraIndex = PlayerData.FreeCameraIndex + 1
  if PlayerData.FreeCameraIndex > table.count(ca) then
    PlayerData.FreeCameraIndex = 1
  end
  if index then
    PlayerData.FreeCameraIndex = index
  end
  local row = ca[PlayerData.FreeCameraIndex]
  local p_x = row.posX
  local p_y = row.posY
  local p_z = row.posZ
  local r_x = row.rotX
  local r_y = row.rotY
  local isCanMove = row.isCanMove
  local nodePath = row.nodePath
  local lastPath
  if PlayerData.cameraNodePath ~= "" and PlayerData.cameraNodePath ~= nodePath then
    lastPath = PlayerData.cameraNodePath
  end
  PlayerData.cameraNodePath = nodePath
  TrainManager:MaskAllEvent(index == 2)
  if PlayerData.FreeCameraIndex == 2 then
    Controller:OpenLight(0, true)
  elseif PlayerData.FreeCameraIndex == 3 or PlayerData.FreeCameraIndex == 1 then
    local state = PlayerData:GetPlayerPrefs("int", "huoCheLight")
    Controller:OpenLight(state)
  end
  UIManager:SetCamera(Vector3(p_x, p_y, p_z), Vector3(r_x, r_y, 0), Vector3(0, row.mainPosY, row.mainPosZ), PlayerData.FreeCameraIndex - 1, lastPath)
  local freeCameraObj = CS.UnityEngine.GameObject.Find("FreeCamera")
  if freeCameraObj ~= nil then
    local f_camera = freeCameraObj:GetComponent(typeof(CS.Gaia.FreeCamera))
    CS.FRef.setProperty(f_camera, "isAdjust", true)
  end
end

function Controller:RefreshHomeMap()
  DataModel.InitMapStationList()
  local grid = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.ScrollGrid_Station.grid
  for i, v in ipairs(DataModel.mapStationList) do
    if grid[i] then
      grid[i].self:SetActive(v.isShowInMap)
      grid[i].Btn_S1.self:SetClickParam(i)
    end
  end
  MapController:showStationLv(grid)
end

function Controller.ClosePrisonScene()
  PrisonController.CloseRoom()
  PrisonCellController.CloseRoom()
  PrisonController.StopBgmSound()
  if MainManager.bgSceneName == DataModel.SceneNameEnum.Main and TradeDataModel.GetInTravel() then
    TrainCameraManager:OpenCamera(0)
  end
end

function Controller.RandomClickAnim(index)
  local clickAnim = "click"
  local roleId = DataModel.roleId[index]
  local viewId = DataModel.UnitViewId[index]
  local unitViewCA = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  local spineIndex = ChangePosterGirlDataModel.GetPosIndex(viewId, index)
  if spineIndex ~= 0 then
    local extraUnitViewId = unitViewCA.extraSpineList[spineIndex].id
    unitViewCA = PlayerData:GetFactoryData(extraUnitViewId, "UnitViewFactory")
  end
  if 0 < #unitViewCA.extraClickAnimationList then
    local totalWeight = 0
    for i, v in ipairs(unitViewCA.extraClickAnimationList) do
      totalWeight = totalWeight + v.weight
    end
    local random = math.random(1, totalWeight)
    for i, v in ipairs(unitViewCA.extraClickAnimationList) do
      if random <= v.weight then
        clickAnim = v.name
        break
      else
        random = random - v.weight
      end
    end
  end
  return clickAnim
end

function Controller.ChangePosterGirlSpineStopClickAnim()
  DataModel.clickAnim = {}
  if View.coroutineSound then
    View.self:StopC(View.coroutineSound)
    View.coroutineSound = nil
  end
  View.Group_Common.Img_DialogBox:SetActive(false)
end

function Controller.ChangePosterGirlNextSpineStopClickAnim()
  DataModel.clickAnim = {}
  if View.coroutineSound then
    View.self:StopC(View.coroutineSound)
    View.coroutineSound = nil
  end
  View.Group_Common.Img_DialogBox:SetActive(false)
end

function Controller:RefreshSafeBtnShow()
  if not ActivitySafeDataModel or not FastBattleDataModel then
    return
  end
  local isUnlock = ActivitySafeDataModel.GetMainSafeIsUnlock()
  if isUnlock then
    View.Group_Common.Btn_Safe:SetActive(true)
    View.Group_Common.Btn_Safe.Img_RedPoint:SetActive(FastBattleDataModel.GetMainActivityRedDotState())
    View.Group_Common.Btn_Safe.Img_RedPoint:SetActive(PlayerData.IsEntrustShowRed())
    local animName
    if TradeDataModel.GetIsTravel() then
      animName = "outside"
    else
      animName = "in"
    end
    if animName then
      View.self:SelectPlayAnim(View.Group_Common.Btn_Safe.self, animName)
    end
    View.Group_Common.Btn_Safe.Btn_Tip:SetActive(PlayerData.IsEntrustShowRed())
    if PlayerData.ServerData.entrust then
      local entrustDataModel = require("UIEntrust/UIEntrustDataModel")
      local maxCount = entrustDataModel.GetEntrustMaxCount()
      if maxCount > table.count(PlayerData.ServerData.entrust) then
        View.Group_Common.Btn_Safe.Btn_Tip.Group_Empty:SetActive(true)
      else
        View.Group_Common.Btn_Safe.Btn_Tip.Group_Empty:SetActive(false)
      end
      local curTime = TimeUtil:GetServerTimeStamp()
      for k, v in pairs(PlayerData.ServerData.entrust) do
        if curTime >= v.end_ts then
          View.Group_Common.Btn_Safe.Btn_Tip.Group_Over:SetActive(true)
          View.Group_Common.Btn_Safe.Btn_Tip.Group_Empty:SetActive(false)
        else
          View.Group_Common.Btn_Safe.Btn_Tip.Group_Over:SetActive(false)
        end
      end
    end
  else
    View.Group_Common.Btn_Safe:SetActive(false)
  end
end

local UIDownloadDataModel

local function GetDownloadingState()
  if UIDownloadDataModel == nil then
    UIDownloadDataModel = require("UIDownload/UIDownloadDataModel")
  end
  if UIDownloadDataModel ~= nil then
    return UIDownloadDataModel.IsDownloading
  end
end

local function GetRetryState()
  if UIDownloadDataModel == nil then
    UIDownloadDataModel = require("UIDownload/UIDownloadDataModel")
  end
  if UIDownloadDataModel ~= nil then
    return UIDownloadDataModel.IsRetry
  end
end

local function SetDownloadingState(IsDownloading, IsRetry)
  if UIDownloadDataModel == nil then
    UIDownloadDataModel = require("UIDownload/UIDownloadDataModel")
  end
  if UIDownloadDataModel ~= nil then
    UIDownloadDataModel.IsDownloading = IsDownloading
    UIDownloadDataModel.IsRetry = IsRetry
  end
end

local function SetPackageViewState(start, ing, off, finish, red)
  View.Group_Common.Btn_Package.Group_Start:SetActive(start)
  View.Group_Common.Btn_Package.Group_Ing:SetActive(ing)
  View.Group_Common.Btn_Package.Group_Off:SetActive(off)
  View.Group_Common.Btn_Package.Group_Finish:SetActive(finish)
  View.Group_Common.Btn_Package.Group_Finish.Img_Red:SetActive(red)
end

local isExistBtn_Package = false
local isGuideAsset = false
local isDownloing = false
local timer = 50
local time

function Controller.GuideAsset()
  isExistBtn_Package = View.Group_Common.Btn_Package ~= nil
  if isExistBtn_Package then
    isDownloing = false
    time = 50
    isGuideAsset = GameSetting.IsGuideAsset ~= nil and DownloadAndPlayController.IsGuideAsset
    local IsExistRewardForGuideAsset = PlayerData.IsExistRewardForGuideAsset()
    View.Group_Common.Btn_Package:SetActive(isGuideAsset or IsExistRewardForGuideAsset)
    if isGuideAsset then
      if GetRetryState() then
        SetPackageViewState(false, false, true, false, false)
        local percent = DownloadAndPlayController.percent
        if 1 < percent then
          percent = 1
        end
        local progressView = View.Group_Common.Btn_Package.Group_Off
        progressView.Img_Progress:SetFilledImgAmount(percent)
        progressView.Txt_Progress:SetText(DownloadAndPlayController.percentInfo)
        return
      end
      if GetDownloadingState() == false then
        SetPackageViewState(true, false, false, false, false)
        return
      end
    elseif IsExistRewardForGuideAsset then
      SetPackageViewState(false, false, false, IsExistRewardForGuideAsset, IsExistRewardForGuideAsset)
    end
  end
end

function Controller.UpdateGuideAsset()
  if isGuideAsset and isExistBtn_Package then
    time = time + 1
    if time > timer then
      time = 0
      if GetDownloadingState() then
        isDownloing = true
        DownloadAndPlayController.UpdateDownloadInfo()
        SetDownloadingState(DownloadAndPlayController.IsDownloading, false)
        if GetDownloadingState() == false then
          local IsExistRewardForGuideAsset = PlayerData.IsExistRewardForGuideAsset()
          SetPackageViewState(false, false, false, IsExistRewardForGuideAsset, IsExistRewardForGuideAsset)
          View.Group_Common.Btn_Package:SetActive(IsExistRewardForGuideAsset)
          isGuideAsset = false
          return
        end
        local percent = DownloadAndPlayController.percent
        if 1 < percent then
          percent = 1
        end
        SetPackageViewState(false, true, false, false, false)
        local progressView = View.Group_Common.Btn_Package.Group_Ing
        progressView.Img_Progress:SetFilledImgAmount(percent)
        progressView.Txt_Progress:SetText(DownloadAndPlayController.percentInfo)
        progressView = View.Group_Common.Btn_Package.Group_Off
        progressView.Img_Progress:SetFilledImgAmount(percent)
        progressView.Txt_Progress:SetText(DownloadAndPlayController.percentInfo)
      end
      if isDownloing and GetRetryState() then
        isDownloing = false
        SetPackageViewState(false, false, true, false, false)
      end
    end
  end
end

function Controller.RefreshLimitShopBannerShow()
  View.Group_Common.Group_Banner:SetActive(false)
  View.Group_Common.Btn_BlackMoon:SetActive(true)
  local bannerCa = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  if not bannerCa then
    return
  end
  local isInTravel = TradeDataModel.GetInTravel()
  if isInTravel then
    if bannerCa.mainUIBannerDrivingIsOpen == false then
      return
    end
  elseif bannerCa.mainUIBannerStationIsOpen == false then
    return
  end
  Net:SendProto("main.main", function(json)
    if string.nilorempty(json.rc) then
      DataModel.bannerDay = json.main_ui_banner_days or 0
      if DataModel.bannerDay <= 0 then
        return
      end
      View.Group_Common.Group_Banner:SetActive(true)
      local storeCa = PlayerData:GetFactoryData(bannerCa.mainUIBannerStoreId, "StoreFactory")
      if storeCa then
        View.Group_Common.Group_Banner.Txt_ShopName:SetText(storeCa.storeName)
      end
      View.Group_Common.Group_Banner.Btn_:SetSprite(bannerCa.mainUIBannerPath)
      View.Group_Common.Group_Banner.Group_Time.Txt_Time:SetText(string.format(GetText(80611602), DataModel.bannerDay))
    end
  end)
end

function Controller.PosterGirlClickChangeAnimation(index)
  DataModel.clickAnim = DataModel.clickAnim or {}
  if DataModel.clickAnim[index] == nil then
    DataModel.clickAnim[index] = Controller.RandomClickAnim(index)
  end
  local animName = DataModel.clickAnim[index]
  local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. index]
  if DataModel.Live2DState[index] then
    local isClick = viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetClickAction(animName, function()
      viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetAction("idle", true, true)
      DataModel.clickAnim[index] = nil
    end)
    if isClick == true then
      local roleId = DataModel.roleId[index]
      local viewId = PlayerData:GetFactoryData(roleId, "UnitFactory").viewId
      local tempView = ChangePosterGirlDataModel.GetViewId(roleId, index)
      if tempView ~= 0 then
        viewId = tempView
      end
      local receptionistData = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
      local posIndex = ChangePosterGirlDataModel.GetPosY(viewId, index)
      if 0 < posIndex and posIndex <= #receptionistData.extraSpineList then
        receptionistData = PlayerData:GetFactoryData(receptionistData.extraSpineList[posIndex].id, "UnitViewFactory")
      end
      Controller:RefreshEffect(index, receptionistData)
    end
  end
  if PlayerData:GetHomeInfo().station_info.is_arrived == 2 or PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
    Controller:RandomPlayRoleSound(index, false)
  end
end

function Controller.GetTrustClick(index)
  Net:SendProto("main.rec_trust", function(json)
    local roleId = DataModel.roleId[index]
    PlayerData:GetRoleById(roleId).trust_exp = json.trust_exp
    PlayerData:GetRoleById(roleId).trust_lv = json.trust_lv
    PlayerData:GetUserInfo().receptionist_ts[index] = json.user_info.receptionist_ts
    CommonTips.OpenTips(80600757)
    View.Group_Common["ScrollView_PosterGirl" .. index].Viewport.Content.Group_PosterGirl.Btn_GetTrust:SetActive(false)
  end, index - 1)
end

function Controller.SwitchSpineClick(index)
  if DataModel.PosterGirlChangeSpine then
    return
  end
  if not table.contains(DataModel.changePosRole, index) then
    return
  end
  local viewId = DataModel.UnitViewId[index]
  local viewCA = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  local spineIndex = ChangePosterGirlDataModel.GetPosIndex(viewId, index)
  spineIndex = spineIndex + 1
  if spineIndex > #viewCA.extraSpineList then
    spineIndex = 0
  else
    viewCA = PlayerData:GetFactoryData(viewCA.extraSpineList[spineIndex].id, "UnitViewFactory")
  end
  ChangePosterGirlDataModel.SetPosIndex(spineIndex, viewId, index)
  DataModel.PosterGirlChangeSpine = true
  View.self:SetEnableAnimator(false)
  local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. index]
  if DataModel.Live2DState[index] then
    local idleName = "idle"
    local idleListId = viewCA.SpineIdleListId
    if idleListId ~= nil and 0 < idleListId then
      local tempCA = PlayerData:GetFactoryData(idleListId, "ListFactory")
      if tempCA ~= nil then
        idleName = tempCA.posterGirlIdleList[1].idleName
      end
    end
    local spineUrl = viewCA.spineUrl
    local spineScale = viewCA.spineScale
    local spineX = viewCA.spineX
    local spineY = viewCA.spineY
    DOTweenTools.DOFadeColorCallback(viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character, Color(1, 1, 1, 0), 0.3, function()
      Controller:RefreshReceptionistData(index, DataModel.roleId[index], viewId, DataModel.UnitViewIdIsSpine[index], true)
      Controller.RefreshPosterGirlFixEffect(index)
      DOTweenTools.DOFadeColorCallback(viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character, Color(1, 1, 1, 1), 0.3, function()
        DataModel.PosterGirlChangeSpine = false
        Controller:SetupPosterGirlIdleState(index, viewId, idleName)
        View.self:SetEnableAnimator(true)
        Controller.ChangePosterGirlNextSpineStopClickAnim()
        viewGroup.Viewport.Content.Group_PosterGirl.SpineAnimation_Character:SetAction(idleName, true, true)
      end)
    end)
  else
    local resUrl = viewCA.resUrl
    if not DataModel.SkinBgState[index] and viewCA.SpineBackground ~= "" and viewCA.singleUrl ~= "" then
      resUrl = viewCA.singleUrl
    end
    local resScale = viewCA.offsetScale
    local resX = viewCA.offsetX
    local resY = viewCA.offsetY
    DOTweenTools.DOFadeColorCallback(viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG.Img_Character, Color(1, 1, 1, 0), 0.3, function()
      Controller:RefreshReceptionistData(index, DataModel.roleId[index], viewId, DataModel.UnitViewIdIsSpine[index], true)
      Controller.RefreshPosterGirlFixEffect(index)
      DOTweenTools.DOFadeColorCallback(viewGroup.Viewport.Content.Group_PosterGirl.Group_CharacterIMG.Img_Character, Color(1, 1, 1, 1), 0.3, function()
        DataModel.PosterGirlChangeSpine = false
        View.self:SetEnableAnimator(true)
        Controller.ChangePosterGirlNextSpineStopClickAnim()
      end)
    end)
  end
end

function Controller.RefreshGoldInfoShow()
  local count, icon = DataModel.GetCityGoldCountAndIcon(TradeDataModel.CurStayCity)
  View.Group_Common.Group_TopLeft.Btn_Gold.Img_Icon:SetSprite(icon)
  View.Group_Common.Group_TopLeft.Btn_Gold.Txt_Num:SetText(count)
end

return Controller
