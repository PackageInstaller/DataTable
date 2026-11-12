local ActivityShopGoodsCtrl = class("ActivityShopGoodsCtrl", BaseCtrl)
ActivityShopGoodsCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  }
}
ActivityShopGoodsCtrl._mapEventConfig = {
  ActivityShopRefreshGoods = "CheckGoodsData"
}

function ActivityShopGoodsCtrl:Open(nShopId, nShopAutoTime)
  self.nShopId = nShopId
  self.nShopAutoTime = nShopAutoTime
  self:CheckGoodsData(true)
end

function ActivityShopGoodsCtrl:CheckGoodsData(bResetPos)
  self._panel.actShopData:CheckGoodsData(self.nShopId)
  self.tbGoods = self._panel.actShopData:GetGoodsList(self.nShopId)
  self:SetTimer()
  self:RefreshList(bResetPos)
end

function ActivityShopGoodsCtrl:SetTimer()
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  local nTime = self._panel.actShopData:GetGoodsAutoUpdateTime(self.nShopId)
  if 0 < nTime and (self.nShopAutoTime == 0 or nTime < self.nShopAutoTime) then
    self.timer = self:AddTimer(1, nTime, function()
      EventManager.Hit("ActivityShopCloseDetail")
      EventManager.Hit(EventId.CloseMessageBox)
      self:CheckGoodsData(true)
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Shop_GoodsRefresh"))
    end, true, true, false)
  end
end

function ActivityShopGoodsCtrl:RefreshList(bResetPos)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.sv:SetAnim(0.04)
  self._mapNode.sv:Init(#self.tbGoods, self, self.OnGridRefresh, self.OnGridBtnClick, not bResetPos)
end

function ActivityShopGoodsCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbGoods[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.ActivityTheme.10101.Shop.ActivityShopGoodsItemCtrl")
  end
  local mapCfg = ConfigTable.GetData("ActivityShop", self.nShopId)
  if mapCfg then
    self.tbGridCtrl[nInstanceID]:Refresh(mapData, mapCfg.CurrencyItemId)
  end
end

function ActivityShopGoodsCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbGoods[nIndex]
  EventManager.Hit(EventId.OpenPanel, PanelId.ShopPopup_10101, mapData, self.nShopId, self._panel.nActId)
end

function ActivityShopGoodsCtrl:Awake()
  self.tbGridCtrl = {}
end

function ActivityShopGoodsCtrl:OnEnable()
end

function ActivityShopGoodsCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function ActivityShopGoodsCtrl:OnDestroy()
end

return ActivityShopGoodsCtrl
