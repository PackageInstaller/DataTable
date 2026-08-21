require("aircraft_room_base")
_class("AircraftEvilRoom", AircraftRoomBase)
AircraftEvilRoom = AircraftEvilRoom

function AircraftEvilRoom:Constructor()
end

function AircraftEvilRoom:SetClientData(client_data)
end

function AircraftEvilRoom:GetEvilRoomConfig()
  local cfg = Cfg.cfg_aircraft_evil_room[self._roomid]
  return cfg
end

function AircraftEvilRoom:GetStoreLimit()
  local cfg = Cfg.cfg_aircraft_evil_room[self._roomid]
  local pet_add_cell = 1
  return cfg.CellCount, pet_add_cell
end

function AircraftEvilRoom:GetSearchEvilStar()
  local cfg = Cfg.cfg_aircraft_evil_room[self._roomid]
  local pet_add_star = 1
  return cfg.SearchEvilCount[1], cfg.SearchEvilCount[2], pet_add_star
end

function AircraftEvilRoom:GetEvils()
end

function AircraftEvilRoom:ReleaseEvil(evil_id)
end

function AircraftEvilRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local next_cfg = Cfg.cfg_aircraft_room[room_cfg.NextLevelID]
  if next_cfg == nil then
    return nil
  end
  local cur_evilroom_cfg = self:GetEvilRoomConfig()
  local next_evilroom_cfg = Cfg.cfg_aircraft_evil_room[room_cfg.NextLevelID]
  if next_evilroom_cfg == nil then
    return nil
  end
  local cur_cell_count = cur_evilroom_cfg.CellCount
  local next_cell_count = next_evilroom_cfg.CellCount
  local cur_search_evil_star = cur_evilroom_cfg.SearchEvilStar
  local next_search_evil_star = next_evilroom_cfg.SearchEvilStar
  local cur_refresh_count = cur_evilroom_cfg.RefreshEvilCount
  local next_refresh_count = next_evilroom_cfg.RefreshEvilCount
  local cur_search_count = cur_evilroom_cfg.SearchCount
  local next_search_count = next_evilroom_cfg.SearchCount
  local cur_pet_number = room_cfg.PetNum
  local next_pet_number = next_cfg.PetNum
  return {
    {cur_cell_count, next_cell_count},
    {cur_search_evil_star, next_search_evil_star},
    {cur_refresh_count, next_refresh_count},
    {cur_search_count, next_search_count},
    {cur_pet_number, next_pet_number}
  }
end

function AircraftEvilRoom:GetDegradeInfo()
  local room_cfg = self:GetConfig()
  local prev_cfg = Cfg.cfg_aircraft_room[room_cfg.PrevLevelID]
  local cur_evilroom_cfg = self:GetEvilRoomConfig()
  local prev_evilroom_cfg = Cfg.cfg_aircraft_evil_room[room_cfg.PrevLevelID]
  local cur_cell_count = cur_evilroom_cfg.CellCount
  local prev_cell_count = 0
  if prev_evilroom_cfg ~= nil then
    prev_cell_count = prev_evilroom_cfg.CellCount
  end
  local cur_search_evil_star = cur_evilroom_cfg.SearchEvilStar
  local prev_search_evil_star = 0
  if prev_evilroom_cfg ~= nil then
    prev_search_evil_star = prev_evilroom_cfg.SearchEvilStar
  end
  local cur_refresh_count = cur_evilroom_cfg.RefreshEvilCount
  local prev_refresh_count = 0
  if prev_evilroom_cfg ~= nil then
    prev_refresh_count = prev_evilroom_cfg.RefreshEvilCount
  end
  local cur_search_count = cur_evilroom_cfg.SearchCount
  local prev_search_count = 0
  if prev_evilroom_cfg ~= nil then
    prev_search_count = prev_evilroom_cfg.SearchCount
  end
  local cur_pet_number = room_cfg.PetNum
  local prev_pet_number = 0
  if prev_cfg ~= nil then
    prev_pet_number = prev_cfg.PetNum
  end
  return {
    {cur_cell_count, prev_cell_count},
    {cur_search_evil_star, prev_search_evil_star},
    {cur_refresh_count, prev_refresh_count},
    {cur_search_count, prev_search_count},
    {cur_pet_number, prev_pet_number}
  }
end
