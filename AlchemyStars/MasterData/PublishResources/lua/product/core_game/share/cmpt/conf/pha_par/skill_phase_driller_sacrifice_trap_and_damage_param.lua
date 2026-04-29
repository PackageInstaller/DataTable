require("skill_phase_param_base")
_class("SkillPhaseDrillerSacrificeTrapAndDamageParam", SkillPhaseParamBase)
SkillPhaseDrillerSacrificeTrapAndDamageParam = SkillPhaseDrillerSacrificeTrapAndDamageParam

function SkillPhaseDrillerSacrificeTrapAndDamageParam:Constructor(t)
  self.startAction = t.startAction
  self.startEffectID = t.startEffectID
  self.lineDelayMs = t.lineDelayMs or 600
  self.mainLineEffectID = t.mainLineEffectID
  self.subLineEffectID = t.subLineEffectID
  self.trapPosEffectID = t.trapPosEffectID
  self.mainLineMonsterBone = t.mainLineMonsterBone
  self.mainLinePetBone = t.mainLinePetBone
  self.subLineTrapBone = t.subLineTrapBone
  self.subLinePetBone = t.subLinePetBone
  self.hitDelayMs = t.hitDelayMs or 50
  self.trapDieDelayMs = t.trapDieDelayMs or 200
  self.hitAnim = t.hitAnim
  self.hitEffectID = t.hitEffectID
  local off = string.split(t.monsterLineOff, ",")
  if off[1] and off[2] and off[3] then
    self.monsterLineOff = Vector3(tonumber(off[1]), tonumber(off[2]), tonumber(off[3]))
  end
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetPhaseType()
  return SkillViewPhaseType.DrillerSacrificeTrapAndDamage
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:_CacheEff(t, effID, count)
  local cacheCount = count or 1
  if effID and effID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[effID].ResPath,
      cacheCount
    })
  end
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetCacheTable()
  local t = {}
  self:_CacheEff(t, self.startEffectID)
  self:_CacheEff(t, self.mainLineEffectID)
  self:_CacheEff(t, self.subLineEffectID, 6)
  self:_CacheEff(t, self.hitEffectID, 6)
  return t
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetStartAction()
  return self.startAction
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetStartEffectID()
  return self.startEffectID
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetLineDelayMs()
  return self.lineDelayMs
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetMainLineEffectID()
  return self.mainLineEffectID
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetMainLineMonsterBone()
  return self.mainLineMonsterBone
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetMainLinePetBone()
  return self.mainLinePetBone
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetSubLineEffectID()
  return self.subLineEffectID
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetSubLinePetBone()
  return self.subLinePetBone
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetSubLineTrapBone()
  return self.subLineTrapBone
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetHitDelayMs()
  return self.hitDelayMs
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetHitAnim()
  return self.hitAnim
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetHitEffectID()
  return self.hitEffectID
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetTrapPosEffectID()
  return self.trapPosEffectID
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetMonsterLineOff()
  return self.monsterLineOff
end

function SkillPhaseDrillerSacrificeTrapAndDamageParam:GetTrapDieDelayMs()
  return self.trapDieDelayMs
end
