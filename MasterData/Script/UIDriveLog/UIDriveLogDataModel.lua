local DataModel = {
  ReceptionistData = {},
  UnitViewId = nil,
  UnitViewIdIsSpine = nil,
  offsetX = 0,
  offsetY = 0,
  RoleId = nil,
  initParams = nil
}
local View = require("UIDriveLog/UIDriveLogView")
local PetInfoData = require("UIPetInfo/UIPetInfoDataModel")
local RubbishDataModel = require("UIHomeRubbish/UIHomeRubbishDataModel")
local goldenWeekDataModel = require("UIGoldenWeek/UIGoldenWeekDataModel")
local ChangePosterGirlDataModel = require("UIChangePosterGirl/UIChangePosterGirlDataModel")

local function UpdataData(self)
  local coach = PlayerData.ServerData.user_home_info.coach
  local furniture = PlayerData.ServerData.user_home_info.furniture
  local unit_waste = 0
  for k, v in pairs(coach) do
    local coach_cfg = PlayerData:GetFactoryData(v.id)
    unit_waste = coach_cfg.carriageRubbish
    DataModel.createRubbish = DataModel.createRubbish + unit_waste
    for k1, v1 in pairs(v.location) do
      local tempfurniture = furniture[tostring(v1.id)]
      if tempfurniture then
        local furCA = PlayerData:GetFactoryData(tempfurniture.id)
        local scoresWithAllBuff = PlayerData.GetFurScoreWithAllBuff(v1.id, furCA.bag)
        DataModel.comfortScore = DataModel.comfortScore + scoresWithAllBuff.comfort
        DataModel.foodScore = DataModel.foodScore + scoresWithAllBuff.food
        DataModel.petScore = DataModel.petScore + scoresWithAllBuff.pet
        DataModel.plantScore = DataModel.plantScore + scoresWithAllBuff.plant
        DataModel.clearScore = 999
        DataModel.entScore = DataModel.entScore + scoresWithAllBuff.play
        DataModel.fishScore = DataModel.fishScore + scoresWithAllBuff.fish
        DataModel.medicalScore = DataModel.medicalScore + scoresWithAllBuff.medical
        DataModel.bedNum = DataModel.bedNum + (furCA.characterNum or 0)
        DataModel.createGold = DataModel.createGold + (furCA.yinuooutput or 0)
        DataModel.createRubbish = DataModel.createRubbish + RubbishDataModel.CalFurRubbishCnt(tempfurniture)
        if tempfurniture.space and tempfurniture.space.reward_ts then
          local totalGenerate = 0
          local totalTime = 0
          for i, v in ipairs(tempfurniture.space.creatures) do
            local create = PlayerData:GetFactoryData(v, "HomeCreatureFactory")
            totalGenerate = totalGenerate + create.rewards[1].num
            totalTime = totalTime + create.purifyTime
          end
          totalGenerate = totalGenerate * (1 - 0.1 * (#tempfurniture.space.creatures - 1)) / (totalTime / 3600)
          DataModel.createGland = DataModel.createGland + totalGenerate
        end
      end
    end
  end
  for k, v in pairs(PlayerData:GetHomeInfo().warehouse) do
    if PlayerData:GetFactoryData(k).mod == "\229\159\186\231\161\128\232\180\167\231\137\169" then
      DataModel.tradeGoodNum = DataModel.tradeGoodNum + v.num
    end
  end
  for i, v in pairs(PlayerData:GetHomeInfo().pet) do
    if v.u_fid and v.u_fid ~= "" then
      DataModel.petNum = DataModel.petNum + 1
    end
  end
  for k, v in pairs(PlayerData:GetRoles()) do
    DataModel.memberNum = DataModel.memberNum + 1
  end
end

local function Init(self)
  local homeInfo = PlayerData.ServerData.user_home_info
  DataModel.trainName = homeInfo.home_name ~= "" and homeInfo.home_name or PlayerData:GetFactoryData(99900014).defaultName
  DataModel.durability = homeInfo.readiness.repair.current_durable
  DataModel.totalDurability = PlayerData.GetCoachMaxDurability()
  DataModel.driverNum = TimeUtil:GetTimeStampTotalDays(PlayerData:GetSeverTime() - homeInfo.open_time)
  DataModel.trainLength = #homeInfo.coach
  DataModel.bedNum = 0
  DataModel.petNum = 0
  DataModel.tPNum = homeInfo.transport_passenger_num
  local disRatio = PlayerData:GetFactoryData(99900014).disRatio
  DataModel.mileageNum = math.floor((homeInfo.drive_distance or 0) * disRatio)
  DataModel.seatNum = PlayerData:GetMaxPassengerNum()
  DataModel.memberNum = 0
  DataModel.gPNume = homeInfo.transport_goods_num
  DataModel.tradeGoodNum = 0
  DataModel.electricLevel = homeInfo.electric_lv
  DataModel.maxSpeed = PlayerData.GetCoachMaxSpeed()
  DataModel.comfortScore = 0
  DataModel.foodScore = 0
  DataModel.petScore = 0
  DataModel.plantScore = 0
  DataModel.clearScore = 0
  DataModel.entScore = 0
  DataModel.fishScore = 0
  DataModel.medicalScore = 0
  DataModel.nowGoodsNum = PlayerData:GetUserInfo().space_info.now_train_goods_num or 0
  DataModel.totalGoods = PlayerData.GetMaxTrainGoodsNum()
  DataModel.nowRubbish = homeInfo.warehouse["82900012"] and homeInfo.warehouse["82900012"].num or 0
  DataModel.createGold = 0
  DataModel.createGland = 0
  DataModel.createRubbish = 0
  DataModel.deterrence = PlayerData:GetUserInfo().deterrence + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddDeterrence) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AddDeterrence, PlayerData:GetUserInfo().deterrence)
  DataModel.coloudness = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddColoudness) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AddColoudness, 0)
  UpdataData(self)
  local nowActivity = require("UIGroup_EventWeek/WeekActivityData").FindNowWeekActivity()
  DataModel.activityStart = next(nowActivity) ~= nil
  if DataModel.activityStart then
    local gradelList = require("UIGroup_EventWeek/WeekActivityData").GetGradelList(nowActivity)
    for i1, v1 in ipairs(gradelList) do
      local buffCfg = PlayerData:GetFactoryData(v1.id)
      if buffCfg.buffType == "endComfortGrade" then
        DataModel.comfortScore = MathEx.roundToDecimalPlaces(DataModel.comfortScore + DataModel.comfortScore * buffCfg.param, 1)
        DataModel.comfortColor = "#FFDA00"
      end
      if buffCfg.buffType == "endPlantGrade" then
        DataModel.plantScore = MathEx.roundToDecimalPlaces(DataModel.plantScore + DataModel.plantScore * buffCfg.param, 1)
        DataModel.plantColor = "#FFDA00"
      end
      if buffCfg.buffType == "endFishGrade" then
        DataModel.fishScore = MathEx.roundToDecimalPlaces(DataModel.fishScore + DataModel.fishScore * buffCfg.param, 1)
        DataModel.fishColor = "#FFDA00"
      end
      if buffCfg.buffType == "endPetGrade" then
        DataModel.petScore = MathEx.roundToDecimalPlaces(DataModel.petScore + DataModel.petScore * buffCfg.param, 1)
        DataModel.petColor = "#FFDA00"
      end
      if buffCfg.buffType == "endFoodGrade" then
        DataModel.foodScore = MathEx.roundToDecimalPlaces(DataModel.foodScore + DataModel.foodScore * buffCfg.param, 1)
        DataModel.foodColor = "#FFDA00"
      end
      if buffCfg.buffType == "endPlayGrade" then
        DataModel.entScore = MathEx.roundToDecimalPlaces(DataModel.entScore + DataModel.entScore * buffCfg.param, 1)
        DataModel.entColor = "#FFDA00"
      end
      if buffCfg.buffType == "enMedicalGrade" then
        DataModel.medicalScore = MathEx.roundToDecimalPlaces(DataModel.medicalScore + DataModel.medicalScore * buffCfg.param, 1)
        DataModel.medicalColor = "#FFDA00"
      end
    end
  end
