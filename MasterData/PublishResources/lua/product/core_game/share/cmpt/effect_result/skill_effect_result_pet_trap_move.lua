require("skill_effect_result_base")
_class("SkillEffectResultPetTrapMove", SkillEffectResultBase)
SkillEffectResultPetTrapMove = SkillEffectResultPetTrapMove

function SkillEffectResultPetTrapMove:Constructor(casterEntityID, posOld, posNew, dirNew, moveType)
  self._casterEntityID = casterEntityID
  self._posOld = posOld
  self._posNew = posNew
  self._dirNew = dirNew
  self._moveType = moveType
end

function SkillEffectResultPetTrapMove:GetEffectType()
  return SkillEffectType.PetTrapMove
end

function SkillEffectResultPetTrapMove:GetEntityID()
  return self._casterEntityID
end

function SkillEffectResultPetTrapMove:GetPosOld()
  return self._posOld:Clone()
end

function SkillEffectResultPetTrapMove:GetPosNew()
  return self._posNew:Clone()
end

function SkillEffectResultPetTrapMove:GetDirNew()
  return self._dirNew
end

function SkillEffectResultPetTrapMove:GetMoveType()
  return self._moveType
end

function SkillEffectResultPetTrapMove:GetTriggerTrapIDList()
  return self._triggerTrapIDList
end

function SkillEffectResultPetTrapMove:SetTriggerTrapList(idList)
  self._triggerTrapIDList = idList
end

function SkillEffectResultPetTrapMove:GetPreviewRange()
  return self._previewRange or {}
end

function SkillEffectResultPetTrapMove:SetPreviewRange(previewRange)
  self._previewRange = previewRange
end
