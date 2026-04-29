require("base_state_node")
_class("Common_WaitRunDataTaskEnd", CTestRobot_Base)
Common_WaitRunDataTaskEnd = Common_WaitRunDataTaskEnd

function Common_WaitRunDataTaskEnd:Constructor(pManger, timeout)
  if timeout then
    self._maxTimeoutMS = timeout * 0.001
  end
end

function Common_WaitRunDataTaskEnd:OnBegin(...)
  self._waitStart = os.clock()
  return Common_WaitRunDataTaskEnd.super.OnBegin(self, ...)
end

function Common_WaitRunDataTaskEnd:OnWorking()
  local runData = self.m_pManager:GetMissionRunData()
  local taskIDList = runData:GetRunTaskIDList()
  local isFinish = TaskHelper:GetInstance():IsAllTaskFinished(taskIDList)
  local isTimeout = self._maxTimeoutMS and os.clock() - self._waitStart > self._maxTimeoutMS or false
  if not isFinish and not isTimeout then
    return false
  end
  return Common_WaitRunDataTaskEnd.super.OnWorking(self)
end
