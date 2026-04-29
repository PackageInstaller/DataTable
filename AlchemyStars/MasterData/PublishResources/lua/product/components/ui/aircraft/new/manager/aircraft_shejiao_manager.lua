_class("AircraftShejiaoManager", Object)
AircraftShejiaoManager = AircraftShejiaoManager

function AircraftShejiaoManager:Constructor(main)
  self._main = main
  self._triggerTime = Cfg.cfg_aircraft_const.aircraft_social_check_time.IntValue
  self._timer = 0
  self._actions = {}
end

function AircraftShejiaoManager:Init()
end

function AircraftShejiaoManager:Dispose()
end

function AircraftShejiaoManager:Update(dtMS)
  self._timer = self._timer + dtMS
  if self._timer > self._triggerTime then
    self._timer = 0
    self:_triggerOnce()
  end
  for key, action in pairs(self._actions) do
    action:Update(dtMS)
    if action:IsOver() then
      AirLog("社交行为结束")
      self._actions[key] = nil
    end
  end
end

function AircraftShejiaoManager:_triggerOnce()
  local pets = self._main:GetPets(function(p)
    local pet = p
    local state = pet:GetState()
    return state == AirPetState.Wandering
  end, true)
  if #pets == 0 then
    AirLog("没有可社交的星灵")
    return
  end
end
