local View = require("UIUnlockedChoose/UIUnlockedChooseView")
local DataModel = require("UIUnlockedChoose/UIUnlockedChooseDataModel")
local ViewFunction = {
  UnlockedChoose_Btn_BG_Click = function(btn, str)
    UIManager:CloseTip()
  end,
  UnlockedChoose_Group_Balloon_Group_Choose1_Btn_Bg_Click = function(btn, str)
    DataModel.ClickElement(1)
  end,
  UnlockedChoose_Group_Balloon_Group_Choose2_Btn_Bg_Click = function(btn, str)
    DataModel.ClickElement(2)
  end,
  UnlockedChoose_Group_Balloon_Group_Choose3_Btn_Bg_Click = function(btn, str)
    DataModel.ClickElement(3)
  end,
  UnlockedChoose_Group_Balloon_Group_Choose4_Btn_Bg_Click = function(btn, str)
    DataModel.ClickElement(4)
  end,
  UnlockedChoose_Group_Balloon_Group_Choose5_Btn_Bg_Click = function(btn, str)
    DataModel.ClickElement(5)
  end,
  UnlockedChoose_Btn_Diamond_Click = function(btn, str)
    DataModel.OpenDiamondGetway()
  end,
  UnlockedChoose_Btn_Diamond_Btn_Add_Click = function(btn, str)
    DataModel.OpenDiamondGetway()
  end,
  UnlockedChoose_Btn_Money_Click = function(btn, str)
    DataModel.OpenMoneyGetway()
  end,
  UnlockedChoose_Btn_Money_Btn_Add_Click = function(btn, str)
    DataModel.OpenMoneyGetway()
  end
}
return ViewFunction
