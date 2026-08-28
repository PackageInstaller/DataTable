local View = require("UIBarStore/UIBarStoreView")
local DataModel = require("UIBarStore/UIBarStoreDataModel")
local Controller = require("UIBarStore/UIBarStoreController")
local ViewFunction = {
  BarStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_Main.Group_Drink.self.IsActive then
      Controller:DrinkReturnToMain()
      return
    elseif View.Group_LocalStore.self.IsActive then
      Controller:StoreReturnToMain()
      return
    end
    if DataModel.IsCityMapIn then
      UIManager:Open("UI/CityMap/CityMap", Json.encode({
        stationId = DataModel.StationId
      }))
      return
    end
    UIManager:GoBack()
  end,
  BarStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  BarStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80303385}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  BarStore_Group_Main_Btn_Drink_Click = function(btn, str)
    Controller:OpenDrink()
  end,
  BarStore_Group_Main_Btn_Store_Click = function(btn, str)
    Controller:OpenStore()
  end,
  BarStore_Group_Main_Btn_Talk_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  BarStore_Group_Main_Group_Drink_Group_Energy_Btn_Energy_Click = function(btn, str)
  end,
  BarStore_Group_Main_Group_Drink_StaticGrid_Drink_SetGrid = function(element, elementIndex)
    return Controller:RefreshDrinkElement(element, elementIndex)
  end,
  BarStore_Group_Main_Group_Drink_StaticGrid_Drink_Group_Drink_Btn_Click_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:Drink(idx)
  end,
  BarStore_Group_LocalStore_Group_StoreList_ScrollGrid_Commodity_SetGrid = function(element, elementIndex)
    Controller:RefreshCommodityShow(element, elementIndex)
  end,
  BarStore_Group_LocalStore_Group_StoreList_ScrollGrid_Commodity_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickCommodity(btn, str)
  end,
  BarStore_Group_LocalStore_Group_StoreList_Btn_ShuaXin_Click = function(btn, str)
    Controller:RefreshShop()
  end,
  BarStore_Group_LocalStore_Group_Reputation_Btn_Reputation_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.ClickReputationBtn(DataModel.StationId, nil, nil, function()
      homeCommon.SetReputationElement(View.Group_LocalStore.Group_Reputation, DataModel.StationId)
    end)
  end,
  BarStore_Group_Main_Group_NpcInfo_Group_1_Btn_Tips_Click = function(btn, str)
    View.Group_Main.Group_NpcInfo.Group_Tips1.self:SetActive(true)
  end,
  BarStore_Group_Main_Group_NpcInfo_Group_Tips1_Btn_Close_Click = function(btn, str)
    View.Group_Main.Group_NpcInfo.Group_Tips1.self:SetActive(false)
  end,
  BarStore_Group_TishiWindow_Btn_Close_Click = function(btn, str)
    View.Group_TishiWindow.self:SetActive(false)
  end,
  BarStore_Group_TishiWindow_Txt_NoReminded_Btn_Check_Click = function(btn, str)
    local isActive = View.Group_TishiWindow.Txt_NoReminded.Btn_Check.Txt_Check.IsActive
    View.Group_TishiWindow.Txt_NoReminded.Btn_Check.Txt_Check:SetActive(not isActive)
  end,
  BarStore_Group_TishiWindow_Btn_Confirm_Click = function(btn, str)
    Controller:ConfirmReplaceBuff()
  end,
  BarStore_Group_TishiWindow_Btn_Cancel_Click = function(btn, str)
    View.Group_TishiWindow.self:SetActive(false)
  end,
  BarStore_Group_Buff_Btn_Close_Click = function(btn, str)
    View.Group_Buff.self:SetActive(false)
  end,
  BarStore_Video_Drink_Skip_Click = function(btn, str)
    UIManager:LoadSplitPrefab(View, "UI/Home/BarStore/BarStore", "Group_Skip")
    View.Group_Skip.self:SetActive(true)
  end,
  BarStore_Group_Skip_Btn_BG_Click = function(btn, str)
    Controller:CloseSkip()
  end,
  BarStore_Group_Skip_Btn_Confirm_Click = function(btn, str)
    Controller:VideoSkip()
  end,
  BarStore_Group_Skip_Btn_Cancel_Click = function(btn, str)
    Controller:CloseSkip()
  end,
  BarStore_Group_Skip_Group_Tip_Btn_Tip_Click = function(btn, str)
    local isSelect = View.Group_Skip.Group_Tip.Btn_Tip.Group_On.self.IsActive
    View.Group_Skip.Group_Tip.Btn_Tip.Group_On.self:SetActive(not isSelect)
  end,
  BarStore_Btn_Skip_Click = function(btn, str)
    local checkTime = PlayerData:GetPlayerPrefs("int", "ShowDrinkVideo")
    if 0 < checkTime then
      Controller:VideoSkip()
    else
      UIManager:LoadSplitPrefab(View, "UI/Home/BarStore/BarStore", "Group_Skip")
      View.Group_Skip.self:SetActive(true)
    end
  end,
  BarStore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  BarStore_Group_LocalStore_Group_StoreList_Group_Tab_Group_Headquarters_Btn__Click = function(btn, str)
    Controller:ChooseTab(1)
  end,
  BarStore_Group_LocalStore_Group_StoreList_Group_Tab_Group_Local_Btn__Click = function(btn, str)
    Controller:ChooseTab(2)
  end,
  BarStore_Group_LocalStore_Group_Ding_StaticGrid_Coin_SetGrid = function(element, elementIndex)
    Controller:RefreshResourceElement(element, elementIndex)
  end,
  BarStore_Group_LocalStore_Group_Ding_StaticGrid_Coin_Group_Coin_Btn_GoldCoin_Click = function(btn, str)
    Controller:ClickResourceElement(str)
  end,
  BarStore_Group_LocalStore_Group_Ding_StaticGrid_Coin_Group_Coin_Group_Num_Btn_Add_Click = function(btn, str)
    Controller:ClickResourceElement(str)
  end,
  BarStore_Group_LocalStore_Group_StoreList_Btn_PL_Click = function(btn, str)
    Controller:ClickBatchBtn()
  end,
  BarStore_Group_LocalStore_Group_StoreList_Group_PL_Group_SelectAll_Btn__Click = function(btn, str)
    Controller:ClickBatchAll()
  end,
  BarStore_Group_LocalStore_Group_StoreList_Group_PL_Btn_Buy_Click = function(btn, str)
    Controller:ConfirmBatchBuy()
  end,
  BarStore_Group_LocalStore_Group_StoreList_Group_Time_Img_1_Btn__Click = function(btn, str)
    View.Group_LocalStore.Group_Tips2.self:SetActive(true)
  end
}
return ViewFunction
