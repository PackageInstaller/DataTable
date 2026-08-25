local CollectHistoryItem, Super = NewViewComponent("CollectHistoryItem")

function CollectHistoryItem:ctor(uiNode, view, viewData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Item_HistoryResource(uiNode)
  self:_InitViewData(viewData)
end

function CollectHistoryItem:OnEnterComponent()
  self:_RefreshView()
end

function CollectHistoryItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
end

function CollectHistoryItem:_OnClick()
  if self._unLock then
    if self._clickCb then
      self._clickCb()
    end
    RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Collection, RedPointDataUtils.RedAttrType.IsNew, self._collectTid)
  elseif self._collectCfg and self._collectCfg.LockTip then
    local lockTip = LT.Text(self._collectCfg.LockTip)
    Alert.ShowStr(lockTip)
  else
    Alert.Show(10843)
  end
end

function CollectHistoryItem:RegisterNotifications()
end

function CollectHistoryItem:_InitViewData(viewData)
  self._clickCb = viewData.clickCb
  self._collectTid = viewData.collectTid
  self._collectCfg = CollectionHallCfgUtils.GetCfg(self._collectTid)
  self._unLock = ArtCollectionController.Instance:IsUnlock(self._collectTid)
end

function CollectHistoryItem:_RefreshView()
  self:_RefreshTitle()
  self:_RefreshState()
  self:_RefreshRedComp()
end

function CollectHistoryItem:_RefreshRedComp()
  self:AddViewComponentOnce(self.ui.Com_RedDot, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
    if not self._unLock then
      return false
    end
    do return RedPointDataUtils.IsShowCollectionItem end
    return RedPointDataUtils.IsShowCollectionItem, self._collectTid
  end)
end

function CollectHistoryItem:_RefreshState()
  if not self._unLock then
    self:SetActive(self.ui.Group_Lock, true)
    self:SetActive(self.ui.Group_CG, false)
    self:SetActive(self.ui.Group_Normal, false)
    self:SetActive(self.ui.Text_Year, false)
    local confuseText = StrUtils.Fix2ConfuseText("    ")
    self:SetText(self.ui.Text_Lock, confuseText)
    return
  end
  local picture = self._collectCfg.Picture
  self:SetActive(self.ui.Group_Lock, false)
  self:SetActive(self.ui.Group_CG, picture)
  self:SetActive(self.ui.Group_Normal, not picture)
  if picture then
    self:SetImage(self.ui.Image_CG, picture)
  end
end

function CollectHistoryItem:_RefreshTitle()
  local prefix, suffix = CollectionHallCfgUtils.GetCollectionHistoryTitle(self._collectTid)
  self:SetText(self.ui.Text_Century, prefix)
  self:SetText(self.ui.Text_Year, suffix)
end

return CollectHistoryItem
