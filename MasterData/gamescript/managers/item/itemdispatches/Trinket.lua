local Trinket = System.NewClass("Trinket", BaseItemDispatch)

function Trinket:GetItemCount(tid)
  do return ItemDataUtils.GetBagItemNum end
  return ItemDataUtils.GetBagItemNum, tid
end

function Trinket:InitItem(item)
  ItemDataUtils.InitBagItem(item)
end

function Trinket:SyncItem(item, reason)
  local oldItem = ItemDataUtils.GetItemByUid(item.uid)
  local proxy = {
    onAdd = function()
      item = ItemDataUtils.GetItemByUid(item.uid)
      ItemDataUtils.AddTrinketToPosMap(item)
      ItemDataUtils.UpdateTrinketSuitNumMap(item, 1)
    end,
    onRemove = function()
      ItemDataUtils.RemoveTrinketFromPosMap(oldItem)
      ItemDataUtils.UpdateTrinketSuitNumMap(oldItem, -1)
    end
  }
  ItemDataUtils.SyncBagItem(item, reason, proxy)
end

function Trinket:GetItemByTid(tid)
  do return ItemDataUtils.GetBagItemByTid end
  return ItemDataUtils.GetBagItemByTid, tid
end

function Trinket:IsStackableItem(tid)
  return false
end

function Trinket:IsBagItem(tid)
  return true
end

return Trinket
