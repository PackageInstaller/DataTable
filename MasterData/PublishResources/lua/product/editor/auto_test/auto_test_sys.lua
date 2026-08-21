_class("AutoTestSystem_Render", Object)
AutoTestSystem_Render = AutoTestSystem_Render

function AutoTestSystem_Render:Constructor(world)
  self._world = world
  self.svc = self._world:GetService("AutoTest")
  self.md = GameGlobal.GetModule(AutoTestModule)
end

function AutoTestSystem_Render:Execute()
  if not EDITOR then
    return
  end
  if not self.md:IsAutoTest() then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc:GetMainStateInputEnable() then
    return
  end
  if self.svc:IsRunning() then
    return
  end
  GameGlobal.TaskManager():CoreGameStartTask(self.svc.AutoTest, self.svc)
end
