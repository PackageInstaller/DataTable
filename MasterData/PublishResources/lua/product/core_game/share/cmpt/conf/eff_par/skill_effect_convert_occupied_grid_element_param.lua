require("skill_effect_param_base")
_class("SkillEffectConvertOccupiedGridElementParam", SkillEffectParamBase)
SkillEffectConvertOccupiedGridElementParam = SkillEffectConvertOccupiedGridElementParam

function SkillEffectConvertOccupiedGridElementParam:Constructor(t)
  self.targetGridElement = t.targetGridElement
  self.maxPosPerTarget = t.maxPosPerTarget
  self.priorityTarget = t.priorityTarget
  self.trapID = t.trapID
end

function SkillEffectConvertOccupiedGridElementParam:GetEffectType()
  return SkillEffectType.ConvertOccupiedGridElement
end

function SkillEffectConvertOccupiedGridElementParam:GetTargetGridElement()
  return self.targetGridElement
end

function SkillEffectConvertOccupiedGridElementParam:GetMaxPosPerTarget()
  return self.maxPosPerTarget
end

function SkillEffectConvertOccupiedGridElementParam:GetPriorityTarget()
  return self.priorityTarget
end

function SkillEffectConvertOccupiedGridElementParam:GetTrapID()
  return self.trapID
end
