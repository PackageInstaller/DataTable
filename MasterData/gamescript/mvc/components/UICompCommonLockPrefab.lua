local UICompCommonLockPrefab, Super = NewViewComponent("UICompCommonLockPrefab")
local ItemType = CommonDefine.ItemType

function UICompCommonLockPrefab:ctor(uiNode, view, lockCb)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Btn_LockResource(uiNode)
  self.lockCb = lockCb
end

function UICompCommonLockPrefab:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnItemDetailLockStates, self._OnItemDetailLockStates, self)
end

function UICompCommonLockPrefab:RegisterEvents()
  if self.ui.Btn_Lock then
    self:AddButtonClickListener(self.ui.Btn_Lock, System.fn(self, self._OnClickUnLock))
  end
  if self.ui.Btn_Unlock then
    self:AddButtonClickListener(self.ui.Btn_Unlock, System.fn(self, self._OnClickLock))
  end
end

function UICompCommonLockPrefab:OnEnterComponent()
  self:_RefreshStates()
end

function UICompCommonLockPrefab:_OnClickLock()
  BagController.Instance:ReqItemLock(self.itemUid, true, self.lockCb)
end

function UICompCommonLockPrefab:_OnClickUnLock()
  BagController.Instance:ReqItemLock(self.itemUid, false, self.lockCb)
end

function UICompCommonLockPrefab:RefreshItemDetailLockStates(itemUid)
  self.itemUid = itemUid
  self:_RefreshStates()
end

function UICompCommonLockPrefab:_RefreshStates()
  if not self.itemUid or 0 == self.itemUid then
    self.ui.uiNode:SetActive(false)
    return
  end
  local itemData = ItemDataUtils.GetItemByUid(self.itemUid)
  if not itemData then
    self.ui.uiNode:SetActive(false)
    return
  end
  local itemType = ItemDataUtils.GetItemType(itemData.tid)
  if itemType ~= ItemType.Trinket then
    self.ui.uiNode:SetActive(false)
    return
  end
  self.ui.uiNode:SetActive(true)
  local isLocked = itemData.locked
  self.ui.Btn_Lock:SetActive(isLocked)
  self.ui.Btn_Unlock:SetActive(not isLocked)
end

function UICompCommonLockPrefab:_OnItemDetailLockStates(uid)
  if uid ~= self.itemUid then
    return
  end
  self:_RefreshStates()
end

return UICompCommonLockPrefab
