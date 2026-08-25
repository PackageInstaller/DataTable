local Weapon = System.NewClass("Weapon", BaseItemDispatch)

function Weapon:GetItemCount(tid)
  do return ItemDataUtils.GetBagItemNum end
  return ItemDataUtils.GetBagItemNum, tid
end

function Weapon:InitItem(item)
  ItemDataUtils.InitBagItem(item)
end

function Weapon:SyncItem(item, reason)
  ItemDataUtils.SyncBagItem(item, reason)
  ItemDataUtils.UpdateEquipableGoodWeaponMap(item)
end

function Weapon:GetItemByTid(tid)
  do return ItemDataUtils.GetBagItemByTid end
  return ItemDataUtils.GetBagItemByTid, tid
end

function Weapon:IsStackableItem(tid)
  return false
end

function Weapon:IsBagItem(tid)
  return true
end

return Weapon
