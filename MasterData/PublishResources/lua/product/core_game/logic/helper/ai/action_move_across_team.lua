require("action_move_base")
_class("ActionMoveAcrossTeam", ActionMoveBase)
ActionMoveAcrossTeam = ActionMoveAcrossTeam

function ActionMoveAcrossTeam:Constructor()
  self:_Reset()
end

function ActionMoveAcrossTeam:Reset()
  ActionMoveAcrossTeam.super.Reset(self)
  self:_Reset()
end

function ActionMoveAcrossTeam:_Reset()
  self._targetMoveOffsetList = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  self._targetPos = nil
end

function ActionMoveAcrossTeam:InitTargetPosList(listPosTarget)
  local posSelf = self.m_entityOwn:GetGridPosition()
  local aiCmpt = self.m_entityOwn:AI()
  local remainMobility = aiCmpt:GetMobilityValid()
  if remainMobility <= 0 then
    self._targetPos = posSelf
    return
  end
  local canMoveAndAcrossPosList = {}
  local canAcrossPosList = {}
  local canMovePosList = {}
  local targetPos = listPosTarget[1]
  local boardServiceLogic = self._world:GetService("BoardLogic")
  for _, pos in ipairs(self._targetMoveOffsetList) do
    local posAcross = targetPos - pos
    if not boardServiceLogic:IsPosBlock(posAcross, BlockFlag.MonsterLand) then
      local posMoveAndAcross = targetPos + pos
      if not boardServiceLogic:IsPosBlock(posMoveAndAcross, BlockFlag.MonsterLand) or posMoveAndAcross == posSelf then
        table.insert(canAcrossPosList, posAcross)
        table.insert(canMoveAndAcrossPosList, posMoveAndAcross)
      end
    end
    local posMove = targetPos + pos
    if not boardServiceLogic:IsPosBlock(posMove, BlockFlag.MonsterLand) or posMove == posSelf then
      table.insert(canMovePosList, posMove)
    end
  end
  if table.intable(canAcrossPosList, posSelf) then
    self._targetPos = posSelf
    return
  end
  if table.count(canAcrossPosList) == 0 then
    if table.count(canMovePosList) == 0 then
      self._targetPos = targetPos
    else
      self._targetPos = canMovePosList[1]
      for _, pos in ipairs(canMovePosList) do
        local nearestPosToTargetDis = Vector2.Distance(self._targetPos, posSelf)
        local workPosToTargetDis = Vector2.Distance(pos, posSelf)
        if nearestPosToTargetDis > workPosToTargetDis then
          self._targetPos = pos
        end
      end
    end
  else
    self._targetPos = canMoveAndAcrossPosList[1]
    for _, pos in ipairs(canMoveAndAcrossPosList) do
      local nearestPosToTargetDis = Vector2.Distance(self._targetPos, posSelf)
      local workPosToTargetDis = Vector2.Distance(pos, posSelf)
      if nearestPosToTargetDis > workPosToTargetDis then
        self._targetPos = pos
      end
    end
  end
end

function ActionMoveAcrossTeam:FindNewTargetPos()
  return self._targetPos
end
