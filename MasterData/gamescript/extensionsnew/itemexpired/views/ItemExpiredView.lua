local ItemExpiredView, Super = NewClass("ItemExpiredView", BaseView)
ItemExpiredView.uiResCls = UI_Awaker_Popup_Expired_TipResource
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local T_HorizontalLayoutGroup = typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)
local T_RectTransform = typeof(CS.UnityEngine.RectTransform)

function ItemExpiredView:ctor(itemList)
  Super.ctor(self)
  self._itemList = itemList
  self._onlyExpireTableView = nil
  self._expireTableView = nil
  self._convertTableView = nil
end

function ItemExpiredView:OnBuildView()
  self:_BuildOnlyExpireListView()
  self:_BuildExpire2ListView()
  self:_BuildConvertListView()
end

function ItemExpiredView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnItemExpiredDataChanged, self._OnRefreshAll, self)
end

function ItemExpiredView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self._OnClickClose))
end

function ItemExpiredView:OnEnterView()
  Super.OnEnterView(self)
  ItemExpiredModel.Instance:SetItemList(self._itemList)
  self:LocalNotify(NotifyId.OnItemExpiredDataChanged)
end

function ItemExpiredView:OnExitView()
  Super.OnExitView(self)
end

function ItemExpiredView:_OnClickClose()
  self:Close()
end

function ItemExpiredView:_GetItemCellSize()
  local rectTrans = self.ui.UI_Common_Item_WuPin_Type1:GetComponent(T_RectTransform)
  if rectTrans then
    return rectTrans.rect.width, rectTrans.rect.height
  end
  return 100, 100
end

function ItemExpiredView:_OnRefreshAll()
  self:_RefreshStaticText()
  self:_RefreshVisible()
  self:_RefreshLists()
end

function ItemExpiredView:_RefreshStaticText()
  self:SetText(self.ui.Text_Expired1, LT.Text("ExpiredText"))
  self:SetText(self.ui.Text_Expired2, LT.Text("ExpiredText"))
  self:SetText(self.ui.Text_Convert, LT.Text("ExpiredConvertText"))
end

function ItemExpiredView:_RefreshVisible()
  local isShowConvert = ItemExpiredModel.Instance:IsShowConvert()
  self.ui.Group_OnlyExpire:SetActive(not isShowConvert)
  self.ui.Group_ExpireAndConvert:SetActive(isShowConvert)
end

function ItemExpiredView:_RefreshLists()
  local isShowConvert = ItemExpiredModel.Instance:IsShowConvert()
  if isShowConvert then
    self:_RefreshExpire2ListView()
    self:_RefreshConvertListView()
  else
    self:_RefreshOnlyExpireListView()
  end
end

function ItemExpiredView:_BuildOnlyExpireListView()
  self._onlyExpireTableView = self:CreateTableview(self.ui.ScrollView_OnlyExpire, function()
    return #(ItemExpiredModel.Instance:GetItemList() or {})
  end, function(view, idx)
    do return self._OnOnlyExpireCellAtIndex, self, view end
    return self._OnOnlyExpireCellAtIndex, self, view, idx
  end, function(view, idx)
    do return self._GetItemCellSize end
    return self._GetItemCellSize, self
  end)
  local content = self.ui.ScrollView_OnlyExpire:GetComponent(T_ScrollRect).content
  local groupCom = content:GetComponent(T_HorizontalLayoutGroup)
  if groupCom then
    groupCom.enabled = true
    groupCom.childAlignment = CS.UnityEngine.TextAnchor.MiddleCenter
  end
end

function ItemExpiredView:_RefreshOnlyExpireListView()
  if self._onlyExpireTableView then
    self._onlyExpireTableView:ReloadData()
  end
end

function ItemExpiredView:_BuildExpire2ListView()
  self._expireTableView = self:CreateTableview(self.ui.ScrollView_Expired2, function()
    return #(ItemExpiredModel.Instance:GetItemList() or {})
  end, function(view, idx)
    do return self._OnExpire2CellAtIndex, self, view end
    return self._OnExpire2CellAtIndex, self, view, idx
  end, function(view, idx)
    do return self._GetItemCellSize end
    return self._GetItemCellSize, self
  end)
end

function ItemExpiredView:_RefreshExpire2ListView()
  if self._expireTableView then
    self._expireTableView:ReloadData()
  end
end

function ItemExpiredView:_BuildConvertListView()
  self._convertTableView = self:CreateTableview(self.ui.ScrollView_Convert, function()
    return #(ItemExpiredModel.Instance:GetConvertItemList() or {})
  end, function(view, idx)
    do return self._OnConvertCellAtIndex, self, view end
    return self._OnConvertCellAtIndex, self, view, idx
  end, function(view, idx)
    do return self._GetItemCellSize end
    return self._GetItemCellSize, self
  end)
end

function ItemExpiredView:_RefreshConvertListView()
  if self._convertTableView then
    self._convertTableView:ReloadData()
  end
end

function ItemExpiredView:_OnOnlyExpireCellAtIndex(view, idx)
  local itemList = ItemExpiredModel.Instance:GetItemList()
  local data = itemList[idx]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  self:_BindItemIcon(cell.gameObject, data, true)
  return cell
end

function ItemExpiredView:_OnExpire2CellAtIndex(view, idx)
  local itemList = ItemExpiredModel.Instance:GetItemList()
  local data = itemList[idx]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  self:_BindItemIcon(cell.gameObject, data, true)
  return cell
end

function ItemExpiredView:_OnConvertCellAtIndex(view, idx)
  local convertList = ItemExpiredModel.Instance:GetConvertItemList()
  local data = convertList[idx]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  self:_BindItemIcon(cell.gameObject, data, false)
  return cell
end

function ItemExpiredView:_BindItemIcon(gameObj, itemData, isShowExpired)
  local viewData = {
    tid = itemData.tid,
    uid = itemData.uid,
    num = itemData.num,
    callback = function(tid, uid)
      ItemDataUtils.ShowItemDetailTips(self.binder, gameObj, uid, tid)
    end,
    showExpiredFunc = function()
      return isShowExpired
    end,
    ShowLockImg = false,
    ShowRedDot = false
  }
  self:AddViewComponentOnce(gameObj, CompPublicIconItemType1, viewData)
end

return ItemExpiredView
