local View = require("UIInvestCenter/UIInvestCenterView")
local DataModel = require("UIInvestCenter/UIInvestCenterDataModel")
local Controller = require("UIInvestCenter/UIInvestCenterController")
local ViewFunction = {
  InvestCenter_Group_Main_Group_Btn_Btn_GoodsTrade_Click = function(btn, str)
    Controller:OpenGoodsTrade()
  end,
  InvestCenter_Group_Main_Group_Btn_Btn_GoodsInvest_Click = function(btn, str)
    Controller:OpenGoodsInvest()
  end,
  InvestCenter_Group_Main_Group_Btn_Btn_Talk_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  InvestCenter_Group_GoodsTrade_Group_In_ScrollGrid__SetGrid = function(element, elementIndex)
    Controller:RefreshInElement(element, elementIndex)
  end,
  InvestCenter_Group_GoodsTrade_Group_In_Btn_detail_Click = function(btn, str)
    Controller:OpenGoodsTradeMission(true)
  end,
  InvestCenter_Group_GoodsTrade_Group_Out_ScrollGrid__SetGrid = function(element, elementIndex)
    Controller:RefreshOutElement(element, elementIndex)
  end,
  InvestCenter_Group_GoodsTrade_Group_Out_Btn_detail_Click = function(btn, str)
    Controller:OpenGoodsTradeMission(false)
  end,
  InvestCenter_Group_spItem_ScrollGrid__SetGrid = function(element, elementIndex)
    Controller:RefreshSpItemElement(element, elementIndex)
  end,
  InvestCenter_Group_spItem_ScrollGrid__Group_Item_Btn_Item_Click = function(btn, str)
    Controller:OnSpItemClick(str)
  end,
  InvestCenter_Group_spItem_ScrollGrid__Group_Item_Group_NoMax_Btn__Click = function(btn, str)
    Controller:OnSpItemUpgrade(str)
  end,
  InvestCenter_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Controller:OnReturnClick()
  end,
  InvestCenter_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  InvestCenter_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  InvestCenter_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  InvestCenter_Group_Trade_Group_Help_Btn_icon_Click = function(btn, str)
  end,
  InvestCenter_Group_Trade_Group_TradeLv_Btn_Tips_Click = function(btn, str)
  end,
  InvestCenter_Group_Trade_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  InvestCenter_Group_Trade_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  InvestCenter_Group_Trade_Group_Energy_Btn_Add_Click = function(btn, str)
  end,
  InvestCenter_Group_Trade_Group_Energy_Btn_Icon_Click = function(btn, str)
  end,
  InvestCenter_Group_GoodsTradeMission_Btn_BG_Click = function(btn, str)
    Controller:CloseGoodsTradeMission()
  end,
  InvestCenter_Group_GoodsTradeMission_Group_In_ScrollGrid__SetGrid = function(element, elementIndex)
    Controller:RefreshInMissionElement(element, elementIndex)
  end,
  InvestCenter_Group_GoodsTradeMission_Group_In_ScrollGrid__Group_Item_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    Controller:RefreshInMissionGoodsElement(element, elementIndex)
  end,
  InvestCenter_Group_GoodsTradeMission_Group_In_ScrollGrid__Group_Item_ScrollGrid_Item_Group_Item_Btn_detail_Click = function(btn, str)
    CommonTips.OpenGoodsTips(tonumber(str))
  end,
  InvestCenter_Group_GoodsTradeMission_Group_Out_ScrollGrid__SetGrid = function(element, elementIndex)
    Controller:RefreshOutMissionElement(element, elementIndex)
  end,
  InvestCenter_Group_GoodsTradeMission_Group_Out_ScrollGrid__Group_Item_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    Controller:RefreshOutMissionGoodsElement(element, elementIndex)
  end,
  InvestCenter_Group_GoodsTradeMission_Group_Out_ScrollGrid__Group_Item_ScrollGrid_Item_Group_Item_Btn_detail_Click = function(btn, str)
    CommonTips.OpenGoodsTips(tonumber(str))
  end
}
return ViewFunction