end

function DataModel.LoadSpineBg()
  local roleId = PlayerData.ServerData.user_info.adjutant_id[1]
  local viewId = DataModel.UnitViewId
  local unitViewIdIsSpine = DataModel.UnitViewIdIsSpine
  local showSpineBg = ChangePosterGirlDataModel.GetBgState(viewId)
  local viewCA = DataModel.ReceptionistData
  if viewCA.SpineBackground == "" or unitViewIdIsSpine == 1 then
    showSpineBg = false
  end
  if showSpineBg == false then
    View.Img_SpineBG:SetActive(false)
    return
  end
  if roleId then
    local live2D = ChangePosterGirlDataModel.IsLive2D(DataModel.UnitViewId, DataModel.UnitViewIdIsSpine)
    if live2D and viewCA.SpineBackground and viewCA.SpineBackground ~= "" then
      showSpineBg = true
      View.Img_SpineBG:SetSprite(viewCA.SpineBackground)
      DataModel.offsetX = viewCA.SpineBGX and viewCA.SpineBGX or 0
      DataModel.offsetY = viewCA.SpineBGY and viewCA.SpineBGY or 0
      local x = View.Group_PosterGirl.Spine_.transform.localPosition.x - DataModel.offsetX
      View.Img_SpineBG.transform.localPosition = Vector3(x, DataModel.offsetY, 0)
      local scale = viewCA.SpineBGScale or 1
      View.Img_SpineBG.transform.localScale = Vector3(scale, scale, 0)
    end
  end
  View.Img_SpineBG:SetActive(showSpineBg)
