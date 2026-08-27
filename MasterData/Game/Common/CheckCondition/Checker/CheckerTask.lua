local CheckerTask = {}

function CheckerTask.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckerTask.ParamsCheck(param)
  return PlayerDataCenter.allTaskData:IsMainTaskComplete(param[2])
end

function CheckerTask.GetUnlockInfo(param)
  local taskId = param[2]
  local taskCfg = ConfigData.task[taskId]
  if taskCfg ~= nil then
    return string.format(ConfigData:GetTipContent(915), LanguageUtil.GetLocaleText(taskCfg.name))
  end
  return ""
end

return CheckerTask
