_class("ActionCompareBossControlledCount", AINewNode)
ActionCompareBossControlledCount = ActionCompareBossControlledCount

function ActionCompareBossControlledCount:OnUpdate()
  local compareMode = self:GetLogicData(-1)
  local count = self:GetLogicData(-2)
  local sBuffLogic = self._world:GetService("BuffLogic")
  local gBoss = self._world:GetGroup(self._world.BW_WEMatchers.Boss)
  local bosses = gBoss:GetEntities()
  local controlledCount = 0
  for _, e in ipairs(bosses) do
    local isControlled = sBuffLogic:CheckControlled(e)
    if isControlled then
      controlledCount = controlledCount + 1
    end
  end
  local res = false
  if compareMode == "eq" then
    res = controlledCount == count
  elseif compareMode == "ne" then
    res = controlledCount ~= count
  elseif compareMode == "gt" then
    res = count < controlledCount
  elseif compareMode == "ge" then
    res = count <= controlledCount
  elseif compareMode == "lt" then
    res = count > controlledCount
  elseif compareMode == "le" then
    res = count >= controlledCount
  end
  if res then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
