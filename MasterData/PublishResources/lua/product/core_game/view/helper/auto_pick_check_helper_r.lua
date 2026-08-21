_class("AutoPickCheckHelperRender", Object)
AutoPickCheckHelperRender = AutoPickCheckHelperRender

function AutoPickCheckHelperRender.IsAutoFightRunning()
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local autoSvc = mainWorld:GetService("AutoFight")
  if autoSvc and autoSvc:IsRunning() then
    return true
  else
    return false
  end
end

function AutoPickCheckHelperRender.ReportAutoFightPickError(errorStep, errorType, activeSkillID, curPickPos)
  local cmd = ClientExceptionReportCommand.CreateAutoFightPickErrorReport(activeSkillID, errorStep, errorType, nil, nil, curPickPos)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClientExceptionReport, cmd)
end

function AutoPickCheckHelperRender.CheckPetSkillReady(petEntity, skillID)
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local utilDataSvc = mainWorld:GetService("UtilData")
  if utilDataSvc and petEntity then
    local ready = utilDataSvc:GetPetSkillReadyAttr(petEntity, skillID)
    if ready and ready == 1 then
      return true
    else
      return false
    end
  end
  return true
end
