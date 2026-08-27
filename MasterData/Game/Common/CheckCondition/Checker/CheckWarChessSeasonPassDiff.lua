local CheckerWarChessSeasonPassDiff = {}
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function CheckerWarChessSeasonPassDiff.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckerWarChessSeasonPassDiff.ParamsCheck(param)
  local actFrameId = param[2]
  local diffId = param[3]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
  if actFrameData == nil then
    if isGameDev then
      error("activity is nil frameId is " .. tostring(actFrameId))
    end
    return false
  end
  local cat = actFrameData:GetActivityFrameCat()
  if actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Hallowmas then
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
    local seasonData = seasonCtrl:GetHallowmasData(actFrameData:GetActId())
    if seasonData == nil then
      return false
    end
    return seasonData:GetCompleteDiffDic()[diffId]
  elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Winter23 then
    local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
    local winter23Data = winter23Ctrl:GetWinter23DataByActId(actFrameData:GetActId())
    if winter23Data == nil then
      return false
    end
    local seasonId = winter23Data:GetWinter23WarchessSeasonId()
    local wcsPassedData = WarChessSeasonManager:GetWCSPassedTower()
    local sPassedData = wcsPassedData[seasonId]
    if sPassedData == nil then
      return false
    end
    local passedMap = sPassedData.difficultyRecord
    if passedMap == nil then
      return false
    end
    return passedMap[diffId]
  elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Season then
    local activitySeasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    local activitySeasonData = activitySeasonCtrl:GetSeasonData()
    local seasonId = activitySeasonData:GetSeasonMainCfg().warchess_season_id
    local wcsPassedData = WarChessSeasonManager:GetWCSPassedTower()
    local sPassedData = wcsPassedData[seasonId]
    if sPassedData == nil then
      return false
    end
    local passedMap = sPassedData.difficultyRecord
    if passedMap == nil then
      return false
    end
    return passedMap[diffId]
  elseif isGameDev then
    warn("activity is nil")
  end
  return false
end

function CheckerWarChessSeasonPassDiff.GetUnlockInfo(param)
  local actFrameId = param[2]
  local diffId = param[3]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
  if actFrameData == nil then
    if isGameDev then
      error("activity is nil frameId is " .. tostring(actFrameId))
    end
    return ""
  end
  if actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Hallowmas then
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
    local seasonData = seasonCtrl:GetHallowmasData(actFrameData:GetActId())
    if seasonData == nil then
      return ""
    end
    local envId = seasonData:GetHallowmasEnvIdByDifficultyId(diffId)
    local envName = LanguageUtil.GetLocaleText(ConfigData.activity_hallowmas_general_env[envId].general_env_name)
    local stageInfoCfg = seasonData:GetHallowmasStageInfoCfg()
    return string.format(ConfigData:GetTipContent(8709), envName, LanguageUtil.GetLocaleText(stageInfoCfg[diffId].difficulty_name))
  elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Winter23 then
    local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
    local winter23Data = winter23Ctrl:GetWinter23DataByActId(actFrameData:GetActId())
    if winter23Data == nil then
      return false
    end
    local seasonId = winter23Data:GetWinter23WarchessSeasonId()
    local envCfg = WarChessSeasonManager:GetEnvCfgBySeasonAndDiff(seasonId, diffId)
    local envName = LanguageUtil.GetLocaleText(envCfg.general_env_name)
    local stageInfoCfg = WarChessSeasonManager:GetWCSStageInfoByDiffId(seasonId, diffId)
    local diffName = LanguageUtil.GetLocaleText(stageInfoCfg.difficulty_name)
    return string.format(ConfigData:GetTipContent(8709), envName, diffName)
  elseif actFrameData:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.Season then
    local activitySeasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    local activitySeasonData = activitySeasonCtrl:GetSeasonData()
    local seasonId = activitySeasonData:GetSeasonMainCfg().warchess_season_id
    local envCfg = WarChessSeasonManager:GetEnvCfgBySeasonAndDiff(seasonId, diffId)
    local envName = LanguageUtil.GetLocaleText(envCfg.general_env_name)
    local stageInfoCfg = WarChessSeasonManager:GetWCSStageInfoByDiffId(seasonId, diffId)
    local diffName = LanguageUtil.GetLocaleText(stageInfoCfg.difficulty_name)
    return string.format(ConfigData:GetTipContent(8709), envName, diffName)
  elseif isGameDev then
    warn("activity is nil")
  end
  return ""
end

return CheckerWarChessSeasonPassDiff
