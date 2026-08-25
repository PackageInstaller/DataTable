local Currency = System.NewClass("Currency", BaseItemDispatch)

function Currency:GetItemCount(tid)
  return DataCenter.itemData.CurrencyData[tid] or 0
end

function Currency:InitItem(item)
  DataCenter.itemData.CurrencyData[item.tid] = item.num
end

function Currency:SyncItem(item, reason)
  local tid = item.tid
  local oldNum = DataCenter.itemData.CurrencyData[tid] or 0
  DataCenter.itemData.CurrencyData[tid] = item.num
  if oldNum < item.num then
    EventMgr.Instance.AddItemEvent:Dispatch(item, oldNum, reason)
  else
    EventMgr.Instance.RemoveItemEvent:Dispatch(item, oldNum, reason)
  end
  if ItemDataUtils.IsAwakerChip(item.tid) then
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(item.tid)
    local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
    RedPointDataUtils.UpdateAwakerRed(awakerData)
  end
  if "UpgradeTalent" == reason then
    RedPointDataUtils.UpdateMainStageResonanceByItemId(item.tid)
  end
  GlobalDispatcher:Dispatch(NotifyId.OnBagItemDataChanged, item.uid, item.tid)
end

function Currency:GetItemByTid(tid)
  return {
    tid = tid,
    num = DataCenter.itemData.CurrencyData[tid] or 0
  }
end

function Currency:IsStackableItem(tid)
  return false
end

function Currency:IsBagItem(tid)
  return false
end

return Currency
