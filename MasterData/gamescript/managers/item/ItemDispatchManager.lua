local ItemDispatchManager, super = System.NewClass("ItemDispatchManager", Manager)

function ItemDispatchManager:ctor()
  super.ctor(self)
  self.itemDispatcher = {}
  self.baseDispatcher = require("Managers.Item.BaseItemDispatch")()
  for k, modName in pairs(CommonDefine.ItemTypeDispatch) do
    if "__kind" ~= k then
      local mod = require("GameScript.Managers.Item.ItemDispatches." .. modName)
      if not self.itemDispatcher[mod.__name] then
        self.itemDispatcher[mod.__name] = mod()
      end
    end
  end
end

function ItemDispatchManager:GetDispatchByItemCid(tid)
  local itemCfg = ItemDataUtils.GetItemConfig(tid)
  if not itemCfg then
    return
  end
  local dispatch = self:GetDispatchByItemType(itemCfg.Type)
  if not dispatch then
    Logger.Error(string.format("GetDispatchByItemCid dispatch not define tid:%s type:%s", tid, itemCfg.Type))
  end
  return dispatch
end

function ItemDispatchManager:GetDispatchByItemType(itemType)
  local key = CommonDefine.ItemTypeDispatch[itemType]
  if not key then
    return self.baseDispatcher
  end
  local dispatch = self.itemDispatcher[key]
  if not dispatch then
    Logger.Error(string.format("GetDispatchByItemType dispatch not define name:%s", key))
  end
  return dispatch
end

function ItemDispatchManager:InitItem(item)
  local dispatch = self:GetDispatchByItemCid(item.tid)
  if dispatch then
    do return dispatch.InitItem, dispatch end
    return dispatch.InitItem, dispatch, item
  end
end

function ItemDispatchManager:SyncItem(item, reason)
  local dispatch = self:GetDispatchByItemCid(item.tid)
  if dispatch then
    do return dispatch.SyncItem, dispatch, item end
    return dispatch.SyncItem, dispatch, item, reason
  end
end

function ItemDispatchManager:GetItemByTid(tid)
  local dispatch = self:GetDispatchByItemCid(tid)
  if dispatch then
    do return dispatch.GetItemByTid, dispatch end
    return dispatch.GetItemByTid, dispatch, tid
  end
end

function ItemDispatchManager:GetItemName(tid)
  local dispatch = self:GetDispatchByItemCid(tid)
  if dispatch then
    do return dispatch.GetItemName, dispatch end
    return dispatch.GetItemName, dispatch, tid
  end
  return ""
end

function ItemDispatchManager:GetItemDesc(tid)
  local dispatch = self:GetDispatchByItemCid(tid)
  if dispatch then
    do return dispatch.GetItemDesc, dispatch end
    return dispatch.GetItemDesc, dispatch, tid
  end
  return ""
end

function ItemDispatchManager:GetItemIcon(tid)
  local dispatch = self:GetDispatchByItemCid(tid)
  if dispatch then
    do return dispatch.GetItemIcon, dispatch end
    return dispatch.GetItemIcon, dispatch, tid
  end
  return ""
end

function ItemDispatchManager:GetItemCount(tid)
  local dispatch = self:GetDispatchByItemCid(tid)
  if dispatch then
    do return dispatch.GetItemCount, dispatch end
    return dispatch.GetItemCount, dispatch, tid
  else
    return 0
  end
end

function ItemDispatchManager:CheckItemCount(tid, count)
  local dispatch = self:GetDispatchByItemCid(tid)
  if dispatch then
    do return dispatch.CheckItemCount, dispatch, tid end
    return dispatch.CheckItemCount, dispatch, tid, count
  else
    return false
  end
end

function ItemDispatchManager:IsStackableItem(tid)
  local dispatch = self:GetDispatchByItemCid(tid)
  if dispatch then
    do return dispatch.IsStackableItem end
    return dispatch.IsStackableItem, dispatch
  end
end

function ItemDispatchManager:IsBagItem(tid)
  local dispatch = self:GetDispatchByItemCid(tid)
  if dispatch then
    do return dispatch.IsBagItem, dispatch end
    return dispatch.IsBagItem, dispatch, tid
  end
end

return ItemDispatchManager
