local ShopGoodsCtrl = class("ShopGoodsCtrl", BaseCtrl)
ShopGoodsCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  }
}
ShopGoodsCtrl._mapEventConfig = {
  ShopRefreshGoods = "CheckGoodsData"
}

function ShopGoodsCtrl:Open(nShopId, nShopAutoTime)
  self.nShopId = nShopId
  self.nShopAutoTime = nShopAutoTime
  self:CheckGoodsData(true)
end

function ShopGoodsCtrl:CheckGoodsData(bResetPos)
  PlayerData.Shop:CheckGoodsData(self.nShopId)
  self.tbGoods = PlayerData.Shop:GetGoodsList(self.nShopId)
  self:SetTimer()
  self:RefreshList(bResetPos)
end

function ShopGoodsCtrl:SetTimer()
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  local nTime = PlayerData.Shop:GetGoodsAutoUpdateTime(self.nShopId)
  if 0 < nTime and (self.nShopAutoTime == 0 or nTime < self.nShopAutoTime) then
    self.timer = self:AddTimer(1, nTime, function()
      EventManager.Hit("ShopCloseDetail")
      EventManager.Hit(EventId.CloseMessageBox)
      self:CheckGoodsData(true)
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_GoodsRefresh"))
    end, true, true, false)
  end
end

function ShopGoodsCtrl:RefreshList(bResetPos)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.sv:SetAnim(0.04)
  self._mapNode.sv:Init(#self.tbGoods, self, self.OnGridRefresh, self.OnGridBtnClick, not bResetPos)
end

function ShopGoodsCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbGoods[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.ShopEx.ShopGoodsItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapData)
end

function ShopGoodsCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbGoods[nIndex]
  EventManager.Hit(EventId.OpenPanel, PanelId.ShopPopupPanel, mapData, self.nShopId)
end

function ShopGoodsCtrl:Awake()
  self.tbGridCtrl = {}
end

function ShopGoodsCtrl:OnEnable()
end

function ShopGoodsCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function ShopGoodsCtrl:OnDestroy()
end

return ShopGoodsCtrl
