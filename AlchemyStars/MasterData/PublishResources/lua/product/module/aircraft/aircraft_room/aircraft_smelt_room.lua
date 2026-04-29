require("aircraft_room_base")
_class("AircraftSmeltRoom", AircraftRoomBase)
AircraftSmeltRoom = AircraftSmeltRoom

function AircraftSmeltRoom:Constructor()
end

function AircraftSmeltRoom:SetClientData(client_data)
  self._storage_max = client_data[1]
  self._one_speed = client_data[2]
  self._atom_dis = client_data[3]
end

function AircraftSmeltRoom:GetRoomConfig()
  local cfg = Cfg.cfg_aircraft_smelt_room[self._roomid]
  return cfg
end

function AircraftSmeltRoom:CanCollect()
  return false
end

function AircraftSmeltRoom:GetAtomNum()
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime() / 1000
  local oldTime = self._module:GetSmeltCDTime()
  local num = (nowTime - oldTime) / self._one_speed
  if num < 0 then
    num = 0
  elseif num > self._storage_max then
    num = self._storage_max
  end
  return num
end

function AircraftSmeltRoom:GetStorageMax()
  return math.floor(self._storage_max)
end

function AircraftSmeltRoom:GetOneSpeed()
  return 3600 / self._one_speed
end

function AircraftSmeltRoom:AtomDiscount()
  return math.max(self._atom_dis, 0)
end

function AircraftSmeltRoom:FacilityTip()
  return self:GetRoomConfig().LockDesc
end

function AircraftSmeltRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_smelt_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_smelt_room[room_cfg.NextLevelID]
  if next_cfg == nil then
    return nil
  end
  local info = {
    {
      AirLevelInfoTitle.AtomStorageCeiling,
      AirRoomChangeLevelDataType.NumberInt,
      cur_cfg.StorageMax,
      next_cfg.StorageMax
    },
    {
      AirLevelInfoTitle.AtomRecoverSpeed,
      AirRoomChangeLevelDataType.NumberFloat,
      cur_cfg.OneSpeed,
      next_cfg.OneSpeed
    }
  }
  if next_cfg.LevelUpTip then
    table.insert(info, {
      AirLevelInfoTitle.UnlockMoreAsset,
      AirRoomChangeLevelDataType.TextData
    })
  end
  return info
end

function AircraftSmeltRoom:GetDegradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_smelt_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_smelt_room[room_cfg.PrevLevelID]
  if next_cfg == nil then
    return nil
  end
  return {
    {
      AirLevelInfoTitle.AtomStorageCeiling,
      AirRoomChangeLevelDataType.NumberInt,
      cur_cfg.StorageMax,
      next_cfg.StorageMax
    },
    {
      AirLevelInfoTitle.AtomRecoverSpeed,
      AirRoomChangeLevelDataType.NumberFloat,
      cur_cfg.OneSpeed,
      next_cfg.OneSpeed
    }
  }
end
