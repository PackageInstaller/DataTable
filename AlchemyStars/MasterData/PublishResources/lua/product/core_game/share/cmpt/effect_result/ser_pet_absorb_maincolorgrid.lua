require("skill_effect_result_base")
_class("SkillEffectResultPetAbsorbMaintainColorGrid", SkillEffectResultBase)
SkillEffectResultPetAbsorbMaintainColorGrid = SkillEffectResultPetAbsorbMaintainColorGrid

function SkillEffectResultPetAbsorbMaintainColorGrid:GetEffectType()
  return SkillEffectType.PetAbsorbMaintainColorGrid
end

function SkillEffectResultPetAbsorbMaintainColorGrid:Constructor(trapIDs)
  self._trapIDs = trapIDs
  self._trapSkillResult = {}
end

function SkillEffectResultPetAbsorbMaintainColorGrid:AddTrapSkillResult(trapID, skillResult)
  self._trapSkillResult[trapID] = skillResult
end

function SkillEffectResultPetAbsorbMaintainColorGrid:GetTrapSkillResult(trapID)
  return self._trapSkillResult[trapID]
end

function SkillEffectResultPetAbsorbMaintainColorGrid:GetTrapIDs()
  return self._trapIDs
end
