local View = require("UIHomeFood/UIHomeFoodView")
local DataModel = require("UIHomeFood/UIHomeFoodDataModel")
local HomeController = require("UIHome/UIHomeController")
local MainUIController = require("UIMainUI/UIMainUIController")
local Controller = {}

function Controller:Init()
  self:RefreshMoveEnergy()
  View.ScrollGrid_FoodList.self:SetActive(true)
  View.ScrollGrid_FoodList.grid.self:SetDataCount(DataModel.mealCount)
  View.ScrollGrid_FoodList.grid.self:RefreshAllElement()
  self:ShowFoodDetail(1)
  self:InitRewards()
  if not DataModel.isOutside then
    HomeController.UpdateFoodBoxNum()
  end
end

function Controller:InitRewards()
  local ex_food = DataModel.ex_food or {}
  local num = 0
  for k, v in pairs(ex_food) do
    num = num + v
  end
  View.Group_Transfer.Txt_Num:SetText(num)
  View.Group_Transfer.Btn_Get.self:SetActive(0 < num)
end

function Controller:ClickRewards()
  Net:SendProto("meal.pet_food", function(json)
    CommonTips.OpenShowItem(json.reward)
    DataModel.ex_food = nil
    Controller:InitRewards()
  end)
end

function Controller:RefreshMoveEnergy()
  local homeCommon = require("Common/HomeCommon")
  local maxHomeEnergy = homeCommon.GetMaxHomeEnergy()
  View.Img_TireBG.Txt_Energy:SetText(string.format(GetText(80600345), DataModel.curHomeEnergy, maxHomeEnergy))
  View.Img_TireBG.Img_TireProgress:SetFilledImgAmount(DataModel.curHomeEnergy / maxHomeEnergy)
end

function Controller:UseFood(idx, freeIdx)
  if not DataModel.isOutside then
    local furList = HomeManager:GetFurnitureByCaId(81300015)
    if furList.Count <= 0 then
      DataModel.isOutside = true
    end
  end
  local info = DataModel.foodList[idx]
  local mealId = info.uid
  if freeIdx ~= -1 then
    mealId = ""
  end
  local checkTipParam = {}
  checkTipParam.isCheckTip = true
  checkTipParam.checkTipKey = "HomeFoodUseOne"
  checkTipParam.checkTipType = 1
  CommonTips.OnPrompt(string.format(GetText(80600341), info.ca.name), nil, nil, function()
    local curEnergy = PlayerData:GetUserInfo().move_energy
    if curEnergy ~= nil and curEnergy <= 0 then
      CommonTips.OpenTips(80600522)
      return
    end
    Net:SendProto("meal.eat", function(json)
      if freeIdx ~= -1 then
        table.insert(PlayerData.ServerData.user_home_info.meal_info.work_meal, freeIdx)
      else
        PlayerData.ServerData.user_home_info.meal_info.box_meal[info.uid] = nil
        local count = PlayerData.ServerData.user_home_info.meal_info.meal_eaten[info.id]
        if count == nil then
          PlayerData.ServerData.user_home_info.meal_info.meal_eaten[tostring(info.id)] = 1
        else
          PlayerData.ServerData.user_home_info.meal_info.meal_eaten[tostring(info.id)] = count + 1
        end
      end
      local lastHomeEnergy = DataModel.curHomeEnergy
      DataModel.curHomeEnergy = PlayerData:GetUserInfo().move_energy or 0
      DataModel.UseFood(idx)
      Controller:RefreshMoveEnergy()
      View.ScrollGrid_FoodList.grid.self:SetDataCount(DataModel.mealCount)
      if DataModel.foodList[idx] == nil then
        self:ShowFoodDetail(1)
      else
        self:ShowFoodDetail(idx)
      end
      CommonTips.OpenTips(80601105)
      if not DataModel.isOutside then
        HomeController.UpdateFoodBoxNum()
      end
      local specialHid = PlayerData.ServerData.user_home_info.meal_info.meal_hid
      local hid = -1
      if specialHid ~= nil and specialHid ~= "" and info.hid == tonumber(specialHid) then
        local unitCA = PlayerData:GetFactoryData(specialHid, "UnitFactory")
        if unitCA == nil then
          error("\229\141\149\228\189\141id:" .. specialHid .. "\228\184\141\229\173\152\229\156\168\230\156\172\229\156\176\233\133\141\231\189\174\232\161\168,\232\175\183\230\163\128\230\159\165\233\133\141\231\189\174")
        end
        hid = unitCA.homeCharacter
        CharacterUtil.StopOp(specialHid)
        PlayerData.ServerData.user_home_info.meal_info.meal_hid = nil
      end
      self.PlayFoodAnim(hid, info, lastHomeEnergy)
    end, mealId, freeIdx)
  end, nil, nil, nil, nil, checkTipParam)
