local BaseItemDispatch = System.NewClass("BaseItemDispatch")

function BaseItemDispatch:GetItemCount(tid)
  return 0
end

function BaseItemDispatch:InitItem(item)
  ItemDataUtils.InitBagItem(item)
end

function BaseItemDispatch:SyncItem(item, reason)
  ItemDataUtils.SyncBagItem(item, reason)
end

function BaseItemDispatch:GetItemByTid(tid)
end

function BaseItemDispatch:GetItemName(tid)
  local itemCfg = ItemDataUtils.GetItemConfig(tonumber(tid))
  if not itemCfg then
    return ""
  end
  do return LT.Text end
  return LT.Text, itemCfg.Name
end

function BaseItemDispatch:GetRichItemName(tid, appendStr, isUnderLine)
  local itemCfg = ItemDataUtils.GetItemConfig(tonumber(tid))
  if not itemCfg then
    return ""
  end
  local itemName = LT.Text(itemCfg.Name)
  itemName = itemName .. (appendStr or "")
  local color = DT.ColorConfig.OptionHighlight.Dark
  if not isUnderLine then
    do return string.format, "<color=%s>%s</color>", color end
    return string.format, "<color=%s>%s</color>", color, itemName
  else
    do return string.format, "<color=%s><u>%s</u></color>", color end
    return string.format, "<color=%s><u>%s</u></color>", color, itemName
  end
end

function BaseItemDispatch:GetItemDesc(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "config is nil:" .. tid)
  return LT.Text(config.Desc) or ""
end

function BaseItemDispatch:GetItemIcon(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  if not config then
    Logger.Error("[GetItemIcon] error params:", tid)
    return
  end
  if config.Type ~= CommonDefine.ItemType.AwakerItem then
    return config.Icon or ""
  end
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(tid)
  do return AwakerDataUtils.GetLittleIcon end
  return AwakerDataUtils.GetLittleIcon, awakerTid
end

function BaseItemDispatch:CheckItemCount(tid, count)
  local itemCount = self:GetItemCount(tid)
  if count < 0 then
    return false
  end
  return count <= itemCount
end

function BaseItemDispatch:IsStackableItem(tid)
  return false
end

function BaseItemDispatch:IsBagItem(tid)
  return false
end

return BaseItemDispatch
