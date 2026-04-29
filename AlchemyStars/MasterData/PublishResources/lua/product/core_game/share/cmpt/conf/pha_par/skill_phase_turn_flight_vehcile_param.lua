require("skill_phase_param_base")
_class("SkillTurnFlightVehcileGridArrayParam", SkillPhaseParamBase)
SkillTurnFlightVehcileGridArrayParam = SkillTurnFlightVehcileGridArrayParam

function SkillTurnFlightVehcileGridArrayParam:Constructor(t)
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._flyEffectID = t.flyEffectID
  self._flyBackEffectID = t.flyBackEffectID
  self._flyTime = t.flyTime
  self._flyBackTime = t.flyBackTime
  self._flyArriveDestory = t.flyArriveDestory
  self._flyBackStartWaitTime = t.flyBackStartWaitTime
end

function SkillTurnFlightVehcileGridArrayParam:GetCacheTable()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    }
  end
  if self._flyEffectID and 0 < self._flyEffectID then
    t[#t + 1] = {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      1
    }
  end
  if self._flyBackEffectID and 0 < self._flyBackEffectID then
    t[#t + 1] = {
      Cfg.cfg_effect[self._flyBackEffectID].ResPath,
      1
    }
  end
  return t
end

function SkillTurnFlightVehcileGridArrayParam:GetPhaseType()
  return SkillViewPhaseType.TurnRoundFlightVehicle
end

function SkillTurnFlightVehcileGridArrayParam:GetFlyTime()
  return self._flyTime
end

function SkillTurnFlightVehcileGridArrayParam:GetFlyBackTime()
  return self._flyBackTime
end

function SkillTurnFlightVehcileGridArrayParam:GetFlyArriveDestory()
  return self._flyArriveDestory
end

function SkillTurnFlightVehcileGridArrayParam:GetFlyBackStartWaitTime()
  return self._flyBackStartWaitTime
end

function SkillTurnFlightVehcileGridArrayParam:GetFlyEffectID()
  return self._flyEffectID
end

function SkillTurnFlightVehcileGridArrayParam:GetFlyBackEffectID()
  return self._flyBackEffectID
end

function SkillTurnFlightVehcileGridArrayParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillTurnFlightVehcileGridArrayParam:GetHitEffectID()
  return self._hitEffectID
end
