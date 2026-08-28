local View = require("UIWulinStore/UIWulinStoreView")
local DataModel = require("UIWulinStore/UIWulinStoreDataModel")
local CommonItem = require("Common/BtnItem")
local NPCDialog = require("Common/NPCDialog")
local ViewFunction = {
  WulinStore_Group_NPC_Btn_Chat_Click = function(btn, str)
    NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.talkText)
  end,
  WulinStore_Group_Right_NewScrollGrid_CommodityList_SetGrid = function(element, elementIndex)
    if not element or not elementIndex then
      return
    end
    if not DataModel.shopList then
      return
    end
    local data = DataModel.shopList[tonumber(elementIndex)]
    if not data then
      return
    end
    local cfg = PlayerData:GetFactoryData(data.id)
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    Btn_Item.Txt_CommodityName:SetText(cfg.commodityName)
    Btn_Item.Txt_PurchaseNum:SetActive(cfg.purchase)
    local remainCnt = data.maxBuyCnt - (DataModel.purchaseDic[data.id] or 0)
    Btn_Item.Txt_PurchaseNum:SetText(remainCnt .. "/" .. data.maxBuyCnt)
    local isSoldOut = data.limitBuy and remainCnt <= 0
    if isSoldOut then
      Btn_Item.Group_SoldOut.self:SetActive(true)
      Btn_Item.Txt_PurchaseNum:SetActive(false)
    else
      Btn_Item.Group_SoldOut.self:SetActive(false)
      Btn_Item.Txt_PurchaseNum:SetActive(true)
    end
    CommonItem:SetItem(Btn_Item.Group_Item, {
      id = cfg.commodityItemList[1].id,
      num = cfg.commodityNum
    })
    local moneyCA = PlayerData:GetFactoryData(cfg.moneyList[1].moneyID) or {}
    Btn_Item.Group_Money.Img_Money:SetSprite(moneyCA.buyPath)
    Btn_Item.Group_Money.Txt_Price:SetText(cfg.moneyList[1].moneyNum)
    local canBuy = PlayerData:GetGoodsById(cfg.moneyList[1].moneyID).num >= cfg.moneyList[1].moneyNum
    local color = canBuy and "#FFFCF7" or "#FF7F7F"
    Btn_Item.Group_Money.Txt_Price:SetColor(color)
  end,
  WulinStore_Group_Right_NewScrollGrid_CommodityList_Group_Item_Btn_Item_Click = function(btn, str)
    local idx = tonumber(str)
    local data = DataModel.shopList[idx]
    if not data then
      return
    end
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
  WulinStore_Group_Right_NewScrollGrid_CommodityList_Group_Item_Btn_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  WulinStore_Group_TopRight_Btn__Click = function(btn, str)
  end,
  WulinStore_StaticGrid_Coin_SetGrid = function(element, elementIndex)
    if not element or not elementIndex then
      return
    end
    local data = DataModel.coinList[elementIndex]
    if not data then
      return
    end
    if data.click == "Tips" then
      element.Btn_:SetClickParam(elementIndex)
    end
    local cfg = PlayerData:GetFactoryData(data.id) or {}
    local num = PlayerData:GetGoodsById(data.id).num or 0
    element.Img_Money:SetSprite(cfg.buyPath)
    element.Txt_Num:SetText(num)
  end,
  WulinStore_StaticGrid_Coin_Group_TopRight_Btn__Click = function(btn, str)
    if not DataModel.coinList then
      return
    end
    local data = DataModel.coinList[tonumber(str)]
    if not data then
      return
    end
    CommonTips.OpenRewardDetail(data.id)
  end,
  WulinStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  WulinStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  WulinStore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  WulinStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end
}
return ViewFunction
