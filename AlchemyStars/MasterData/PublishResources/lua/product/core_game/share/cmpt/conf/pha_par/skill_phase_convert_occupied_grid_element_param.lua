require("skill_phase_param_base")
_class("SkillPhaseConvertOccupiedGridElementParam", SkillPhaseParamBase)
SkillPhaseConvertOccupiedGridElementParam = SkillPhaseConvertOccupiedGridElementParam

function SkillPhaseConvertOccupiedGridElementParam:Constructor(t)
  self._gridEffectID = t.gridEffectID
  self._bestEffectTime = t.bestEffectTime
end

function SkillPhaseConvertOccupiedGridElementParam:GetCacheTable()
  local t = {}
  if self._gridEffectID and self._gridEffectID > 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    }
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    t[#t + 1] = {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    }
  end
  return t
end

function SkillPhaseConvertOccupiedGridElementParam:GetPhaseType()
  return SkillViewPhaseType.ConvertOccupiedGridPhase
end

function SkillPhaseConvertOccupiedGridElementParam:GetSoundCacheTable()
  return nil
end

function SkillPhaseConvertOccupiedGridElementParam:GetVoiceCacheTable()
  return nil
end

function SkillPhaseConvertOccupiedGridElementParam:GetBestEffectTime()
  return self._bestEffectTime
end

function SkillPhaseConvertOccupiedGridElementParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseConvertOccupiedGridElementParam:GetBestEffectTime()
  return self._bestEffectTime
end
