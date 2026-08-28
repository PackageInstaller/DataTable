local CommonItem = require("Common/BtnItem")
local View = require("UIBattle_EquipmentWeek/UIBattle_EquipmentWeekView")
local DataModel = require("UIBattle_EquipmentWeek/UIBattle_EquipmentWeekDataModel")
local Controller = require("UIBattle_EquipmentWeek/UIBattle_EquipmentWeekController")
local ViewFunction = {
  Battle_EquipmentWeek_Group_Level_StaticGrid_Level_SetGrid = function(element, elementIndex)
    Controller:SetElementDifficulty(element, elementIndex)
  end,
  Battle_EquipmentWeek_Group_Level_StaticGrid_Level_Group_Item_Btn_Selected_Click = function(btn, str)
    Controller:SelectDifficulty(tonumber(str))
  end,
  Battle_EquipmentWeek_Group_Level_Group_Item_Btn_Selected_Click = function(btn, str)
  end,
  Battle_EquipmentWeek_Group_Right_Group_Reward_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.LevelList[DataModel.LeftIndex]
    local rewardList = row.dropList
    CommonItem:SetItem(element.Group_Item, {
      id = rewardList[elementIndex].id,
      num = rewardList[elementIndex].num
    }, EnumDefine.ItemType.Item)
    element.Group_Item.Btn_Item:SetClickParam(rewardList[elementIndex].id)
  end,
  Battle_EquipmentWeek_Group_Right_Group_Reward_ScrollGrid_Item_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end,
  Battle_EquipmentWeek_Group_Right_Btn_Start_Click = function(btn, str)
    Controller:startBattle()
  end,
  Battle_EquipmentWeek_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if DataModel.initParams.isBattleReturn then
      if DataModel.activityId then
        UIManager:Open("UI/Activity/ActivityGlobalBattle/MaterialBattle", Json.encode({
          activityId = DataModel.activityId,
          battleLeftIndex = DataModel.battleLeftIndex
        }))
      else
        UIManager:Open("UI/StageQuest/StageQuest", Json.encode({
          titleIndex = DataModel.titleIndex,
          battleLeftIndex = DataModel.battleLeftIndex,
          isBattleReturn = true
        }))
      end
    else
      UIManager:GoBack()
    end
  end,
  Battle_EquipmentWeek_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Battle_EquipmentWeek_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Battle_EquipmentWeek_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Battle_EquipmentWeek_Group_Right_Group_Skip_Btn_Skip_Click = function(btn, str)
    Controller:ClickSkipWin()
  end,
  Battle_EquipmentWeek_Group_Right_Group_Skip_Btn_Start_Click = function(btn, str)
    Controller:startBattle()
  end,
  Battle_EquipmentWeek_Group_Right_Btn_Skip_Click = function(btn, str)
  end
}
return ViewFunction
