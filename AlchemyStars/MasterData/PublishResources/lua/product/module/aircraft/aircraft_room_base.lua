_class("AircraftRoomBase", Object)
AircraftRoomBase = AircraftRoomBase

function AircraftRoomBase:Constructor()
  self._module = GameGlobal.GetModule(AircraftModule)
end

function AircraftRoomBase:SetData(space_info)
  self._space_info = space_info
  self._spaceid = space_info.space_id
  self._roomid = space_info.room_id
  self._space_status = space_info.space_status
  self._pstid = space_info.room_pstid
  self._pets = {}
  self._pet_infos = {}
  self._pets_id = {}
  local pet_module = GameGlobal.GetModule(PetModule)
  for i, pstid in ipairs(space_info.pets) do
    if pstid ~= 0 then
      local pet = pet_module:GetPet(pstid)
      if not pet then
        Log.error("not find pet ", pstid)
        return
      end
      table.insert(self._pets, pet)
    end
    self._pets_id[#self._pets_id + 1] = pstid
  end
  self:SetClientData(space_info.client_data)
  self:SetExtData(space_info.ext_data)
end

function AircraftRoomBase:SetExtData(ext_data)
end

function AircraftRoomBase:SetClientData(client_data)
end

function AircraftRoomBase:GetSpaceStatus()
  return self._space_status
end

function AircraftRoomBase:SetSpaceStatus(eSpaceStatus)
  self._space_status = eSpaceStatus
end

function AircraftRoomBase:RoomId()
  return self._roomid
end

function AircraftRoomBase:SpaceId()
  return self._spaceid
end

function AircraftRoomBase:Level()
  if self._space_status == SpaceState.SpaceStateBuilding then
    return 0
  end
  local cfg = Cfg.cfg_aircraft_room[self._roomid]
  return cfg.Level
end

function AircraftRoomBase:NextLevel()
  local cfg = Cfg.cfg_aircraft_room[self._roomid]
  return cfg.NextLevelID
end

function AircraftRoomBase:MaxLevel()
  local cfgs = Cfg.cfg_aircraft_room({
    RoomType = self:GetRoomType()
  })
  local max = 1
  for _, c in pairs(cfgs) do
    if max < c.Level then
      max = c.Level
    end
  end
  return max
end

function AircraftRoomBase:GetConfig()
  local cfg = Cfg.cfg_aircraft_room[self._roomid]
  if cfg == nil then
    Log.error("[aircraft] cfg is nil, roomid=", self._roomid)
  end
  return cfg
end

function AircraftRoomBase:GetSpaceConfig()
  local cfg = Cfg.cfg_aircraft_space[self._spaceid]
  return cfg
end

function AircraftRoomBase:GetCfgById(room_id)
  local cfg = Cfg.cfg_aircraft_room[room_id]
  if cfg == nil then
    Log.error("[aircraft] cfg is nil, roomid=", room_id)
  end
  return cfg
end

function AircraftRoomBase:GetPets()
  return self._pets
end

function AircraftRoomBase:GetPetsId()
  return self._pets_id
end

function AircraftRoomBase:GetPet(pstid)
  if self._pets then
    for index, pet in pairs(self._pets) do
      if pet:GetPstID() == pstid then
        return pet
      end
    end
  end
  return nil
end

function AircraftRoomBase:GetPetCount()
  return #self._pets
end

function AircraftRoomBase:GetPetCountLimit()
  local cfg = self:GetConfig()
  return cfg.PetNum
end

function AircraftRoomBase:GetRoomType()
  local cfg = self:GetConfig()
  return cfg.RoomType
end

function AircraftRoomBase:GetRoomName()
  local cfg = self:GetConfig()
  return cfg.Name
end

function AircraftRoomBase:GetRoomEnglishName()
  local cfg = self:GetConfig()
  return cfg.EnglishName
end

function AircraftRoomBase:GetRoomIcon1()
  local cfg = self:GetConfig()
  return cfg.RoomIcon1
end

function AircraftRoomBase:GetRoomIcon2()
  local cfg = self:GetConfig()
  return cfg.RoomIcon2
end

function AircraftRoomBase:GetRoomTypeIcon1()
  local room_cfg = Cfg.cfg_aircraft_room
  for id, room_cfg in pairs(room_cfg) do
    if room_cfg.Level == 1 and room_cfg.RoomType == self:GetRoomType() then
      return room_cfg.RoomTypeIcon1
    end
  end
end

function AircraftRoomBase:GetRoomTypeIcon2()
  local room_cfg = Cfg.cfg_aircraft_room({})
  for id, room_cfg in pairs(room_cfg) do
    if room_cfg.Level == 1 and room_cfg.RoomType == self:GetRoomType() then
      return room_cfg.RoomTypeIcon2
    end
  end
end

function AircraftRoomBase:GetRoomIcon3()
  local room_cfg = Cfg.cfg_aircraft_room({})
  for id, room_cfg in pairs(room_cfg) do
    if room_cfg.Level == 1 and room_cfg.RoomType == self:GetRoomType() then
      return room_cfg.RoomTypeIcon3
    end
  end
end

function AircraftRoomBase:GetMaxFireflyToBuild()
  local timemd = GameGlobal.GetModule(SvrTimeModule)
  local now = timemd:GetServerTime() / 1000
  local left = self._build_finish_time - now
  local unit_time = Cfg.cfg_aircraft_values[AirValueID.FireflyToTimeRate].IntValue
  local count = math.floor(left / unit_time)
  return count
end

function AircraftRoomBase:GetRoomDescription()
  local cfg = self:GetConfig()
  return StringTable.Get(cfg.Description)
end

function AircraftRoomBase:GetUpgradeNeed()
  local next_level = self:NextLevel()
  if next_level == 0 then
    Log.fatal("[aircraft] room was max level")
    return {}
  end
  local room_cfg = self:GetCfgById(next_level)
  return room_cfg.Need
end

function AircraftRoomBase:GetDegradeRecycle()
  local room_cfg = self:GetConfig()
  return room_cfg.Recycle
end

function AircraftRoomBase:GetNeedRooms()
  local room_cfg = self:GetConfig()
  return room_cfg.NeedRoom
end

function AircraftRoomBase:GetUpgradeNeedTime()
  local room_cfg = self:GetConfig()
  return room_cfg.LevelUpTime
end

function AircraftRoomBase:GetCurrentPower()
  return self:GetConfig().NeedPower
end

function AircraftRoomBase:GetUpgradeNeedPower()
  local room_cfg = self:GetConfig()
  local next_level_cfg = Cfg.cfg_aircraft_room[room_cfg.NextLevelID]
  return next_level_cfg.NeedPower
end

function AircraftRoomBase:GetDegradeNeedPower()
  local room_cfg = self:GetConfig()
  local prev_level_cfg = Cfg.cfg_aircraft_room[room_cfg.PrevLevelID]
  return prev_level_cfg.NeedPower
end

function AircraftRoomBase:EnoughPowerToUpgrade()
  local power_leave = self._module:GetPower()
  local next_level_need_power = self:GetUpgradeNeedPower()
  local current_level_need_power = self:GetConfig().NeedPower
  if power_leave >= next_level_need_power - current_level_need_power then
    return true
  else
    return false
  end
end

function AircraftRoomBase:BuildRemainTime()
  local timemd = GameGlobal.GetModule(SvrTimeModule)
  local now = timemd:GetServerTime() / 1000
  local remain_time = self._space_info.build_finish_time - now
  if 0 < remain_time then
    return remain_time
  else
    return 0
  end
end

function AircraftRoomBase:CanCollect()
  return false
end
