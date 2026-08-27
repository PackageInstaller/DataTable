local EpUtil = {}

function EpUtil.CalEpInfinityScore(totalDmg)
  if not ExplorationManager:IsEpInifinity() then
    error("not Ep Inifinity")
    return 0, 0
  end
  local score = 0
  local envId, envDiffId, dungeonId = ExplorationManager:TryGetEpEnv()
  local diffCfg = ConfigData.act_general_ep_difficulty[envDiffId]
  local formularId = diffCfg.infinite_score
  local formularCfgList = ConfigData.act_general_ep_infinite_score[formularId]
  local remaindDmg = totalDmg
  for index, cfg in ipairs(formularCfgList) do
    if index < #formularCfgList then
      local nextLevelDmg = formularCfgList[index + 1].damage_min - cfg.damage_min
      if remaindDmg > nextLevelDmg then
        remaindDmg = remaindDmg - nextLevelDmg
        score = score + nextLevelDmg * cfg.permyriad / 10000
      else
        score = score + remaindDmg * cfg.permyriad / 10000
        break
      end
    elseif index == #formularCfgList then
      score = score + remaindDmg * cfg.permyriad / 10000
    end
  end
  local epInfiniteCoe = ExplorationManager.epCtrl.mapData:GetEpInfiniteCoe()
  return math.floor(score * (1 + epInfiniteCoe / 100)), epInfiniteCoe
end

function EpUtil.CalEpInfinityScore4Act24(totalDmg)
  if not ExplorationManager:IsEpInifinity4Act24() then
    error("not Ep Inifinity for Act24")
    return 0, 0
  end
  local score = 0
  local formularId
  local moduleId, curStageId = ExplorationManager:GetCurModuleDungeonId()
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_InfiniteMode then
    if ConfigData.reinforce_exploration_verify_exploration == nil then
      return false
    end
    for actId, levelCfgDic in pairs(ConfigData.reinforce_exploration_verify_exploration) do
      for stageId, levelCfg in pairs(levelCfgDic) do
        if stageId == curStageId then
          formularId = levelCfg.infinite_score
          goto lbl_48
        end
      end
    end
  end
  ::lbl_48::
  if formularId == nil then
    error("no formularId for Ep Inifinity for Act24")
    return 0, 0
  end
  local formularCfgList = ConfigData.reinforce_exploration_infinite_score[formularId]
  local remaindDmg = totalDmg
  for index, cfg in ipairs(formularCfgList) do
    if index < #formularCfgList then
      local nextLevelDmg = formularCfgList[index + 1].damage_min - cfg.damage_min
      if remaindDmg > nextLevelDmg then
        remaindDmg = remaindDmg - nextLevelDmg
        score = score + nextLevelDmg * cfg.permyriad / 10000
      else
        score = score + remaindDmg * cfg.permyriad / 10000
        break
      end
    elseif index == #formularCfgList then
      score = score + remaindDmg * cfg.permyriad / 10000
    end
  end
  local epInfiniteCoe = ExplorationManager.epCtrl.mapData:GetEpInfiniteCoe()
  return math.floor(score * (1 + epInfiniteCoe / 100)), epInfiniteCoe
end

return EpUtil
