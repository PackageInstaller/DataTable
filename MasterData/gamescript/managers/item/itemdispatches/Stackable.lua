local Stackable = System.NewClass("Stackable", BaseItemDispatch)

function Stackable:GetItemCount(tid)
  do return ItemDataUtils.GetBagItemNum end
  return ItemDataUtils.GetBagItemNum, tid
end

function Stackable:InitItem(item)
  ItemDataUtils.InitBagItem(item)
end

function Stackable:SyncItem(item, reason)
  ItemDataUtils.SyncBagItem(item, reason)
  if ItemDataUtils.IsResonanceParticle(item.tid) or "UpgradeTalent" == reason then
    RedPointDataUtils.UpdateMainStageResonanceByItemId(item.tid)
  end
end

function Stackable:GetItemByTid(tid)
  do return ItemDataUtils.GetBagItemByTid end
  return ItemDataUtils.GetBagItemByTid, tid
end

function Stackable:IsStackableItem(tid)
  return true
end

function Stackable:IsBagItem(tid)
  return true
end

return Stackable
