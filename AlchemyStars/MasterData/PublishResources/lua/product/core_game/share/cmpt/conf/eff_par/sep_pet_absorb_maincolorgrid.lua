_class("SkillEffectPetAbsorbMaintainColorGridParam", SkillEffectParamBase)
SkillEffectPetAbsorbMaintainColorGridParam = SkillEffectPetAbsorbMaintainColorGridParam

function SkillEffectPetAbsorbMaintainColorGridParam:Constructor(t)
  self._trapID = {}
  if type(t.trapID) == "number" then
    self._trapID[t.trapID] = true
  elseif type(t.trapID) == "table" then
    for _, id in ipairs(t.trapID) do
      self._trapID[id] = true
    end
  end
  self._notifyTrapSkillTrapIDList = t.notifyTrapSkillTrapIDList or {}
  self._notifySecondPieceType = t.notifySecondPieceType
end

function SkillEffectPetAbsorbMaintainColorGridParam:GetEffectType()
  return SkillEffectType.PetAbsorbMaintainColorGrid
end

function SkillEffectPetAbsorbMaintainColorGridParam:GetTrapID()
  return self._trapID
end

function SkillEffectPetAbsorbMaintainColorGridParam:GetNotifyTrapSkillTrapIDList()
  return self._notifyTrapSkillTrapIDList
end

function SkillEffectPetAbsorbMaintainColorGridParam:GetNotifySecondPieceType()
  return self._notifySecondPieceType
end
