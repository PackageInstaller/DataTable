_class("MoveScopeRecordComponent", Object)
MoveScopeRecordComponent = MoveScopeRecordComponent

function MoveScopeRecordComponent:Constructor(offSet)
  self._moveOffSet = offSet
end

function MoveScopeRecordComponent:RecordMoveOffSet(offSet)
  self._moveOffSet = offSet
end

function MoveScopeRecordComponent:GetMoveOffSet()
  return self._moveOffSet
end

function MoveScopeRecordComponent:RecordMoveScope(moveScope)
  self._moveScope = moveScope
end

function MoveScopeRecordComponent:GetMoveScope()
  return self._moveScope
end

function Entity:MoveScopeRecord()
  return self:GetComponent(self.WEComponentsEnum.MoveScopeRecord)
end

function Entity:RemoveMoveScopeRecord()
  if self:HasMoveScopeRecord() then
    self:RemoveComponent(self.WEComponentsEnum.MoveScopeRecord)
  end
end

function Entity:AddMoveScopeRecord(offSet)
  local index = self.WEComponentsEnum.MoveScopeRecord
  local component = MoveScopeRecordComponent:New(offSet)
  self:AddComponent(index, component)
end

function Entity:HasMoveScopeRecord()
  local index = self.WEComponentsEnum.MoveScopeRecord
  return self:HasComponent(index)
end
