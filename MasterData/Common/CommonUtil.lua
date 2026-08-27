CommonUtil = {}

function CommonUtil.SplitStrToNumber(str, pattern)
  local list = string.split(str, pattern)
  for k, v in ipairs(list) do
    list[k] = tonumber(v)
  end
  return list
end

function CommonUtil.SplitStrToString(str, pattern)
  local list = string.split(str, pattern)
  for k, v in ipairs(list) do
    list[k] = v
  end
  return list
end

function CommonUtil.SplitStrToStrAndNumber(str, p1, p2)
  local list = string.split(str, p1)
  local list1 = {}
  local list2 = {}
  for k, v in ipairs(list) do
    local tmpList = string.split(v, p2)
    if 2 <= #tmpList then
      table.insert(list1, tmpList[1])
      table.insert(list2, tonumber(tmpList[2]))
    end
  end
  return list1, list2
end

function CommonUtil.SplitStrToDoubleNumber(str, p1, p2)
  local list = string.split(str, p1)
  local list1 = {}
  local list2 = {}
  for k, v in ipairs(list) do
    local tmpList = string.split(v, p2)
    if 2 <= #tmpList then
      table.insert(list1, tonumber(tmpList[1]))
      table.insert(list2, tonumber(tmpList[2]))
    end
  end
  return list1, list2
end

function CommonUtil.SplitStrToDic(str, p1, p2, KeyAction, valueAction)
  local list = string.split(str, p1)
  local dic = {}
  for k, v in ipairs(list) do
    local tmpList = string.split(v, p2)
    if 2 <= #tmpList then
      local key = KeyAction and KeyAction(tmpList[1]) or tmpList[1]
      local value = valueAction and valueAction(tmpList[2]) or tmpList[2]
      dic[key] = value
    end
  end
  return dic
end

function CommonUtil.NewFullList(len, content)
  local list = {}
  for i = 1, len do
    list[i] = content
  end
  return list
end

function CommonUtil.GetDetailDescribeSetting(eGameSetDescType)
  local setCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  return setCtrl:GetIsShowDetailDescribe(eGameSetDescType)
end

function CommonUtil.GetIsNeedPlayUltrSkillAnimi(skillId, setPlayed)
  local setCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  local index = setCtrl:GetGSMultSettingIndex(eGameSetDescType.ultrSkillAnimi)
  if index == 0 then
    return false
  elseif index == 1 then
    if setCtrl:IsTodayPlayedUltSkillAnimi(skillId) then
      return false
    end
    if setPlayed then
      setCtrl:SetIsTodayPlayedUltSkillAnimi(skillId, true)
    end
    return true
  else
    if setPlayed then
      setCtrl:SetIsTodayPlayedUltSkillAnimi(skillId, true)
    end
    return true
  end
end

function CommonUtil.IsOpenDormFightInvited()
  local setCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  local index = setCtrl:GetGSMultSettingIndex(eGameSetDescType.dormFightCoundBeInvited)
  if index == nil then
    return true
  end
  if index == 0 then
    return false
  end
  return true
end

function CommonUtil.IsOpenUltSkillAuto()
  local setCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  local index = setCtrl:GetGSMultSettingIndex(eGameSetDescType.ultSkill_auto)
  if index == nil then
    return true
  end
  if index == 0 then
    return false
  end
  return true
end

function CommonUtil.IsOpenFairyBattlePerform()
  local setCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  local index = setCtrl:GetGSMultSettingIndex(eGameSetDescType.fairyBattlePerform)
  if index == nil then
    return true
  end
  if index == 0 then
    return false
  end
  return true
end

function CommonUtil.DefaultItemsSortList(item_ids, item_nums, sortDic)
  local itemList = {}
  local itemNumDic = {}
  for idx, id in pairs(item_ids) do
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(id))
    else
      itemNumDic[id] = item_nums[idx]
      table.insert(itemList, itemCfg)
    end
  end
  local itemList = CommonUtil.DefaultItemsSort(itemList, sortDic)
  table.removeall(item_ids)
  table.removeall(item_nums)
  for _, itemCfg in pairs(itemList) do
    local id = itemCfg.id
    table.insert(item_ids, id)
    table.insert(item_nums, itemNumDic[id])
  end
  return item_ids, item_nums
end

function CommonUtil.GetIsWarChessQuickMove()
  local setCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  local index = setCtrl:GetGSMultSettingIndex(eGameSetDescType.quick_move)
  return index == 1
end

function CommonUtil.GetIsWarChessQuickInteract()
  local setCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  local index = setCtrl:GetGSMultSettingIndex(eGameSetDescType.quick_interaction)
  return index == 1
end

function CommonUtil.DefaultItemsSortList(item_ids, item_nums, sortDic)
  local itemList = {}
  local itemNumDic = {}
  for idx, id in pairs(item_ids) do
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(id))
    else
      itemNumDic[id] = item_nums[idx]
      table.insert(itemList, itemCfg)
    end
  end
  local itemList = CommonUtil.DefaultItemsSort(itemList, sortDic)
  table.removeall(item_ids)
  table.removeall(item_nums)
  for _, itemCfg in pairs(itemList) do
    local id = itemCfg.id
    table.insert(item_ids, id)
    table.insert(item_nums, itemNumDic[id])
  end
  return item_ids, item_nums
end

function CommonUtil.DefaultItemsSort(itemCfgs, sortDic)
  if #itemCfgs == 1 then
    return itemCfgs
  end
  local count = 0
  if sortDic ~= nil then
    count = table.count(sortDic)
  end
  table.sort(itemCfgs, function(a, b)
    local aSort = 1
    local bSort = 1
    if count ~= 0 then
      aSort = sortDic[a.order_sort] or count + 1
      bSort = sortDic[b.order_sort] or count + 1
    end
    if aSort ~= bSort then
      return aSort < bSort
    end
    aSort = a.order_sort
    bSort = b.order_sort
    if aSort ~= bSort then
      return aSort < bSort
    end
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    return a.id < b.id
  end)
  return itemCfgs
end

CommonUtil.UInt32Max = 4294967295
CommonUtil.Int32Max = 2147483647
CommonUtil.UInt16Max = 65535
CommonUtil.Int16Max = 32767
CommonUtil.Int64Max = math.maxinteger
CommonUtil.Int64Min = math.mininteger
CommonUtil.DaySeconds = 86400
