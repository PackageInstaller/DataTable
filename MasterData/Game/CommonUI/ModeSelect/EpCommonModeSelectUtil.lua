local EpCommonModeSelectUtil = {}

function EpCommonModeSelectUtil.IsEpCommonEnvHaveDiff(envId, diff, index)
  local envCfg = ConfigData.act_general_ep_env[envId]
  local stageList = envCfg.stage_id
  local stageCount = #stageList
  if index <= stageCount then
    return true
  end
  return false
end

function EpCommonModeSelectUtil.IsEpCommonEnvUnlock(envId)
  local envCfg = ConfigData.act_general_ep_env[envId]
  local isUnlock = CheckCondition.CheckLua(envCfg.pre_condition, envCfg.pre_para1, envCfg.pre_para2)
  if not isUnlock then
    local unlockDes = CheckCondition.GetUnlockInfoLua(envCfg.pre_condition, envCfg.pre_para1, envCfg.pre_para2)
    return false, unlockDes
  end
  return true
end

function EpCommonModeSelectUtil.IsEpCommonDiffUnlock(envId, diff, index)
  local diffCfg = ConfigData.act_general_ep_difficulty[diff]
  local isUnlock = CheckCondition.CheckLua(diffCfg.pre_condition, diffCfg.pre_para1, diffCfg.pre_para2, diffCfg.pre_para3)
  if not isUnlock then
    local unlockDes = CheckCondition.GetUnlockInfoLua(diffCfg.pre_condition, diffCfg.pre_para1, diffCfg.pre_para2, diffCfg.pre_para3)
    return false, unlockDes
  end
  return true
end

function EpCommonModeSelectUtil.IsEpCommonInfinity(diff)
  local diffCfg = ConfigData.act_general_ep_difficulty[diff]
  if diffCfg.infinite_score ~= nil and diffCfg.infinite_score ~= 0 then
    return true
  end
  return false
end

return EpCommonModeSelectUtil
