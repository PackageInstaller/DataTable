local View = require("UIFireStore/UIFireStoreView")
local DataModel = require("UIFireStore/UIFireStoreDataModel")
local CommonItem = require("Common/BtnItem")
local NPCDialog = require("Common/NPCDialog")
local ViewFunction = {
  FireStore_Group_NPC_Btn_Chat_Click = function(btn, str)
    NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.talkText)
  end,
  FireStore_Group_Right_NewScrollGrid_CommodityList_SetGrid = function(element, elementIndex)
    local data = DataModel.shopList[tonumber(elementIndex)]
    local cfg = PlayerData:GetFactoryData(data.id)
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    Btn_Item.Txt_CommodityName:SetText(cfg.commodityName)
    Btn_Item.Txt_PurchaseNum:SetActive(data.limitBuy)
    local remainCnt = data.maxBuyCnt - (DataModel.purchaseDic[data.id] or 0)
    Btn_Item.Txt_PurchaseNum.Txt_Num:SetText(remainCnt)
    Btn_Item.Group_SoldOut.self:SetActive(data.limitBuy and remainCnt <= 0)
    CommonItem:SetItem(Btn_Item.Group_Item, {
      id = cfg.commodityItemList[1].id,
      num = cfg.commodityNum
    })
    local moneyCA = PlayerData:GetFactoryData(cfg.moneyList[1].moneyID)
    Btn_Item.Group_Money.Img_Money:SetSprite(moneyCA.buyPath)
    Btn_Item.Group_Money.Txt_Price:SetText(cfg.moneyList[1].moneyNum)
    local canBuy = PlayerData:GetGoodsById(cfg.moneyList[1].moneyID).num >= cfg.moneyList[1].moneyNum
    local color = canBuy and "#FFFCCE" or "#A2A2A2"
    Btn_Item.Group_Money.Txt_Price:SetColor(color)
  end,
  FireStore_Group_Right_NewScrollGrid_CommodityList_Group_Item_Btn_Item_Click = function(btn, str)
    local idx = tonumber(str)
    local data = DataModel.shopList[idx]
    local remainCnt = data.maxBuyCnt - (DataModel.purchaseDic[data.id] or 0)
    local notBuy = data.limitBuy and remainCnt <= 0
    if notBuy then
      NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.saleOutText)
      CommonTips.OpenTips(80602917)
      return
    end
    local parmas = {}
    parmas.index = idx - 1
    parmas.shopid = DataModel.shopId
    parmas.id = data.id
    parmas.residue = remainCnt
    
    local function callBack()
      DataModel.initPurchaseDic(DataModel.shopId)
      DataModel.SortShopList()
      View.Group_Right.NewScrollGrid_CommodityList.grid.self:RefreshAllElement()
      View.StaticGrid_Coin.grid.self:RefreshAllElement()
      NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.buySuccessText)
    end
    
    CommonTips.OpenBuyTips(parmas, callBack)
  end,
  FireStore_Group_Right_NewScrollGrid_CommodityList_Group_Item_Btn_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  FireStore_Group_TopRight_Btn__Click = function(btn, str)
  end,
  FireStore_StaticGrid_Coin_SetGrid = function(element, elementIndex)
    local data = DataModel.coinList[elementIndex]
    if data.click == "Tips" then
      element.Btn_:SetClickParam(elementIndex)
    end
    local cfg = PlayerData:GetFactoryData(data.id)
    local num = PlayerData:GetGoodsById(data.id).num or 0
    element.Img_Money:SetSprite(cfg.buyPath)
    element.Txt_Num:SetText(num)
  end,
  FireStore_StaticGrid_Coin_Group_TopRight_Btn__Click = function(btn, str)
    local data = DataModel.coinList[tonumber(str)]
    CommonTips.OpenRewardDetail(data.id)
  end,
  FireStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  FireStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  FireStore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  FireStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
