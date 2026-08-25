local ConstantCfgUtils = {}

function ConstantCfgUtils.GetMonthlySpendingLimitsInfo()
  local rst = {}
  local cfgList = DT.GetOriginalConstant("MonthlySpendingLimits")
  for i = 1, #cfgList, 3 do
    table.insert(rst, {
      minAge = cfgList[i] or nil,
      maxAge = cfgList[i + 1] or nil,
      limitNum = cfgList[i + 2] or nil
    })
  end
  return rst
end

function ConstantCfgUtils.GetDefaultBgMusicId()
  local cfgList = DT.GetOriginalConstant("DefaultBgMusicId")
  if cfgList then
    return cfgList[1]
  end
  return nil
end

return ConstantCfgUtils