end

function Controller:ShowFoodDetail(idx)
  local group = View.Group_Description
  local info = DataModel.foodList[idx]
  local ca = info.ca
  group.Txt_Name:SetText(info.ca.name)
  local isFree = info.free == true
  group.Btn_Use.self:SetActive(isFree)
  group.Img_Used.self:SetActive(isFree)
  group.Btn_UseAll.self:SetActive(isFree)
  group.Btn_UseLoveBento.self:SetActive(not isFree)
  group.Btn_UseAllLoveBento.self:SetActive(not isFree)
  local BtnUse = isFree and group.Btn_Use or group.Btn_UseLoveBento
  local imgUse = group.Img_Used
  group.Group_FreeOrder:SetActive(isFree)
  group.Group_LoveBento:SetActive(not isFree)
  local date
  local curTime = PlayerData:GetSeverTime()
  if not info.used and curTime < TimeUtil:GetFutureTime(0, 5) then
    date = os.date("*t", curTime - 86400)
  else
    date = os.date("*t", curTime)
  end
  View.Img_Top.Txt_Date:SetText(string.format(GetText(80601198), date.month, date.day))
  local riseBentoEnergy = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseBentoEnergy)
  if isFree then
    local freeGroup = group.Group_FreeOrder
    local used = info.used
    local isArrive = self:IsArrive(idx)
    BtnUse:SetActive(not used and isArrive)
    imgUse.self:SetActive(used)
    if used or not isArrive then
      self:UpdateGroupTime(idx)
    else
    end
    freeGroup.Txt_Des:SetText(ca.des)
  else
    local loveGroup = group.Group_LoveBento
    local heroCA = PlayerData:GetFactoryData(info.hid, "UnitFactory")
    loveGroup.Txt_Subtitle:SetText(string.format(GetText(80601217), heroCA.name))
    local isEaten = PlayerData.ServerData.user_home_info.meal_info.meal_eaten[tostring(info.id)] ~= nil
    loveGroup.Group_Tire.Txt_Energy:SetText(isEaten and -(ca.energy + riseBentoEnergy) or "-?")
    local letterBG = loveGroup.Img_LetterBG
    letterBG.Img_PicBg.Img_Avatar:SetSprite(PlayerData:GetFactoryData(heroCA.skinList[1].unitViewId).face)
    letterBG.Txt_Content:SetText(heroCA.FoodList[1].letter)
    letterBG.Txt_Name:SetText(heroCA.name)
    BtnUse:SetActive(true)
  end
  BtnUse:SetClickParam(idx)
  self.lastDetailIdx = self.curDetailIdx
  self.curDetailIdx = idx
  View.ScrollGrid_FoodList.grid.self:RefreshAllElement()
end

function Controller:UpdateGroupTime(idx)
  local info = DataModel.foodList[idx]
  if info.free and (info.used or not self:IsArrive(idx)) then
    local nextTime = self:GetRefreshStampByIndex(idx)
    local timeTable = TimeUtil:SecondToTable(nextTime - TimeUtil:GetServerTimeStamp())
  end
end

function Controller:GetRefreshStampByIndex(idx)
  local info = DataModel.foodList[idx]
  local refreshTime = info.refreshTime
  local h = tonumber(string.sub(refreshTime, 1, 2))
  local m = tonumber(string.sub(refreshTime, 4, 5))
  local s = tonumber(string.sub(refreshTime, 7, 8))
  return TimeUtil:GetNextSpecialTimeStamp(h, m, s)
