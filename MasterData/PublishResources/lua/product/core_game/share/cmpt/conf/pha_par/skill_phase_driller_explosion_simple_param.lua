require("skill_phase_param_base")
_class("SkillPhaseDrillerExplosionSimpleParam", SkillPhaseParamBase)
SkillPhaseDrillerExplosionSimpleParam = SkillPhaseDrillerExplosionSimpleParam

function SkillPhaseDrillerExplosionSimpleParam:Constructor(t)
  self.monsterClassID = t.monsterClassID
  self.startAction = t.startAction
  self.startEffectID = t.startEffectID
  self.mainEffectID = t.mainEffectID
  self.startMatAnim = t.startMatAnim
  self.bossShowDelayMs = t.bossShowDelayMs
  self.bossShowAction = t.bossShowAction
  self.bossShowEffectID = t.bossShowEffectID
  self.finalDelayMs = t.finalDelayMs
end

function SkillPhaseDrillerExplosionSimpleParam:GetPhaseType()
  return SkillViewPhaseType.DrillerExplosionSimple
end

function SkillPhaseDrillerExplosionSimpleParam:_CacheEff(t, effID, count)
  local cacheCount = count or 1
  if effID and effID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[effID].ResPath,
      cacheCount
    })
  end
end

function SkillPhaseDrillerExplosionSimpleParam:GetCacheTable()
  local t = {}
  self:_CacheEff(t, self.startEffectID)
  self:_CacheEff(t, self.bossShowEffectID)
  return t
end

function SkillPhaseDrillerExplosionSimpleParam:GetStartAction()
  return self.startAction
end

function SkillPhaseDrillerExplosionSimpleParam:GetStartEffectID()
  return self.startEffectID
end

function SkillPhaseDrillerExplosionSimpleParam:GetMainEffectID()
  return self.mainEffectID
end

function SkillPhaseDrillerExplosionSimpleParam:GetStartMatAnim()
  return self.startMatAnim
end

function SkillPhaseDrillerExplosionSimpleParam:GetMonsterClassID()
  return self.monsterClassID
end

function SkillPhaseDrillerExplosionSimpleParam:GetBossShowDelayMs()
  return self.bossShowDelayMs
end

function SkillPhaseDrillerExplosionSimpleParam:GetBossShowAction()
  return self.bossShowAction
end

function SkillPhaseDrillerExplosionSimpleParam:GetBossShowEffectID()
  return self.bossShowEffectID
end

function SkillPhaseDrillerExplosionSimpleParam:GetFinalDelayMs()
  return self.finalDelayMs
end
