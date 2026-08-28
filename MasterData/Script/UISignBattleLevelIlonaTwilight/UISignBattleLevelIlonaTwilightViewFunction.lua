local CommonItem = require("Common/BtnItem")
local View = require("UISignBattleLevelIlonaTwilight/UISignBattleLevelIlonaTwilightView")
local Controller = require("UISignBattleLevelIlonaTwilight/UISignBattleLevelIlonaTwilightController")
local DataModel = require("UISignBattleLevelIlonaTwilight/UISignBattleLevelIlonaTwilightDataModel")
local ViewFunction = {
  SignBattleLevelIlonaTwilight_ScrollGrid_Map_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  SignBattleLevelIlonaTwilight_ScrollGrid_Map_Group_Level_Group_Level_Group_Current_Btn_Level_Click = function(btn, str)
    Controller:OpenRightPage(tonumber(str))
  end,
  SignBattleLevelIlonaTwilight_Btn_Gacha_Click = function(btn, str)
    local t = {}
    t.poolId = DataModel.activityCA.signBattleExtract
    UIManager:Open("UI/Gacha/GachaNew", Json.encode(t))
  end,
  SignBattleLevelIlonaTwilight_Group_SpLevelDetails_Btn_Close_Click = function(btn, str)
    Controller:CloseChoose()
  end,
  SignBattleLevelIlonaTwilight_Group_SpLevelDetails_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local row = DataModel.dropList[elementIndex]
    element.Group_Item.Btn_Item:SetClickParam(row.id)
    element.Group_First.self:SetActive(false)
    element.Group_Allready.self:SetActive(false)
    if row.type == 1 then
      element.Group_First.self:SetActive(true)
      if row.isFinish == true then
        element.Group_Allready.self:SetActive(true)
      end
    end
    CommonItem:SetItem(element.Group_Item, row)
  end,
  SignBattleLevelIlonaTwilight_Group_SpLevelDetails_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  SignBattleLevelIlonaTwilight_Group_SpLevelDetails_Btn_Fight_Click = function(btn, str)
    Controller:TryBattle()
  end,
  SignBattleLevelIlonaTwilight_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if DataModel.initParams.isBattleReturn then
      if DataModel.mainActivityId then
        UIManager:Open("UI/Activity/ActivityMain", Json.encode({
          id = DataModel.mainActivityId,
          backToHome = true
        }))
      else
        UIManager:Open("UI/Activity/ActivityMain", Json.encode({
          id = DataModel.activityCA.id,
          backToHome = true
        }))
      end
    else
      UIManager:GoBack()
    end
  end,
  SignBattleLevelIlonaTwilight_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    Controller:CloseChoose()
    UIManager:GoHome()
  end,
  SignBattleLevelIlonaTwilight_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  SignBattleLevelIlonaTwilight_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
