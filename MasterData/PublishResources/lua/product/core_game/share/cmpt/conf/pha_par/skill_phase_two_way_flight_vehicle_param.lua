require("skill_phase_param_base")
_class("SkillPhaseTwoWayFlightVehicleParam", SkillPhaseParamBase)
SkillPhaseTwoWayFlightVehicleParam = SkillPhaseTwoWayFlightVehicleParam

function SkillPhaseTwoWayFlightVehicleParam:Constructor(t)
  self._targetEffectID = t.targetEffectID
  self._targetAnimName = t.targetAnimName
  self._castEffectID = t.castEffectID
  self._castDelay = t.castDelay
  self._castTimeLen = t.castTimeLen
end

function SkillPhaseTwoWayFlightVehicleParam:GetCacheTable()
  local t = {
    {
      Cfg.cfg_effect[self._castEffectID].ResPath,
      1
    },
    {
      Cfg.cfg_effect[self._targetEffectID].ResPath,
      1
    }
  }
  return t
end

function SkillPhaseTwoWayFlightVehicleParam:GetPhaseType()
  return SkillViewPhaseType.TwoWayFlightVehicle
end
