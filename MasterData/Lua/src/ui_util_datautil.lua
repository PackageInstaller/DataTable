local util = {}

function util.parseRewardConfig(rewardList, isServerData, needSort, clientSortRwdList, originData, needCombine)
  if not rewardList then
    return {}
  end
  needSort = needSort or false
  needCombine = needCombine or false
  local result = {}
  local orderList = {}
  if clientSortRwdList then
    for i = 1, #clientSortRwdList do
      local reward = clientSortRwdList[i]
      local itemType = reward[1]
      local itemId = reward[2]
      local itemNum = reward[3]
      table.insert(orderList, {
        itemType = itemType,
        itemId = itemId,
        itemNum = itemNum
      })
    end
  end
  if isServerData then
    local readyList = {}
    for i = 1, #rewardList do
      local curRwd = rewardList[i]
      local arg1 = curRwd.sortArg1
      local arg11 = curRwd.sort_arg1
      table.insert(readyList, {
        itemType = curRwd.itemtype,
        itemId = curRwd.itemid,
        itemNum = curRwd.itemnum,
        guid = curRwd.guid,
        sortArg1 = curRwd.sort_arg1,
        sortArg2 = curRwd.sort_arg2,
        exts = curRwd.exts
      })
    end
    local sortList = C_DataUtil.ParseLuaRewardConfig(readyList, needSort, orderList, needCombine)
    local list = {}
    for i = 0, sortList.Count - 1 do
      table.insert(list, sortList[i])
    end
    if originData then
      table.sort(rewardList, function(a, b)
        local _, indexA = table.find(list, function(v)
          return v.itemId == a.itemid
        end)
        local _, indexB = table.find(list, function(v)
          return v.itemId == b.itemid
        end)
        return indexA < indexB
      end)
      result = rewardList
    else
      result = list
    end
  else
    local sortList = {}
    local keys = util.getListIdx(rewardList)
    for i = 1, #keys do
      local reward = rewardList[keys[i]]
      if reward ~= nil then
        local itemType = reward[1]
        local itemId = reward[2]
        local itemNum = reward[3]
        table.insert(sortList, {
          itemType = itemType,
          itemId = itemId,
          itemNum = itemNum
        })
      end
    end
    if needSort then
      local listRwds = C_DataUtil.ParseLuaRewardConfig(sortList, needSort, orderList)
      sortList = {}
      for i = 0, listRwds.Count - 1 do
        local rwd = listRwds[i]
        table.insert(sortList, {
          itemType = rwd.itemType,
          itemId = rwd.itemId,
          itemNum = rwd.itemNum
        })
      end
    end
    result = sortList
  end
  return result
end

function util.getListIdx(rewardList)
  local list = {}
  for idx, _ in pairs(rewardList) do
    table.insert(list, idx)
  end
  table.sort(list)
  return list
end

function util.parseRewardConfigNoNum(reward)
  local result = {}
  for _, v in pairs(reward) do
    local itemType = v[1]
    local itemId = v[2]
    table.insert(result, {
      itemType = itemType,
      itemId = itemId,
      itemNum = 0
    })
  end
  return result
end

function util.parseRangeRewardConfig(reward)
  local result = {}
  for _, v in pairs(reward) do
    local itemType = v[1]
    local itemId = v[2]
    local itemNumTxt = ""
    local itemNum_1 = v[3]
    local itemNum_2 = v[4] or v[3]
    if itemNum_1 == -1 then
      local rewardchanceTxt = L_GameTpl:getDungeonEntrustRewardChance():getNameById(itemNum_2)
      if rewardchanceTxt then
        itemNumTxt = rewardchanceTxt
      else
        itemNumTxt = L_WordsTpl:getValue("residual_code_datautil_01")
      end
    elseif itemNum_1 == itemNum_2 then
      itemNumTxt = tostring(itemNum_1)
    else
      itemNumTxt = string.format("%d~%d", itemNum_1, itemNum_2)
    end
    if itemType == 10 and itemId == 4 then
      if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.heroFavorability) == true then
        table.insert(result, {
          itemType = itemType,
          itemId = itemId,
          itemNumTxt = itemNumTxt
        })
      end
    else
      table.insert(result, {
        itemType = itemType,
        itemId = itemId,
        itemNumTxt = itemNumTxt
      })
    end
  end
  return result
end

function util.parseRewardConfigItem(reward)
  local result = {}
  if reward then
    local itemType = reward[1]
    local itemId = reward[2]
    local itemNum = reward[3]
    result = {
      itemType = itemType,
      itemId = itemId,
      itemNum = itemNum
    }
  end
  return result
end

function util.paresRewardProto(rewards)
  local result = {}
  for _, v in ipairs(rewards) do
    if not math.isEmpty(v.itemtype) then
      table.insert(result, {
        itemType = v.itemtype,
        itemId = v.itemid,
        itemNum = v.itemnum,
        guid = v.guid
      })
    end
  end
  return result
end

function util.getEmptyModuleDatas(num)
  local datas = {}
  for i = 1, num do
    table.insert(datas, {})
  end
  return datas
end

function util.checkItemEnough(reward, showTip)
  if table.isEmpty(reward) then
    return true
  end
  for _, item in ipairs(reward) do
    if L_ItemTplManager:getItemNum(item[1], item[2]) < item[3] then
      if showTip then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getTplById("notice_common_lackItem"))
      end
      return false
    end
  end
  return true
end

function util.checkItemEnough2(rewards, showTip)
  for i = 0, rewards.Count - 1 do
    local reward = rewards[i]
    local itemType, itemId, itemNum = reward[0], reward[1], reward[2]
    if itemNum > L_ItemTplManager:getItemNum(itemType, itemId) then
      if showTip then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getTplById("notice_common_lackItem"))
      end
      return false
    end
  end
  return true
end

function util.getItemStacks(itemType, id, num)
  local res = {}
  if itemType == L_Const.resType.commonItem then
    local _commonItemTpl = L_GameTpl:getCommonItemTpl()
    local tpl = _commonItemTpl:getTplById(id)
    if tpl == nil then
      return res
    end
    local stackNum = tpl.stackNum
    if stackNum <= 0 then
      res = {num}
    else
      while 0 < num do
        table.insert(res, math.min(num, stackNum))
        num = num - stackNum
      end
    end
  elseif itemType == L_Const.resType.petEgg then
    for i = 1, num do
      table.insert(res, 1)
    end
  else
    res = {num}
  end
  return res
end

function util.setModuleItemSelect(modules, bindDataKey, value, bindKey)
  for _, module in ipairs(modules) do
    module.bind[bindKey] = value == module.bind[bindDataKey]
  end
end

return util
