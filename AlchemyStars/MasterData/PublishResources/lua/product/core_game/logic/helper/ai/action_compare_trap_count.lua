_class("ActionCompareTrapCount", AINewNode)
ActionCompareTrapCount = ActionCompareTrapCount

function ActionCompareTrapCount:OnUpdate()
  local trapId = self:GetLogicData(-1)
  local compareMode = self:GetLogicData(-2)
  local count = self:GetLogicData(-3)
  local gTrap = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local traps = gTrap:GetEntities()
  local trapCount = 0
  for _, trap in ipairs(traps) do
    if not trap:HasDeadMark() and trap:Trap():GetTrapID() == trapId then
      trapCount = trapCount + 1
    end
  end
  local res = false
  if compareMode == "eq" then
    res = trapCount == count
  elseif compareMode == "ne" then
    res = trapCount ~= count
  elseif compareMode == "gt" then
    res = count < trapCount
  elseif compareMode == "ge" then
    res = count <= trapCount
  elseif compareMode == "lt" then
    res = count > trapCount
  elseif compareMode == "le" then
    res = count >= trapCount
  end
  if res then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
