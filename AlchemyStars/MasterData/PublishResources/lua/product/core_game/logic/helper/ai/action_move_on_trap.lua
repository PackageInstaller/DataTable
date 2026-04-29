require("action_move_base")
_class("ActionMoveOnTrap", ActionMoveBase)
ActionMoveOnTrap = ActionMoveOnTrap

function ActionMoveOnTrap:Constructor()
  self:_Reset()
end

function ActionMoveOnTrap:Reset()
  ActionMoveOnTrap.super.Reset(self)
  self:_Reset()
end

function ActionMoveOnTrap:_Reset()
  self._targetPos = nil
end

function ActionMoveOnTrap:InitTargetPosList(listPosTarget)
  local nSkillID = self:GetLogicData(1)
  local skillID = self:GetLogicData(-1)
  skillID = skillID or nSkillID
  if skillID == 0 then
    return
  end
  local trapID = self:GetLogicData(-2)
  if trapID == 0 then
    return
  end
  local trapIDTwo = self:GetLogicData(-3) or 0
  local posSelf = self.m_entityOwn:GetGridPosition()
  local dir = self.m_entityOwn:GridLocation().Direction
  local selfBodyArea = self.m_entityOwn:BodyArea():GetArea()
  local aiCmpt = self.m_entityOwn:AI()
  local remainMobility = aiCmpt:GetMobilityValid()
  if remainMobility <= 0 then
    self._targetPos = posSelf
    return
  end
  local targetEntity = aiCmpt:GetTargetEntity()
  local posTarget = targetEntity:GetGridPosition()
  local skillRangeData = self:CalculateSkillRange(skillID, posSelf, dir, selfBodyArea)
  if table.intable(skillRangeData, posTarget) then
    self._targetPos = posSelf
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local trapServerLogic = self._world:GetService("TrapLogic")
  local tarpPosList = trapServerLogic:FindTrapPosByTrapID(trapID)
  local tarpTwoPosList = trapServerLogic:FindTrapPosByTrapID(trapIDTwo)
  table.appendArray(tarpPosList, tarpTwoPosList)
  local dirs = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  local validPosList = {posSelf}
  for i = 1, remainMobility do
    local calcPosList = table.cloneconf(validPosList)
    for _, pos in ipairs(calcPosList) do
      for k, dir in ipairs(dirs) do
        local workPos = pos + dir
        if not table.intable(validPosList, workPos) and table.intable(tarpPosList, workPos) and not utilDataSvc:IsPosBlock(workPos, BlockFlag.MonsterLand) then
          table.insert(validPosList, workPos)
        end
      end
    end
  end
  local oneMoveStepPosList = {}
  for _, pos in ipairs(validPosList) do
    local skillRange = self:CalculateSkillRange(skillID, pos, dir, selfBodyArea)
    if table.intable(skillRange, posTarget) then
      self._targetPos = pos
      return
    end
    local dis = Vector2.Distance(posSelf, pos)
    if dis == 1 then
      table.insert(oneMoveStepPosList, pos)
    end
  end
  if 0 < table.count(oneMoveStepPosList) then
    table.sort(oneMoveStepPosList, function(a, b)
      local disA = Vector2.Distance(posTarget, a)
      local disB = Vector2.Distance(posTarget, b)
      return disA < disB
    end)
    self._targetPos = oneMoveStepPosList[1]
    return
  end
  self._targetPos = validPosList[1]
end

function ActionMoveOnTrap:FindNewTargetPos()
  return self._targetPos
end
