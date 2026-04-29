require("aircraft_room_base")
_class("AircraftTacticRoom", AircraftRoomBase)
AircraftTacticRoom = AircraftTacticRoom

function AircraftTacticRoom:Constructor()
  self._room_ext_data = nil
  self._cartridge_cd = 0
  self._pet_cd = 0
end

function AircraftTacticRoom:SetClientData(client_data)
  self._cartridge_cd = client_data[1]
  self._pet_cd = client_data[2]
end

function AircraftTacticRoom:SetExtData(data)
  if data then
    self._room_ext_data = TacticRoomExtData:New()
    local ret, msg = lua_dc.LoadStream(self._room_ext_data._className, data, self._room_ext_data)
    if ret == nil then
      Log.fatal("AircraftTacticRoom:SetExtData lua_dc.LoadStream fail! ", msg)
    else
    end
  end
end

function AircraftTacticRoom:GetRoomConfig()
  local cfg = Cfg.cfg_aircraft_tactic_room[self._roomid]
  return cfg
end

function AircraftTacticRoom:GetPetRemainFightNum(petTPSID)
  local numLimit = Cfg.cfg_aircraft_values[AirValueID.WeekPetFightNumLimit].IntValue
  for key, value in pairs(self._room_ext_data.pet_fight_list) do
    if key == petTPSID then
      local remainNum = numLimit - value
      if remainNum < 0 then
        remainNum = 0
      end
      return remainNum
    end
  end
  return numLimit
end

function AircraftTacticRoom:GetCartridgeLimit()
  local cfgTacticRoom = self:GetRoomConfig()
  local numLimit = cfgTacticRoom.CartridgeLimit
  return numLimit
end

function AircraftTacticRoom:GetNextResetTime()
  if self._room_ext_data then
    return self._room_ext_data.next_reset_time
  end
  return 0
end

function AircraftTacticRoom:CanOpenCartridgeGiftBox()
  if self:GetCartridgeGiftCount() > 0 then
    return true
  end
  return false
end

function AircraftTacticRoom:IsCartridgeLimit()
  local maxCount = self:GetCartridgeLimit()
  local cartridgeList = self:GetCartridgeList()
  local count = #cartridgeList + self:GetCartridgeGiftCount()
  if maxCount <= count then
    return true
  end
  return false
end

function AircraftTacticRoom:GetCartridgeList()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local list = itemModule:GetItemListBySubType(ItemSubType.ItemSubType_Cartridge)
  return list
end

function AircraftTacticRoom:GetCartridgeGiftCount()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local giftID = Cfg.cfg_aircraft_values[AirValueID.CartridgeGiftID].IntValue
  local count = itemModule:GetItemCount(giftID)
  return count
end

function AircraftTacticRoom:IsReceived(num)
  local receiveList = self._room_ext_data.received_week_award_list
  for i = 1, #receiveList do
    if num == receiveList[i] then
      return true
    end
  end
  return false
end

function AircraftTacticRoom:CanReceiveWeeklyReward()
  do return false end
  local awardItems = {}
  local weeklyAward = Cfg.cfg_aircraft_values[AirValueID.WeekPassAward].StringValue
  local a = string.split(weeklyAward, "|")
  for i = 1, #a do
    local b = string.split(a[i], ";")
    awardItems[i] = tonumber(b[1])
  end
  local passNum = self._room_ext_data.week_pass_num
  for i = 1, #awardItems do
    if passNum >= awardItems[i] and not self:IsReceived(awardItems[i]) then
      return true
    end
  end
  return false
end

function AircraftTacticRoom:NavMenuCanCollect()
  local cartridgeList = self:GetCartridgeList()
  local cardCount = #cartridgeList + self:GetCartridgeGiftCount()
  return 0 < cardCount or self:CanReceiveWeeklyReward()
end

function AircraftTacticRoom:CanCollect()
  return self:CanOpenCartridgeGiftBox() or self:CanReceiveWeeklyReward()
end

function AircraftTacticRoom:GetCartridgeCountDown()
  if self._room_ext_data.cartridge_cd_time == 0 then
    return 0
  end
  local countdownTime = self._room_ext_data.cartridge_cd_time + self._cartridge_cd
  return math.ceil(countdownTime)
end

function AircraftTacticRoom:GetCartridgeDeltaTime()
  if self:IsCartridgeLimit() then
    return -1
  end
  local time = self:GetCartridgeCountDown()
  local now = math.floor(GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000)
  return time - now
end

function AircraftTacticRoom:GetWeeklyPassTimes()
  if self._room_ext_data then
    return self._room_ext_data.week_pass_num
  end
  return 0
end

function AircraftTacticRoom:GetWeeklyFreeMakeCount()
  if self._room_ext_data then
    return self._room_ext_data.remain_free_prod_times
  end
  return 0
end

function AircraftTacticRoom:GetWeeklyFreeMakeLimit()
  local cfgTacticRoom = self:GetRoomConfig()
  return cfgTacticRoom.FreeCount
end

function AircraftTacticRoom:GetRoomResCD()
  local cfgTacticRoom = self:GetRoomConfig()
  return cfgTacticRoom.CD, self._pet_cd
end

function AircraftTacticRoom:GetOneCartridgeSpeed()
  return self._cartridge_cd
end

function AircraftTacticRoom:GetDegradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_tactic_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_tactic_room[room_cfg.PrevLevelID]
  if next_cfg == nil then
    return nil
  end
  return {
    {
      AirLevelInfoTitle.TacticTapeStorageCount,
      AirRoomChangeLevelDataType.NumberInt,
      cur_cfg.CartridgeLimit,
      next_cfg.CartridgeLimit
    },
    {
      AirLevelInfoTitle.TacticTapeMakeTime,
      AirRoomChangeLevelDataType.Time,
      cur_cfg.CD,
      next_cfg.CD
    },
    {
      AirLevelInfoTitle.TacticTapeWeeklyFreeTimes,
      AirRoomChangeLevelDataType.NumberInt,
      cur_cfg.FreeCount,
      next_cfg.FreeCount
    }
  }
end

function AircraftTacticRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_tactic_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_tactic_room[room_cfg.NextLevelID]
  if next_cfg == nil then
    return nil
  end
  return {
    {
      AirLevelInfoTitle.TacticTapeStorageCount,
      AirRoomChangeLevelDataType.NumberInt,
      cur_cfg.CartridgeLimit,
      next_cfg.CartridgeLimit
    },
    {
      AirLevelInfoTitle.TacticTapeMakeTime,
      AirRoomChangeLevelDataType.Time,
      cur_cfg.CD,
      next_cfg.CD
    },
    {
      AirLevelInfoTitle.TacticTapeWeeklyFreeTimes,
      AirRoomChangeLevelDataType.NumberInt,
      cur_cfg.FreeCount,
      next_cfg.FreeCount
    }
  }
end

function AircraftTacticRoom:TacticPeakRewardedList()
  return self._room_ext_data.received_peak_lv_list
end

function AircraftTacticRoom:SetPeakRewardedList(lv_list)
  self._room_ext_data.received_peak_lv_list = lv_list
end

function AircraftTacticRoom:GetThemeList()
  return self._room_ext_data.theme_list
end

function AircraftTacticRoom:SetThemeList(theme_list)
  self._room_ext_data.theme_list = theme_list
end

function AircraftTacticRoom:GetCartridgeExtraAwards(cartridge_pstid)
  local awards = self._room_ext_data.cartridge_extra_award_list[cartridge_pstid]
  if awards then
    return awards
  end
  return nil
end
