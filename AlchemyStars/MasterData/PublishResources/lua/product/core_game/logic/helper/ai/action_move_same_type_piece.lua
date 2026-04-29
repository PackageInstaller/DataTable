require("action_move_base")
_class("ActionMoveSameTypePiece", ActionMoveBase)
ActionMoveSameTypePiece = ActionMoveSameTypePiece

function ActionMoveSameTypePiece:Constructor()
  self.m_targetPos = nil
end

function ActionMoveSameTypePiece:Reset()
  ActionMoveSameTypePiece.super.Reset(self)
  self.m_targetPos = nil
end

function ActionMoveSameTypePiece:InitTargetPosList(listPosTarget)
  local posSelf = self.m_entityOwn:GetGridPosition()
  local aiCmpt = self.m_entityOwn:AI()
  local remainMobility = aiCmpt:GetMobilityValid()
  if remainMobility <= 0 then
    self.m_targetPos = posSelf
    return
  end
  local targetPosList = self:ComputeWalkRange(posSelf, remainMobility, true)
  if targetPosList == nil or #targetPosList <= 0 then
    self.m_targetPos = posSelf
    return
  end
  local element = self.m_entityOwn:Element():GetPrimaryType()
  local count = 0
  local targetPos
  for _, v in ipairs(targetPosList) do
    local pos = v:GetPos()
    local c = self:_GetSamePieceCount(pos, element)
    if count < c then
      count = c
      targetPos = pos
    end
  end
  if targetPos then
    self.m_targetPos = targetPos
    return
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local area = boardServiceLogic.AIArea
  for x = area.minX, area.maxX do
    for y = area.minY, area.maxY do
      local pos = Vector2(x, y)
      if not boardServiceLogic:IsPosBlock(pos, BlockFlag.MonsterLand) then
        local c = self:_GetSamePieceCount(pos, element)
        if count < c then
          count = c
          targetPos = pos
        elseif c == count and targetPos then
          local length1 = Vector2.Distance(targetPos, posSelf)
          local length2 = Vector2.Distance(pos, posSelf)
          if length1 > length2 then
            targetPos = pos
          end
        end
      end
    end
  end
  if targetPos then
    self.m_targetPos = targetPos
  else
    self.m_targetPos = posSelf
  end
end

function ActionMoveSameTypePiece:_GetSamePieceCount(pos, element)
  local posSelf = self.m_entityOwn:GetGridPosition()
  local utilData = self._world:GetService("UtilData")
  if not utilData:IsValidPiecePos(pos) then
    return 0
  end
  local count = 0
  for i = -1, 1 do
    for j = -1, 1 do
      local p = Vector2(pos.x + i, pos.y + j)
      if utilData:IsValidPiecePos(p) and element == utilData:FindPieceElement(p) then
        count = count + 1
      end
    end
  end
  return count
end

function ActionMoveSameTypePiece:FindNewTargetPos()
  return self.m_targetPos
end
