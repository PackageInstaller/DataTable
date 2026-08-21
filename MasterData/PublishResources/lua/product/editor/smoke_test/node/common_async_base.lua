require("base_state_node")
_class("Common_AsyncBase", CTestRobot_Base)
Common_AsyncBase = Common_AsyncBase

function Common_AsyncBase:OnWorking()
  if not self._taskID then
    return self:CreateTask()
  end
  return self:WaitTaskFinish()
end

function Common_AsyncBase:CreateTask()
  self._asyncRes = AsyncOperationStatusData:New()
  local runData = self._manager:GetMissionRunData()
  self._taskID = GameGlobal.TaskManager():StartTask(self.TaskFunc, self, self._asyncRes)
  if self._taskID == -1 then
    return Common_AsyncBase.super:OnWorking()
  end
  return false
end

function Common_AsyncBase:TaskFunc(TT, outResult)
end

function Common_AsyncBase:WaitTaskFinish()
  local isFinished = TaskHelper:GetInstance():IsTaskFinished(self._taskID, true)
  if isFinished then
    self:AfterTask()
    self.m_nNodeState = Enum_ActionState.E_Down
    self._taskID = nil
  end
  return isFinished
end

function Common_AsyncBase:AfterTask()
end
