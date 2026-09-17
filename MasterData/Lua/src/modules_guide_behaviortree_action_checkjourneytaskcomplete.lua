local this = L_BevTree:registClass("guide.checkJourneyTaskComplete", L_BevTree.action)
local _journeyTaskTpl = L_GameTpl:getJourneyTaskTpl()

function this:param()
  self.journeyTaskId = 0
  self.checkState = 0
  self.isTrue = 0
  self.isQuickCheck = 0
end

function this:parse()
  self.journeyTaskId = self:getParam("journeyTaskId", true)
  local tpl = _journeyTaskTpl:getTplById(self.journeyTaskId)
  self.taskId = tpl and tpl.taskId
  self.checkState = self:getParam("checkState", true) or 0
  local isTrue = self:getParam("isTrue", true) or 0
  self.isTrue = isTrue ~= 0
  local isQuickCheck = self:getParam("isQuickCheck", true) or 0
  self.isQuickCheck = isQuickCheck ~= 0
end

function this:execute()
  local state = AzurWorld.TaskMgr.m_Module:GetJourneyTaskState(self.taskId)
  local JourneyTaskState = CS.Azur.Gameplay.Task.JourneyTaskState
  local result = false
  if self.checkState == 0 then
    result = 0 < state.value__ & (JourneyTaskState.COMPLETED.value__ | JourneyTaskState.GAINED.value__)
  elseif self.checkState == 1 then
    result = 0 < state.value__ & JourneyTaskState.TRACEING.value__
  end
  if result == self.isTrue then
    return L_BevTree.taskResult.Success
  end
  if self.isQuickCheck then
    return L_BevTree.taskResult.Failure
  end
  return L_BevTree.taskResult.Running
end

return this
