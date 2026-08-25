local SetupDataUtils = {}

function SetupDataUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.Setup[tid]
end

function SetupDataUtils.GetCfgByField(field, tid)
  if not field or not tid then
    return nil
  end
  local cfg = SetupDataUtils.GetCfg(tid)
  if not cfg then
    return nil
  end
  return cfg[field]
end

function SetupDataUtils.GetRangeList(cfg)
  local rst = {}
  local range = cfg.Range
  if not range then
    return rst
  end
  while string.find(range, ",") do
    local tailIdx = string.find(range, ",")
    local subStr = string.sub(range, 1, tailIdx - 1)
    range = string.sub(range, tailIdx + 1, #range)
    table.insert(rst, subStr)
  end
  table.insert(rst, range)
  return rst
end

local _sortedCfgList = {}

function SetupDataUtils.GetSortedEnableCfgList()
  if table.next(_sortedCfgList) then
    return _sortedCfgList
  end
  local rst = {}
  for _, cfg in pairs(DT.Setup) do
    if not SettingManager.Instance:CheckSetupEnable(cfg) then
    else
      table.insert(rst, cfg)
    end
  end
  table.sort(rst, function(a, b)
    return a.SortID < b.SortID
  end)
  _sortedCfgList = rst
  return rst
end

local _uName2SetUpCfgMap = {}

function SetupDataUtils.GetCfgByUniqueName(uName)
  if _uName2SetUpCfgMap[uName] then
    return _uName2SetUpCfgMap[uName]
  end
  for _, config in pairs(DT.Setup) do
    if config.UniqueName then
      _uName2SetUpCfgMap[config.UniqueName] = config
    end
  end
  return _uName2SetUpCfgMap[uName]
end

return SetupDataUtils
