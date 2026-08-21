_class("TrapTransformParam", Object)
TrapTransformParam = TrapTransformParam

function TrapTransformParam:Constructor(trapID)
  self._trapID = trapID
  self._trapPositionList = {
    Vector2(0, 0)
  }
  self._trapRotationList = {
    Vector2(0, 1)
  }
  self._trapCheckBlock = false
end

function TrapTransformParam:GetTrapID()
  return self._trapID
end

function TrapTransformParam:SetTrapID(trapID)
  self._trapID = trapID
end

function TrapTransformParam:SetPositionList(positionList)
  self._trapPositionList = positionList
end

function TrapTransformParam:GetPositionList()
  return self._trapPositionList
end

function TrapTransformParam:SetRotationList(rotationList)
  self._trapRotationList = rotationList
end

function TrapTransformParam:GetRotationList()
  return self._trapRotationList
end

function TrapTransformParam:SetTrapCheckBlock(check)
  self._trapCheckBlock = check
end

function TrapTransformParam:IsTrapCheckBlock()
  return self._trapCheckBlock
end
