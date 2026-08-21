require("aircraft_room_base")
_class("AircraftCentralRoom", AircraftRoomBase)
AircraftCentralRoom = AircraftCentralRoom

function AircraftCentralRoom:Constructor()
end

function AircraftCentralRoom:SetClientData(client_data)
  self.client_data = client_data
  local affi = 0
  for i = 1, #self._pets do
    affi = affi + self._pets[i]:GetWorkSkillAffinity(AirRoomType.CentralRoom, WorkSkillType.WS_Central_AddAffinity)
  end
  self._settle_add_ambient = affi
end

function AircraftCentralRoom:SetExtData(data)
  self.extData = CentralRoomExtData:New()
  if data then
    local ret, msg = lua_dc.LoadStream(self.extData._className, data, self.extData)
    if ret == nil then
      Log.fatal("AircraftCentralRoom:SetExtData lua_dc.LoadStream fail! ", msg)
    end
  end
end

function AircraftCentralRoom:SetExtCentralData(exData)
  self.extData = exData
end

function AircraftCentralRoom:GetCentralRoomConfig()
  local cfg = Cfg.cfg_aircraft_central_room[self._roomid]
  return cfg
end

function AircraftCentralRoom:GetAmbientValue()
  return self._module:GetAmbientValue(), self._settle_add_ambient
end

function AircraftCentralRoom:GetTotalAmbientValue()
  return self._module:GetTotalAmbientValue()
end

function AircraftCentralRoom:GetFullAmbient()
  return self._module:GetAmbientValue()
end

function AircraftCentralRoom:GetAddAmbient()
  local cfg = Cfg.cfg_aircraft_central_room[self._roomid]
  return cfg.AddAmbient
end

function AircraftCentralRoom:GetAmbientLimit()
  local cfg = Cfg.cfg_aircraft_central_room[self._roomid]
  return cfg.AmbientLimit
end

function AircraftCentralRoom:GetAddFurnitureAmbientValue()
  local lfAv, lfMv = self._module:CalCentralPetWorkSkill()
  return 1, lfMv
end

function AircraftCentralRoom:GetPeriodAffinity()
  local cfg = Cfg.cfg_aircraft_central_room[self._roomid]
  local nPeriodAffinity = self._module:GetTotalAmbientValue() * cfg.AmbientToAffinity
  return nPeriodAffinity
end

function AircraftCentralRoom:GetAffinityUpdateTime()
  return self.extData.end_time, self.extData.total_time
end

function AircraftCentralRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local next_cfg = Cfg.cfg_aircraft_room[room_cfg.NextLevelID]
  if next_cfg == nil then
    return nil
  end
  local cur_centralroom_cfg = self:GetCentralRoomConfig()
  local next_centralroom_cfg = Cfg.cfg_aircraft_central_room[room_cfg.NextLevelID]
  if next_centralroom_cfg == nil then
    return nil
  end
  local cur_level = self:Level()
  local cur_firefly_limit = cur_centralroom_cfg.AddMaxFirefly
  local next_firefly_limit = next_centralroom_cfg.AddMaxFirefly
  local cur_ambient_limit = cur_centralroom_cfg.AmbientLimit
  local next_ambient_limit = next_centralroom_cfg.AmbientLimit
  return {
    {
      AirLevelInfoTitle.RoomLevelLimit,
      AirRoomChangeLevelDataType.NumberInt,
      cur_level,
      cur_level + 1
    },
    {
      AirLevelInfoTitle.FireflyLimit,
      AirRoomChangeLevelDataType.NumberInt,
      cur_firefly_limit,
      next_firefly_limit
    },
    {
      AirLevelInfoTitle.AmbientLimit,
      AirRoomChangeLevelDataType.NumberInt,
      cur_ambient_limit,
      next_ambient_limit
    }
  }
end
