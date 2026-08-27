local CheckerSectorStage = {}
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local SectorEnum = require("Game.Sector.SectorEnum")

local function GetDiffStr(difficult)
  local diffstr
  if difficult == ExplorationEnum.eDifficultType.Normal then
    diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_1)
  elseif difficult == ExplorationEnum.eDifficultType.Hard then
    diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_2)
  else
    diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_3)
  end
  return diffstr
end

local function GetSectorInfo(difficultStr, sectorStageCfg)
  local sectorId = ConfigData:GetSectorIdShow(sectorStageCfg.sector)
  return string.format(ConfigData:GetTipContent(TipContent.LockTip_Sector), tostring(sectorId), tostring(sectorId), tostring(sectorStageCfg.num), difficultStr)
end

local function DefaultInfoFunc(sectorStageCfg)
  if ConfigData.sector.onlyShowStageIdSectorDic[sectorStageCfg.sector] then
    local sectorCfg = ConfigData.sector[sectorStageCfg.sector]
    local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
    return string.format(ConfigData:GetTipContent(7007), sectorName, sectorStageCfg.num)
  end
  local diffstr = GetDiffStr(sectorStageCfg.difficulty)
  return GetSectorInfo(diffstr, sectorStageCfg)
end

local function DefaultMainUnlockInfoFunc(sectorStageCfg, chapterId)
  local difficultStr = GetDiffStr(sectorStageCfg.difficulty)
  return string.format(ConfigData:GetTipContent(TipContent.LockTip_Sector), tostring(chapterId), tostring(chapterId), tostring(sectorStageCfg.num), difficultStr)
end

local specialInfoFuncDic = {
  [6] = function(sectorStageCfg)
    local actId, data, inRuning = PlayerDataCenter.allActivitySectorIData:GetDataBySectorIdRunning(sectorStageCfg.sector)
    if inRuning then
      local sectorId, _ = ConfigData:GetSectorIdShow(sectorStageCfg.sector)
      local msg = string.format(ConfigData:GetTipContent(13010), sectorId, sectorStageCfg.num)
      return string.format(ConfigData:GetTipContent(262), msg)
    end
    return DefaultInfoFunc(sectorStageCfg)
  end,
  [90012] = function(sectorStageCfg)
    local sectorCfg = ConfigData.sector[sectorStageCfg.sector]
    local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
    return string.format(ConfigData:GetTipContent(7007), sectorName, sectorStageCfg.num)
  end,
  [90011] = function(sectorStageCfg)
    local sectorId, _ = ConfigData:GetSectorIdShow(sectorStageCfg.sector)
    local msg = string.format(ConfigData:GetTipContent(13007), sectorId, sectorStageCfg.num)
    return string.format(ConfigData:GetTipContent(262), msg)
  end,
  [110011] = function(sectorStageCfg)
    local sectorCfg = ConfigData.sector[sectorStageCfg.sector]
    local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
    local stageName = LanguageUtil.GetLocaleText(sectorStageCfg.name)
    local stageShortName = string.format(ConfigData:GetTipContent(13006), "", tostring(sectorStageCfg.num))
    local str = sectorName .. ":" .. stageShortName .. "-" .. stageName
    return string.format(ConfigData:GetTipContent(262), str)
  end,
  [240011] = function(sectorStageCfg)
    local sectorCfg = ConfigData.sector[sectorStageCfg.sector]
    local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
    local stageName = LanguageUtil.GetLocaleText(sectorStageCfg.name)
    local str = sectorName .. ":" .. stageName
    return string.format(ConfigData:GetTipContent(262), str)
  end,
  [240012] = function(sectorStageCfg)
    local sectorCfg = ConfigData.sector[sectorStageCfg.sector]
    local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
    local stageName = LanguageUtil.GetLocaleText(sectorStageCfg.name)
    local str = sectorName .. ":" .. stageName
    return string.format(ConfigData:GetTipContent(262), str)
  end,
  [450011] = function(sectorStageCfg)
    local sectorCfg = ConfigData.sector[sectorStageCfg.sector]
    local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
    local stageName = LanguageUtil.GetLocaleText(sectorStageCfg.name)
    return string.format(ConfigData:GetTipContent(262), stageName)
  end,
  [450012] = function(sectorStageCfg)
    local sectorCfg = ConfigData.sector[sectorStageCfg.sector]
    local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
    local stageName = LanguageUtil.GetLocaleText(sectorStageCfg.name)
    return string.format(ConfigData:GetTipContent(262), stageName)
  end
}

function CheckerSectorStage.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckerSectorStage.ParamsCheck(param)
  return PlayerDataCenter.sectorStage:IsStageComplete(param[2])
end

function CheckerSectorStage.GetUnlockInfo(param)
  local sectorStageId = param[2]
  local sectorStageCfg = ConfigData.sector_stage[sectorStageId]
  if sectorStageCfg == nil then
    return ""
  end
  local info
  local chapterId = ConfigData.sector_sector_resident.sectorId2ChapterIdMap[sectorStageCfg.sector]
  if chapterId ~= nil then
    local realChapterId = ConfigData:GetSectorIdShow(sectorStageCfg.sector)
    realChapterId = realChapterId == 0 and chapterId or realChapterId
    info = DefaultMainUnlockInfoFunc(sectorStageCfg, realChapterId)
    return info
  end
  local specialFunc = specialInfoFuncDic[sectorStageCfg.sector]
  if specialFunc ~= nil then
    info = specialFunc(sectorStageCfg)
    return info
  end
  return DefaultInfoFunc(sectorStageCfg)
end

return CheckerSectorStage
