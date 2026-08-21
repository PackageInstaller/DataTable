_class("SkillEffectResultChangeBlockData", SkillEffectResultBase)
SkillEffectResultChangeBlockData = SkillEffectResultChangeBlockData

function SkillEffectResultChangeBlockData:Constructor(onAbyss, change)
  self._onAbyss = onAbyss
  self._change = change
end

function SkillEffectResultChangeBlockData:GetEffectType()
  return SkillEffectType.ChangeBlockData
end

function SkillEffectResultChangeBlockData:GetOnAbyss()
  return self._onAbyss
end

function SkillEffectResultChangeBlockData:GetChangeType()
  return self._change
end
