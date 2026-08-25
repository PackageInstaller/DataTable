local BagController = NewClass("BagController", BaseController)

function BagController:OnInit()
end

function BagController:OnReset()
end

function BagController:OnOpenBagView(itemType, itemTid)
  UIManager.Instance:Reopen(Urls.BagView, itemType, itemTid)
end

function BagController:ReqItemLock(uid, lock, callback)
  if not uid or 0 == uid then
    return
  end
  local chosenItemData = ItemDataUtils.GetItemByUid(uid)
  if not chosenItemData then
    return
  end
  local itemType = ItemDataUtils.GetItemType(chosenItemData.tid)
  if itemType == cd.ItemType.Weapon then
    if callback then
      callback(false)
    end
    return
  end
  local protoName = lock and "OnLockItem" or "OnUnlockItem"
  ProtoManager.Instance:ReqServer("GameRequest", protoName, function(lockState)
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if itemData then
      itemData.locked = lockState
      EventMgr.Instance.DecomposeLockStateEvent:Dispatch(uid)
    end
    if callback then
      callback(lockState)
    end
    self:Notify(NotifyId.OnItemDetailLockStates, uid)
  end, function()
  end, uid)
end

return BagController
