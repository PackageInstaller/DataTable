local CheckerStageChallengeComplete = {}

function CheckerStageChallengeComplete.LengthCheck(param)
  return #param == 3
end

function CheckerStageChallengeComplete.ParamsCheck(param)
  local type = param[2]
  if type == 1 then
    local dungeonId = param[3]
    return PlayerDataCenter.dungeonCenterData:IsDgChallengeTaskCompleteAll(dungeonId)
  elseif type == 2 then
    local stageId = param[3]
    return PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskCompleteAll(stageId)
  else
    error("not support challenge checker type")
    return true
  end
end

function CheckerStageChallengeComplete.GetUnlockInfo(param)
  local tip = ConfigData:GetTipContent(207)
  local name
  local type = param[2]
  if type == 1 then
    local dungeonId = param[3]
    local dungeonStageCfg = ConfigData.battle_dungeon[dungeonId]
    name = LanguageUtil.GetLocaleText(self.__dungeonStageCfg.name)
  elseif type == 2 then
    local stageId = param[3]
    local stageCfg = ConfigData.sector_stage[stageId]
    name = LanguageUtil.GetLocaleText(stageCfg.name)
  else
    error("not support challenge checker type")
    name = "err"
  end
  return string.format(tip, name)
end

return CheckerStageChallengeComplete
