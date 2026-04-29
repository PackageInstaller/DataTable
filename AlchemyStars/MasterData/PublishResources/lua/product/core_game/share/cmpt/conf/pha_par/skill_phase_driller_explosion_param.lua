require("skill_phase_param_base")
_class("SkillPhaseDrillerExplosionParam", SkillPhaseParamBase)
SkillPhaseDrillerExplosionParam = SkillPhaseDrillerExplosionParam

function SkillPhaseDrillerExplosionParam:Constructor(t)
  self.boomEffectID = t.boomEffectID
  self.monsterClassID = t.monsterClassID
  self.startAction = t.startAction
  self.startEffectID = t.startEffectID
  self.screenEffectID = t.screenEffectID
  self.centerEffectID = t.centerEffectID
  self.hitAnim = t.hitAnim
  self.hitEffectID = t.hitEffectID
  self.screenEffectDelayMs = t.screenEffectDelayMs
  self.summonTrapDelayMs = t.summonTrapDelayMs
  self.hitPlayerDelayMs = t.hitPlayerDelayMs
  self.bossShowDelayMs = t.bossShowDelayMs
  self.bossShowAction = t.bossShowAction
  self.bossShowEffectID = t.bossShowEffectID
  self.finalDelayMs = t.finalDelayMs
end

function SkillPhaseDrillerExplosionParam:GetPhaseType()
  return SkillViewPhaseType.DrillerExplosion
end

function SkillPhaseDrillerExplosionParam:_CacheEff(t, effID, count)
  local cacheCount = count or 1
  if effID and effID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[effID].ResPath,
      cacheCount
    })
  end
end

function SkillPhaseDrillerExplosionParam:GetCacheTable()
  local t = {}
  self:_CacheEff(t, self.boomEffectID)
  self:_CacheEff(t, self.startEffectID)
  self:_CacheEff(t, self.screenEffectID)
  self:_CacheEff(t, self.centerEffectID)
  self:_CacheEff(t, self.hitEffectID)
  self:_CacheEff(t, self.bossShowEffectID)
  return t
end

function SkillPhaseDrillerExplosionParam:GetStartAction()
  return self.startAction
end

function SkillPhaseDrillerExplosionParam:GetStartEffectID()
  return self.startEffectID
end

function SkillPhaseDrillerExplosionParam:GetBoomEffectID()
  return self.boomEffectID
end

function SkillPhaseDrillerExplosionParam:GetScreenEffectID()
  return self.screenEffectID
end

function SkillPhaseDrillerExplosionParam:GetCenterEffectID()
  return self.centerEffectID
end

function SkillPhaseDrillerExplosionParam:GetMonsterClassID()
  return self.monsterClassID
end

function SkillPhaseDrillerExplosionParam:GetScreenEffectDelayMs()
  return self.screenEffectDelayMs
end

function SkillPhaseDrillerExplosionParam:GetSummonTrapDelayMs()
  return self.summonTrapDelayMs
end

function SkillPhaseDrillerExplosionParam:GetHitPlayerDelayMs()
  return self.hitPlayerDelayMs
end

function SkillPhaseDrillerExplosionParam:GetBossShowDelayMs()
  return self.bossShowDelayMs
end

function SkillPhaseDrillerExplosionParam:GetHitAnim()
  return self.hitAnim
end

function SkillPhaseDrillerExplosionParam:GetHitEffectID()
  return self.hitEffectID
end

function SkillPhaseDrillerExplosionParam:GetBossShowAction()
  return self.bossShowAction
end

function SkillPhaseDrillerExplosionParam:GetBossShowEffectID()
  return self.bossShowEffectID
end

function SkillPhaseDrillerExplosionParam:GetFinalDelayMs()
  return self.finalDelayMs
end
