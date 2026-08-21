require("aircraft_room_base")
_class("AircraftPowerRoom", AircraftRoomBase)
AircraftPowerRoom = AircraftPowerRoom

function AircraftPowerRoom:Constructor()
end

function AircraftPowerRoom:SetClientData(client_data)
  self._firefly_room_rate = client_data[1]
  self._firefly_pet_rate = client_data[2]
end

function AircraftPowerRoom:GetPowerRoomConfig()
  local cfg = Cfg.cfg_aircraft_power_room[self._roomid]
  return cfg
end

function AircraftPowerRoom:GetFireflyRecoverSpeed()
  return self._firefly_room_rate, self._firefly_pet_rate
end

function AircraftPowerRoom:GetFireflyTotalSpeed()
  return self._firefly_room_rate + self._firefly_pet_rate
end

function AircraftPowerRoom:GetPowerLimit()
  local cfg = Cfg.cfg_aircraft_power_room[self._roomid]
  return cfg.AddPower
end

function AircraftPowerRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local cur_powerroom_cfg = self:GetPowerRoomConfig()
  local next_powerroom_cfg = Cfg.cfg_aircraft_power_room[room_cfg.NextLevelID]
  if next_powerroom_cfg == nil then
    return nil
  end
  local cur_power_limit = cur_powerroom_cfg.AddPower
  local next_power_limit = next_powerroom_cfg.AddPower
  local cur_firefly_recover = cur_powerroom_cfg.FireflyRecover
  local nxt_firefly_recover = next_powerroom_cfg.FireflyRecover
  return {
    {
      AirLevelInfoTitle.PowerLimit,
      AirRoomChangeLevelDataType.NumberInt,
      cur_power_limit,
      next_power_limit
    },
    {
      AirLevelInfoTitle.FireflyRate,
      AirRoomChangeLevelDataType.NumberFloat,
      cur_firefly_recover,
      nxt_firefly_recover
    }
  }
end

function AircraftPowerRoom:GetDegradeInfo()
  local room_cfg = self:GetConfig()
  local cur_powerroom_cfg = self:GetPowerRoomConfig()
  local prev_powerroom_cfg = Cfg.cfg_aircraft_power_room[room_cfg.PrevLevelID]
  if prev_powerroom_cfg == nil then
    return nil
  end
  local cur_power_limit = cur_powerroom_cfg.AddPower
  local next_power_limit = prev_powerroom_cfg.AddPower
  local cur_firefly_recover = cur_powerroom_cfg.FireflyRecover
  local prev_firefly_recover = prev_powerroom_cfg.FireflyRecover
  return {
    {
      AirLevelInfoTitle.PowerLimit,
      AirRoomChangeLevelDataType.NumberInt,
      cur_power_limit,
      next_power_limit
    },
    {
      AirLevelInfoTitle.FireflyRate,
      AirRoomChangeLevelDataType.NumberFloat,
      cur_firefly_recover,
      prev_firefly_recover
    }
  }
end
