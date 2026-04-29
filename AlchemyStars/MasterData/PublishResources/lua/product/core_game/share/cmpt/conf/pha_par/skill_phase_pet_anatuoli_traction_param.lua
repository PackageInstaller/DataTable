require("skill_phase_param_base")
_class("SkillPhasePetANaTuoLiTractionParam", SkillPhaseParamBase)
SkillPhasePetANaTuoLiTractionParam = SkillPhasePetANaTuoLiTractionParam

function SkillPhasePetANaTuoLiTractionParam:Constructor(t)
  self.casterAction = t.casterAction
  self.casterEffectID = tonumber(t.casterEffectID)
  self.playTractionDelayMs = tonumber(t.playTractionDelayMs)
  self.tractionCenterEffectDelayMs = tonumber(t.tractionCenterEffectDelayMs)
  self.tractionCenterEffectID = tonumber(t.tractionCenterEffectID)
  self.tractionChaseEffectID = tonumber(t.tractionChaseEffectID)
  self.tractionChaseEffectTimeMs = tonumber(t.tractionChaseEffectTimeMs)
  self.tractionPushEffectID = tonumber(t.tractionPushEffectID)
  self.tractionPushEffectHoldTimeMs = tonumber(t.tractionPushEffectHoldTimeMs)
  self.tractionPushEffectMoveTimeMs = tonumber(t.tractionPushEffectMoveTimeMs)
  self.tractionBoomEffectID = tonumber(t.tractionBoomEffectID)
  self.tractionTargetEffectID = tonumber(t.tractionTargetEffectID)
  self.tractionMoveTimeMs = tonumber(t.tractionMoveTimeMs)
  self.tractionMoveAction = t.tractionMoveAction
  self.finalWaitTimeMs = tonumber(t.finalWaitTimeMs)
  self.beHitAnimation = t.beHitAnimation
  self.beHitEffectID = tonumber(t.beHitEffectID)
end

function SkillPhasePetANaTuoLiTractionParam:GetPhaseType()
  return SkillViewPhaseType.PetANaTuoLiTraction
end

function SkillPhasePetANaTuoLiTractionParam:GetCacheTable()
  local t = {}
  if self.tractionTargetEffectID and self.tractionTargetEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.tractionTargetEffectID].ResPath,
      1
    })
  end
  if self.casterEffectID and self.casterEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.casterEffectID].ResPath,
      1
    })
  end
  if self.tractionCenterEffectID and self.tractionCenterEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.tractionCenterEffectID].ResPath,
      1
    })
  end
  if self.tractionChaseEffectID and self.tractionChaseEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.tractionChaseEffectID].ResPath,
      2
    })
  end
  if self.tractionPushEffectID and self.tractionPushEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.tractionPushEffectID].ResPath,
      2
    })
  end
  if self.tractionBoomEffectID and self.tractionBoomEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.tractionBoomEffectID].ResPath,
      2
    })
  end
  if self.beHitEffectID and self.beHitEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.beHitEffectID].ResPath,
      2
    })
  end
  return t
end

function SkillPhasePetANaTuoLiTractionParam:GetCasterAction()
  return self.casterAction
end

function SkillPhasePetANaTuoLiTractionParam:GetCasterEffectID()
  return self.casterEffectID
end

function SkillPhasePetANaTuoLiTractionParam:GetPlayTractionDelayMs()
  return self.playTractionDelayMs
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionCenterEffectDelayMs()
  return self.tractionCenterEffectDelayMs
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionCenterEffectID()
  return self.tractionCenterEffectID
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionChaseEffectID()
  return self.tractionChaseEffectID
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionChaseEffectTimeMs()
  return self.tractionChaseEffectTimeMs
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionPushEffectID()
  return self.tractionPushEffectID
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionPushEffectHoldTimeMs()
  return self.tractionPushEffectHoldTimeMs
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionPushEffectMoveTimeMs()
  return self.tractionPushEffectMoveTimeMs
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionBoomEffectID()
  return self.tractionBoomEffectID
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionTargetEffectID()
  return self.tractionTargetEffectID
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionMoveTimeMs()
  return self.tractionMoveTimeMs
end

function SkillPhasePetANaTuoLiTractionParam:GetTractionMoveAction()
  return self.tractionMoveAction
end

function SkillPhasePetANaTuoLiTractionParam:GetFinalWaitTimeMs()
  return self.finalWaitTimeMs
end

function SkillPhasePetANaTuoLiTractionParam:GetBeHitAnimation()
  return self.beHitAnimation
end

function SkillPhasePetANaTuoLiTractionParam:GetBeHitEffectID()
  return self.beHitEffectID
end
