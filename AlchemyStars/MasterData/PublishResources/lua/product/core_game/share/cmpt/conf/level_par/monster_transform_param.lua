_class("MonsterTransformParam", Object)
MonsterTransformParam = MonsterTransformParam

function MonsterTransformParam:Constructor(monsterID)
  self._monsterID = monsterID
  self._monsterPosition = Vector2(0, 0)
  self._monsterRotation = Vector2(0, -1)
  self._forward = Vector2(0, 0)
  self._bodyArea = nil
end

function MonsterTransformParam:GetMonsterID()
  return self._monsterID
end

function MonsterTransformParam:SetPosition(position)
  self._monsterPosition = position
end

function MonsterTransformParam:GetPosition()
  return self._monsterPosition
end

function MonsterTransformParam:SetRotation(rotation)
  self._monsterRotation = rotation
end

function MonsterTransformParam:GetRotation()
  return self._monsterRotation
end

function MonsterTransformParam:SetForward(forward)
  self._forward = forward
end

function MonsterTransformParam:GetForward()
  return self._forward
end

function MonsterTransformParam:GetBodyArea()
  return self._bodyArea
end

function MonsterTransformParam:SetBodyArea(bodyArea)
  self._bodyArea = bodyArea
end

function MonsterTransformParam:GetOffset()
  return self._offset
end

function MonsterTransformParam:SetOffset(offset)
  self._offset = offset
end

function MonsterTransformParam:SetBoardIndex(boardIndex)
  self._boardIndex = boardIndex
end

function MonsterTransformParam:GetBoardIndex()
  return self._boardIndex
end
