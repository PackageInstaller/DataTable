local View = require("UIChildLevel/UIChildLevelView")
local DataModel = require("UIChildLevel/UIChildLevelDataModel")
local Controller = require("UIChildLevel/UIChildLevelController")
local ViewFunction = {
  ChildLevel_Btn_Close_Click = function(btn, str)
    Controller:CancelLevelClick()
  end,
  ChildLevel_Group_BG_Group_1_ScrollView__Viewport_Content_Group_Level1_Btn_Level_Click = function(btn, str)
    Controller:ClickLevelBtn(str)
  end,
  ChildLevel_Group_BG_Group_1_ScrollView__Viewport_Content_Group_Level2_Btn_Level_Click = function(btn, str)
    Controller:ClickLevelBtn(str)
  end,
  ChildLevel_Group_BG_Group_1_ScrollView__Viewport_Content_Group_Level3_Btn_Level_Click = function(btn, str)
    Controller:ClickLevelBtn(str)
  end,
  ChildLevel_Group_BG_Group_1_ScrollView__Viewport_Content_Group_Level4_Btn_Level_Click = function(btn, str)
    Controller:ClickLevelBtn(str)
  end,
  ChildLevel_Group_BG_Group_1_ScrollView__Viewport_Content_Group_Level5_Btn_Level_Click = function(btn, str)
    Controller:ClickLevelBtn(str)
  end,
  ChildLevel_Group_BG_Group_1_ScrollView__Viewport_Content_Group_Level6_Btn_Level_Click = function(btn, str)
    Controller:ClickLevelBtn(str)
  end,
  ChildLevel_Group_BG_Group_1_ScrollView__Viewport_Content_Group_Level7_Btn_Level_Click = function(btn, str)
    Controller:ClickLevelBtn(str)
  end,
  ChildLevel_Group_BG_Group_1_ScrollView__Viewport_Content_Group_Level8_Btn_Level_Click = function(btn, str)
    Controller:ClickLevelBtn(str)
  end,
  ChildLevel_Group_LevelDetails_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:RefreshRewardElement(element, elementIndex)
  end,
  ChildLevel_Group_LevelDetails_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickRewardItem(str)
  end,
  ChildLevel_Group_LevelDetails_Group_Ding_Btn_Energy_Click = function(btn, str)
    Controller:ClickEnergy()
  end,
  ChildLevel_Group_LevelDetails_Group_Ding_Btn_Energy_Btn_Add_Click = function(btn, str)
    Controller:ClickEnergy()
  end,
  ChildLevel_Group_LevelDetails_Btn_Fight_Click = function(btn, str)
    Controller:ClickStartBattle()
  end,
  ChildLevel_Group_LevelDetails_Group_Auto_Btn_Auto_Click = function(btn, str)
    Controller:AutoBattleClick()
  end,
  ChildLevel_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Controller:Return()
  end,
  ChildLevel_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    Controller:Home()
  end,
  ChildLevel_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ChildLevel_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ChildLevel_Group_SpLevelDetails_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:RefreshRewardElement(element, elementIndex)
  end,
  ChildLevel_Group_SpLevelDetails_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickRewardItem(str)
  end,
  ChildLevel_Group_SpLevelDetails_Group_Ding_Btn_Energy_Click = function(btn, str)
    Controller:ClickEnergy()
  end,
  ChildLevel_Group_SpLevelDetails_Group_Ding_Btn_Energy_Btn_Add_Click = function(btn, str)
    Controller:ClickEnergy()
  end,
  ChildLevel_Group_SpLevelDetails_Btn_Fight_Click = function(btn, str)
    Controller:ClickStartBattle()
  end,
  ChildLevel_Group_SpLevelDetails_Group_Lock_Btn_Lock_Click = function(btn, str)
    Controller:LockDiffClick(not DataModel.isLockDiff)
  end,
  ChildLevel_Group_SpLevelDetails_Group_Auto_Btn_Auto_Click = function(btn, str)
  end
}
return ViewFunction
