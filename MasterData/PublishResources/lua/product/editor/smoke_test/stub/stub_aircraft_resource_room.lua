if not SMOKE_TEST_ENABLED then
  return
end
Log.warn("TestRobotModule: AircraftResourceRoom stub!")

function AircraftResourceRoom:SetClientData(client_data)
  self._room_cd = client_data[1] or 0
  self._pet_cd = client_data[2] or 0
  self._room_limit = client_data[3] or 0
  self._pet_limit = client_data[4] or 0
  self._total_limit = self._pet_limit + self._room_limit
  self._total_cd = self._pet_cd + self._room_cd
end
