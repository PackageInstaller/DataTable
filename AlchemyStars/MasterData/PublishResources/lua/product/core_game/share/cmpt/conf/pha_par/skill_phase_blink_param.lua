require("skill_phase_param_base")
_class("SkillPhaseBlinkParam", SkillPhaseParamBase)
SkillPhaseBlinkParam = SkillPhaseBlinkParam

function SkillPhaseBlinkParam:Constructor(t)
  self.castEffectID = t.castEffectID
  self.castAnimation = t.castAnimation
  self.castDuration = t.castDuration
  self.stealthDuration = t.stealthDuration
  self.appearEffectID = t.appearEffectID
  self.appearAnimation = t.appearAnimation
  self.appearDuration = t.appearDuration
end

function SkillPhaseBlinkParam:GetPhaseType()
  return SkillViewPhaseType.Blink
end

function SkillPhaseBlinkParam:GetCacheTable()
  local t = {}
  if self.castEffectID and self.castEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.castEffectID].ResPath,
      1
    })
  end
  if self.appearEffectID and self.appearEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.appearEffectID].ResPath,
      1
    })
  end
  return t
end
