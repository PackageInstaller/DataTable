local DropCfgUtils = {}

function DropCfgUtils.GetCfg(dropTid)
  if not dropTid then
    return nil
  end
  return DT.Drop[dropTid]
end

function DropCfgUtils.GetCfgByfield(field, dropTid)
  if not field or not dropTid then
    return nil
  end
  local cfg = DropCfgUtils.GetCfg(dropTid)
  if not cfg then
    return nil
  end
  return cfg[field]
end

local SSRAwakerSelectOneDrop = DT.GetConstant("SSRAwakerSelectOneDrop")

function DropCfgUtils.GetOneDropAwakerItemTidList(poolTid)
  local rst = {}
  local dropTid = SSRAwakerSelectOneDrop
  if poolTid and DT.Summon[poolTid].Type == cd.SummonPoolType.ChooseUp then
    local SSRAwakerDIYSelectOneDropList = DT.Constant.SSRAwakerDIYSelectOneDrop.Data or {}
    for i = 2, #SSRAwakerDIYSelectOneDropList, 2 do
      if SSRAwakerDIYSelectOneDropList[i] == poolTid then
        dropTid = SSRAwakerDIYSelectOneDropList[i - 1]
        break
      end
    end
  end
  local dataList = DropCfgUtils.GetCfgByfield("data_list", dropTid)
  for _, cfgData in pairs(dataList) do
    if cfgData.DropNum < 1 then
    elseif cfgData.StartDropTime and cfgData.StartDropTime > TimeUtils.GetServerTime() then
    else
      table.insert(rst, cfgData.DropItem)
    end
  end
  return rst
end

function DropCfgUtils.GetProbabilityPercentInfoList(dropTid, totalPercent, rst)
  rst = rst or {}
  local dropCfg = DropCfgUtils.GetCfg(dropTid)
  if not dropCfg then
    return
  end
  local dropDataList = dropCfg.data_list or {}
  local totalWeight = 0
  for _, dropData in ipairs(dropDataList) do
    totalWeight = totalWeight + dropData.WeightOrRate
  end
  for _, dropData in ipairs(dropDataList) do
    local targetPercent = dropData.WeightOrRate / totalWeight * totalPercent
    if dropData.DropType == CommonDefine.DropType.Item then
      local dropItemTid = dropData.DropItem
      rst[dropItemTid] = targetPercent
    elseif dropData.DropType == CommonDefine.DropType.Drop then
      DropCfgUtils.GetProbabilityPercentInfoList(dropData.DropItem, targetPercent, rst)
    end
  end
end

function DropCfgUtils.GetDropDataList(dropTid)
  local dropCfg = DropCfgUtils.GetCfg(dropTid)
  if not dropCfg then
    return {}
  end
  return dropCfg.data_list or {}
end

function DropCfgUtils.GetRandomAbsolutelyDropItemInfoList(dropTid)
  local rst = {}
  local dropCfg = DropCfgUtils.GetCfg(dropTid)
  if not dropCfg then
    return rst
  end
  local dataList = dropCfg.data_list
  local headCfg = dataList[1]
  if not headCfg then
    return rst
  end
  if headCfg.Type == "Random" then
    for _, dropCfgData in ipairs(dataList) do
      if dropCfgData.WeightOrRate == 10000 then
        table.insert(rst, {
          tid = dropCfgData.DropItem,
          num = dropCfgData.DropNum
        })
      end
    end
    if 0 == #rst then
      for _, dropCfgData in ipairs(dataList) do
        if dropCfgData.WeightOrRate > 0 then
          table.insert(rst, {
            tid = dropCfgData.DropItem,
            num = nil
          })
        end
      end
    end
  elseif headCfg.Type == "Weight" then
    local minDrop
    for _, dropCfgData in ipairs(dataList) do
      if dropCfgData.DropItem and (not minDrop or (dropCfgData.DropNum or 0) < (minDrop.DropNum or 0)) then
        minDrop = dropCfgData
      end
    end
    if minDrop then
      table.insert(rst, {
        tid = minDrop.DropItem,
        num = minDrop.DropNum
      })
    end
  end
  return rst
end

return DropCfgUtils
