_class("ChessPetComponent", Object)

function ChessPetComponent:Constructor(chessPetID, chessPetClassID, chessPetRaceType)
  self._chessPetID = chessPetID
  self._chessPetClassID = chessPetClassID
  self._chessPetRaceType = chessPetRaceType
  self._attackSkillID = 0
  self._previewSkillID = 0
  self._dieSkillID = 0
  self._hasFinishTurn = false
end

function ChessPetComponent:IsChessPetFinishTurn()
  return self._hasFinishTurn
end

function ChessPetComponent:SetChessPetFinishTurn(finishTurn)
  self._hasFinishTurn = finishTurn
end

function ChessPetComponent:GetChessPetID()
  return self._chessPetID
end

function ChessPetComponent:GetChessPetClassID()
  return self._chessPetClassID
end

function ChessPetComponent:GetChessPetRaceType()
  return self._chessPetRaceType
end

function ChessPetComponent:GetChessPetBlockData()
  if MonsterRaceType.Fly == self._chessPetRaceType then
    return BlockFlag.MonsterFly
  end
  return BlockFlag.MonsterLand
end

function ChessPetComponent:SetSkillID(skillID)
  if not skillID then
    return
  end
  self._attackSkillID = skillID.attack or 0
  self._previewSkillID = skillID.preview or 0
  self._dieSkillID = skillID.die or 0
end

function ChessPetComponent:GetAttackSkillID()
  return self._attackSkillID
end

function ChessPetComponent:GetPreviewSkillID()
  if self._previewSkillID ~= 0 then
    return self._previewSkillID
  end
  return self._attackSkillID
end

function ChessPetComponent:GetDieSkillID()
  return self._dieSkillID
end

function ChessPetComponent:WEC_PostInitialize(owner)
end

function ChessPetComponent:WEC_PostRemoved()
end

function Entity:ChessPet()
  return self:GetComponent(self.WEComponentsEnum.ChessPet)
end

function Entity:HasChessPet()
  return self:HasComponent(self.WEComponentsEnum.ChessPet)
end

function Entity:AddChessPet()
  local index = self.WEComponentsEnum.ChessPet
  local component = ChessPetComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceChessPet(chessPetID, chessPetClassID, chessPetRaceType)
  local index = self.WEComponentsEnum.ChessPet
  local component = ChessPetComponent:New(chessPetID, chessPetClassID, chessPetRaceType)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveChessPet()
  if self:HasChessPet() then
    self:RemoveComponent(self.WEComponentsEnum.ChessPet)
  end
end
