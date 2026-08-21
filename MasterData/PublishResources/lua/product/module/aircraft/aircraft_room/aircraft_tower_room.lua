require("aircraft_room_base")
_class("AircraftTowerRoom", AircraftRoomBase)
AircraftTowerRoom = AircraftTowerRoom

function AircraftTowerRoom:Constructor()
end

function AircraftTowerRoom:SetClientData(client_data)
  self._room_cd = client_data[1]
  self._pet_cd = client_data[2]
  self._room_limit = client_data[3]
  self._pet_limit = client_data[4]
  self._total_limit = self._pet_limit + self._room_limit
  self._total_cd = self._pet_cd + self._room_cd
end

function AircraftTowerRoom:GetTowerRoomConfig()
  local cfg = Cfg.cfg_aircraft_tower_room[self._roomid]
  return cfg
end

function AircraftTowerRoom:CanCollect()
  return self:GetHeartAmberCount() * 3 > self._room_limit + self._pet_limit
end

function AircraftTowerRoom:AwardID()
  return 3220000
end

function AircraftTowerRoom:GetDrawCardCount()
  return self._module:GetDrawCardCount()
end

function AircraftTowerRoom:GetHeartAmberCount()
  return self._module:GetHeartAmberCount()
end

function AircraftTowerRoom:GetDrawCardCD()
  return self._room_cd, self._pet_cd
end

function AircraftTowerRoom:GetOutputLimit()
  return self._room_limit, self._pet_limit
end

function AircraftTowerRoom:GetRoomPetCD()
  return self._room_cd, self._pet_cd
end

function AircraftTowerRoom:GetDrawCardSpeed()
  local total_speed = 3600 / (self._room_cd + self._pet_cd)
  local room_speed = 3600 / self._room_cd
  local pet_work_speed = total_speed - room_speed
  return room_speed, pet_work_speed
end

function AircraftTowerRoom:GetNextLevelDrawcardSpeed()
  local cfg = self:GetConfig()
  local next_cfg = Cfg.cfg_aircraft_tower_room[cfg.NextLevelID]
  if next_cfg == nil then
    return nil
  end
  return 3600 / next_cfg.RecoverCD
end

function AircraftTowerRoom:GetLastLevelDrawcardSpeed()
  local cfg = self:GetConfig()
  local last_cfg = Cfg.cfg_aircraft_tower_room[cfg.PrevLevelID]
  if last_cfg == nil then
    return nil
  end
  return 3600 / last_cfg.RecoverCD
end

function AircraftTowerRoom:GetDrawCardLeftCDTime()
  if self._module:GetDrawCardCount() == self._total_limit then
    return -1
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local now = timeModule:GetServerTime() / 1000
  local start = self._module:GetDrawCardCDTime()
  local left = start + self._total_cd - now
  if left <= 0 then
    left = 0
  end
  return left
end

function AircraftTowerRoom:CanCollectOutside()
  local target = math.floor(self._total_limit / 3)
  local cur = self._module:GetHeartAmberCount()
  return 1 <= cur and target < cur
end

function AircraftTowerRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_tower_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_tower_room[room_cfg.NextLevelID]
  if next_cfg == nil then
    return nil
  end
  local cur_resource_count = cur_cfg.ResourceLimit
  local nxt_resource_count = next_cfg.ResourceLimit
  return {
    {
      AirLevelInfoTitle.DrawCardCount,
      AirRoomChangeLevelDataType.NumberInt,
      cur_resource_count,
      nxt_resource_count
    },
    {
      AirLevelInfoTitle.DrawcardAssetRocoverSpeed,
      AirRoomChangeLevelDataType.NumberFloat
    },
    {
      AirLevelInfoTitle.DrawcardAssetRocoverSpeed,
      AirRoomChangeLevelDataType.NumberFloat,
      self:GetDrawCardSpeed(),
      self:GetNextLevelDrawcardSpeed()
    }
  }
end

function AircraftTowerRoom:GetDegradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_tower_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_tower_room[room_cfg.PrevLevelID]
  if next_cfg == nil then
    return nil
  end
  local cur_resource_count = cur_cfg.ResourceLimit
  local nxt_resource_count = next_cfg.ResourceLimit
  return {
    {
      AirLevelInfoTitle.DrawCardCount,
      AirRoomChangeLevelDataType.NumberInt,
      cur_resource_count,
      nxt_resource_count
    },
    {
      AirLevelInfoTitle.DrawcardAssetRocoverSpeed,
      AirRoomChangeLevelDataType.NumberFloat,
      self:GetDrawCardSpeed(),
      self:GetLastLevelDrawcardSpeed()
    }
  }
end
