local View = require("UIDriveLog/UIDriveLogView")
local DataModel = require("UIDriveLog/UIDriveLogDataModel")
local ViewFunction = require("UIDriveLog/UIDriveLogViewFunction")
local ChangePosterGirlDataModel = require("UIChangePosterGirl/UIChangePosterGirlDataModel")
local Luabehaviour = {
  serialize = function()
    return DataModel.initParams
  end,
  deserialize = function(initParams)
    DataModel.initParams = initParams
    DataModel:Init()
    local roleId = PlayerData.ServerData.user_info.adjutant_id[1]
    ChangePosterGirlDataModel.Scene = "Adjutant"
    local viewId = PlayerData:GetFactoryData(roleId, "UnitFactory").viewId
    if ChangePosterGirlDataModel.GetViewId(roleId) ~= 0 then
      viewId = ChangePosterGirlDataModel.GetViewId(roleId)
    end
    DataModel.RoleId = roleId
    DataModel.UnitViewId = viewId
    DataModel.UnitViewIdIsSpine = 0
    local live2D = ChangePosterGirlDataModel.IsLive2D(DataModel.UnitViewId, DataModel.UnitViewIdIsSpine)
    View.Img_SpineBG:SetActive(false)
    local receptionistData = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
    DataModel.ReceptionistData = receptionistData
    local gender = PlayerData:GetUserInfo().gender or 1
    View.Group_PosterGirl:SetActive(true)
    if live2D then
      View.Group_PosterGirl.Spine_:SetActive(true)
      View.Group_PosterGirl.Group_CharacterIMG:SetActive(false)
      local spineIndex = ChangePosterGirlDataModel.GetPosIndex(viewId)
      if 0 < spineIndex and spineIndex <= #receptionistData.extraSpineList then
        receptionistData = PlayerData:GetFactoryData(receptionistData.extraSpineList[spineIndex].id)
        DataModel.ReceptionistData = receptionistData
      end
      local spineUrl = receptionistData.spineUrl
      if gender == 0 and receptionistData.spineFemale ~= "" then
        spineUrl = receptionistData.spineFemale
      end
      View.Group_PosterGirl.Spine_:SetData(spineUrl, "idle")
      View.Group_PosterGirl.Spine_.transform.localPosition = Vector3(-370 + receptionistData.spineX, -1200 + receptionistData.spineY, 0)
    end
    local canvas = View.Btn_.Img_Bg1:GetComponent(typeof(CS.UnityEngine.Canvas))
    if initParams ~= nil then
      canvas.overrideSorting = false
    else
      canvas.overrideSorting = true
    end
    View.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalScale(Vector3(1, 1, 1))
    if not live2D then
      View.Group_PosterGirl:SetActive(true)
      View.Group_PosterGirl.Spine_:SetActive(false)
      View.Group_PosterGirl.Group_CharacterIMG:SetActive(true)
      DataModel.SkinBgState = ChangePosterGirlDataModel.GetBgState(DataModel.UnitViewId)
      if DataModel.SkinBgState then
        local resPath = receptionistData.resUrl
        if gender == 0 and receptionistData.pngFemale ~= "" then
          resPath = receptionistData.pngFemale
        end
        View.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetSprite(resPath)
      else
        local resPath = receptionistData.resUrl
        if gender == 0 then
          if receptionistData.singleFemale ~= "" then
            resPath = receptionistData.singleFemale
          elseif receptionistData.pngFemale ~= "" then
            resPath = receptionistData.pngFemale
          end
        elseif receptionistData.singleUrl ~= "" then
          resPath = receptionistData.singleUrl
        end
        View.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetSprite(resPath)
      end
      View.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalPosition(Vector3(-370 + receptionistData.offsetX, receptionistData.offsetY, 0))
      View.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalScale(Vector3(receptionistData.offsetScale, receptionistData.offsetScale, receptionistData.offsetScale))
    end
    View.Group_TrainInfo.ScrollView_:SetVerticalNormalizedPosition(1)
    local item1 = View.Group_TrainInfo.ScrollView_.Viewport.Content.Img_Bg1
    item1.Img_TrainName.Txt_1.Txt_2:SetText(DataModel.trainName)
    item1.Img_Durability.Txt_1.Txt_2:SetText(DataModel.durability .. "/" .. DataModel.totalDurability)
    item1.Group_Left.Group_Days.Txt_2:SetText(string.format(GetText(80600997), DataModel.driverNum))
    item1.Group_Left.Group_CarriageNum.Txt_2:SetText(string.format(GetText(80600999), DataModel.trainLength))
    item1.Group_Left.Group_BedNum.Txt_2:SetText(string.format(GetText(80601000), DataModel.bedNum))
    item1.Group_Left.Group_PetNum.Txt_2:SetText(string.format(GetText(80601002), DataModel.petNum))
    item1.Group_Left.Group_TotalCustomerNum.Txt_2:SetText(string.format(GetText(80601004), DataModel.tPNum))
    item1.Group_Right.Group_TotalMileage.Txt_2:SetText(string.format(GetText(80600998), DataModel.mileageNum))
    item1.Group_Right.Group_SeatNum.Txt_2:SetText(string.format(GetText(80601000), DataModel.seatNum))
    item1.Group_Right.Group_CharacterNum.Txt_2:SetText(string.format(GetText(80601001), DataModel.memberNum))
    item1.Group_Right.Group_TotalShipmentNum.Txt_2:SetText(string.format(GetText(80601003), DataModel.gPNume))
    item1.Group_Right.Group_GoodNum.Txt_2:SetText(string.format(GetText(80601003), DataModel.tradeGoodNum))
    local item2 = View.Group_TrainInfo.ScrollView_.Viewport.Content.Img_Bg2
    item2.Group_Left.Group_Days.Txt_2:SetText(DataModel.electricLevel)
    item2.Group_Right.Group_TotalMileage.Txt_2:SetText(string.format(GetText(80600409), DataModel.maxSpeed))
    local item3 = View.Group_TrainInfo.ScrollView_.Viewport.Content.Img_Bg3
    item3.Group_Left.Group_Comfortable.Txt_2:SetText(ClearFollowZero(DataModel.comfortScore))
    item3.Group_Left.Group_Comfortable.Txt_2:SetColor(DataModel.comfortColor or "FFFFFF")
    item3.Group_Left.Group_Delicous.Txt_2:SetText(ClearFollowZero(DataModel.foodScore))
    item3.Group_Left.Group_Delicous.Txt_2:SetColor(DataModel.foodColor or "FFFFFF")
    item3.Group_Left.Group_Pet.Txt_2:SetText(ClearFollowZero(DataModel.petScore))
    item3.Group_Left.Group_Pet.Txt_2:SetColor(DataModel.petColor or "FFFFFF")
    item3.Group_Left.Group_Plant.Txt_2:SetText(ClearFollowZero(DataModel.plantScore))
    item3.Group_Left.Group_Plant.Txt_2:SetColor(DataModel.plantColor or "FFFFFF")
    item3.Group_Right.Group_Clean.Txt_2:SetText(DataModel.clearScore)
    item3.Group_Right.Group_Clean.Txt_2:SetColor(DataModel.clearColor or "FFFFFF")
    item3.Group_Right.Group_Happiness.Txt_2:SetText(ClearFollowZero(DataModel.entScore))
    item3.Group_Right.Group_Happiness.Txt_2:SetColor(DataModel.entColor or "FFFFFF")
    item3.Group_Right.Group_Fish.Txt_2:SetText(ClearFollowZero(DataModel.fishScore))
    item3.Group_Right.Group_Fish.Txt_2:SetColor(DataModel.fishColor or "FFFFFF")
    item3.Group_Right.Group_Medical.Txt_2:SetText(ClearFollowZero(DataModel.medicalScore))
    item3.Group_Right.Group_Medical.Txt_2:SetColor(DataModel.medicalColor or "FFFFFF")
    local item4 = View.Group_TrainInfo.ScrollView_.Viewport.Content.Img_Bg4
    item4.Group_CurrentLoad.Img_BarBot.Img_BarTop:SetFilledImgAmount(DataModel.nowGoodsNum / DataModel.totalGoods)
    item4.Group_CurrentLoad.Txt_2:SetText(DataModel.nowGoodsNum .. "/" .. DataModel.totalGoods)
    item4.Group_CurrtentTrash.Txt_2:SetText(DataModel.nowRubbish)
    local item5 = View.Group_TrainInfo.ScrollView_.Viewport.Content.Img_Bg5
    item5.Group_GoldOutput.Txt_2:SetText(string.format(GetText(80601006), DataModel.createGold))
    item5.Group_CurrentLoad.Txt_2:SetText(string.format(GetText(80601006), DataModel.createGland))
    item5.Group_CurrtentTrash.Txt_2:SetText(string.format(GetText(80601007), DataModel.createRubbish))
    local item6 = View.Group_TrainInfo.ScrollView_.Viewport.Content.Img_Bg6
    item6.Group_Deterrence.Txt_Num:SetText(DataModel.deterrence)
    item6.Group_Coloudness.Txt_Num:SetText(DataModel.coloudness)
    local cfg = PlayerData:GetFactoryData(99900073, "ConfigFactory")
    View.Group_TrainInfo.ScrollView_.Viewport.Content.Img_Bg7:SetActive(cfg.showOpen)
    Net:SendProto("main.overview", function(json)
      DataModel.nowRubbish = json.waste_block
      DataModel.clearScore = json.current_clean or 1
      item3.Group_Right.Group_Clean.Txt_2:SetText(math.floor(DataModel.clearScore * 100) .. "%")
      item4.Group_CurrtentTrash.Txt_2:SetText(DataModel.nowRubbish)
    end)
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local scaleOneDaySecond = 86400 / homeConfig.dayScale
    local scaleTimeToday = (TimeUtil:GetServerTimeStamp() + PlayerData.TimeZone * 3600) % scaleOneDaySecond
    local mainUIConfig = PlayerData:GetFactoryData(99900034, "ConfigFactory")
    local todayZeroTimeStamp = scaleTimeToday / scaleOneDaySecond * 86400
    local idx = 0
    for k, v in pairs(mainUIConfig.bgList) do
      local h = tonumber(string.sub(v.changeTime, 1, 2))
      local m = tonumber(string.sub(v.changeTime, 4, 5))
      local s = tonumber(string.sub(v.changeTime, 7, 8))
      local checkTimeStamp = h * 3600 + m * 60 + s
      if todayZeroTimeStamp < checkTimeStamp then
        idx = k
        break
      end
    end
    idx = idx - 1
    if idx <= 0 then
      idx = #mainUIConfig.bgList
    end
    View.Btn_.Img_Bg1:SetSprite(mainUIConfig.bgList[idx].bgPath)
    DataModel.LoadSpineBg()
    DataModel.RefreshPosterGirlFixEffect()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    DataModel.SpineBgFollow()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