end

function Controller:IsArrive(idx)
  local info = DataModel.foodList[idx]
  return self:IsArriveByInfo(info)
end

function Controller:IsArriveByInfo(info)
  if not info.free then
    return true
  end
  if info.used then
    return true
  end
  local serverTime = TimeUtil:GetServerTimeStamp() + PlayerData.TimeZone * 3600
  local date = os.date("!*t", serverTime)
  if date.hour < 5 then
    return true
  end
  local refreshTime = info.refreshTime
  local h = tonumber(string.sub(refreshTime, 1, 2))
  local m = tonumber(string.sub(refreshTime, 4, 5))
  local s = tonumber(string.sub(refreshTime, 7, 8))
  if h < date.hour then
    return true
  end
  if h > date.hour then
    return false
  end
  if m < date.min then
    return true
  end
  if m > date.min then
    return false
  end
  if s < date.sec then
    return true
  end
  if s > date.sec then
    return false
  end
  return true
end

function Controller:DayRefresh()
  Net:SendProto("meal.info", function(json)
    local oldMealInfo = PlayerData:GetHomeInfo().meal_info
    local newMealInfo = json.meal_info
    if oldMealInfo and newMealInfo then
      local oldBoxMeal = oldMealInfo.box_meal or {}
      local newBoxMeal = newMealInfo.box_meal or {}
      for k, v in pairs(oldBoxMeal) do
        if newBoxMeal[k] == nil then
          PlayerData:ClearLoveBentoClicked(k)
        end
      end
    end
    PlayerData:GetHomeInfo().meal_info = json.meal_info
    DataModel.InitData()
    Controller:Init()
  end)
end

function Controller.PlayFoodAnim(heroId, info, lastHomeEnergy)
  local ca = info.ca
  MainUIController:HideAll(true)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local animList = homeConfig.playerEatAni
  local funcList = {}
  for i = #animList, 1, -1 do
    local cb
    if i == #animList then
      function cb()
        UIManager:ClosePanel(true, "UI/CityStore/StoreSkip")
        
        UIManager:Open("UI/HomeFurniture/HomeFoodSettlement", Json.encode({
          foodEnergy = ca.energy + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseBentoEnergy),
          curEnergy = DataModel.curHomeEnergy,
          lastHomeEnergy = lastHomeEnergy,
          hid = info.hid,
          mealId = info.uid,
          isOutside = DataModel.isOutside
        }))
      end
    elseif i == #animList - 1 then
      function cb()
        HomeManager:ShowEffect(true)
        
        funcList[i + 1]()
      end
    else
      cb = funcList[i + 1]
    end
    if DataModel.isOutside then
      cb()
      return
    end
    funcList[i] = function()
      HomeManager:PlayGenerAnim(animList[i].animation, cb)
    end
  end
  local homeCfg = PlayerData:GetFactoryData(99900014)
  local gender = PlayerData:GetUserInfo().gender == 1 and homeCfg.conductorM or homeCfg.conductorW
  HomeManager:SetFoodPath(homeConfig.eatPrefab)
  HomeManager:SetFastFoodCam(gender, tonumber(heroId))
  HomeManager:PlayGenerAnim(animList[1].animation, funcList[1])
  HomeManager:PlayTempAnim(homeConfig.memberEatAni)
  UIManager:Open("UI/CityStore/StoreSkip")
  local skipDataModel = require("UIStoreSkip/UIStoreSkipDataModel")
  skipDataModel:SetCallBack(function()
    HomeManager:PauseGenerAnim()
    HomeManager:PauseTempAnim()
    UIManager:Open("UI/HomeFurniture/HomeFoodSettlement", Json.encode({
      foodEnergy = ca.energy + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseBentoEnergy),
      curEnergy = DataModel.curHomeEnergy,
      lastHomeEnergy = lastHomeEnergy,
      hid = info.hid,
      mealId = info.uid,
      isOutside = DataModel.isOutside
    }))
  end)
end

