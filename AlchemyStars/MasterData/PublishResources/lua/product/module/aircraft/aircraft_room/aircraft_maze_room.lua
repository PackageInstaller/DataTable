require("aircraft_room_base")
_class("AircraftMazeRoom", AircraftRoomBase)
AircraftMazeRoom = AircraftMazeRoom

function AircraftMazeRoom:Constructor()
  self._mazeModule = GameGlobal.GetModule(MazeModule)
end

function AircraftMazeRoom:SetClientData(client_data)
  self._light_room_rate = client_data[1]
  self._light_pet_rate = client_data[2]
end

function AircraftMazeRoom:GetMazeRoomConfig()
  local cfg = Cfg.cfg_aircraft_maze_room[self._roomid]
  return cfg
end

function AircraftMazeRoom:AwardID()
  return RoleAssetID.RoleAssetLight
end

function AircraftMazeRoom:GetBaseLightCount()
  local cfg = Cfg.cfg_aircraft_maze_room[self._roomid]
  return cfg.BaseLightCount
end

function AircraftMazeRoom:GetLightStorage()
  return self._module:GetLightStorage()
end

function AircraftMazeRoom:CanCollect()
  local cfg = Cfg.cfg_aircraft_maze_room[self._roomid]
  local need_count = cfg.MainCollectNeedNum or 1
  local l_storage_value = self:GetLightStorage()
  if 1 <= l_storage_value and need_count < l_storage_value then
    return true
  end
  return false
end

function AircraftMazeRoom:GetLightRate()
  return self._light_room_rate, self._light_pet_rate
end

function AircraftMazeRoom:GetLightSpeed()
  local l_rate = math.max(self._light_room_rate + self._light_pet_rate, 1)
  local total_speed = 3600 / l_rate
  local room_speed = 3600 / self._light_room_rate
  local pet_work_speed = total_speed - room_speed
  return room_speed, pet_work_speed
end

function AircraftMazeRoom:GetResetTime()
  return self._mazeModule:GetSecToFinish()
end

function AircraftMazeRoom:GetRoomTypeAndRelicType()
  local cfg = Cfg.cfg_aircraft_maze_room[self._roomid]
  local room_cnt = #cfg.UnlockRoomType
  return room_cnt, cfg.UnlockRelicCount
end

function AircraftMazeRoom:CanCollectOutside()
  local cfg = Cfg.cfg_aircraft_maze_room[self._roomid]
  local target = cfg.MainCollectNeedNum or 1
  local cur = self._module:GetLightStorage()
  return 1 <= cur and target < cur
end

function AircraftMazeRoom:GetMazeCoinIncrease()
  local cfg = Cfg.cfg_aircraft_maze_room[self._roomid]
  return cfg.CoinIncrease
end

function AircraftMazeRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_maze_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_maze_room[room_cfg.NextLevelID]
  if next_cfg == nil then
    return nil
  end
  local cur_light_base = cur_cfg.BaseLightCount
  local nxt_light_base = next_cfg.BaseLightCount
  local cur_room_coin = cur_cfg.CoinIncrease
  local nxt_room_coin = next_cfg.CoinIncrease
  return {
    {
      AirLevelInfoTitle.LightInitCount,
      AirRoomChangeLevelDataType.NumberInt,
      cur_light_base,
      nxt_light_base
    },
    {
      AirLevelInfoTitle.MazeProduct,
      AirRoomChangeLevelDataType.NumberPercent,
      cur_room_coin,
      nxt_room_coin
    },
    {
      AirLevelInfoTitle.MazeAssetIncrease,
      AirRoomChangeLevelDataType.TextData
    }
  }
end

function AircraftMazeRoom:GetDegradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_maze_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_maze_room[room_cfg.PrevLevelID]
  if next_cfg == nil then
    return nil
  end
  local cur_light_base = cur_cfg.BaseLightCount
  local nxt_light_base = next_cfg.BaseLightCount
  local cur_room_coin = cur_cfg.CoinIncrease
  local nxt_room_coin = next_cfg.CoinIncrease
  return {
    {
      AirLevelInfoTitle.LightInitCount,
      AirRoomChangeLevelDataType.NumberInt,
      cur_light_base,
      nxt_light_base
    },
    {
      AirLevelInfoTitle.MazeProduct,
      AirRoomChangeLevelDataType.NumberPercent,
      cur_room_coin,
      nxt_room_coin
    },
    {
      AirLevelInfoTitle.MazeAssetDecrease,
      AirRoomChangeLevelDataType.TextData
    }
  }
end
