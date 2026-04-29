require("action_move_base")
_class("ActionMoveToSpecificTrap", ActionMoveBase)
ActionMoveToSpecificTrap = ActionMoveToSpecificTrap

function ActionMoveToSpecificTrap:FindNewTargetPos()
  local posSelf = self.m_entityOwn:GetGridPosition()
  local targetPos = Vector2.New(posSelf.x, posSelf.y)
  local trapID = tonumber(self.m_configData[1])
  if trapID then
    local trapLogicSvc = self._world:GetService("TrapLogic")
    local trapPosList = trapLogicSvc:FindTrapPosByTrapID(trapID)
    if 0 < #trapPosList then
      local posListNearSelf = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
      posListNearSelf:AllowDuplicate()
      for index, trapPos in ipairs(trapPosList) do
        AINewNode.InsertSortedArray(posListNearSelf, posSelf, trapPos, index)
      end
      local aiSortByDistance = posListNearSelf:GetAt(1)
      targetPos = aiSortByDistance.data
    end
  end
  return targetPos
end
