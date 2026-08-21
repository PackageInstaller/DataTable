require("aircraft_room_base")
_class("AircraftResourceRoom", AircraftRoomBase)
AircraftResourceRoom = AircraftResourceRoom

function AircraftResourceRoom:Constructor()
  self._resModule = GameGlobal.GetModule(ResDungeonModule)
end

function AircraftResourceRoom:SetClientData(client_data)
  self._room_cd = client_data[1]
  self._pet_cd = client_data[2]
  self._room_limit = client_data[3]
  self._pet_limit = client_data[4]
  if self._pet_limit then
    self._total_limit = self._pet_limit + self._room_limit
  else
    self._total_limit = self._room_limit
  end
  self._total_cd = self._pet_cd + self._room_cd
end

function AircraftResourceRoom:GetResourceRoomConfig()
  local cfg = Cfg.cfg_aircraft_resource_room[self._roomid]
  return cfg
end

function AircraftResourceRoom:CanCollect()
  return false
end

function AircraftResourceRoom:GetResCardCount()
  return self._resModule:GetDoubleResNum()
end

function AircraftResourceRoom:GetResCardCD()
  return self._room_cd, self._pet_cd
end

function AircraftResourceRoom:GetResCardLimit()
  return self._room_limit, self._pet_limit
end

function AircraftResourceRoom:GetResCardLeftCDTime()
  if self:GetResCardCount() >= self._total_limit then
    return -1
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local now = timeModule:GetServerTime() / 1000
  local start = self._module:GetResCardCDTime()
  local left = start + self._total_cd - now
  if left <= 0 then
    left = 0
  end
  return left
end

function AircraftResourceRoom:GetCoinDungeonLevel()
  local cfg = Cfg.cfg_aircraft_resource_room[self._roomid]
  return cfg.CoinDungeonLevel
end

function AircraftResourceRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_resource_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_resource_room[room_cfg.NextLevelID]
  if next_cfg == nil then
    return nil
  end
  local cur_res_dungeon_id = cur_cfg.CoinDungeonLevel
  local nxt_res_dungeon_id = next_cfg.CoinDungeonLevel
  local cur_res_reward_count = cur_cfg.ResCardLimit
  local nxt_res_reward_count = next_cfg.ResCardLimit
  local cur_res_reward_cd = cur_cfg.ResCardCD
  local nxt_res_reward_cd = next_cfg.ResCardCD
  return {
    {
      AirLevelInfoTitle.ResDungeonLevel,
      AirRoomChangeLevelDataType.NumberInt,
      cur_res_dungeon_id,
      nxt_res_dungeon_id
    },
    {
      AirLevelInfoTitle.ResRewardCD,
      AirRoomChangeLevelDataType.Hour,
      cur_res_reward_cd,
      nxt_res_reward_cd
    },
    {
      AirLevelInfoTitle.ResRewardCount,
      AirRoomChangeLevelDataType.NumberInt,
      cur_res_reward_count,
      nxt_res_reward_count
    }
  }
end

function AircraftResourceRoom:GetDegradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_resource_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_resource_room[room_cfg.PrevLevelID]
  if next_cfg == nil then
    return nil
  end
  local cur_res_dungeon_id = cur_cfg.CoinDungeonLevel
  local nxt_res_dungeon_id = next_cfg.CoinDungeonLevel
  local cur_res_reward_count = cur_cfg.ResCardLimit
  local nxt_res_reward_count = next_cfg.ResCardLimit
  local cur_res_reward_cd = cur_cfg.ResCardCD
  local nxt_res_reward_cd = next_cfg.ResCardCD
  return {
    {
      AirLevelInfoTitle.ResDungeonLevel,
      AirRoomChangeLevelDataType.NumberInt,
      cur_res_dungeon_id,
      nxt_res_dungeon_id
    },
    {
      AirLevelInfoTitle.ResRewardCD,
      AirRoomChangeLevelDataType.Hour,
      cur_res_reward_cd,
      nxt_res_reward_cd
    },
    {
      AirLevelInfoTitle.ResRewardCount,
      AirRoomChangeLevelDataType.NumberInt,
      cur_res_reward_count,
      nxt_res_reward_count
    }
  }
end
