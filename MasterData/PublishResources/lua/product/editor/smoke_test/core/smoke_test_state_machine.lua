_class("SmokeTestStateMachine", Object)
SmokeTestStateMachine = SmokeTestStateMachine

function SmokeTestStateMachine:Constructor()
  self._manager = GameGlobal.GetModule(TestRobotModule)
  self._currentNode = nil
end

function SmokeTestStateMachine:SetRunData(runData)
  self._runData = runData
end

function SmokeTestStateMachine:GetRunData()
  return self._runData
end

function SmokeTestStateMachine:Update()
  if not self._currentNode then
    return
  end
  local node = self._currentNode
  if SmokeTestStateNodeStatus.Create == node:GetStatus() then
    node:Setup()
  end
  local status = node:Update()
  if SmokeTestStateNodeStatus.Done == status then
    local result = node:GetResult()
    node:Teardown()
  end
end

function SmokeTestStateMachine.CreateInstance(sequence, rootNodeID)
end