end

function DataModel.SpineBgFollow()
  if View.Img_SpineBG.IsActive then
    local x = View.Group_PosterGirl.Spine_.transform.localPosition.x - DataModel.offsetX
    local pos = Vector3(x, DataModel.offsetY, 0)
    View.Img_SpineBG.transform.localPosition = pos
  end
end

function DataModel.RefreshPosterGirlFixEffect()
  local showFrontFixEffect = false
  local showBottomFixEffect = false
  local roleId = PlayerData.ServerData.user_info.adjutant_id[1]
  if roleId then
    local live2D = ChangePosterGirlDataModel.IsLive2D(DataModel.UnitViewId, DataModel.UnitViewIdIsSpine)
    if live2D and not DataModel.showSpine2 then
      DataModel.EffectState = ChangePosterGirlDataModel.GetEffectState(DataModel.UnitViewId)
      if DataModel.EffectState then
        local viewCA = DataModel.ReceptionistData
        local frontFixEffect = viewCA.frontFixEffectUrl
        if frontFixEffect and frontFixEffect ~= "" then
          showFrontFixEffect = true
          View.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetData(frontFixEffect, "effect_idle")
          View.self:StartC(LuaUtil.cs_generator(function()
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            View.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetActive(true)
          end))
        end
        local bottomFixEffectUrl = viewCA.bottomFixEffectUrl
        if bottomFixEffectUrl and bottomFixEffectUrl ~= "" then
          showBottomFixEffect = true
          View.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetData(bottomFixEffectUrl, "effect_idle")
          View.self:StartC(LuaUtil.cs_generator(function()
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            View.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetActive(true)
          end))
        end
      else
        View.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetActive(false)
        View.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetActive(false)
      end
    end
  end
  if not showFrontFixEffect then
    View.Group_PosterGirl.SpineAnimation_CharacterFrontIdleEffect:SetActive(false)
  end
  if not showBottomFixEffect then
    View.Group_PosterGirl.SpineAnimation_CharacterBottomIdleEffect:SetActive(false)
  end
end

DataModel.Init = Init
return DataModel
