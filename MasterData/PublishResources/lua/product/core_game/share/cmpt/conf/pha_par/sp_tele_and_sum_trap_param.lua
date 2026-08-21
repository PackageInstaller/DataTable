require("skill_phase_param_base")
_class("SkillPhaseTeleportAndSummonTrapParam", SkillPhaseParamBase)
SkillPhaseTeleportAndSummonTrapParam = SkillPhaseTeleportAndSummonTrapParam

function SkillPhaseTeleportAndSummonTrapParam:Constructor(t)
  self._teleportEffectID = t.teleportEffectID
  self._audioID = t.audioID
  self._audioDelay = t.audioDelay
  self._audioType = t.audioType
  self._teleportEffectDelay = t.teleportEffectDelay
  self._teleportAnimList = t.teleportAnimNameList
  self._gridEffectID = t.gridEffectID
  self._gridEffectDelay = t.gridEffectDelay
  self._teleportWaitTime = t.teleportWaitTime
  self._teleportEffectPos = Vector2(5, 5)
  self._teleportOverTriggerName = t.teleportOverTriggerName
end

function SkillPhaseTeleportAndSummonTrapParam:GetCacheTable()
  local t = {}
  if self._teleportEffectID and self._teleportEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._teleportEffectID].ResPath,
      2
    })
  end
  if self._gridEffectID and 0 < self._gridEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      8
    })
  end
  return t
end

function SkillPhaseTeleportAndSummonTrapParam:GetCacheAudio()
  if self._audioID and self._audioID > 0 then
    return {
      self._audioID
    }
  end
end

function SkillPhaseTeleportAndSummonTrapParam:GetPhaseType()
  return SkillViewPhaseType.TeleportAndSummonTrap
end

function SkillPhaseTeleportAndSummonTrapParam:GetTeleportEffectPos()
  return self._teleportEffectPos
end

function SkillPhaseTeleportAndSummonTrapParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseTeleportAndSummonTrapParam:GetGridEffectDelay()
  return self._gridEffectDelay
end

function SkillPhaseTeleportAndSummonTrapParam:GetTeleportWaitTime()
  return self._teleportWaitTime
end

function SkillPhaseTeleportAndSummonTrapParam:GetTeleportEffectID()
  return self._teleportEffectID
end

function SkillPhaseTeleportAndSummonTrapParam:GetTeleportEffectDelay()
  return self._teleportEffectDelay
end

function SkillPhaseTeleportAndSummonTrapParam:GetTeleportAnimList()
  return self._teleportAnimList
end

function SkillPhaseTeleportAndSummonTrapParam:GetTeleportOverTriggerName()
  return self._teleportOverTriggerName
end

function SkillPhaseTeleportAndSummonTrapParam:GetAudioID()
  return self._audioID
end

function SkillPhaseTeleportAndSummonTrapParam:GetAudioDelay()
  return self._audioDelay
end

function SkillPhaseTeleportAndSummonTrapParam:GetAudioType()
  return self._audioType
end
