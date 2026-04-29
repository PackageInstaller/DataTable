require("aircraft_room_base")
_class("AircraftPrismRoom", AircraftRoomBase)
AircraftPrismRoom = AircraftPrismRoom

function AircraftPrismRoom:Constructor()
end

function AircraftPrismRoom:SetClientData(client_data)
  self._physic_room_rate = client_data[1]
  self._physic_pet_rate = client_data[2]
  self._physic_room_storage = client_data[3]
  self._physic_pet_storage = client_data[4]
end

function AircraftPrismRoom:GetPrismRoomConfig()
  local cfg = Cfg.cfg_aircraft_prism_room[self._roomid]
  return cfg
end

function AircraftPrismRoom:AwardID()
  return RoleAssetID.RoleAssetPhyPoint
end

function AircraftPrismRoom:GetPhysicStorage()
  return self._module:GetPhysicStorage()
end

function AircraftPrismRoom:GetTotalPhysicStorageLimit()
  return self._physic_room_storage + self._physic_pet_storage
end

function AircraftPrismRoom:CanCollect()
  return self:GetPhysicStorage() * 3 > self:GetTotalPhysicStorageLimit()
end

function AircraftPrismRoom:GetPhysicRate()
  return self._physic_room_rate, self._physic_pet_rate
end

function AircraftPrismRoom:GetPhysicSpeed()
  local l_rate = math.max(self._physic_room_rate + self._physic_pet_rate, 1)
  local total_speed = 3600 / l_rate
  local room_speed = 3600 / self._physic_room_rate
  local pet_work_speed = total_speed - room_speed
  return room_speed, pet_work_speed
end

function AircraftPrismRoom:GetNextLevelPhysicSpeed()
  local room_cfg = self:GetConfig()
  if not room_cfg then
    return nil
  end
  local nxt_prism_cfg = Cfg.cfg_aircraft_prism_room[room_cfg.NextLevelID]
  if nxt_prism_cfg == nil then
    return nil
  end
  local cfg_value = nxt_prism_cfg.LocalRecover
  local l_rate = math.max(cfg_value, 1)
  local room_speed = 3600 / l_rate
  return room_speed
end

function AircraftPrismRoom:GetLastLevelPhysicSpeed()
  local room_cfg = self:GetConfig()
  if not room_cfg then
    return nil
  end
  local last_prism_cfg = Cfg.cfg_aircraft_prism_room[room_cfg.PrevLevelID]
  if last_prism_cfg == nil then
    return nil
  end
  local cfg_value = last_prism_cfg.LocalRecover
  local l_rate = math.max(cfg_value, 1)
  local room_speed = 3600 / l_rate
  return room_speed
end

function AircraftPrismRoom:GetPhysicStorageLimit()
  return self._physic_room_storage, self._physic_pet_storage
end

function AircraftPrismRoom:GetExPhysicLimit()
  local cfg = Cfg.cfg_aircraft_prism_room[self._roomid]
  return cfg.ExMaxPhysic
end

function AircraftPrismRoom:CanCollectOutside()
  local target = math.floor((self._physic_room_storage + self._physic_pet_storage) / 3)
  local cur = self._module:GetPhysicStorage()
  return 1 <= cur and target < cur
end

function AircraftModule:HandleCEventCollectPrism(TT, count)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCollectPrism)
  request.prism_count = count
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == AircraftEventResult.AircraftEventResult_Succ then
    self._aircraftInfo.physic_storage = self._aircraftInfo.physic_storage - count
  end
  return res
end

function AircraftPrismRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local next_cfg = Cfg.cfg_aircraft_room[room_cfg.NextLevelID]
  if next_cfg == nil then
    return nil
  end
  local cur_prism_cfg = Cfg.cfg_aircraft_prism_room[room_cfg.ID]
  local nxt_prism_cfg = Cfg.cfg_aircraft_prism_room[room_cfg.NextLevelID]
  return {
    {
      AirLevelInfoTitle.ExPhysicLimit,
      AirRoomChangeLevelDataType.NumberInt,
      cur_prism_cfg.ExMaxPhysic,
      nxt_prism_cfg.ExMaxPhysic
    },
    {
      AirLevelInfoTitle.PhysicStorageLimit,
      AirRoomChangeLevelDataType.NumberInt,
      cur_prism_cfg.LocalStorage,
      nxt_prism_cfg.LocalStorage
    },
    {
      AirLevelInfoTitle.PhyRecoverSpeed,
      AirRoomChangeLevelDataType.NumberFloat,
      self:GetPhysicSpeed(),
      self:GetNextLevelPhysicSpeed()
    }
  }
end

function AircraftPrismRoom:GetDegradeInfo()
  local room_cfg = self:GetConfig()
  local prev_cfg = Cfg.cfg_aircraft_room[room_cfg.PrevLevelID]
  if prev_cfg == nil then
    return nil
  end
  local cur_prism_cfg = Cfg.cfg_aircraft_prism_room[room_cfg.ID]
  local nxt_prism_cfg = Cfg.cfg_aircraft_prism_room[room_cfg.PrevLevelID]
  return {
    {
      AirLevelInfoTitle.ExPhysicLimit,
      AirRoomChangeLevelDataType.NumberInt,
      cur_prism_cfg.ExMaxPhysic,
      nxt_prism_cfg.ExMaxPhysic
    },
    {
      AirLevelInfoTitle.PhysicStorageLimit,
      AirRoomChangeLevelDataType.NumberInt,
      cur_prism_cfg.LocalStorage,
      nxt_prism_cfg.LocalStorage
    },
    {
      AirLevelInfoTitle.PhyRecoverSpeed,
      AirRoomChangeLevelDataType.NumberFloat,
      self:GetPhysicSpeed(),
      self:GetLastLevelPhysicSpeed()
    }
  }
end
