local CheckerActivityGeneralNormal = {}

function CheckerActivityGeneralNormal.LengthCheck(param)
  return 1 < #param
end

function CheckerActivityGeneralNormal.ParamsCheck(param)
  local taskId = param[2]
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  return actFrameCtrl:isCompleteActivityTask(taskId)
end

function CheckerActivityGeneralNormal.GetUnlockInfo(param)
  local tip = ConfigData:GetTipContent(801)
  local taskId = param[2]
  local taskCfg = ConfigData.task[taskId]
  if taskCfg == nil then
    error("task is nil " .. tostring(taskId))
    return ""
  end
  local title = LanguageUtil.GetLocaleText(taskCfg.name)
  local intro = LanguageUtil.GetLocaleText(taskCfg.task_intro)
  return string.format(tip, title, intro)
end

return CheckerActivityGeneralNormal
