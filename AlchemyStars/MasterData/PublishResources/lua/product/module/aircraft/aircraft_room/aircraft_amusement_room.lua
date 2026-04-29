require("aircraft_room_base")
_class("AircraftAmusementRoom", AircraftRoomBase)
AircraftAmusementRoom = AircraftAmusementRoom

function AircraftAmusementRoom:Constructor()
end

function AircraftAmusementRoom:CanCollect()
  return false
end

function AircraftAmusementRoom:GetAmbientValue()
  return self._module:GetAmusementAmbient(self:GetRoomType())
end

function AircraftAmusementRoom:GetUpgradeInfo()
  return {}
end

function AircraftAmusementRoom:GetDegradeInfo()
  return {}
end
