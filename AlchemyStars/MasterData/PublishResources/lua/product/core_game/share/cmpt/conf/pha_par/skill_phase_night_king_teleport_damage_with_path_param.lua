require("skill_phase_param_base")
_class("SkillPhaseNightKingTeleportDamageWithPathParam", SkillPhaseParamBase)
SkillPhaseNightKingTeleportDamageWithPathParam = SkillPhaseNightKingTeleportDamageWithPathParam

function SkillPhaseNightKingTeleportDamageWithPathParam:Constructor(t)
  self.startAction = t.startAction
  self.startEffectID = t.startEffectID
  self.hideDelay = t.hideDelay
  self.attackEffectID = t.attackEffectID
  self.attackCameraEffectID = t.attackCameraEffectID
  self.dashAudioID = t.dashAudioID
  self.secondDashDelay = t.secondDashDelay
  self.dashInterval = t.dashInterval
  self.showEffectDelay = t.showEffectDelay
  self.showDelay = t.showDelay
  self.showEffectID = t.showEffectID
  self.beHitAnimation = t.beHitAnimation
  self.beHitEffectID = t.beHitEffectID
  self.finalBeHitEffectID = t.finalBeHitEffectID
  self.finalDelay = t.finalDelay
  self.endAction = t.endAction
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetPhaseType()
  return SkillViewPhaseType.NightKingTeleportDamageWithPath
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetCacheTable()
  local t = {}
  if self.startEffectID and self.startEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.startEffectID].ResPath,
      1
    })
  end
  if self.attackEffectID and self.attackEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.attackEffectID].ResPath,
      1
    })
  end
  if self.attackCameraEffectID and self.attackCameraEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.attackCameraEffectID].ResPath,
      1
    })
  end
  if self.showEffectID and self.showEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.showEffectID].ResPath,
      1
    })
  end
  if self.beHitEffectID and self.beHitEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.beHitEffectID].ResPath,
      1
    })
  end
  if self.finalBeHitEffectID and self.finalBeHitEffectID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.finalBeHitEffectID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetStartAction()
  return self.startAction
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetEndAction()
  return self.endAction
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetHideDelay()
  return self.hideDelay
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetStartEffectID()
  return self.startEffectID
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetAttackEffectID()
  return self.attackEffectID
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetAttackCameraEffectID()
  return self.attackCameraEffectID
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetDashAudioID()
  return self.dashAudioID
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetSecondDashDelay()
  return self.secondDashDelay
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetDashInterval()
  return self.dashInterval
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetShowEffectDelay()
  return self.showEffectDelay
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetShowDelay()
  return self.showDelay
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetShowEffectID()
  return self.showEffectID
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetBeHitAnimation()
  return self.beHitAnimation
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetBeHitEffectID()
  return self.beHitEffectID
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetFinalBeHitEffectID()
  return self.finalBeHitEffectID
end

function SkillPhaseNightKingTeleportDamageWithPathParam:GetFinalDelay()
  return self.finalDelay
end
