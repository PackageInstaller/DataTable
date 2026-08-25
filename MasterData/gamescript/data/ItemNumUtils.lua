local ItemNumUtils = {}

function ItemNumUtils.GetStr(itemTidOrName, itemNum)
  if itemNum then
    local itemName
    if DT.Item[itemTidOrName] and DT.Item[itemTidOrName].Name then
      itemName = LT.Text(DT.Item[itemTidOrName].Name)
    else
      itemName = LT.Text(itemTidOrName or "")
    end
    do return LT.Textf, "ItemNameNumShow", itemName end
    return LT.Textf, "ItemNameNumShow", itemName, itemNum
  else
    do return LT.Textf, "ItemNumShow" end
    return LT.Textf, "ItemNumShow", itemTidOrName or "", itemName, itemNum
  end
end

function ItemNumUtils.GetNextLineStr(itemTidOrName, itemNum)
  local itemName
  if DT.Item[itemTidOrName] and DT.Item[itemTidOrName].Name then
    itemName = LT.Text(DT.Item[itemTidOrName].Name)
  else
    itemName = LT.Text(itemTidOrName or "")
  end
  do return LT.Textf, "ItemNameNumNextLineShow", itemName end
  return LT.Textf, "ItemNameNumNextLineShow", itemName, itemNum
end

function ItemNumUtils.GetNameStr(itemTidOrName)
  local itemName
  if DT.Item[itemTidOrName] and DT.Item[itemTidOrName].Name then
    itemName = LT.Text(DT.Item[itemTidOrName].Name)
  else
    itemName = LT.Text(itemTidOrName or "")
  end
  do return LT.Textf, "ItemNameShow" end
  return LT.Textf, "ItemNameShow", itemName or ""
end

function ItemNumUtils.GetFlatListStr(itemTidList)
  local retStr = ""
  for i = 1, #itemTidList, 2 do
    retStr = retStr .. ItemNumUtils.GetStr(itemTidList[i], itemTidList[i + 1])
    if i < #itemTidList - 1 then
      retStr = retStr .. " ,"
    end
  end
  return retStr
end

return ItemNumUtils
