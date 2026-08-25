local ItemType = CommonDefine.ItemType
local ItemDetailsController = NewClass("ItemDetailsController", BaseController)

function ItemDetailsController:OnInit()
end

function ItemDetailsController:OnReset()
  self._curShowTipsTag = nil
end

function ItemDetailsController:ShowItemDetailTips(parentNode, uid, tid, banLock, extraData)
  if tid and ItemDataUtils.GetItemType(tid) == ItemType.AwakerItem then
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(tid)
    if not AwakerCfgUtils.IsAwakerOpened(awakerTid) then
      Alert.Show("AwakerNotOpenTips")
      return
    end
    AwakerDataUtils.JumpToSingleAwakerPanel(CommonDefine.AwakerPage.Detail, awakerTid)
    return
  end
  if not parentNode or not uid and not tid then
    return
  end
  extraData = extraData or {}
  local closeCb = extraData.closeCb
  local lockCb = extraData.lockCb
  local hideAttr = extraData.hideAttr
  local posY = extraData.posY
  local posX = extraData.posX
  local ignoreCustomInput = extraData.ignoreCustomInput
  local showWeaponHave = extraData.showWeaponHave == true
  if tid then
    local itemCfg = DT.Item[tid]
    if itemCfg and itemCfg.DropItemGets then
      if itemCfg.Type == ItemType.Weapon then
        if not itemCfg.WeaponMainAttribute then
          tid = itemCfg.DropItemGets
        end
      else
        tid = itemCfg.DropItemGets
      end
    end
  end
  local tipsKey = tid or uid or 0
  local tipsTag = string.format("%s_%s_%d", tostring(tid or uid), tostring(tipsKey), parentNode:GetInstanceID())
  if self._curShowTipsTag == tipsTag then
    return
  end
  if self._curShowTipsTag then
    UIManager.Instance:CloseByUrl(Urls.ItemDetailsView)
  end
  self._curShowTipsTag = tipsTag
  local model = ItemDetailsModel.Instance
  model:ResetData()
  if uid then
    model:SetChosenItemUid(uid)
  end
  local itemType = ItemDataUtils.GetItemType(tid)
  local isPreview = false
  if not ItemDataUtils.GetItemByUid(uid) or itemType == ItemType.AwakerItem then
    uid = nil
  end
  if not uid and tid and tid > 0 then
    local isWeapon = itemType == ItemType.Weapon
    local isTrinket = itemType == ItemType.Trinket
    local data
    if isWeapon then
      data = ItemDataUtils.ConstructWeaponItem(tid)
    else
      data = {tid = tid, uid = 1}
    end
    model:SetItemDataMap({data})
    model:SetChosenItemUid(data.uid)
    isPreview = not isWeapon
    if nil == banLock and (isWeapon or isTrinket) then
      banLock = true
    end
  end
  UIManager.Instance:SetTempPanelLayer(Urls.ItemDetailsView, UIDefine.LayerCfg.TipPopRoot.name)
  UIManager.Instance:Reopen(Urls.ItemDetailsView, {
    closeCb = closeCb,
    lockCb = lockCb,
    parentNode = parentNode,
    hideAttr = hideAttr,
    posY = posY,
    posX = posX,
    ignoreCustomInput = ignoreCustomInput,
    isPreview = isPreview,
    banLock = banLock,
    showWeaponHave = showWeaponHave
  })
end

function ItemDetailsController:ReqItemLock(lock, callback)
  local chosenUid = ItemDetailsModel.Instance:GetChosenItemUid()
  if not chosenUid or 0 == chosenUid then
    return
  end
  local chosenItemData = ItemDataUtils.GetItemByUid(chosenUid)
  if not chosenItemData then
    return
  end
  local itemType = ItemDataUtils.GetItemType(chosenItemData.tid)
  if itemType == ItemType.Weapon then
    if callback then
      callback(false)
    end
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  local protoName = lock and "OnLockItem" or "OnUnlockItem"
  ProtoManager.Instance:ReqServer("GameRequest", protoName, function(lockState)
    local itemData = ItemDataUtils.GetItemByUid(chosenUid)
    if itemData then
      itemData.locked = lockState
      EventMgr.Instance.DecomposeLockStateEvent:Dispatch(chosenUid)
      GlobalDispatcher:Dispatch(NotifyId.OnBagItemDataChanged, chosenUid, itemData.tid)
    end
    if callback then
      callback(lockState)
    end
    self:Notify(NotifyId.OnItemDetailLockStates, chosenUid)
  end, function()
  end, chosenUid)
end

function ItemDetailsController:CloseItemDetailTips()
  UIManager.Instance:CloseByUrl(Urls.ItemDetailsView)
  self._curShowTipsTag = nil
end

function ItemDetailsController:IsItemDetailTipsShowing()
  return UIManager.Instance:GetWindow(Urls.ItemDetailsView) ~= nil
end

return ItemDetailsController
