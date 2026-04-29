_class("SkillCommonParam", Object)
SkillCommonParam = SkillCommonParam

function SkillCommonParam:Constructor(effectID, effectdelay)
  self._effectID = effectID
  self._effectdelay = effectdelay
end

function SkillCommonParam:GetStartDelayTime()
  return self._effectdelay
end

function SkillCommonParam:GetSkillEffectID()
  return self._effectID
end
