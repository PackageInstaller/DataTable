_class("AutoFightSystem_Render", Object)
AutoFightSystem_Render = AutoFightSystem_Render

function AutoFightSystem_Render:Constructor(world)
  self._world = world
  self.svc = self._world:GetService("AutoFight")
end

function AutoFightSystem_Render:Execute()
  local utilStatSvc = self._world:GetService("UtilData")
  if not utilStatSvc:GetStatAutoFight() then
    return
  end
  local isWaitInputState = self:_IsWaitInputState()
  if not isWaitInputState then
    return
  end
  if not isWaitInputState then
    return
  end
  if self.svc:IsRunning() then
    return
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  GameGlobal.TaskManager():CoreGameStartTask(self.svc.AutoFight, self.svc, teamEntity)
end

function AutoFightSystem_Render:_IsWaitInputState()
  local utilDataSvc = self._world:GetService("UtilData")
  local gameFsmStateID = utilDataSvc:GetCurMainStateID()
  if gameFsmStateID == GameStateID.PickUpChainSkillTarget then
    return true
  end
  return utilDataSvc:GetMainStateInputEnable()
end
