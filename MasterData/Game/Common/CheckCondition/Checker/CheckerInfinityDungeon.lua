local CheckerInfinityDungeon = {}
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function CheckerInfinityDungeon.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckerInfinityDungeon.IsFulfillInfinityLevel(infinitySategId, needLevel)
  if needLevel == -1 then
    return PlayerDataCenter.infinityData:IsInfinityDungeonCompleted(infinitySategId)
  else
    local processing = PlayerDataCenter.infinityData:GetInfinityDungeonProcess(infinitySategId)
    if processing ~= nil and needLevel <= processing then
      return true
    end
  end
  return false
end

function CheckerInfinityDungeon.ParamsCheck(param)
  return CheckerInfinityDungeon.IsFulfillInfinityLevel(param[2], param[3])
end

function CheckerInfinityDungeon.GetUnlockInfo(param)
  local infinitySategId = param[2]
  local needLevel = param[3]
  local cfg = ConfigData.endless
  local indexTable = cfg.levelDic[infinitySategId]
  local sectorId = indexTable.sectorId
  local index = indexTable.index
  local chapterId = ConfigData.sector_sector_resident.sectorId2ChapterIdMap[sectorId]
  if chapterId ~= nil then
    sectorId = chapterId
  end
  local str = ""
  if needLevel == -1 then
    str = string.format(ConfigData:GetTipContent(TipContent.LockTip_Endless), tostring(sectorId), tostring(index * 10))
  else
    str = string.format(ConfigData:GetTipContent(TipContent.LockTip_EndlessLevel), tostring(sectorId), tostring(index * 10), tostring(needLevel))
  end
  return str
end

return CheckerInfinityDungeon
