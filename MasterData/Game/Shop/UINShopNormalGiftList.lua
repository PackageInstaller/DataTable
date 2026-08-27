local UINShopNormalGiftList = class("UINShopNormalGiftList", UIBaseNode)
local base = UIBaseNode
local UINShopNormalGiftItem = require("Game.Shop.UINShopNormalGiftItem")
local cs_ResLoader = CS.ResLoader
local cs_Canvas = CS.UnityEngine.Canvas
local cs_MessageCommon = CS.MessageCommon

function UINShopNormalGiftList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemDic = {}
  self.dataList = {}
  self.__OnPayGiftChange = BindCallback(self, self.OnPayGiftChange)
  MsgCenter:AddListener(eMsgEventId.PayGiftChange, self.__OnPayGiftChange)
  self.ui.giftBagList.onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  self.ui.giftBagList.onChangeItem = BindCallback(self, self.OnChangeItem)
  self.__TimeRefreshView = BindCallback(self, self.TimeRefreshView)
end

function UINShopNormalGiftList:OnShow()
  self.__OnRefreshGiftItemReddot = BindCallback(self, self.OnRefreshGiftItemReddot)
  RedDotController:AddListener(RedDotDynPath.ShopPath, self.__OnRefreshGiftItemReddot)
  self.__InitDataListView = BindCallback(self, self.InitDataListView)
  MsgCenter:AddListener(eMsgEventId.PayGiftItemPreConfition, self.__InitDataListView)
end

function UINShopNormalGiftList:ShopCommonInit(uiShop)
  self.uiShop = uiShop
  self.shopCtrl = uiShop.shopCtrl
end

function UINShopNormalGiftList:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  if self.gameObject.activeInHierarchy then
    UIUtil.RefreshTopResId({
      ConstGlobalItem.PaidItem,
      ConstGlobalItem.PaidSubItem
    })
  end
  local shopCfg = ConfigData.shop[shopId]
  self:InitGiftList(shopCfg, pageId, self.uiShop.ui.quickPurchaseRoot, autoSelectShelfId)
  self.uiShop:RefreshHeadBar(nil, shopCfg)
end

function UINShopNormalGiftList:InitGiftList(shopCfg, pageId, purchaseRoot, autoSelectShelfId)
  if self.resloader == nil then
    self.resloader = cs_ResLoader.Create()
  end
  self.purchaseRoot = purchaseRoot
  self.shopCfg = shopCfg
  self.pageId = pageId
  self.payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  self:InitDataListView()
  self.payGiftCtrl:SetAllNewBeLooked(pageId)
  if autoSelectShelfId == nil then
    return
  end
  local selectedData
  for i, v in ipairs(self.dataList) do
    if v.groupCfg.id == autoSelectShelfId then
      selectedData = v
      break
    end
  end
  if selectedData ~= nil then
    local quickBuyWindow = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
    if quickBuyWindow ~= nil and quickBuyWindow.active then
      quickBuyWindow:InitBuyPayGift(selectedData)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(window)
        window:SlideIn()
        window:InitBuyPayGift(selectedData)
      end)
    end
  end
end

function UINShopNormalGiftList:InitDataListView()
  self.dataList = self.payGiftCtrl:GetShowPayGiftByPageId(self.pageId)
  if #self.dataList > 0 then
    table.sort(self.dataList, function(a, b)
      if a.needRefresh or b.needRefresh then
        local aSoldOut = a:IsSoldOut()
        local bSoldOut = b:IsSoldOut()
        if aSoldOut ~= bSoldOut then
          return not aSoldOut
        end
      end
      if a.isFree ~= b.isFree then
        return a.isFree
      end
      if a.initPreGroupLine ~= b.initPreGroupLine then
        return a.initPreGroupLine < b.initPreGroupLine
      end
      return a.groupCfg.line < b.groupCfg.line
    end)
    self:RefreshPayGiftView()
  else
    self.uiShop:InitShop(nil)
  end
end

function UINShopNormalGiftList:RefreshPayGiftView()
  cs_Canvas.ForceUpdateCanvases()
  self.ui.giftBagList:ClearCells()
  self.ui.giftBagList.totalCount = #self.dataList
  self.ui.giftBagList:RefillCells()
end

function UINShopNormalGiftList:OnInstantiateItem(go)
  local item = UINShopNormalGiftItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UINShopNormalGiftList:TimeRefreshView()
  self.__lastRefreshTm = self.__lastRefreshTm or 0
  if PlayerDataCenter.timestamp >= self.__lastRefreshTm and PlayerDataCenter.timestamp - self.__lastRefreshTm < 1 then
    return
  end
  self.__lastRefreshTm = PlayerDataCenter.timestamp
  cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(331))
  self:InitDataListView()
end

function UINShopNormalGiftList:OnChangeItem(go, index)
  local item = self.itemDic[go]
  local data = self.dataList[index + 1]
  item:InitGiftItem(data, self.purchaseRoot, self.resloader, self.__TimeRefreshView)
  self:RefreshGiftItemReddotByItem(item)
end

function UINShopNormalGiftList:OnPayGiftChange(groupId)
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  local data = payGiftCtrl.dataDic[groupId]
  if data:IsSoldOut() then
    self:InitDataListView()
  else
    for k, v in pairs(self.itemDic) do
      if v.data.groupCfg.id == groupId then
        v:RefreshGiftItem()
        self:RefreshGiftItemReddotByItem(v)
        break
      end
    end
  end
end

function UINShopNormalGiftList:OnRefreshGiftItemReddot()
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, self.payGiftCtrl.shopId, self.pageId)
  if ok then
    for _, giftItem in pairs(self.itemDic) do
      local childNode = shopNode:GetChild(giftItem.data.groupCfg.id)
      giftItem:SetGiftItemReddot(childNode ~= nil and childNode:GetRedDotCount() > 0)
    end
  else
    for _, giftItem in pairs(self.itemDic) do
      giftItem:SetGiftItemReddot(false)
    end
  end
end

function UINShopNormalGiftList:RefreshGiftItemReddotByItem(giftItem)
  local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, self.payGiftCtrl.shopId, self.pageId)
  if ok then
    local childNode = shopNode:GetChild(giftItem.data.groupCfg.id)
    giftItem:SetGiftItemReddot(childNode ~= nil and childNode:GetRedDotCount() > 0)
  else
    giftItem:SetGiftItemReddot(false)
  end
end

function UINShopNormalGiftList:OnHide()
  RedDotController:RemoveListener(RedDotDynPath.ShopPath, self.__OnRefreshGiftItemReddot)
  MsgCenter:RemoveListener(eMsgEventId.PayGiftItemPreConfition, self.__InitDataListView)
end

function UINShopNormalGiftList:OnDelete()
  for k, v in pairs(self.itemDic) do
    v:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.PayGiftChange, self.__OnPayGiftChange)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UINShopNormalGiftList
