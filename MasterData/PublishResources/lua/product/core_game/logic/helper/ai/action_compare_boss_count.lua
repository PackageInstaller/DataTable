_class("ActionCompareBossCount", AINewNode)
ActionCompareBossCount = ActionCompareBossCount

function ActionCompareBossCount:OnUpdate()
  local compareMode = self:GetLogicData(-1)
  local count = self:GetLogicData(-2)
  local gBoss = self._world:GetGroup(self._world.BW_WEMatchers.Boss)
  local bosses = gBoss:GetEntities()
  local bossCount = table.count(bosses)
  local res = false
  if compareMode == "eq" then
    res = bossCount == count
  elseif compareMode == "ne" then
    res = bossCount ~= count
  elseif compareMode == "gt" then
    res = count < bossCount
  elseif compareMode == "ge" then
    res = count <= bossCount
  elseif compareMode == "lt" then
    res = count > bossCount
  elseif compareMode == "le" then
    res = count >= bossCount
  end
  if res then
    return AINewNodeStatus.Success
  else
    return AINewNodeStatus.Failure
  end
end
