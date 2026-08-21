require("skill_phase_param_base")
_class("SkillPhaseDrillerSummonBaseMonsterParam", SkillPhaseParamBase)
SkillPhaseDrillerSummonBaseMonsterParam = SkillPhaseDrillerSummonBaseMonsterParam

function SkillPhaseDrillerSummonBaseMonsterParam:Constructor(t)
  self.startAction = t.startAction
  self.downAction = t.downAction
  self.lineEffectID = t.lineEffectID
  self.lineEffectCasterBone = t.lineEffectCasterBone
  self.lineEffectTrapBone = t.lineEffectTrapBone
  self.upTailEffectID = t.upTailEffectID
  self.downTailEffectID = t.downTailEffectID
  self.landEffectID = t.landEffectID
  self.upEffAnim = t.upEffAnim
  self.downEffAnim = t.downEffAnim
  self.showDropDelay = t.showDropDelay
  self.landDelay = t.landDelay
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetPhaseType()
  return SkillViewPhaseType.DrillerSummonBaseMonster
end

function SkillPhaseDrillerSummonBaseMonsterParam:_CacheEff(t, effID, count)
  local cacheCount = count or 1
  if effID and effID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[effID].ResPath,
      cacheCount
    })
  end
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetCacheTable()
  local t = {}
  self:_CacheEff(t, self.lineEffectID)
  self:_CacheEff(t, self.upTailEffectID)
  self:_CacheEff(t, self.downTailEffectID)
  self:_CacheEff(t, self.landEffectID)
  return t
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetStartAction()
  return self.startAction
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetDownAction()
  return self.downAction
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetLineEffectID()
  return self.lineEffectID
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetLineEffectCasterBone()
  return self.lineEffectCasterBone
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetLineEffectTrapBone()
  return self.lineEffectTrapBone
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetLineEffectID()
  return self.lineEffectID
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetUpTailEffectID()
  return self.upTailEffectID
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetDownTailEffectID()
  return self.downTailEffectID
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetLandEffectID()
  return self.landEffectID
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetUpEffAnim()
  return self.upEffAnim
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetDownEffAnim()
  return self.downEffAnim
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetShowDropDelay()
  return self.showDropDelay
end

function SkillPhaseDrillerSummonBaseMonsterParam:GetLandDelay()
  return self.landDelay
end