function Controller.InitFoodCook()
  local uid = PlayerData:GetHomeInfo().meal_info and PlayerData:GetHomeInfo().meal_info.meal_hid
  if uid and uid ~= "" then
    local UINewHomeLiveDataModel = require("UINewHomeLive/UINewHomeLiveDataModel")
    if UINewHomeLiveDataModel.IsInEmergency(uid) or UINewHomeLiveDataModel.IsRoleLiveIn(uid) then
      return
    end
    for ufid, v in pairs(PlayerData:GetHomeInfo().furniture) do
      if tonumber(v.id) == 81300014 then
        CharacterUtil.InitOp(uid, ufid, 0, -1)
        local homeCharacter = CharacterUtil.GetHomeCharacterById(uid)
        if homeCharacter then
          local homeCharacterPos = homeCharacter.view.transform.position
          local pos = Vector3(homeCharacterPos.x, 0, homeCharacterPos.z + 1)
          homeCharacter.animePart:AddSpineEffectRes("Home/Cook/shaofan/ShaoFan", pos)
        end
        break
      end
    end
  end
end

function Controller:UseAllFood()
  local curEnergy = PlayerData:GetUserInfo().move_energy
  if curEnergy ~= nil and curEnergy <= 0 then
    CommonTips.OpenTips(80600522)
    return
  end
  local foodCount = #DataModel.foodList - 3
  for i = 1, 3 do
    if DataModel.foodList[i].used ~= true and self:IsArriveByInfo(DataModel.foodList[i]) then
      foodCount = foodCount + 1
    end
  end
  if foodCount <= 0 then
    CommonTips.OpenTips(80607564)
    return
  end
  local foodList = Clone(DataModel.foodList)
  local finalList = {}
  DataModel.SortByDueTime(foodList)
  local foodEnergy = 0
  for i = 1, #foodList do
    if curEnergy <= foodEnergy then
      break
    end
    if foodList[i].used ~= true and self:IsArriveByInfo(foodList[i]) then
      finalList[#finalList + 1] = foodList[i]
      foodEnergy = foodEnergy + foodList[i].ca.energy + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseBentoEnergy)
    end
  end
  local checkTipParam = {}
  checkTipParam.isCheckTip = true
  checkTipParam.checkTipKey = "HomeFoodUseAll"
  checkTipParam.checkTipType = 1
  CommonTips.OnPrompt(string.format(GetText(80607563), foodEnergy, curEnergy), nil, nil, function()
    Net:SendProto("meal.eat", function(json)
      for i = 1, #finalList do
        if finalList[i].free then
          table.insert(PlayerData.ServerData.user_home_info.meal_info.work_meal, i)
        else
          PlayerData.ServerData.user_home_info.meal_info.box_meal[finalList[i].uid] = nil
          local count = PlayerData.ServerData.user_home_info.meal_info.meal_eaten[finalList[i].id]
          if count == nil then
            PlayerData.ServerData.user_home_info.meal_info.meal_eaten[tostring(finalList[i].id)] = 1
          else
            PlayerData.ServerData.user_home_info.meal_info.meal_eaten[tostring(finalList[i].id)] = count + 1
          end
        end
        DataModel.UseFoodByInfo(finalList[i])
      end
      local lastHomeEnergy = DataModel.curHomeEnergy
      DataModel.curHomeEnergy = PlayerData:GetUserInfo().move_energy or 0
      Controller:RefreshMoveEnergy()
      View.ScrollGrid_FoodList.grid.self:SetDataCount(DataModel.mealCount)
      self:ShowFoodDetail(1)
      CommonTips.OpenTips(80601105)
      if not DataModel.isOutside then
        HomeController.UpdateFoodBoxNum()
      end
      UIManager:Open("UI/HomeFurniture/HomeFoodSettlement", Json.encode({
        foodEnergy = foodEnergy,
        curEnergy = DataModel.curHomeEnergy,
        lastHomeEnergy = lastHomeEnergy,
        isOutside = true
      }))
    end, -1, -1, 1)
  end, nil, nil, nil, nil, checkTipParam)
end

return Controller
