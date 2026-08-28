local View = require("UIMaterialBattle/UIMaterialBattleView")
local Controller = require("UIMaterialBattle/UIMaterialBattleController")
local DataModel = require("UIMaterialBattle/UIMaterialBattleDataModel")
local ViewFunction = {
  MaterialBattle_Group_Left_ScrollGrid_Left_SetGrid = function(element, elementIndex)
    Controller:SetBtnLabelGridElelment(element, elementIndex)
  end,
  MaterialBattle_Group_Left_ScrollGrid_Left_Group_Item_Btn_Label_Click = function(btn, str)
    if DataModel.BattleLeftIndex == tonumber(str) then
      return
    end
    Controller:ClickBattleLeftList(tonumber(str))
  end,
  MaterialBattle_Group_Right_Group_Material_Group_Level_ScrollGrid_Level_SetGrid = function(element, elementIndex)
    Controller:SetBattleLevelGridElelment(element, elementIndex)
  end,
  MaterialBattle_Group_Right_Group_Material_Group_Level_ScrollGrid_Level_Group_Item_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:SetRewardGridElelment(element, elementIndex)
  end,
  MaterialBattle_Group_Right_Group_Material_Group_Level_ScrollGrid_Level_Group_Item_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  MaterialBattle_Group_Right_Group_Material_Group_Level_ScrollGrid_Level_Group_Item_Btn_Enter_Click = function(btn, str)
    Controller:ClickEnterBattleBtn(str)
  end,
  MaterialBattle_Group_Right_Group_EquipmentDay_Group_Level_ScrollGrid_Level_SetGrid = function(element, elementIndex)
    Controller:SetBattleLevelGridElelment(element, elementIndex)
  end,
  MaterialBattle_Group_Right_Group_EquipmentDay_Group_Level_ScrollGrid_Level_Group_Item_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:SetRewardGridElelment(element, elementIndex)
  end,
  MaterialBattle_Group_Right_Group_EquipmentDay_Group_Level_ScrollGrid_Level_Group_Item_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  MaterialBattle_Group_Right_Group_EquipmentDay_Group_Level_ScrollGrid_Level_Group_Item_Btn_Enter_Click = function(btn, str)
    Controller:ClickEnterBattleBtn(str)
  end,
  MaterialBattle_Group_Right_Group_EquipmentWeek_Group_Level_ScrollGrid_Level_SetGrid = function(element, elementIndex)
    Controller:SetBattleLevelGridElelment(element, elementIndex)
  end,
  MaterialBattle_Group_Right_Group_EquipmentWeek_Group_Level_ScrollGrid_Level_Group_Item_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:SetRewardGridElelment(element, elementIndex)
  end,
  MaterialBattle_Group_Right_Group_EquipmentWeek_Group_Level_ScrollGrid_Level_Group_Item_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  MaterialBattle_Group_Right_Group_EquipmentWeek_Group_Level_ScrollGrid_Level_Group_Item_Btn_Enter_Click = function(btn, str)
    Controller:ClickEnterBattleBtn(str)
  end,
  MaterialBattle_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if DataModel.ActivityId then
      UIManager:Open("UI/Activity/ActivityMain", Json.encode({
        id = DataModel.ActivityId,
        backToHome = true
      }))
    else
      UIManager:GoHome()
    end
  end,
  MaterialBattle_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  MaterialBattle_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  MaterialBattle_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
