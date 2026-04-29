_class("TeleportRecordComponent", Object)
TeleportRecordComponent = TeleportRecordComponent

function TeleportRecordComponent:Constructor()
  self._recordsByRound = {}
end

function TeleportRecordComponent:AddSingleTeleportRecord(round, beginPos, finalPos, casterID)
  if not self._recordsByRound[round] then
    self._recordsByRound[round] = {}
  end
  table.insert(self._recordsByRound[round], {
    beginPos = beginPos,
    finalPos = finalPos,
    casterID = casterID
  })
end

function TeleportRecordComponent:GetAllTeleportRecordByRound(round)
  return self._recordsByRound[round] or {}
end

function Entity:TeleportRecord()
  return self:GetComponent(self.WEComponentsEnum.TeleportRecord)
end

function Entity:HasTeleportRecord()
  return self:HasComponent(self.WEComponentsEnum.TeleportRecord)
end

function Entity:AddTeleportRecord()
  local index = self.WEComponentsEnum.TeleportRecord
  local component = TeleportRecordComponent:New()
  self:AddComponent(index, component)
  return component
end

function Entity:ReplaceTeleportRecord()
  local index = self.WEComponentsEnum.TeleportRecord
  local component = TeleportRecordComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveTeleportRecord()
  if self:HasActiveSkill() then
    self:RemoveComponent(self.WEComponentsEnum.TeleportRecord)
  end
end
