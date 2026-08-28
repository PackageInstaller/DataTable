local View = require("UIMainUI/UIMainUIView")
local Controller = require("UIMainUI/UIMainUIController")
local DataModel = require("UIMainUI/UIMainUIDataModel")
local NoticeDataModel = require("UINotice/UINoticeDataModel")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local TradeController = require("UIHome/UIHomeTradeController")
local MapController = require("UIHome/UIHomeMapController")
local AdvDataModel = require("UIAdvMain/UIAdvMainDataModel")
local MapDataModel = require("UIHome/UIHomeMapDataModel")
local ChangePosterGirlDataModel = require("UIChangePosterGirl/UIChangePosterGirlDataModel")
local CtrlCommon = require("UIMainUI/Controller/UIMainUI_CommonController")
local ViewFunction = {
  MainUI_Group_Common_Group_Navigation_Btn_Quest_Click = function(btn, str)
    Controller:ExitTo("UI/Quest/Quest")
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_ScrollView_Map_Viewport_Content_ScrollGrid_Station_SetGrid = function(element, elementIndex)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_ScrollView_Map_Viewport_Content_ScrollGrid_Station_Group_Item_Btn_S1_Click = function(btn, str)
    MapController:ClickBtn(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    MapController:ShowDetailMap(false)
    if DataModel.IsActivity then
      View.self:Confirm()
    end
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    MapController:ShowDetailMap(false)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80301502}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Btn_Map_Click = function(btn, str)
    Controller.readyToGo()
  end,
  MainUI_Group_Common_Group_TopLeft_Btn_ProfilePhoto_Click = function(btn, str)
    if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant then
      Controller:ExitTo("UI/MainUI/ESC", Json.encode({showAdjutantBg = true}))
    else
      Controller:ExitTo("UI/MainUI/ESC")
    end
    DataModel.MainToESC = true
  end,
  MainUI_Group_Common_Group_TopLeft_Btn_Gold_Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Store_Click = function(btn, str)
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      Controller:ExitTo("UI/Store/Store", Json.encode(json))
    end)
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Headhunt_Click = function(btn, str)
    Net:SendProto("recruit.pool_info", function(json)
      local DetailsDataModel = require("UIGachaDetails/UIGachaDetailsDataModel")
      DetailsDataModel.SetProtectInfo(json.protect_info)
      Controller:ExitTo("UI/Gacha/GachaNew")
    end)
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Mission_Click = function(btn, str)
    local isOpen, currentBattleId = PlayerData:GetNowPassData()
    local BattlePassDataModel = require("UIBattlePass_Quest/UIBattlePass_QuestDataModel")
    if PlayerData.CurrentBattleId ~= nil and PlayerData.CurrentBattleId ~= currentBattleId or PlayerData.CurrentBattleId == nil or BattlePassDataModel:GetRefreshBattlePass() then
      Net:SendProto("battle_pass.bp_info", function(json)
        if json.quests then
          for k, v in pairs(json.quests) do
            PlayerData.ServerData.quests[k] = v
          end
        end
        Controller:ExitTo("UI/BP_Quest/BattlePass_Quest")
      end)
    else
      Net:SendProto("quest.list", function(json)
        PlayerData.ServerData.quests = json.quests
        Controller:ExitTo("UI/BP_Quest/BattlePass_Quest")
      end, EnumDefine.QuestListDefine.All)
    end
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Member_Click = function(btn, str)
    local status = {btn = "Member", roleId = ""}
    Controller:ExitTo("UI/CharacterList/CharacterList", Json.encode(status))
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Squads_Click = function(btn, str)
    local status = {
      Current = "MainUI",
      hasOpenThreeView = false,
      squadIndex = PlayerData.BattleInfo.squadIndex
    }
    PlayerData.Last_Chapter_Parms = nil
    Controller:ExitTo("UI/Squads/Squads", Json.encode(status))
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Depot_Click = function(btn, str)
    Controller:ExitTo("UI/Depot/Depot")
  end,
  MainUI_Group_Coach_Btn_Decorate_Click = function(btn, str)
    if CommonTips.GuideAsset() then
      return
    end
    PlayerData.TempCache.BeginDecorateTimeStamp = TimeUtil:GetServerTimeStamp()
    UIManager:Open("UI/Home/HomeCoach")
  end,
  MainUI_Group_OutSide_Group_Station_Btn_SellG_Click = function(btn, str)
    TradeController:SaleGarbage()
  end,
  MainUI_Group_OutSide_Group_Station_Btn_HandleG_Click = function(btn, str)
    Net:SendProto("main.overview", function(json)
      local UIPassageTrafficRankDataModel = require("UIPassageTrafficRank/UIPassageTrafficRankDataModel")
      UIPassageTrafficRankDataModel.clearScore = json.current_clean or 1
      Net:SendProto("station.psg_source_info", function(json)
        PlayerData.RefreshSolicitData(json)
        UIManager:Open("UI/MainUI/PassageTrafficRank")
      end)
    end)
  end,
  MainUI_Group_OutSide_Group_Station_Btn_Build_Click = function(btn, str)
    local funcCommon = require("Common/FuncCommon")
    if not funcCommon.FuncActiveCheck(108, true) then
      return
    end
    CommonTips.OpenToHomeCarriageeditor()
  end,
  MainUI_Btn_ShowUI_Click = function(btn, str)
    if Controller.forbidShow ~= true then
      Controller:ReShowUI()
    end
  end,
  MainUI_Group_OutSide_Group_Running_Btn_Horn_Click = function(btn, str)
    if not PlayerData.CurTrainSkinIsSpecial() then
      TrainEffectHelper:LoadEffect(TrainEffectHelper.Enum_TrainEffectType.Sonar, true, false)
      TrainEffectHelper:SetEffectsActive(TrainEffectHelper.Enum_TrainEffectType.Sonar, true)
    end
  end,
  MainUI_Group_OutSide_Group_Running_Btn_Accelerate_Click = function(btn, str)
    if PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 then
      CommonTips.OpenTips(80601262)
      return
    end
    Controller.Rush()
  end,
  MainUI_Group_OutSide_Group_Running_Group_Gear_Btn_D_Click = function(btn, str)
    if PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 then
      CommonTips.OpenTips(80601262)
      return
    end
    Controller.Drive()
  end,
  MainUI_Group_OutSide_Group_Running_Group_Gear_Btn_B_Click = function(btn, str)
    if PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 then
      CommonTips.OpenTips(80601262)
      return
    end
    Controller.Stop()
  end,
  MainUI_Group_OutSide_Group_Running_Group_Gear_Btn_R_Click = function(btn, str)
    if PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 then
      CommonTips.OpenTips(80601262)
      return
    end
    PlayerData:SetPlayerPrefs("int", "IsStop", 0)
    local trainCA = PlayerData:GetFactoryData(99900037, "ConfigFactory")
    local homeCA = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local innerTrainMa = CS.FRef.getProperty(TrainManager, "InternalTrainManager")
    local speed = trainCA.speedReverse
    local SpeedReverse = (speed + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AsternSpeed, speed)) / homeCA.speedRatio
    CS.FRef.setProperty(innerTrainMa, "SpeedReverse", SpeedReverse)
    Controller.Astern()
  end,
  MainUI_Group_OutSide_Group_Running_Btn_Mask_Click = function(btn, str)
  end,
  MainUI_Btn_Launch_Click = function(btn, str)
    Controller.readyToGo()
  end,
  MainUI_Group_OutSide_Group_Station_Btn_Visit_Click = function(btn, str)
    CommonTips.OpenTips(80607634)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_Energy_Btn_Energy_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_ScrollView_Map_Viewport_Content_Btn_Close_Click = function(btn, str)
    MapDataModel.CurSelectedId = 0
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Selected:SetActive(false)
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.self:SelectPlayAnim("StationInfoOut")
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Btn_EmptyTip:SetActive(false)
  end,
  MainUI_Group_Adjutant_Btn_Achieve_Click = function(btn, str)
    Controller:ExitTo("UI/Achievement/Achievement")
  end,
  MainUI_Group_Adjutant_Btn_TrainOverview_Click = function(btn, str)
    Controller:ExitTo("UI/DriveLog/DriveLog")
    View.timer:Pause()
  end,
  MainUI_Group_Adjutant_Btn_DrivingLog_Click = function(btn, str)
    if CommonTips.GuideAsset() then
      return
    end
    Net:SendProto("plot.info", function(json)
      Controller:ExitTo("UI/PlotReview/PlotReview")
    end)
  end,
  MainUI_Group_Common_Btn_Enter_Click = function(btn, str)
    local stationId = TradeDataModel.EndCity
    if stationId ~= 83000001 and stationId ~= 83000053 and CommonTips.GuideAsset() then
      return
    end
    Controller.enterStation()
  end,
  MainUI_Group_Common_Btn_Leave_Click = function(btn, str)
    MapController:ShowDetailMap(true)
  end,
  MainUI_Btn_City_Click = function(btn, str)
    if TradeDataModel.GetIsTravel() then
      return
    end
    local homeCommon = require("Common/HomeCommon")
    homeCommon.TimeCheckRefreshStationInfo(nil, function()
      local t = {}
      t.stationId = TradeDataModel.EndCity
      Controller:ExitTo("UI/CityMap/CityMap", Json.encode(t))
    end)
  end,
  MainUI_Btn_Dungeon_Click = function(btn, str)
    local HomeCommon = require("Common/HomeCommon")
    local stateInfo = HomeCommon.GetCityStateInfo(TradeDataModel.EndCity)
    if stateInfo ~= nil and stateInfo.dungeonId > 0 then
      local status = {}
      status.chapterId = stateInfo.dungeonId
      status.startNew = true
      PlayerData.Last_Chapter_Parms = {
        chapterId = status.chapterId,
        Current = "MainUI"
      }
      PlayerData.BattleCallBackPage = "UI/InsZone/InsZone"
      UIManager:Open("UI/InsZone/InsZone", Json.encode(status))
    end
  end,
  MainUI_Group_OutSide_Group_Running_Btn_Camera_Click = function(btn, str)
    Controller.SetCamera()
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_Loadage_Btn_Icon_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_Loadage_Btn_Add_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_HomeEnergy_Btn_Icon_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_HomeEnergy_Btn_Add_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.OpenMoveEnergyUseItem(function()
      homeCommon.SetMoveEnergyElement(View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_HomeEnergy)
    end)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  MainUI_Group_Coach_Group_QuickJump_Btn_DecorateOFF_Click = function(btn, str)
    if View.Group_Coach.Img_Control.self.IsActive then
      View.Group_Coach.Btn_Manager:SetBtnInteractable(false)
      View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(false)
      View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(false)
      View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(false)
      Controller.ShowManagerTool(false, function()
        Controller.ShowCoachQuickJump(true, function()
          View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(true)
          View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(true)
          View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(true)
          View.Group_Coach.Btn_Manager:SetBtnInteractable(true)
        end)
      end)
      return
    end
    Controller.ShowCoachQuickJump(true)
  end,
  MainUI_Group_Coach_Group_QuickJump_Btn_Close_Click = function(btn, str)
    View.Group_Coach.Btn_Manager:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(false)
    Controller.ShowCoachQuickJump(false, function()
      View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(true)
      View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(true)
      View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(true)
      View.Group_Coach.Btn_Manager:SetBtnInteractable(true)
    end)
  end,
  MainUI_Group_Coach_Group_QuickJump_Btn_DecorateON_Click = function(btn, str)
    View.Group_Coach.Btn_Manager:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(false)
    Controller.ShowCoachQuickJump(false, function()
      View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(true)
      View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(true)
      View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(true)
      View.Group_Coach.Btn_Manager:SetBtnInteractable(true)
    end)
  end,
  MainUI_Group_Coach_Group_QuickJump_Group_Windows_Group_train_Btn_train_Click = function(btn, str)
  end,
  MainUI_Group_Coach_Group_QuickJump_Group_Windows_Img_Base_StaticGrid_Train_SetGrid = function(element, elementIndex)
    if elementIndex > DataModel.MaxCoachNum then
      element:SetActive(false)
      return
    end
    element:SetActive(true)
    local isEmpty = not PlayerData:GetHomeInfo().coach[elementIndex]
    local ucid = PlayerData:GetHomeInfo().coach_template[elementIndex]
    if not isEmpty then
      local roomIndex = DataModel.GetRoomIndexByUCid(ucid)
      if roomIndex == HomeManager.camRoom then
        DataModel.SelectJumpRoomCtr = element
      end
      local id = PlayerData:GetHomeInfo().coach[elementIndex].id
      local coachCA = PlayerData:GetFactoryData(id, "HomeCoachFactory")
      local typeCA = PlayerData:GetFactoryData(coachCA.coachType, "TagFactory")
      if not roomIndex then
        DataModel.CurBanEnterCoachCount = DataModel.CurBanEnterCoachCount + 1
        element.Btn_train:SetClickParam(-1)
      else
        element.Btn_train:SetClickParam(roomIndex)
        table.insert(DataModel.JumpRoomCtrList, element)
      end
      element.Btn_train.Img_Select:SetActive(roomIndex == HomeManager.camRoom)
      element.Btn_train.Img_UnSelect:SetActive(roomIndex ~= HomeManager.camRoom)
      element.Btn_train.Img_Select.Img_Icon:SetSprite(typeCA.skipJumpIcon)
      element.Btn_train.Img_UnSelect.Img_Icon:SetSprite(typeCA.skipJumpIcon)
      local showTxt = string.format("%02d", elementIndex)
      element.Btn_train.Img_Empty.Txt_Empty:SetText(showTxt)
      element.Btn_train.Img_Select.Txt_Select:SetText(showTxt)
      element.Btn_train.Img_UnSelect.Txt_UnSelect:SetText(showTxt)
      element.Btn_train.Img_Empty:SetActive(false)
    else
      element.Btn_train.Img_Empty:SetActive(true)
      element.Btn_train.Img_Select:SetActive(false)
      element.Btn_train.Img_UnSelect:SetActive(false)
      element.Btn_train:SetClickParam(elementIndex)
    end
  end,
  MainUI_Group_Coach_Group_QuickJump_Group_Windows_Img_Base_StaticGrid_Train_Group_train_Btn_train_Click = function(btn, str)
    local idx = tonumber(str)
    if idx == -1 then
      CommonTips.OpenTips(80601145)
      return
    end
    if idx > #PlayerData:GetHomeInfo().coach then
      return
    end
    if idx == HomeManager.camRoom then
      return
    end
    MainManager:SetTrainViewFilter(30, false)
    HomeManager:OpenHome(idx)
    if DataModel.SelectJumpRoomCtr then
      DataModel.SelectJumpRoomCtr.Btn_train.Img_Select:SetActive(false)
      DataModel.SelectJumpRoomCtr.Btn_train.Img_UnSelect:SetActive(true)
    end
    local ctr = DataModel.JumpRoomCtrList[idx + 1]
    if ctr then
      ctr.Btn_train.Img_Select:SetActive(true)
      ctr.Btn_train.Img_UnSelect:SetActive(false)
      DataModel.SelectJumpRoomCtr = ctr
    end
  end,
  MainUI_Group_Common_Group_MB_BtnPolygon_Adjutant_Click = function(btn, str)
    Controller.StopPosterGirlAudioSource()
    View.Group_Common.Group_MB.Group_Lighting.self:SetLocalScale(0, 0, 0, 0)
    if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.OutSide then
      View.self:PlayAnim("OToA")
    elseif PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Coach then
      View.self:PlayAnim("CToA")
    end
    local roleId = DataModel.roleId
    Controller:SwitchTab(DataModel.UIShowEnum.Adjutant, true)
    if roleId ~= PlayerData.ServerData.user_info.adjutant_id then
      DataModel:InitRoleTrustData()
    end
  end,
  MainUI_Group_Common_Group_MB_BtnPolygon_OutSide_Click = function(btn, str)
    Controller.StopPosterGirlAudioSource()
    View.Group_Common.Group_MB.Group_Lighting.self:SetLocalScale(1, 1, 1, 0)
    if DataModel.CurSceneName == DataModel.SceneNameEnum.Main then
      if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant then
        View.self:PlayAnim("AToO")
      end
      local roleId = DataModel.roleId
      Controller:SwitchTab(DataModel.UIShowEnum.OutSide, true)
      if roleId ~= PlayerData.ServerData.user_info.receptionist_id then
        DataModel:InitRoleTrustData()
      end
      return
    else
      PlayerData.TempCache.MainUIShowState = DataModel.UIShowEnum.OutSide
    end
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      CommonTips.OpenLoadingCB(function()
        UIManager:Pause(false)
        CBus:ChangeScene("Main")
      end)
    end))
  end,
  MainUI_Group_Common_Group_MB_BtnPolygon_Coach_Click = function(btn, str)
    local funcCommon = require("Common/FuncCommon")
    if not funcCommon.FuncActiveCheck(106, true) then
      return
    end
    Controller.StopPosterGirlAudioSource()
    if DataModel.CurSceneName == DataModel.SceneNameEnum.Home then
      if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant then
        View.self:PlayAnim("AToC")
      end
      Controller:SwitchTab(DataModel.UIShowEnum.Coach, true)
      return
    else
      PlayerData.TempCache.MainUIShowState = DataModel.UIShowEnum.Coach
    end
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      
      local function cb()
        local SliceSceneManager = CBus:GetManager(CS.ManagerName.SliceSceneManager, true)
        if SliceSceneManager ~= nil then
          SliceSceneManager.loadedScene:Clear()
        end
        CBus:ChangeScene("Home")
        GameSetting:LoadPlayerSetting()
        PlayerData:ResetCharacterFilter()
        PlayerData:ResetSuaqsFilter()
        PlayerData:ResetDepotFilter()
      end
      
      local loadingConfig = PlayerData:GetFactoryData(99900036, "ConfigFactory")
      local randomNum = math.random(1, #loadingConfig.enterHomeUIList)
      CommonTips.OpenLoading(nil, "", loadingConfig.enterHomeUIList[randomNum].imagePath, cb)
    end))
    DataModel.IsGoHomeCoach = true
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Group_Goods_ScrollGrid_GoodsList_SetGrid = function(element, elementIndex)
    local info = MapDataModel.CurShowList[elementIndex]
    local goodsCA = PlayerData:GetFactoryData(info.id, "HomeGoodsFactory")
    element.Img_Item:SetSprite(goodsCA.imagePath)
    element.Btn_Item:SetClickParam(elementIndex)
    element.Img_Bottom:SetSprite(UIConfig.BottomConfig[goodsCA.qualityInt + 1])
    element.Img_Mask:SetSprite(UIConfig.MaskConfig[goodsCA.qualityInt + 1])
    element.Group_Corner.Img_Specialty:SetActive(info.isSpecial)
    element.Group_Corner.Img_EventWeek:SetActive(MapDataModel.tradeData[info.id])
    element.Group_Corner.Img_EventWeek:SetSprite(MapDataModel.nowActivity.activityItemCorner)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Group_Goods_ScrollGrid_GoodsList_Group_Item_Btn_Item_Click = function(btn, str)
    local info = MapDataModel.CurShowList[tonumber(str)]
    local data = {}
    data.goodsId = info.id
    data.goodsType = 1
    UIManager:Open("UI/Common/GoodsTips", Json.encode(data))
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_Go_Click = function(btn, str)
    local stationId = MapDataModel.CurSelectedId
    if stationId ~= 83000001 and stationId ~= 83000053 and CommonTips.GuideAsset() then
      return
    end
    Controller.TryGoToNewCity()
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_BuyRush_Click = function(btn, str)
    local cfg = PlayerData:GetFactoryData("99900007")
    local max = PlayerData.GetMaxFuelNum()
    if PlayerData:GetHomeInfo().readiness.fuel.fuel_num == max then
      CommonTips.OpenTips(80600795)
    else
      UIManager:Open("UI/Common/BuyRushTips")
    end
  end,
  MainUI_Group_Common_Btn_Help_Click = function(btn, str)
    local curr
    for i = TrainManager.TrainCtrl.FirstTrain.PathIndex + 1, 1, -1 do
      local v = TradeDataModel.Path[i]
      if PlayerData:GetHomeInfo().stations[tostring(v.beginId)].is_unlock == 1 then
        curr = v
        break
      end
    end
    if curr then
      local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
      local trainHelpCost = homeConfig.trainHelpCost
      local passDistance
      if curr.isForward then
        passDistance = TrainManager.TrainCtrl.FirstTrain.Position
      else
        passDistance = curr.length - TrainManager.TrainCtrl.FirstTrain.Position
      end
      DataModel.TrailerCityId = curr.beginId
      CommonTips.OnPrompt(string.format(GetText(80601304), math.floor(passDistance * trainHelpCost)), GetText(80600068), GetText(80600067), function()
        local t = {
          [1] = homeConfig.trainHelpLook
        }
        PlayerData.TempCache.IsHelp = true
        local cfg = PlayerData:GetFactoryData(DataModel.TrailerCityId, "HomeStationFactory")
        
        function PlayerData.TempCache.TrailerFinishCb()
          Train.TrailerStop()
        end
        
        View.Group_Common.Btn_Help.self:SetActive(false)
        Controller.BackShow(false)
        UIManager:Open(UIPath.UIDialog, Json.encode({
          id = cfg.trainHelpChat
        }))
      end, function()
        print_r("cancel")
      end, true)
    end
  end,
  MainUI_Group_Common_Btn_HideUI_Click = function(btn, str)
    Controller:HideAll()
  end,
  MainUI_Group_Common_Btn_HidePosterGirl_Click = function(btn, str)
    DataModel.isPosterGirlShow = not DataModel.isPosterGirlShow
    local isShow = DataModel.isPosterGirlShow
    if PlayerData.TempCache.MainUIShowState ~= DataModel.UIShowEnum.Adjutant then
      PlayerData.showPosterGirl = isShow and 1 or -1
    end
    View.Group_Common.Btn_Change.self:SetActive(isShow)
    View.Group_Common.Btn_SwitchSpine:SetActive(isShow)
    for i = 1, 10 do
      local scroll = View.Group_Common["ScrollView_PosterGirl" .. i]
      if scroll == nil then
        break
      end
      local _content = scroll.Viewport.Content
      _content.Group_PosterGirl.self:SetActive(isShow)
      _content.Group_Video.self:SetActive(isShow)
    end
    if isShow then
      View.timer:Resume()
      Controller:ShowPosterGirl(true, PlayerData.TempCache.MainUIShowState ~= DataModel.UIShowEnum.Coach)
    else
      Controller.StopPosterGirlAudioSource()
      for i = 1, 10 do
        Controller.HideAllEffect(i)
      end
    end
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_PassengerCapacity_Btn_Add_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_PassengerCapacity_Btn_Icon_Click = function(btn, str)
  end,
  MainUI_Group_OutSide_Group_Running_Btn_Light_Click = function(btn, str)
    Controller:OpenLight()
  end,
  MainUI_Group_Common_Group_Back_Btn_Fight_Click = function(btn, str)
    local stationId = TradeDataModel.StartCity
    if stationId ~= 83000001 and stationId ~= 83000053 and CommonTips.GuideAsset() then
      return
    end
    Controller.BackFunction()
  end,
  MainUI_Group_Common_Group_TopLeft_Group_Buff_Img_BuffSpeed_Btn__Click = function(btn, str)
    DataModel.ShowHomeBuffTips()
  end,
  MainUI_Group_Common_Group_TopLeft_Group_Buff_Img_Buff_Btn__Click = function(btn, str)
    DataModel.ShowHomeBuffTips()
  end,
  MainUI_Group_Park_Btn_Park_Click = function(btn, str)
  end,
  MainUI_Group_Park_Btn_Start_Click = function(btn, str)
  end,
  MainUI_Group_Coach_Btn_Manager_Click = function(btn, str)
    Net:SendProto("main.overview", function(json)
      local UIPassageTrafficRankDataModel = require("UIPassageTrafficRank/UIPassageTrafficRankDataModel")
      UIPassageTrafficRankDataModel.clearScore = json.current_clean or 1
      UIManager:Open("UI/MainUI/PassageTrafficRank")
    end)
  end,
  MainUI_Group_Coach_Img_Control_Btn_PetManage_Click = function(btn, str)
    UIManager:Open("UI/HomePet/PetManage")
  end,
  MainUI_Group_Coach_Img_Control_Btn_Passenger_Click = function(btn, str)
    if not PlayerData.IsPassageFunOpen() then
      CommonTips.OpenTips(80601642)
      return
    end
    UIManager:Open("UI/Passenger/Passenger")
  end,
  MainUI_Group_Common_Group_Event_Group_Fight_BtnPolygon_Fight_Click = function(btn, str)
    Controller.Battle()
  end,
  MainUI_Group_Common_Group_Event_Group_Strike_BtnPolygon_Strike_Click = function(btn, str)
    if TrainManager.TrainCtrl == nil or TrainManager.TrainCtrl.StateCtrl == nil then
      return
    end
    if PlayerData.IsEnergyEnough() then
      TrainManager:ChangeStrikeState(StrikeState.Start)
    else
      CommonTips.OpenTips(80600541)
    end
  end,
  MainUI_Group_Common_Group_Event_Group_Buy_BtnPolygon_Buy_Click = function(btn, str)
    Controller.SpendMoneyBuyRoad()
  end,
  MainUI_Group_Common_Group_Event_Group_Balloon_BtnPolygon_Balloon_Click = function(btn, str)
    if DataModel.TrainEventAreaId then
      UIManager:Open("UI/MainUI/BalloonChoose", Json.encode({
        eventId = DataModel.TrainEventId,
        lineId = DataModel.TrainLineId,
        areaId = DataModel.TrainEventAreaId
      }))
    else
      UIManager:Open("UI/MainUI/BalloonChoose", Json.encode({
        eventId = DataModel.TrainEventId,
        lineId = DataModel.TrainLineId
      }))
    end
  end,
  MainUI_Group_Common_Group_MB_Btn_Electric_Click = function(btn, str)
    Controller:ExitTo("UI/Home/HomeElectric")
  end,
  MainUI_Group_Common_Btn_ClickFight_Click = function(btn, str)
    Train.CloseLevelEventIndexUI()
    if PlayerData.IsQuestComplete(81000001) == false or PlayerData.IsQuestComplete(81000712) == false then
      PlayerData.TempCache.EventIndex = nil
      CommonTips.OpenTips(80601979)
      return
    end
    Controller.ImmediatelyStop()
    Controller.Battle()
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Activity_Click = function(btn, str)
    UIManager:Open("UI/SignIn/SignIn")
  end,
  MainUI_Group_Common_Group_TopRight_Btn_ActivityNew_Click = function(btn, str)
    if CommonTips.GuideAsset() then
      return
    end
    UIManager:Open("UI/Activity/ActivityMain")
  end,
  MainUI_Group_Common_Group_Event_Group_Back_Btn_Fight_Click = function(btn, str)
    Controller.BackFunction()
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_Trailer_Click = function(btn, str)
    local trailerUnlock = PlayerData:GetFactoryData(99900060, "ConfigFactory").trailerUnlock
    if trailerUnlock > PlayerData:GetUserInfo().lv then
      CommonTips.OpenTips(80602348)
      return
    end
    if CommonTips.GuideAsset() then
      return
    end
    local trailerConfig = PlayerData:GetFactoryData(99900060, "ConfigFactory")
    local trailerLv = PlayerData:GetHomeInfo().back_lv
    local trailerList = trailerConfig.trailerList
    local trailer = trailerList[trailerLv + 1]
    local maxNum = trailerConfig.trailerMax + trailer.trailerExtra
    local currNum = PlayerData:GetHomeInfo().req_back_num
    local currRemainNum = maxNum - currNum
    local currTime = TimeUtil:GetServerTimeStamp()
    local maxMonthNum = 0
    if next(PlayerData.ServerData.monthly_card) ~= nil then
      for i, v in pairs(PlayerData.ServerData.monthly_card) do
        local deadline = v.deadline
        if currTime < deadline then
          maxMonthNum = PlayerData:GetFactoryData(99900060, "ConfigFactory").trailerMonthCardMax
        end
      end
    end
    local currMonthNum = PlayerData:GetHomeInfo().monthly_req_back_num
    local activityData = PlayerData:GetActivityData(86000069)
    if activityData and activityData.rec_today and TimeUtil:GetServerTimeStamp() <= activityData.rec_today then
      maxMonthNum = maxMonthNum + PlayerData:GetFactoryData(99900060, "ConfigFactory").trailerMonthCardMax
      currMonthNum = currMonthNum + (PlayerData:GetHomeInfo().activity_monthly_req_back_num or 0)
    end
    local currMonthRemainNum = maxMonthNum - currMonthNum
    local currAllRemainNum = currRemainNum + currMonthRemainNum
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local distance = math.ceil(MapDataModel.GetTargetStationDistance(MapDataModel.CurSelectedId) * homeConfig.disRatio)
    UIManager:Open("UI/MainUI/TrailerPrompt", tostring(distance))
  end,
  MainUI_Group_Common_Group_TopLeft_Group_Buff_Img_BuffBattle_Btn__Click = function(btn, str)
    DataModel.ShowHomeBuffTips()
  end,
  MainUI_Btn_AdBoard_Click = function(btn, str)
    if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Passenger then
      return
    end
    local adBoard = View.Obj_AdBoard:GetComponent(typeof(CS.AdBoardView))
    local caId = adBoard.caId
    if caId <= 0 then
      return
    end
    local currIndex = adBoard.curIndex + 1
    local curAd = DataModel.GetAdInfo(adBoard, currIndex)
    if not curAd then
      return
    end
    local webUrl = curAd.webUrl
    if webUrl ~= nil and webUrl ~= "" then
      CS.UnityEngine.Application.OpenURL(webUrl)
      return
    end
    local uiURL = curAd.uiURL
    if uiURL ~= nil and uiURL ~= "" then
      local uiParam = curAd.uiParam
      if uiURL == "UI/Store/Store" then
        local a, b = PlayerData:OpenStoreCondition()
        if a == false then
          CommonTips.OpenTips(b[1].txt)
          return
        end
        Net:SendProto("shop.info", function(json)
          local param = Json.decode(uiParam)
          local recharge = PlayerData.RechargeGoods[tostring(param.storeId)]
          if recharge and recharge[tostring(param.subIndex)] and recharge[tostring(param.subIndex)].num > 0 then
            if View.Group_Common.Group_TopRight.Btn_Headhunt.self.IsActive then
              Controller:ExitTo("UI/Gacha/GachaNew")
            end
          elseif View.Group_Common.Group_TopRight.Btn_Store.self.IsActive then
            Controller:ExitTo(uiURL, uiParam)
          end
        end)
      else
        Controller:ExitTo(uiURL, uiParam)
      end
    end
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_DriveSetup_Click = function(btn, str)
    UIManager:Open("UI/MainUI/DriveSetup")
  end,
  MainUI_Group_Coach_Img_Control_Btn_Prisoner_Click = function(btn, str)
    UIManager:Open("UI/Prison/PrisonerList/PrisonerList", Json.encode({Mode = "Coach"}))
  end,
  MainUI_Group_Common_Btn_Change_Click = function(btn, str)
    DataModel:GetNextSoundTime()
    View.timer.delay = DataModel.nextDelay
    View.timer:Reset()
    local status = {
      btn = "Change",
      scene = (PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.OutSide or PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Coach) and "Main" or "Adjutant",
      roleId = DataModel.roleId
    }
    Controller:ExitTo("UI/CharacterInfo/ChangePosterGirl/ChangePosterGirl", Json.encode(status), function()
      for i = 1, 10 do
        local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. i]
        if viewGroup == nil then
          break
        end
        viewGroup.Viewport.Content.Group_PosterGirl.self:SetActive(true)
      end
      Controller:RandomPlayRoleSound(nil, true)
    end, function()
      for i = 1, 10 do
        local viewGroup = View.Group_Common["ScrollView_PosterGirl" .. i]
        if viewGroup == nil then
          break
        end
        viewGroup.Viewport.Content.Group_PosterGirl.self:SetActive(false)
      end
    end)
    DataModel.MainToESC = true
    Controller.ChangePosterGirlSpineStopClickAnim()
  end,
  MainUI_Group_Common_Btn_SwitchSpine_Click = function(btn, str)
    local roleCount = #DataModel.changePosRole
    if roleCount == 1 then
      Controller.SwitchSpineClick(DataModel.changePosRole[1])
    else
      local active = not View.Group_Common.Btn_SwitchSpine.ScrollGrid_.self.gameObject.activeSelf
      View.Group_Common.Btn_SwitchSpine.ScrollGrid_.self:SetActive(active)
      if active then
        View.Group_Common.Btn_SwitchSpine.ScrollGrid_.grid.self:SetDataCount(roleCount)
        View.Group_Common.Btn_SwitchSpine.ScrollGrid_.grid.self:RefreshAllElement(roleCount)
      end
    end
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_ActivityWeek_Click = function(btn, str)
    UIManager:Open("UI/Activity/ActivityMain", Json.encode({
      id = MapDataModel.nowActivity.activityId
    }))
  end,
  MainUI_Group_Common_Btn_StageQuest_Click = function(btn, str)
    if CommonTips.GuideAsset() then
      return
    end
    Net:SendProto("quest.list", function(json)
      if json.quests.activity_day_quests then
        PlayerData.ServerData.quests.activity_day_quests = json.quests.activity_day_quests
      end
      PlayerData.ServerData.liveness_rewards = json.liveness_rewards
      UIManager:Open("UI/StageQuest/StageQuest")
    end, EnumDefine.QuestListDefine.BattlePassQuest)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_IconTip_Group_GT1_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80301502, titleId = 80602194}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_IconTip_Group_GT2_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80301502, titleId = 80602054}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_IconTip_Group_SMM1_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80301502, titleId = 80602072}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_IconTip_Group_SMM2_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80301502, titleId = 80602072}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  MainUI_Btn_Share_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Btn_Tip_Click = function(btn, str)
    local isActive = View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_IconTip.IsActive
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_IconTip:SetActive(not isActive)
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Btn_Tip.Img_Red:SetActive(false)
    local red = PlayerData:GetPlayerPrefs("int", "mainUITipRed")
    if red == 0 then
      PlayerData:SetPlayerPrefs("int", "mainUITipRed", 1)
    end
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_Passenger_Click = function(btn, str)
    local vf = require("UIPassageTrafficRank/UIPassageTrafficRankViewFunction")
    DataModel.isGoMapStation = MapDataModel.CurSelectedId
    vf:PassageTrafficRank_Btn_ZhaoLan_Click()
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_Trade_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    local station_info = PlayerData:GetHomeInfo().station_info
    if station_info.status == -1 then
      local cityMapId = homeCommon.GetCityStateInfo(station_info.sid).cityMapId
      local bubbleList = PlayerData:GetFactoryData(cityMapId).bubbleList
      for i = 1, #bubbleList do
        local ca = PlayerData:GetFactoryData(bubbleList[i].id)
        if ca.btnType == "HomeTrade" then
          DataModel.isGoMapStation = MapDataModel.CurSelectedId
          require("UICityMap/UICityMapDataModel").stationId = station_info.sid
          require("UICityMap/UICityMapController"):ClickBtn(nil, {
            bubbleId = bubbleList[i].id
          })
        end
      end
    end
  end,
  MainUI_Btn_Revenue_Click = function(btn, str)
    Net:SendProto("main.revenue_record", function(json)
      UIManager:Open("UI/RevenueOverview/RevenueOverview", Json.encode({
        incomeRecord = json.revenue_record
      }))
    end, PlayerData:GetUserInfo().uid)
  end,
  MainUI_Group_Common_Btn_Community_Click = function(btn, str)
    CtrlCommon:OnBtnCommunity()
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Btn_EmptyTip_Click = function(btn, str)
    UIManager:Open("UI/MainUI/EmptyTip", Json.encode({
      hasLoadageEmpty = (PlayerData:GetUserInfo().space_info.now_train_goods_num or 0) < PlayerData.GetMaxTrainGoodsNum(),
      hasPassengerEmpty = (PlayerData:GetCurPassengerNum() or 0) < (PlayerData:GetMaxPassengerNum() or 0),
      curCityId = PlayerData:GetHomeInfo().station_info.sid
    }), Controller.GoToNewCity)
  end,
  MainUI_Group_Common_Group_Navigation_Group_QuestList_Btn_Navigation_Click = function(btn, str)
    if PlayerData.TempCache.showQuest1 > 0 then
      UIManager:Open("UI/Quest/Quest", Json.encode({
        questId = PlayerData.TempCache.showQuest1
      }))
    end
  end,
  MainUI_Group_Common_Group_Navigation_Group_QuestList_Btn_Navigation2_Click = function(btn, str)
    if PlayerData.TempCache.showQuest2 > 0 then
      UIManager:Open("UI/Quest/Quest", Json.encode({
        questId = PlayerData.TempCache.showQuest2
      }))
    end
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Slider_Scale_Slider = function(slider, value)
    MapController:SetMapScale(value)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Slider_Scale_SliderDown = function(slider)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Slider_Scale_SliderUp = function(slider)
  end,
  MainUI_Img_Dashboard_Btn_FreindsList_Click = function(btn, str)
    local UIFriendsListController = require("UIFriendsList/UIFriendsListController")
    UIFriendsListController.OpenFriendsList()
  end,
  MainUI_Group_Common_Btn_Company_Click = function(btn, str)
  end,
  MainUI_Group_Common_Btn_Safe_Click = function(btn, str)
    if CommonTips.GuideAsset() then
      return
    end
    UIManager:Open("UI/Activity/ActivityMain", Json.encode({id = 86000096}))
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_Skip_Click = function(btn, str)
    MapController:ClickBtnJump()
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Btn_QuestTip_Click = function(btn, str)
    if DataModel.mainQuestStationId ~= 0 then
      MapController:AutoToClickStation(DataModel.mainQuestStationId, true, true)
      View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.self.ScrollRect.velocity = Vector2.zero
    end
  end,
  MainUI_Btn_Map_Click = function(btn, str)
    WastelandGameManager:GameInit()
  end,
  MainUI_Group_Common_Btn_Package_Click = function(btn, str)
    if PlayerData.IsExistRewardForGuideAsset() then
      UIManager:Open("UI/Download/Download", Json.encode({IsGameIn = true}))
    else
      CommonTips.GuideAsset()
    end
  end,
  MainUI_Group_Common_Group_MusicPlayer_Group_Open_Btn_Switch_Click = function(btn, str)
    Controller.OnBGMChangeModelClick()
  end,
  MainUI_Group_Common_Group_MusicPlayer_Group_Open_Btn_PlayStop_Click = function(btn, str)
    Controller.OnBgmPlayStopClick()
  end,
  MainUI_Group_Common_Group_MusicPlayer_Group_Open_Btn_Close_Click = function(btn, str)
    Controller.ShowBgmView(0)
  end,
  MainUI_Group_Common_Group_MusicPlayer_Group_Open_Btn_Like_Click = function(btn, str)
    Controller.OnBGMLikeClick()
  end,
  MainUI_Group_Common_Group_MusicPlayer_Group_Open_Group_Free_Btn_Next_Click = function(btn, str)
    Controller.OnBGMNextClick()
  end,
  MainUI_Group_Common_Group_MusicPlayer_Group_Open_Group_Free_Btn_Previous_Click = function(btn, str)
    Controller.OnBGMPreClick()
  end,
  MainUI_Group_Common_Group_MusicPlayer_Group_Close_Btn__Click = function(btn, str)
    Controller.ShowBgmView(1)
  end,
  MainUI_Group_Common_Group_MusicPlayer_Group_Open_Btn__Click = function(btn, str)
    UIManager:Open("UI/MusicPlayer/MusicPlayer")
  end,
  MainUI_Group_Common_Group_Banner_Btn__Click = function(btn, str)
    local bannerCa = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    if not bannerCa then
      return
    end
    UIManager:Open("UI/Store/Store", bannerCa.mainUIBannerArgs)
  end,
  MainUI_Group_Common_Btn_HideAni_Click = function(btn, str)
  end,
  MainUI_Group_Common_Btn_BlackMoon_Click = function(btn, str)
    local shopId = PlayerData:GetFactoryData(80611834, "TextFactory")
    UIManager:Open("UI/Store/Store", shopId.text)
  end,
  MainUI_Group_OutSide_Group_Station_Btn_Achieve_Click = function(btn, str)
    Controller:ExitTo("UI/Achievement/Achievement")
  end,
  MainUI_Group_Common_Btn_Safe_Btn_Tip_Click = function(btn, str)
    UIManager:Open("UI/Entrust/Entrust")
  end,
  MainUI_Group_Common_Group_Advertisement_StaticGrid_Count_SetGrid = function(element, elementIndex)
    element.Img_Select:SetActive(elementIndex == DataModel.curAdScrollIndex)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl1_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_Click = function(btn, str)
    Controller.PosterGirlClickChangeAnimation(1)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl1_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click_Click = function(btn, str)
    Controller:PosterGirlBtnClick(1, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl1_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click2_Click = function(btn, str)
    Controller:PosterGirlBtnClick(1, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl1_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation2_Click = function(btn, str)
    if PlayerData:GetHomeInfo().station_info.is_arrived == 2 or PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
      Controller:RandomPlayRoleSound(1)
    end
  end,
  MainUI_Group_Common_ScrollView_PosterGirl1_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation3_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl1_Viewport_Content_Group_PosterGirl_Btn_SwitchSpine_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl1_Viewport_Content_Group_PosterGirl_Btn_GetTrust_Click = function(btn, str)
    Controller.GetTrustClick(1)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl1_Viewport_Content_Group_PosterGirl_Btn_FestivalGift_Click = function(btn, str)
    local index = PlayerData:GetCurFestivalIndex()
    PlayerData:GetFestivalRewards(1, index)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl1_Viewport_Content_Group_Video_Video_play_Skip_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl2_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_Click = function(btn, str)
    Controller.PosterGirlClickChangeAnimation(2)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl2_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click_Click = function(btn, str)
    Controller:PosterGirlBtnClick(2, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl2_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click2_Click = function(btn, str)
    Controller:PosterGirlBtnClick(2, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl2_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation2_Click = function(btn, str)
    if PlayerData:GetHomeInfo().station_info.is_arrived == 2 or PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
      Controller:RandomPlayRoleSound(2)
    end
  end,
  MainUI_Group_Common_ScrollView_PosterGirl2_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation3_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl2_Viewport_Content_Group_PosterGirl_Btn_SwitchSpine_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl2_Viewport_Content_Group_PosterGirl_Btn_GetTrust_Click = function(btn, str)
    Controller.GetTrustClick(2)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl2_Viewport_Content_Group_PosterGirl_Btn_FestivalGift_Click = function(btn, str)
    local index = PlayerData:GetCurFestivalIndex()
    PlayerData:GetFestivalRewards(2, index)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl2_Viewport_Content_Group_Video_Video_play_Skip_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl3_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_Click = function(btn, str)
    Controller.PosterGirlClickChangeAnimation(3)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl3_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click_Click = function(btn, str)
    Controller:PosterGirlBtnClick(3, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl3_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click2_Click = function(btn, str)
    Controller:PosterGirlBtnClick(3, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl3_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation2_Click = function(btn, str)
    if PlayerData:GetHomeInfo().station_info.is_arrived == 2 or PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
      Controller:RandomPlayRoleSound(3)
    end
  end,
  MainUI_Group_Common_ScrollView_PosterGirl3_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation3_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl3_Viewport_Content_Group_PosterGirl_Btn_SwitchSpine_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl3_Viewport_Content_Group_PosterGirl_Btn_GetTrust_Click = function(btn, str)
    Controller.GetTrustClick(3)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl3_Viewport_Content_Group_PosterGirl_Btn_FestivalGift_Click = function(btn, str)
    local index = PlayerData:GetCurFestivalIndex()
    PlayerData:GetFestivalRewards(3, index)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl3_Viewport_Content_Group_Video_Video_play_Skip_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl4_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_Click = function(btn, str)
    Controller.PosterGirlClickChangeAnimation(4)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl4_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click_Click = function(btn, str)
    Controller:PosterGirlBtnClick(4, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl4_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click2_Click = function(btn, str)
    Controller:PosterGirlBtnClick(4, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl4_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation2_Click = function(btn, str)
    if PlayerData:GetHomeInfo().station_info.is_arrived == 2 or PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
      Controller:RandomPlayRoleSound(4)
    end
  end,
  MainUI_Group_Common_ScrollView_PosterGirl4_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation3_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl4_Viewport_Content_Group_PosterGirl_Btn_SwitchSpine_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl4_Viewport_Content_Group_PosterGirl_Btn_GetTrust_Click = function(btn, str)
    Controller.GetTrustClick(4)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl4_Viewport_Content_Group_PosterGirl_Btn_FestivalGift_Click = function(btn, str)
    local index = PlayerData:GetCurFestivalIndex()
    PlayerData:GetFestivalRewards(4, index)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl4_Viewport_Content_Group_Video_Video_play_Skip_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl5_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_Click = function(btn, str)
    Controller.PosterGirlClickChangeAnimation(5)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl5_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click_Click = function(btn, str)
    Controller:PosterGirlBtnClick(5, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl5_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click2_Click = function(btn, str)
    Controller:PosterGirlBtnClick(5, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl5_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation2_Click = function(btn, str)
    if PlayerData:GetHomeInfo().station_info.is_arrived == 2 or PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
      Controller:RandomPlayRoleSound(5)
    end
  end,
  MainUI_Group_Common_ScrollView_PosterGirl5_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation3_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl5_Viewport_Content_Group_PosterGirl_Btn_SwitchSpine_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl5_Viewport_Content_Group_PosterGirl_Btn_GetTrust_Click = function(btn, str)
    Controller.GetTrustClick(5)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl5_Viewport_Content_Group_PosterGirl_Btn_FestivalGift_Click = function(btn, str)
    local index = PlayerData:GetCurFestivalIndex()
    PlayerData:GetFestivalRewards(5, index)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl5_Viewport_Content_Group_Video_Video_play_Skip_Click = function(btn, str)
  end,
  MainUI_Group_Common_Btn_SwitchSpine_ScrollGrid__SetGrid = function(element, elementIndex)
    local roleIndex = DataModel.changePosRole[elementIndex]
    local viewId = DataModel.UnitViewId[roleIndex]
    local cfg = PlayerData:GetFactoryData(viewId)
    element.Btn_ProfilePhoto.Img_Client:SetSprite(cfg.face)
    element.Btn_:SetClickParam(roleIndex)
  end,
  MainUI_Group_Common_Btn_SwitchSpine_ScrollGrid__Group_Item_Btn__Click = function(btn, str)
    Controller.SwitchSpineClick(tonumber(str))
  end,
  MainUI_Group_Common_Btn_SwitchSpine_ScrollGrid__Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_TopLeft_Group_Buff_Img_BuffWL_Btn__Click = function(btn, str)
    DataModel.ShowHomeBuffTips()
  end,
  MainUI_Group_Common_ScrollView_PosterGirl_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click_Click = function(btn)
    Controller:PosterGirlBtnClick(1, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_click2_Click = function(btn)
    Controller:PosterGirlBtnClick(1, btn)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation_Click = function(btn, str)
    Controller.PosterGirlClickChangeAnimation(1)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation2_Click = function(btn, str)
    if PlayerData:GetHomeInfo().station_info.is_arrived == 2 or PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
      Controller:RandomPlayRoleSound(1)
    end
  end,
  MainUI_Group_Common_ScrollView_PosterGirl_Viewport_Content_Group_PosterGirl_Btn_SwitchSpine_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl_Viewport_Content_Group_PosterGirl_Btn_GetTrust_Click = function(btn, str)
    Controller.GetTrustClick(1)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl_Viewport_Content_Group_PosterGirl_Btn_FestivalGift_Click = function(btn, str)
    local index = PlayerData:GetCurFestivalIndex()
    PlayerData:GetFestivalRewards(1, index)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl_Viewport_Content_Group_PosterGirl_Btn_ChangeAnimation3_Click = function(btn, str)
  end,
  MainUI_Group_Common_ScrollView_PosterGirl_Viewport_Content_Group_Video_Video_play_Skip_Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_Advertisement_Group_Mask_Group_Drag_Group_Item1_Btn__Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_Advertisement_Group_Mask_Group_Drag_Group_Item2_Btn__Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_Advertisement_Group_Mask_Group_Drop_Group_Item1_Btn__Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_Advertisement_Group_Mask_Group_Drop_Group_Item2_Btn__Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_Advertisement_ScrollGrid_Advertisement_SetGrid = function(element, elementIndex)
  end,
  MainUI_Group_Common_Group_Navigation_Btn_Navigation_Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_BroadCast_Group_BG_Group_Upper_Group_TopRight_Btn_Close_Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_Fight_Btn_Mask_Click = function(btn, str)
    View.self:PlayAnimOnce("BattleEnd", function()
      Controller:TrainEvent()
    end)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  MainUI_Group_Common_Group_TopLeft_Img_Buff_Btn__Click = function(btn, str)
    local drinkBuff = PlayerData:GetCurDrinkBuff()
    if drinkBuff ~= nil then
      local t = {}
      t.posX = -479
      t.posY = -322
      t.drinkBuff = drinkBuff
      UIManager:Open("UI/Common/HomeBuff", Json.encode(t))
    end
  end,
  MainUI_Group_Common_Btn_Fight_Click = function(btn, str)
    Controller.Battle()
  end,
  MainUI_Group_Resources_Group_Energy_Btn_ResourceEnergy_Click = function(btn, str)
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local homeCommon = require("Common/HomeCommon")
    local t = {}
    t.refreshTime = PlayerData:GetUserInfo().move_energy_time
    t.maxValue = homeCommon.GetMaxHomeEnergy()
    t.curValue = PlayerData:GetUserInfo().move_energy
    t.onceTime = homeConfig.homeEnergyAddCD
    t.onceAdd = homeConfig.homeEnergyAdd
    t.textId = 80600412
    CommonTips.OpenExplain(homeConfig.homeEnergyItemId, {x = 540, y = 290}, t)
  end,
  MainUI_Btn_Adv_Click = function(btn, str)
    Net:SendProto("adventure.adv_info", function(json)
      local levelCA = PlayerData:GetFactoryData(json.advId, "AdvLevelFactory")
      PlayerPrefs.SetString("MapName", levelCA.mapPath)
      AdvDataModel:Reset()
      AdvDataModel.digItem = json.digItem
      print_r("\230\140\150\230\142\152\230\149\176\230\141\174")
      print_r(DataModel.digItem)
      
      local function cb()
        CBus:ChangeScene("Endless")
      end
      
      CommonTips.OpenLoading(cb, "UI/Home/HomeLoading")
    end)
  end
}
return ViewFunction
