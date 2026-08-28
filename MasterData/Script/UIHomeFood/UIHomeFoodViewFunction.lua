local View = require("UIHomeFood/UIHomeFoodView")
local DataModel = require("UIHomeFood/UIHomeFoodDataModel")
local Controller = require("UIHomeFood/UIHomeFoodController")
local ViewFunction = {
  HomeFood_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  HomeFood_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  HomeFood_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    UIManager:Open("UI/Common/Group_Help", Json.encode({helpId = 80301501}))
  end,
  HomeFood_ScrollGrid_FoodList_SetGrid = function(element, elementIndex)
    local info = DataModel.foodList[elementIndex]
    element.Img_Picked:SetActive(elementIndex == Controller.curDetailIdx)
    element.Btn_Food:SetClickParam(elementIndex)
    local isFree = info.free == true
    local energyShow = info.ca.energy + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseBentoEnergy)
    local nodeFree = element.Node_Free
    local nodeLove = element.Node_LoveBento
    nodeFree.self:SetActive(isFree)
    nodeLove.self:SetActive(not isFree)
    if isFree then
      nodeFree.Txt_FoodName:SetText(info.ca.name)
      nodeFree.Img_Food:SetSprite(info.ca.foodImagePath)
      local used = info.used
      local isArrive = Controller:IsArrive(elementIndex)
      nodeFree.Img_UsedMask:SetActive(used or not isArrive)
      local groupTire = nodeFree.Group_Tire
      groupTire.self:SetActive(not used and isArrive)
      element.Node_Free.Txt_FoodName:SetActive(not used and isArrive)
      if not used then
        groupTire.Txt_Energy:SetText(string.format(GetText(80600347), -energyShow))
      end
      nodeFree.Txt_Time:SetText(string.format(GetText(80600346), string.sub(info.refreshTime, 1, 5)))
    else
      nodeLove.Txt_FoodName:SetText(info.ca.name)
      nodeLove.Img_Food:SetSprite(info.ca.foodImagePath)
      local isClicked = PlayerData:GetLoveBentoClicked(info.uid)
      nodeLove.Img_NewIcon:SetActive(not isClicked)
      local heroCA = PlayerData:GetFactoryData(info.hid, "UnitFactory")
      nodeLove.Txt_Name:SetText(heroCA.name)
      local remainTime = info.dueTime - TimeUtil:GetServerTimeStamp()
      nodeLove.Img_Time.Txt_Days:SetText(math.ceil(remainTime / 86400))
      local isEaten = PlayerData.ServerData.user_home_info.meal_info.meal_eaten[tostring(info.id)] ~= nil
      nodeLove.Group_TireLocked.Txt_Energy:SetText(string.format("%s", isEaten and -energyShow or "-?"))
    end
  end,
  HomeFood_ScrollGrid_FoodList_Group_Item_Btn_Food_Click = function(btn, str)
    local idx = tonumber(str)
    local info = DataModel.foodList[idx]
    if info == nil then
      return
    end
    if not info.free then
      local uid = info.uid
      if not PlayerData:GetLoveBentoClicked(uid) then
        PlayerData:SetLoveBentoClicked(uid, true)
      end
    end
    Controller:ShowFoodDetail(idx)
  end,
  HomeFood_Img_TireBG_Btn_MoveEnergy_Click = function(btn, str)
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local homeCommon = require("Common/HomeCommon")
    local t = {}
    t.refreshTime = PlayerData:GetUserInfo().move_energy_time
    t.minValue = 0
    t.curValue = PlayerData:GetUserInfo().move_energy
    t.onceTime = homeConfig.homeEnergyAddCD
    t.onceAdd = -homeConfig.homeEnergyAdd
    t.textId = 80600412
    CommonTips.OpenExplain(homeConfig.homeEnergyItemId, {x = 638, y = 290}, t)
  end,
  HomeFood_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeFood_Group_Description_Group_LoveBento_Btn_Tip_Click = function(btn, str)
    local imgTip = View.Group_Description.Group_LoveBento.Btn_Tip.Img_Tip
    imgTip.self:SetActive(true)
    imgTip.Txt_Title:SetText(GetText(80601205))
    imgTip.Txt_Content:SetText(GetText(80601206))
  end,
  HomeFood_Group_Description_Btn_Use_Click = function(btn, str)
    local idx = tonumber(str)
    local info = DataModel.foodList[idx]
    Controller:UseFood(idx, info.free and idx - 1 or -1)
  end,
  HomeFood_Group_Description_Group_LoveBento_Btn_Tip_Img_Tip_Btn_TipMask_Click = function(btn, str)
    View.Group_Description.Group_LoveBento.Btn_Tip.Img_Tip.self:SetActive(false)
  end,
  HomeFood_Group_Description_Btn_UseAll_Click = function(btn, str)
    Controller:UseAllFood()
  end,
  HomeFood_Group_Transfer_Btn_Get_Click = function(btn, str)
    Controller:ClickRewards()
  end,
  HomeFood_Group_Description_Btn_UseLoveBento_Click = function(btn, str)
    local idx = tonumber(str)
    local info = DataModel.foodList[idx]
    Controller:UseFood(idx, info.free and idx - 1 or -1)
  end,
  HomeFood_Group_Description_Btn_UseAllLoveBento_Click = function(btn, str)
    Controller:UseAllFood()
  end,
  HomeFood_ScrollGrid_FoodList_Group_Item_Node_LoveBento_Click = function(btn, str)
  end,
  HomeFood_ScrollGrid_FoodList_Group_Item_Btn_LoveBento_Click = function(btn, str)
  end,
  HomeFood_Img_LoveBento_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end
}
return ViewFunction
