require("aircraft_room_base")
_class("AircraftPurifyRoom", AircraftRoomBase)
AircraftPurifyRoom = AircraftPurifyRoom

function AircraftPurifyRoom:Constructor()
end

function AircraftPurifyRoom:SetClientData(client_data)
end

function AircraftPurifyRoom:GetPurifyRoomConfig()
  local cfg = Cfg.cfg_aircraft_purify_room[self._roomid]
  return cfg
end

function AircraftPurifyRoom:GetPurifyEvilConfig()
end

function AircraftPurifyRoom:GetTotalPurifyTime()
  local base_time = 10
  local pet_minus = 1
  return base_time, pet_minus
end

function AircraftPurifyRoom:GetLeftPurifyTime()
end

function AircraftPurifyRoom:CollectReward()
end

function AircraftPurifyRoom:StopPurify()
end

function AircraftPurifyRoom:PurifyStatus()
  return PurifyRoomStatus.EVIL_WITHOUT_PURIFY
end

function AircraftPurifyRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local next_cfg = Cfg.cfg_aircraft_room[room_cfg.NextLevelID]
  if next_cfg == nil then
    return nil
  end
  local cur_purifyroom_cfg = Cfg.cfg_aircraft_purify_room[self._roomid]
  local next_purifyroom_cfg = Cfg.cfg_aircraft_purify_room[room_cfg.NextLevelID]
  if next_purifyroom_cfg == nil then
    return nil
  end
  local cur_cell_count = cur_purifyroom_cfg.DecrTime
  local next_cell_count = next_purifyroom_cfg.DecrTime
  local cur_pet_number = room_cfg.PetNum
  local next_pet_number = next_cfg.PetNum
  return {
    {cur_cell_count, next_cell_count},
    {cur_pet_number, next_pet_number}
  }
end

function AircraftPurifyRoom:GetDegradeInfo()
  local room_cfg = self:GetConfig()
  local prev_cfg = Cfg.cfg_aircraft_room[room_cfg.prevLevelID]
  local cur_purifyroom_cfg = Cfg.cfg_aircraft_purify_room[self._roomid]
  local prev_purifyroom_cfg = Cfg.cfg_aircraft_purify_room[room_cfg.prevLevelID]
  local cur_decr_time = cur_purifyroom_cfg.DecrTime
  local prev_decr_time = 0
  if prev_purifyroom_cfg ~= nil then
    prev_decr_time = prev_purifyroom_cfg.DecrTime
  end
  local cur_pet_number = room_cfg.PetNum
  local prev_pet_number = 0
  if prev_cfg ~= nil then
    prev_pet_number = prev_cfg.PetNum
  end
  return {
    {cur_decr_time, prev_decr_time},
    {cur_pet_number, prev_pet_number}
  }
end
