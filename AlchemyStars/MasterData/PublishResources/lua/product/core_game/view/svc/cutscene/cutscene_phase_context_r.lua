_class("CutscenePhaseContext", Object)
CutscenePhaseContext = CutscenePhaseContext

function CutscenePhaseContext:Constructor(world)
  self._world = world
  self._waitTaskList = {}
end

function CutscenePhaseContext:GetCutsceneWorld()
  return self._world
end

function CutscenePhaseContext:AddPhaseTask(taskID)
  self._waitTaskList[#self._waitTaskList + 1] = taskID
end

function CutscenePhaseContext:GetPhaseTaskList()
  return self._waitTaskList
end
