_class("MirageComponent", Object)
MirageComponent = MirageComponent

function MirageComponent:Constructor()
  self._isOpen = false
  self._maxRound = 5
  self._curRound = 0
  self._forceClose = false
  self._movePos = Vector2.zero
  self._trapRefreshID = 0
  self._trapInheritAttributes = nil
  self._mirageBossEntityID = 0
end

function MirageComponent:SetMirageOpenState(isOpen)
  self._isOpen = isOpen
end

function MirageComponent:IsMirageOpen()
  return self._isOpen
end

function MirageComponent:SetMirageForceClose(forceClose)
  self._forceClose = forceClose
  if self._forceClose then
    self._isOpen = false
  end
end

function MirageComponent:IsMirageForceClose()
  return self._forceClose
end

function MirageComponent:SetTrapRefreshID(refreshID)
  self._trapRefreshID = refreshID
end

function MirageComponent:GetTrapRefreshID()
  return self._trapRefreshID
end

function MirageComponent:SetMirageTrapInheritAttributes(attributes)
  self._trapInheritAttributes = attributes
end

function MirageComponent:GetMirageTrapInheritAttributes()
  return self._trapInheritAttributes
end

function MirageComponent:SetMirageBossEntityID(bossEntityID)
  self._mirageBossEntityID = bossEntityID
end

function MirageComponent:GetMirageBossEntityID()
  return self._mirageBossEntityID
end

function MirageComponent:SetRoundCount(curRound)
  if curRound > self._maxRound then
    return
  end
  if curRound == self._maxRound then
    self:SetMirageOpenState(false)
  end
  self._curRound = curRound
end

function MirageComponent:GetRoundCount()
  return self._curRound
end

function MirageComponent:GetRemainRoundCount()
  return self._maxRound - self._curRound
end

function MirageComponent:IsRoundOver()
  if self._maxRound > self._curRound then
    return false
  end
  return true
end

function MirageComponent:SetMovePos(gridPos)
  self._movePos = gridPos
end

function MirageComponent:GetMovePos()
  return self._movePos
end

function MirageComponent:SetWalkResult(walkResult)
  self._walkResult = walkResult
end

function MirageComponent:GetWalkResult()
  return self._walkResult
end

function Entity:Mirage()
  return self:GetComponent(self.WEComponentsEnum.Mirage)
end

function Entity:HasMirage()
  return self:HasComponent(self.WEComponentsEnum.Mirage)
end

function Entity:AddMirage()
  local index = self.WEComponentsEnum.Mirage
  local component = MirageComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceMirage()
  local index = self.WEComponentsEnum.Mirage
  local component = MirageComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveMirage()
  if self:HasMirage() then
    self:RemoveComponent(self.WEComponentsEnum.Mirage)
  end
end
