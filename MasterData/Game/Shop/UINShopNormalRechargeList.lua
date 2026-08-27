local UINShopNormalRechargeList = class("UINShopNormalRechargeList", UIBaseNode)
local base = UIBaseNode
local UINShopNormalRechargeItem = require("Game.Shop.UINShopNormalRechargeItem")
local cs_ResLoader = CS.ResLoader

function UINShopNormalRechargeList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINShopNormalRechargeItem, self.ui.quartzItem)
  self.ui.quartzItem:SetActive(false)
  self.__onTimerRefresh = BindCallback(self, self.__OnTimerRefresh)
end

function UINShopNormalRechargeList:ShopCommonInit(uiShop)
  self.uiShop = uiShop
  self.shopCtrl = uiShop.shopCtrl
end

function UINShopNormalRechargeList:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  self.shopId = shopId
  self.pageId = pageId
  self.shopCtrl:GetShopData(shopId, function(shopData)
    local shopGoodsDic = shopData:GetCurShopGoods(pageId)
    self:InitRechargeList(shopGoodsDic)
    self.uiShop:RefreshHeadBar(shopData)
    if self.gameObject.activeInHierarchy then
      UIUtil.RefreshTopResId({
        ConstGlobalItem.PaidItem
      })
    end
  end)
end

function UINShopNormalRechargeList:InitRechargeList(goodDataDic)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local list = {}
  for k, v in pairs(goodDataDic) do
    if not v.isSoldOut then
      table.insert(list, v)
    end
    saveUserData:SetIsRechargeShelfNotNew(v.shelfId, true)
  end
  table.sort(list, function(a, b)
    if a.order ~= b.order then
      return a.order < b.order
    end
    return a.shelfId < b.shelfId
  end)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.resloader = cs_ResLoader.Create()
  self.itemPool:HideAll()
  for i, v in ipairs(list) do
    local item = self.itemPool:GetOne()
    item:InitRechargeItem(v, self.resloader)
  end
  self.shopCtrl:AddShopTimerCallback(self.__onTimerRefresh, "rechargeList")
end

function UINShopNormalRechargeList:__OnTimerRefresh()
  local isNeedRefresh = false
  for _, rechargeItem in pairs(self.itemPool.listItem) do
    isNeedRefresh = isNeedRefresh or rechargeItem:RefreshRechargeLeftTime()
  end
  if isNeedRefresh then
    self.shopCtrl:ReqShopDetail(self.shopId, function()
      self:RefreshShopNode(self.shopId, self.pageId)
    end)
  end
end

function UINShopNormalRechargeList:OnShow()
  base.OnShow(self)
  self.shopCtrl:RemoveShopTimerCallback(self.__onTimerRefresh)
end

function UINShopNormalRechargeList:OnHide()
  base.OnHide(self)
  self.shopCtrl:RemoveShopTimerCallback(self.__onTimerRefresh)
end

function UINShopNormalRechargeList:OnDelete()
  for i, v in ipairs(self.itemPool.listItem) do
    v:Delete()
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.shopCtrl:RemoveShopTimerCallback(self.__onTimerRefresh)
  base.OnDelete(self)
end

return UINShopNormalRechargeList
