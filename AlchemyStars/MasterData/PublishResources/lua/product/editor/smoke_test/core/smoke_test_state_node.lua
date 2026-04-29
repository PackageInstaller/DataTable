_class("SmokeTestStateNode", Object)
SmokeTestStateNode = SmokeTestStateNode

function SmokeTestStateNode:Constructor()
  self._manager = GameGlobal.GetModule(TestRobotModule)
  self._state = SmokeTestStateNodeStatus.Create
  self._result = 1
end

function SmokeTestStateNode:RegisterOwnerMachine(machine)
  self._machine = machine
end

function SmokeTestStateNode:Setup()
end

function SmokeTestStateNode:Teardown()
end

function SmokeTestStateNode:Update()
  if SmokeTestStateNodeStatus.Enter == self._state then
    local isFinished = self:Enter()
    if isFinished then
      self._state = SmokeTestStateNodeStatus.Execute
    end
  end
  if SmokeTestStateNodeStatus.Execute == self._state then
    local isFinished = self:Execute()
    if isFinished then
      self._state = SmokeTestStateNodeStatus.Exit
    end
  end
  if SmokeTestStateNodeStatus.Exit == self._state then
    local isFinished = self:Execute()
    if isFinished then
      self._state = SmokeTestStateNodeStatus.Done
    end
  end
  return self._state
end

function SmokeTestStateNode:GetStatus()
  return self._state
end

function SmokeTestStateNode:GetResult()
  return self._result
end

function SmokeTestStateNode:Enter()
  self._manager:WriteProgressLog()
  return self:OnBegin()
end

function SmokeTestStateNode:Execute()
  return self:OnWorking()
end

function SmokeTestStateNode:Exit()
  self._manager:WriteProgressLog()
  return self:OnEnd()
end

function SmokeTestStateNode:OnSetup()
end

function SmokeTestStateNode:OnTeardown()
end

function SmokeTestStateNode:OnBegin()
  return true
end

function SmokeTestStateNode:OnWorking()
  return true
end

function SmokeTestStateNode:OnEnd()
  return true
end

function SmokeTestStateNode:__tostring()
  return self._className
end
