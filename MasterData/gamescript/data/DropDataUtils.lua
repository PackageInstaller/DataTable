local DropDataUtils = {}

function DropDataUtils.GetCfg(dropTid)
  if not dropTid then
    return nil
  end
  return DT.Drop[dropTid]
end

function DropDataUtils.GetCfgByfield(field, dropTid)
  if not field or not dropTid then
    return nil
  end
  local cfg = DropDataUtils.GetCfg(dropTid)
  if not cfg then
    return nil
  end
  return cfg[field]
end

function DropDataUtils.GetDropItemTids(dropTid)
  if not dropTid then
    return {}
  end
  local now = TimeUtils.GetServerTime()
  local ITEM_DROP_TYPE = CommonDefine.DropType.Item
  local rst = {}
  local dataList = DropDataUtils.GetCfgByfield("data_list", dropTid)
  for _, cfgData in pairs(dataList) do
    if cfgData.DropType == ITEM_DROP_TYPE and cfgData.DropNum >= 1 and now >= (cfgData.StartDropTime or 0) then
      table.insert(rst, cfgData.DropItem)
    end
  end
  return rst
end

return DropDataUtils
