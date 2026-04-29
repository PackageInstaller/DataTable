require("skill_phase_param_base")
_class("SkillFlightVehcileGridArrayParam", SkillPhaseParamBase)
SkillFlightVehcileGridArrayParam = SkillFlightVehcileGridArrayParam

function SkillFlightVehcileGridArrayParam:Constructor(t)
  self._bornEffectDelay = t.bornEffectDelay
  self._bornEffectID = t.bornEffectID
  self._flyStartMs = t.flyStartMs
  self._gridEffectID = t.gridEffectID
  self._flyOneGridMS = t.flyOneGridMS
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._disappearEffectID = t.disappearEffectID
end

function SkillFlightVehcileGridArrayParam:GetPhaseType()
  return SkillViewPhaseType.FlightVehicle
end

function SkillFlightVehcileGridArrayParam:GetBornEffectDelay()
  return self._bornEffectDelay
end

function SkillFlightVehcileGridArrayParam:GetBornEffectID()
  return self._bornEffectID
end

function SkillFlightVehcileGridArrayParam:GetFlyStartMs()
  return self._flyStartMs
end

function SkillFlightVehcileGridArrayParam:GetStartDelayTime()
  return self._startDelayTime
end

function SkillFlightVehcileGridArrayParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillFlightVehcileGridArrayParam:GetFlyOneGridMS()
  return self._flyOneGridMS
end

function SkillFlightVehcileGridArrayParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillFlightVehcileGridArrayParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillFlightVehcileGridArrayParam:GetDisappearEffectID()
  return self._disappearEffectID
end

function SkillFlightVehcileGridArrayParam:GetFinishWaitTime()
  return self._finishWaitTime
end

function SkillFlightVehcileGridArrayParam:GetCacheTable()
  local t = {}
  local effIds = {
    self._gridEffectID,
    self._hitEffectID,
    self._bornEffectID,
    self._disappearEffectID
  }
  for i, v in ipairs(effIds) do
    local cfgv = Cfg.cfg_effect[v]
    if cfgv then
      table.insert(t, {
        cfgv.ResPath,
        1
      })
    end
  end
  return t
end
