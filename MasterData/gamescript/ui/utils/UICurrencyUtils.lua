local UICurrencyUtils = {}
local Color_Yellow = "#fff4a7"
local Color_White = "#FFFFFF"

function UICurrencyUtils.GetEnergyCurrencyShow(itemNum)
  local recoverLimit = PlayerDataUtils.GetEnergyNaturalRecoverLimit(DataCenter.playerData.DRole.level)
  if itemNum < recoverLimit then
    do return string.format, "<color=%s>%s/%s</color>", Color_White, itemNum end
    return string.format, "<color=%s>%s/%s</color>", Color_White, itemNum, recoverLimit
  end
  do return string.format, "<color=%s>%s/%s</color>", Color_Yellow, itemNum end
  return string.format, "<color=%s>%s/%s</color>", Color_Yellow, itemNum, recoverLimit
end

function UICurrencyUtils.GetStageGroupUnlockItemCurrencyShow(itemNum)
  local cfgMaximumNumberOfKeysHeld = DT.GetOriginalConstant("MaximumNumberOfKeysHeld")
  local maxOwnNum = cfgMaximumNumberOfKeysHeld and cfgMaximumNumberOfKeysHeld[2]
  if itemNum < maxOwnNum then
    do return string.format, "<color=%s>%s/%s</color>", Color_White, itemNum end
    return string.format, "<color=%s>%s/%s</color>", Color_White, itemNum, maxOwnNum
  end
  do return string.format, "<color=%s>%s/%s</color>", Color_Yellow, itemNum end
  return string.format, "<color=%s>%s/%s</color>", Color_Yellow, itemNum, maxOwnNum
end

return UICurrencyUtils
