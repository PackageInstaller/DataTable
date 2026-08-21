_class("AircraftModule", GameModule)
AircraftModule = AircraftModule

function AircraftModule:Constructor()
  self._spaces = {}
  self._rooms = {}
  self._aircraftInfo = nil
  self._maxValue = 2147483647
  self._areaFurniture = {}
  self._received_peak_lv_list = {}
  self._theme_list = {}
end

function AircraftModule:GetAircraftInfo()
  return self._aircraftInfo
end

function AircraftModule:IsAmusementRoom(eAirRoomType)
  return eAirRoomType >= AirRoomType.AmusementBegin and eAirRoomType < AirRoomType.AmusementEnd
end

function AircraftModule:GetStoryEventDicByTriggerType(TriggerType)
  if not self._aircraftInfo then
    return nil
  end
  local l_PetPstIdStoryEventIdMap = self._aircraftInfo.trigger_stroy_pet[TriggerType]
  return l_PetPstIdStoryEventIdMap
end

function AircraftModule:GetHavePresentPets()
  if not self._aircraftInfo then
    return {}
  end
  return self._aircraftInfo.present_pets.pet_array
end

function AircraftModule:AcceptPresent(TT, pet_pstid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAcceptPresent)
  request.pet_pstid = pet_pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent.drop_item_list
end

function AircraftModule:AcceptPresentByTemplateID(TT, petTemplateID)
  local petModule = GameGlobal.GetModule(PetModule)
  local pet = petModule:GetPetByTemplateId(petTemplateID)
  if pet then
    return self:AcceptPresent(TT, pet:GetPstID())
  else
    local res = AsyncRequestRes:New()
    res:SetSucc(false)
    return res
  end
end

function AircraftModule:AcceptVisitingPresent(TT, visitPetPstID)
  Log.debug("visitPetPstID : ", visitPetPstID, "AcceptVisitingPresent")
  return self:AcceptVisit(TT, visitPetPstID)
end

function AircraftModule:GetVisitPets()
  if not self._aircraftInfo then
    return nil
  end
  return self._aircraftInfo.visit_pets.pet_array
end

function AircraftModule:AcceptVisit(TT, visit_pet_pstid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAcceptVisitPet)
  request.pet_pstid = visit_pet_pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent.drop_item_list
end

function AircraftModule:AcceptVisitByTemplateID(TT, petTemplateID)
  local petModule = GameGlobal.GetModule(PetModule)
  local petPstID = petModule:GetPetByTemplateId(petTemplateID)
  if petPstID then
    return self:AcceptVisit(TT, petPstID:GetPstID())
  else
    local res = AsyncRequestRes:New()
    res:SetSucc(false)
    return res
  end
end

function AircraftModule:GetPetStroyEventId(pet_pstid)
  local ret_arr = {}
  for l_type = EStoryTriggerType.TouchPet, EStoryTriggerType.UnlockRoom do
    local l_PetPstIdStoryEventIdMap = self:GetStoryEventDicByTriggerType(l_type)
    if l_PetPstIdStoryEventIdMap ~= nil and table.count(l_PetPstIdStoryEventIdMap) > 0 and l_PetPstIdStoryEventIdMap[pet_pstid] ~= nil and 0 < table.count(l_PetPstIdStoryEventIdMap[pet_pstid].story_event_id_list) then
      for index, value in ipairs(l_PetPstIdStoryEventIdMap[pet_pstid].story_event_id_list) do
        if 0 < value then
          ret_arr[#ret_arr + 1] = value
        end
      end
    end
  end
  return ret_arr
end

function AircraftModule:SetPetStoryEvent(TriggerType, pet_pstid, story_event_id)
  if TriggerType == nil or pet_pstid == nil or pet_pstid <= 0 or story_event_id == nil or story_event_id <= 0 then
    return
  end
  local l_PetPstIdStoryEventIdMap = self._aircraftInfo.trigger_stroy_pet[TriggerType]
  if l_PetPstIdStoryEventIdMap == nil then
    self._aircraftInfo.trigger_stroy_pet[TriggerType] = {}
    l_PetPstIdStoryEventIdMap = self._aircraftInfo.trigger_stroy_pet[TriggerType]
  end
  if l_PetPstIdStoryEventIdMap[pet_pstid] == nil then
    l_PetPstIdStoryEventIdMap[pet_pstid] = pet_story_struct:New()
  end
  table.insert(l_PetPstIdStoryEventIdMap[pet_pstid].story_event_id_list, story_event_id)
end

function AircraftModule:ClickNotHaveStoryPet(pstid)
  if pstid <= 0 then
    return
  end
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventPushClickPet)
  msg.pet_pstid = pstid
  self:Push(msg)
end

function AircraftModule:CheckTriggerCilckStoryEvent(TT, pstid)
  if pstid <= 0 then
    return false
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAircraftCheckClickPetTriggerStory)
  request.pet_pstid = pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return false
  end
  local nRet = reply.msg.ret
  if nRet ~= AircraftEventResult.AircraftEventResult_Succ then
    return false
  end
  local reply_msg = reply.msg
  if 0 < reply_msg.trigger_click_story_id then
    self:SetPetStoryEvent(EStoryTriggerType.TouchPet, pstid, reply_msg.trigger_click_story_id)
    return true
  end
  return false
end

function AircraftModule:CreateRoom(Info)
  local cfg = Cfg.cfg_aircraft_room[Info.room_id]
  if not cfg then
    Log.error("CreateRoom Failed, roomid=" .. tostring(Info.room_id))
    return
  end
  local room
  if cfg.RoomType == AirRoomType.AisleRoom then
    room = AircraftAisleRoom:New()
  elseif cfg.RoomType == AirRoomType.CentralRoom then
    room = AircraftCentralRoom:New()
  elseif cfg.RoomType == AirRoomType.PowerRoom then
    room = AircraftPowerRoom:New()
  elseif cfg.RoomType == AirRoomType.MazeRoom then
    room = AircraftMazeRoom:New()
  elseif cfg.RoomType == AirRoomType.PrismRoom then
    room = AircraftPrismRoom:New()
  elseif cfg.RoomType == AirRoomType.TowerRoom then
    room = AircraftTowerRoom:New()
  elseif cfg.RoomType == AirRoomType.ResourceRoom then
    room = AircraftResourceRoom:New()
  elseif cfg.RoomType == AirRoomType.EvilRoom then
    room = AircraftEvilRoom:New()
  elseif cfg.RoomType == AirRoomType.PurifyRoom then
    room = AircraftPurifyRoom:New()
  elseif cfg.RoomType == AirRoomType.SmeltRoom then
    room = AircraftSmeltRoom:New()
  elseif cfg.RoomType == AirRoomType.DispatchRoom then
    room = AircraftDispatchRoom:New()
  elseif cfg.RoomType == AirRoomType.TacticRoom then
    room = AircraftTacticRoom:New()
  elseif self:IsAmusementRoom(cfg.RoomType) then
    room = AircraftAmusementRoom:New()
  end
  if room ~= nil then
    room:SetData(Info)
  end
  return room
end

function AircraftModule:GetSpaceStatus(space_id)
  local s = self._spaces[space_id]
  if s then
    return s.space_status
  end
end

function AircraftModule:GetBuildType(space_id)
  local cfg = Cfg.cfg_aircraft_space({ID = space_id})
  if cfg then
    return cfg[1].BuildType
  else
    Log.error("[aircraft] get cfg_aircraft_space error , space_id =", space_id)
    return nil
  end
end

function AircraftModule:GetCleanCost(space_id)
  local cfg = Cfg.cfg_aircraft_space({ID = space_id})
  if cfg then
    return cfg[1].CleanCost
  else
    Log.error("[aircraft] get cfg_aircraft_space error , space_id =", space_id)
    return nil
  end
end

function AircraftModule:GetAddFirefly(space_id)
  local cfg = Cfg.cfg_aircraft_space({ID = space_id})
  if cfg then
    return cfg[1].AddFirefly
  else
    Log.error("[aircraft] get cfg_aircraft_space error , space_id =", space_id)
    return nil
  end
end

function AircraftModule:GetBuildTypeSorted(space_id)
  local res = {}
  local cfg = Cfg.cfg_aircraft_space({ID = space_id})
  if cfg then
    local build_types = cfg[1].BuildType
    for i, type in pairs(build_types) do
      local count = self:GetRoomCount(type)
      local max_num = self:GetRoomLimitCount(type)
      local is_full = count == max_num
      res[i] = {
        BuildType = type,
        Count = count,
        MaxNum = max_num,
        IsFull = is_full
      }
    end
    table.sort(res, function(a, b)
      if a.IsFull == b.IsFull then
        return a.BuildType < b.BuildType
      else
        return b.IsFull
      end
    end)
  else
    Log.error("[aircraft] get cfg_aircraft_space error , space_id =", space_id)
    return nil
  end
  return res
end

function AircraftModule:GetSpaceInfo(spaceid)
  return self._spaces[spaceid]
end

function AircraftModule:GetSpaceInfos()
  return self._spaces
end

function AircraftModule:GetRoom(spaceid)
  local r = self._rooms[spaceid]
  return r
end

function AircraftModule:GetRoomById(roomId)
  for id, room in pairs(self._rooms) do
    if room:RoomId() == roomId then
      return room
    end
  end
  return nil
end

function AircraftModule:GetPetAirRoom(pet)
  for id, room in pairs(self._rooms) do
    if room:GetPet(pet:GetPstID()) then
      return room
    end
  end
  return nil
end

function AircraftModule:GetRoomCount(type, level)
  local cnt = 0
  for i, room in pairs(self._rooms) do
    if AirRoomType.AisleRoom ~= room:GetRoomType() and (type == 0 or type == room:GetRoomType()) and (level == nil or level == 0 or level <= room:Level()) then
      cnt = cnt + 1
    end
  end
  return cnt
end

function AircraftModule:GetRoomCountWithOutAmusement(type, level)
  local cnt = 0
  for i, room in pairs(self._rooms) do
    if AirRoomType.AisleRoom ~= room:GetRoomType() and self:IsAmusementRoom(room:GetRoomType()) == false and (type == 0 or type == room:GetRoomType()) and (level == nil or level == 0 or level <= room:Level()) then
      cnt = cnt + 1
    end
  end
  return cnt
end

function AircraftModule:GetRoomNameByType(room_type)
  local room_cfg = Cfg.cfg_aircraft_room({})
  for id, cur_room_cfg in pairs(room_cfg) do
    if cur_room_cfg.RoomType == room_type then
      return cur_room_cfg.Name
    end
  end
  return nil
end

local PetStatus = {Selected = 0, NotSelected = 1}

function AircraftModule:GetPets(space_id)
  local room_pets = {}
  local other_room_pets = {}
  local cnt = 0
  local other_cnt = 0
  for i, room in pairs(self._rooms) do
    if room then
      local room_type = room:GetRoomType()
      local pets = room:GetPets()
      local _space_id = room:SpaceId()
      if _space_id == space_id then
        for i, pet in pairs(pets) do
          cnt = cnt + 1
          room_pets[cnt] = {
            Status = PetStatus.NotSelected,
            SpaceID = _space_id,
            RoomType = room_type,
            Pet = pet
          }
        end
      else
        for i, pet in pairs(pets) do
          other_cnt = other_cnt + 1
          other_room_pets[other_cnt] = {
            Status = PetStatus.NotSelected,
            SpaceID = _space_id,
            RoomType = room_type,
            Pet = pet
          }
        end
      end
    end
  end
  return room_pets, other_room_pets
end

function AircraftModule:GetPower()
  local power = self:GetMaxPower() - self:CalcAllRoomUsePower()
  if power < 0 then
    Log.error("[aircraft] power calc error, max_power =", self:GetMaxPower(), " usedpower =", self:CalcAllRoomUsePower())
    return 0
  end
  return power
end

function AircraftModule:GetMaxPower()
  local max_power = Cfg.cfg_aircraft_values[AirValueID.InitStarPower].IntValue
  local power_rooms = self:GetPowerRooms()
  for i, p in pairs(power_rooms) do
    if p:GetSpaceStatus() > SpaceState.SpaceStateBuilding then
      local cfg = p:GetPowerLimit()
      max_power = max_power + cfg
    end
  end
  return max_power
end

function AircraftModule:GetAllRoomPetCount()
  local cnt = 0
  for i, room in pairs(self._rooms) do
    if room then
      cnt = cnt + room:GetPetCount()
    end
  end
  return cnt
end

function AircraftModule:GetRoomWithType(roomType)
  for i, room in pairs(self._rooms) do
    if room:GetRoomType() == roomType then
      return room
    end
  end
end

function AircraftModule:GetCentralRoom()
  for i, room in pairs(self._rooms) do
    if room:GetRoomType() == AirRoomType.CentralRoom then
      return room
    end
  end
end

function AircraftModule:GetResRoom()
  for i, room in pairs(self._rooms) do
    if room:GetRoomType() == AirRoomType.ResourceRoom then
      return room
    end
  end
  return nil
end

function AircraftModule:GetRoomByRoomType(roomType)
  for i, room in pairs(self._rooms) do
    if room:GetRoomType() == roomType then
      return room
    end
  end
  return nil
end

function AircraftModule:GetAllRoomPetCountLimit()
  local cnt = 0
  for i, room in pairs(self._rooms) do
    cnt = cnt + room:GetPetCountLimit()
  end
  return cnt
end

function AircraftModule:GetRoomLimitCount(room_type)
  local limit = 0
  local central_room = self:GetCentralRoom()
  if room_type == AirRoomType.AisleRoom then
    limit = central_room:GetCentralRoomConfig().AisleLimit[1]
  elseif room_type == AirRoomType.PowerRoom then
    limit = central_room:GetCentralRoomConfig().PowerRoomLimit[1]
  elseif room_type == AirRoomType.MazeRoom then
    limit = central_room:GetCentralRoomConfig().MazeRoomLimit[1]
  elseif room_type == AirRoomType.PrismRoom then
    limit = central_room:GetCentralRoomConfig().PrismRoomLimit[1]
  elseif room_type == AirRoomType.ResourceRoom then
    limit = central_room:GetCentralRoomConfig().ResourceRoomLimit[1]
  elseif room_type == AirRoomType.TowerRoom then
    limit = central_room:GetCentralRoomConfig().TowerRoomLimit[1]
  elseif room_type == AirRoomType.EvilRoom then
    limit = central_room:GetCentralRoomConfig().EvilRoomLimit[1]
  elseif room_type == AirRoomType.PurifyRoom then
    limit = central_room:GetCentralRoomConfig().PurifyRoomLimit[1]
  elseif room_type == AirRoomType.SmeltRoom then
    limit = central_room:GetCentralRoomConfig().SmeltRoomLimit[1]
  elseif room_type == AirRoomType.DispatchRoom then
    limit = central_room:GetCentralRoomConfig().DispatchRoomLimit[1]
  elseif room_type == AirRoomType.TacticRoom then
    limit = central_room:GetCentralRoomConfig().TacticRoomLimit[1]
  else
    Log.error("[aircraft] type error , room_type=", room_type)
  end
  return limit
end

function AircraftModule:GetPowerRooms()
  local power_rooms = {}
  if self._rooms == nil then
    return power_rooms
  end
  for i, room in pairs(self._rooms) do
    if room:GetRoomType() == AirRoomType.PowerRoom then
      table.insert(power_rooms, room)
    end
  end
  return power_rooms
end

function AircraftModule:GetAllRooms()
  local rooms = {}
  for i, room in pairs(self._rooms) do
    if room:GetRoomType() ~= AirRoomType.AisleRoom then
      table.insert(rooms, room)
    end
  end
  table.sort(rooms, function(a, b)
    return a:GetRoomType() < b:GetRoomType()
  end)
  return rooms
end

function AircraftModule:CalcAllRoomUsePower()
  local total = 0
  for i, room in pairs(self._rooms) do
    local cfg = room:GetConfig()
    if room:GetSpaceStatus() == SpaceState.SpaceStateUpgrading and cfg.LevelUpTime and 0 < cfg.LevelUpTime and 0 < cfg.NextLevelID then
      cfg = Cfg.cfg_aircraft_room[cfg.NextLevelID]
    end
    total = total + cfg.NeedPower
  end
  return total
end

function AircraftModule:GetFirefly()
  local recover_rate = self:GetFireflyRecoverSpeed()
  local cur_firefly = self._aircraftInfo.firefly_value
  if 0 < recover_rate then
    local now = self:GetServerTime()
    local last = self._aircraftInfo.update_time
    local diff = math.max(0, now - last)
    local delta = diff * recover_rate
    cur_firefly = math.min(self._aircraftInfo.firefly_value + delta, self:GetMaxFirefly())
  end
  return math.floor(cur_firefly)
end

function AircraftModule:GetMaxFirefly()
  local sum = 0
  for i, s in pairs(self._spaces) do
    if s.space_status > SpaceState.SpaceStateNeedClean then
      local cfg = Cfg.cfg_aircraft_space[i]
      sum = sum + cfg.AddFirefly
    end
  end
  local room_id = self:GetCentralRoom():RoomId()
  local cfg = Cfg.cfg_aircraft_central_room[room_id]
  sum = sum + cfg.AddMaxFirefly
  return sum
end

function AircraftModule:GetUpdateTime()
  return self._aircraftInfo.update_time
end

function AircraftModule:GetFireflyRecoverSpeed()
  local sum = 0
  for i, room in pairs(self._rooms) do
    if room:GetRoomType() == AirRoomType.PowerRoom and room:GetSpaceStatus() >= SpaceState.SpaceStateFull then
      local s = room:GetFireflyTotalSpeed()
      sum = sum + s
    end
  end
  local base = Cfg.cfg_aircraft_values[AirValueID.FireflyBaseRate].FloatValue
  local max = Cfg.cfg_aircraft_values[AirValueID.FireflyMaxRate].FloatValue
  local final = base + sum
  if max < final then
    final = max
  end
  return final
end

function AircraftModule:GetServerTime()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmSecond, nMilliSecond = math.modf(time_mod:GetServerTime() / 1000)
  return tmSecond
end

function AircraftModule:GetCleanSpaceRemainingTime(space_id)
  local spaceinfo = self._spaces[space_id]
  if not spaceinfo or spaceinfo.space_status ~= SpaceState.SpaceStateCleaning then
    return 0
  end
  local finish_time = spaceinfo.build_finish_time
  local now = self:GetServerTime()
  local remain = finish_time - now
  if remain < 0 then
    remain = 0
  end
  return remain
end

function AircraftModule:GetFireFlyRemainderTime()
  local recover_rate = self:GetFireflyRecoverSpeed()
  if recover_rate <= 0 then
    return -1
  end
  local now = self:GetServerTime()
  local last = self._aircraftInfo.update_time
  if now < last then
    now = last
  end
  local need_recover_firefly = self:GetMaxFirefly() - self._aircraftInfo.firefly_value
  local diff_time = need_recover_firefly / recover_rate
  local remain = diff_time - (now - last)
  if remain < 0 then
    remain = 0
  end
  return remain
end

function AircraftModule:GetMaxHealthPoint()
  local need_recover_firefly = self:GetMaxFirefly() - self:GetFirefly()
  if need_recover_firefly <= 0 then
    Log.warn("[aircraft] firefly donot need recover error")
    return 0
  end
  local role_module = GameGlobal.GetModule(RoleModule)
  local cur_health_point = role_module:GetHealthPoint()
  local ph_change_firefly = Cfg.cfg_aircraft_values[AirValueID.PhysicToFireflyRate].IntValue
  if ph_change_firefly <= 0 then
    Log.error("[aircraft] ph_change_firefly error")
    return 0
  end
  local max_need_health_point = math.floor(need_recover_firefly / ph_change_firefly)
  return math.min(cur_health_point, max_need_health_point)
end

function AircraftModule:GetAmbientValue()
  return self._aircraftInfo.ambient_value
end

function AircraftModule:GetAmusementAmbient(_AmusementType)
  if self:IsAmusementRoom(_AmusementType) == false or self._aircraftInfo.amusement_ambient[_AmusementType] == nil then
    return 0
  end
  return self._aircraftInfo.amusement_ambient[_AmusementType]
end

function AircraftModule:GetValidAmbient()
  local l_nTotal = self:GetTotalAmbientValue()
  local l_CentralRoom = self:GetCentralRoom()
  local l_nCurLimit = l_CentralRoom:GetAmbientLimit()
  return l_nTotal >= l_nCurLimit and l_nCurLimit or l_nTotal
end

function AircraftModule:GetTotalAmbientValue()
  local l_totalValue = 0
  l_totalValue = l_totalValue + self:CalFurnitureAmbient(true)
  local l_nTotalLimit = self:GetCentralTotalAmbientLimit()
  if l_totalValue > l_nTotalLimit then
    l_totalValue = l_nTotalLimit
  end
  return l_totalValue
end

function AircraftModule:GetCentralTotalAmbientLimit()
  local nMaxValue = 0
  local cfg = Cfg.cfg_aircraft_central_room({})
  for key, value in pairs(cfg) do
    if nMaxValue < value.AmbientLimit then
      nMaxValue = value.AmbientLimit
    end
  end
  return nMaxValue
end

function AircraftModule:GetCurCentralAmbientLimit()
  local l_CentralRoom = self:GetCentralRoom()
  return l_CentralRoom:GetAmbientLimit()
end

function AircraftModule:CalFurnitureAmbient(bCalWorkSkill)
  local nTotalAmbient = 0
  local FurnitureId2NumMap = self:GetUseFurnitureItemNum()
  local lfAv = 0
  local lfMv = 0
  if bCalWorkSkill then
    lfAv, lfMv = self:CalCentralPetWorkSkill()
  end
  for key, value in pairs(FurnitureId2NumMap) do
    local nAssetId = key
    local nCount = value
    local l_cfg = Cfg.cfg_item_furniture[nAssetId]
    if l_cfg then
      local nCalAmbient = l_cfg.Atmosphere
      if bCalWorkSkill then
        nCalAmbient = nCalAmbient + math.floor(l_cfg.Atmosphere * lfMv) + math.floor(lfAv)
      end
      nTotalAmbient = nTotalAmbient + nCalAmbient * nCount
    end
  end
  return nTotalAmbient
end

function AircraftModule:CalAllFurnitureAmbientInfo()
  local ret_table = {}
  local FurnitureId2NumMap = self:GetUseFurnitureItemNum()
  local lfAv, lfMv = self:CalCentralPetWorkSkill()
  for key, value in pairs(FurnitureId2NumMap) do
    local nAssetId = key
    local nCount = value
    local l_cfg = Cfg.cfg_item_furniture[nAssetId]
    if l_cfg then
      local tmp = {}
      tmp.nAssetId = nAssetId
      tmp.baseAmbient = l_cfg.Atmosphere
      tmp.exAmbient = math.floor(l_cfg.Atmosphere * lfMv) + math.floor(lfAv)
      tmp.count = nCount
      ret_table[#ret_table + 1] = tmp
    end
  end
  return ret_table
end

function AircraftModule:CalCentralPetWorkSkill()
  local lfAv = 0
  local lfMv = 0
  local l_CentralRoom = self:GetCentralRoom()
  if l_CentralRoom == nil then
    return lfAv, lfMv
  end
  local pets = l_CentralRoom:GetPets()
  for i, pet in pairs(pets) do
    local l_lfAv, l_lfMv = pet:GetWorkSkillEffectVV(WorkSkillType.WS_Furniture_Add_Ambient, AirRoomType.CentralRoom)
    lfAv = lfAv + l_lfAv
    lfMv = lfMv + l_lfMv
  end
  return lfAv, lfMv
end

function AircraftModule:GetUseFurnitureItemNum()
  if self._areaFurniture == nil then
    return {}
  end
  local l_OutId2NumMap = {}
  for area, value in pairs(self._areaFurniture) do
    for _, var in ipairs(value) do
      local id = var.asset_id
      if l_OutId2NumMap[id] == nil then
        l_OutId2NumMap[id] = 1
      else
        l_OutId2NumMap[id] = l_OutId2NumMap[id] + 1
      end
    end
  end
  return l_OutId2NumMap
end

function AircraftModule:GetUseFurnitureItemNumByItemID(itemID)
  local l_OutId2NumMap = self:GetUseFurnitureItemNum()
  local useItemNum = l_OutId2NumMap[itemID] or 0
  local tempItemNum = self:GetTempFurnitureCount(itemID)
  return useItemNum + tempItemNum
end

function AircraftModule:GetFurnitureItemNumInBagByItemID(itemID)
  local l_OutId2NumMap = self:GetUseFurnitureItemNum()
  local useItemNum = l_OutId2NumMap[itemID] or 0
  return useItemNum
end

function AircraftModule:GetRemainsFurnitureItemNumByItemID(itemID)
  local itemModule = self:GetModule(ItemModule)
  local hasItemNum = itemModule:GetItemCount(itemID)
  local useItemNum = self:GetUseFurnitureItemNumByItemID(itemID)
  local remainsNum = hasItemNum - useItemNum
  return remainsNum
end

function AircraftModule:GetFurnitureByArea(area)
  return self._areaFurniture[area]
end

function AircraftModule:ClearTempFurniture()
  self._tempFur = nil
end

function AircraftModule:ChangeTempFurniture(furID, count)
  if self._tempFur == nil then
    self._tempFur = {}
  end
  if self._tempFur[furID] == nil then
    self._tempFur[furID] = 0
  end
  self._tempFur[furID] = self._tempFur[furID] + count
end

function AircraftModule:GetTempFurnitureCount(furID)
  if self._tempFur == nil then
    return 0
  end
  return self._tempFur[furID] or 0
end

function AircraftModule:GetPrismRoom()
  for i, room in pairs(self._rooms) do
    if room:GetRoomType() == AirRoomType.PrismRoom then
      return room
    end
  end
end

function AircraftModule:GetPhysicLocalRate()
  local room = self:GetPrismRoom()
  if not room then
    return 0.0
  end
  local cfg = Cfg.cfg_aircraft_prism_room[room:RoomId()]
  return cfg.LocalRecover
end

function AircraftModule:GetPhysicStorage()
  local recover_rate = self:GetPhysicLocalRate()
  local cur_value = self._aircraftInfo.physic_storage
  if 0 < recover_rate then
    local room = self:GetPrismRoom()
    local now = self:GetServerTime()
    local last = self._aircraftInfo.update_time
    if now < last then
      now = last
    end
    local diff = now - last
    local delta = diff / recover_rate
    local max = room:GetTotalPhysicStorageLimit()
    cur_value = math.min(self._aircraftInfo.physic_storage + delta, max)
  end
  return cur_value
end

function AircraftModule:GetPhysicStorageLimit()
  local room = self:GetPrismRoom()
  if room == nil then
    return 0
  end
  local max = room._physic_room_storage + room._physic_pet_storage
  return max
end

function AircraftModule:GetMazeRoom()
  for i, room in pairs(self._rooms) do
    if room:GetRoomType() == AirRoomType.MazeRoom then
      return room
    end
  end
end

function AircraftModule:GetLightRate()
  local room = self:GetMazeRoom()
  if not room then
    return 0.0
  end
  local r1, r2 = room:GetLightRate()
  local rate = math.max(r1 + r2, 1)
  return rate
end

function AircraftModule:GetLightStorage()
  local recover_rate = self:GetLightRate()
  local cur_value = self._aircraftInfo.light_storage
  if 0 < recover_rate then
    local room = self:GetMazeRoom()
    local now = self:GetServerTime()
    local last = self._aircraftInfo.update_time
    if now < last then
      now = last
    end
    local diff = now - last
    local delta = math.floor(diff / recover_rate)
    local max = self._maxValue
    cur_value = math.min(self._aircraftInfo.light_storage + delta, max)
  end
  return cur_value
end

function AircraftModule:GetResCardCount()
  return self._aircraftInfo.res_card_count
end

function AircraftModule:GetDrawCardCount()
  return self._aircraftInfo.draw_card_count
end

function AircraftModule:GetHeartAmberCount()
  return self._aircraftInfo.heart_amber_count
end

function AircraftModule:GetResCardCDTime()
  return self._aircraftInfo.res_card_cd_time
end

function AircraftModule:GetDrawCardCDTime()
  return self._aircraftInfo.draw_card_cd_time
end

function AircraftModule:GetSmeltCDTime()
  return self._aircraftInfo.smelt_cd_time
end

function AircraftModule:GetCollectTypeCount()
  local l_totalCount = 0
  for id, room in pairs(self._rooms) do
    if room:CanCollect() then
      l_totalCount = l_totalCount + 1
    end
  end
  return l_totalCount
end

function AircraftModule:GetRoomLevelUpPreCondition(spaceID)
  local roomData = self:GetRoom(spaceID)
  if roomData == nil then
    return {}
  end
  if roomData:Level() >= roomData:MaxLevel() then
    return {}
  end
  local condData = roomData:GetNeedRooms()
  local conds = {}
  for i = #condData, 1, -1 do
    local cond = condData[i]
    local type = cond[1]
    local level = cond[2]
    local need = cond[3]
    local had = self:GetRoomCountWithOutAmusement(type, level)
    if need <= had then
    else
      conds[#conds + 1] = AircraftLevelUpPreCondition:New(type, level, need, had)
    end
  end
  return conds
end

function AircraftModule:CanRoomLevelUp(spaceID, checkMatEnough)
  local roomData = self:GetRoom(spaceID)
  if roomData == nil then
    return false
  else
  end
  if roomData:Level() >= roomData:MaxLevel() then
    return false
  end
  if not roomData:EnoughPowerToUpgrade() then
    return false
  end
  local roomType = roomData:GetRoomType()
  if roomType >= AirRoomType.AmusementBegin and roomType <= AirRoomType.AmusementEnd then
    return false
  end
  local mats = roomData:GetUpgradeNeed()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local matEnough = false
  if checkMatEnough then
    matEnough = true
    for _, mat in ipairs(mats) do
      local id = mat[1]
      local need = mat[2]
      if roleModule:GetAssetCount(id) == nil then
        Log.exception("无法获取物品数量：", id, "，空间：", spaceID)
      end
      local had = math.floor(roleModule:GetAssetCount(id))
      if need > had then
        matEnough = false
        break
      end
    end
  else
    for _, mat in ipairs(mats) do
      local id = mat[1]
      local need = mat[2]
      if roleModule:GetAssetCount(id) == nil then
        Log.exception("无法获取物品数量：", id, "，空间：", spaceID)
      end
      local had = math.floor(roleModule:GetAssetCount(id))
      if need > had then
        return false
      end
    end
  end
  local cond = self:GetRoomLevelUpPreCondition(spaceID)
  if 0 < #cond then
    return false
  end
  if checkMatEnough then
    return true, matEnough
  else
    return true
  end
end

function AircraftModule:GetSpaceUnlockLevel(spaceID)
  local centerRooms = Cfg.cfg_aircraft_room({
    RoomType = AirRoomType.CentralRoom
  })
  for _, room in ipairs(centerRooms) do
    local cfg = Cfg.cfg_aircraft_central_room[room.ID]
    if cfg == nil then
      Log.fatal("找不到主控室id：", room.ID)
      return
    end
    for _, space in ipairs(cfg.OpenSpaces) do
      if space == spaceID then
        return room.Level
      end
    end
  end
end

function AircraftModule:CanRoomSettlePet(spaceID)
  local petModule = GameGlobal.GetModule(PetModule)
  local petsCount = table.count(petModule:GetPets())
  local count = 0
  for _, room in pairs(self._rooms) do
    count = count + #room:GetPets()
  end
  if petsCount <= count then
    return false
  end
  local room = self:GetRoom(spaceID)
  if room then
    local ceiling = room:GetPetCountLimit()
    local pets = #room:GetPets()
    return ceiling > pets
  end
end

function AircraftModule:GetSmeltRoom()
  for i, room in pairs(self._rooms) do
    if room:GetRoomType() == AirRoomType.SmeltRoom then
      return room
    end
  end
end

function AircraftModule:IsSmeltItemLock(id)
  local room = self:GetSmeltRoom()
  if not room then
    return true
  end
  local items = Cfg.cfg_item_smelt({})
  local cfg
  for _, item in pairs(items) do
    if item.Output[1] == id then
      cfg = item
      break
    end
  end
  return self:IsSmeltItemLockEx(room, cfg)
end

function AircraftModule:IsSmeltItemLockEx(room, cfg)
  if not room then
    return true
  end
  local missionModule = GameGlobal.GetModule(MissionModule)
  if cfg and cfg.Condition then
    for _, data in ipairs(cfg.Condition) do
      local type = data[1]
      local param = data[2]
      if type == SmeltItemType.SIT_Mission then
        if not missionModule:IsPassMissionID(param) then
          return true
        end
      elseif type == SmeltItemType.SIT_Lv and param > room:Level() then
        return true
      end
    end
  end
  return false
end

function AircraftModule:GetMaterialInfoByOutPutId(id)
  local items = Cfg.cfg_item_smelt({})
  local cfg
  for _, item in pairs(items) do
    if item.Output[1] == id then
      cfg = item
      break
    end
  end
  return self:GetSmeltLockInfo(cfg)
end

function AircraftModule:Init()
  self.caller:RegisterPushHandler(CEventPushAircraftInfo, self.HandleAircraftInfo, self)
  self.caller:RegisterPushHandler(CEventPushAircraftSpaceInfos, self.HandleSpaceInfos, self)
  self.caller:RegisterPushHandler(CEventPushAircraftAreaFurniture, self.HandUpdateAreaFurniture, self)
end

function AircraftModule:SetSpaceInfos(spaces)
  for i, s in pairs(spaces) do
    self._spaces[s.space_id] = s
  end
  for i, s in pairs(self._spaces) do
    local r = self._rooms[i]
    if s.room_id > 0 then
      if not r then
        r = self:CreateRoom(s)
        self._rooms[i] = r
      elseif s.space_status == SpaceState.SpaceStateEmpty then
        self._rooms[i] = nil
      else
        r:SetData(s)
      end
    elseif s.space_status == SpaceState.SpaceStateEmpty then
      self._rooms[i] = nil
    end
  end
end

function AircraftModule:GetRoomStatus(roomType)
  local room = self:GetRoomWithType(roomType)
  if room then
    return room:GetSpaceStatus()
  end
end

function AircraftModule:__GetSpaceStatus(nSpaceId)
  if nSpaceId == nil or self._spaces[nSpaceId] == nil or self._rooms[nSpaceId] == nil then
    return nil
  end
  return self._spaces[nSpaceId].space_status
end

function AircraftModule:__SetSpaceStatus(nSpaceId, eSpaceState)
  if nSpaceId == nil or self._spaces[nSpaceId] == nil or self._rooms[nSpaceId] == nil then
    return
  end
  local l_space = self._spaces[nSpaceId]
  l_space.space_status = eSpaceState
  local l_room = self._rooms[nSpaceId]
  l_room:SetSpaceStatus(eSpaceState)
end

function AircraftModule:__SetSpaceStatusAndRefresUI(nSpaceId, eSpaceState)
  self:__SetSpaceStatus(nSpaceId, eSpaceState)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshMainUI)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshTopbar)
end

function AircraftModule:SetAircraftInfo(aircraftInfo)
  self._aircraftInfo = aircraftInfo
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshTopbar)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRedPoint)
end

function AircraftModule:HandleAircraftInfo(msg)
  self:SetAircraftInfo(msg.info)
end

function AircraftModule:HandUpdateAreaFurniture(msg)
  self:_UpdateFurnitureId(msg.update_furniture_info, msg.area_id)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftAreaFurnitureUpdate, msg.area_id, msg.update_furniture_info)
end

function AircraftModule:HandleSpaceInfos(msg)
  self:SetSpaceInfos(msg.infos)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshMainUI)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshTopbar)
end

function AircraftModule:RequestCleanSpace(TT, spaceid)
  return self:SpaceOperate(TT, spaceid, AircraftRoomOperation.CleanSpace)
end

function AircraftModule:RequestBuildRoom(TT, spaceid, roomid)
  return self:SpaceOperate(TT, spaceid, AircraftRoomOperation.BuildRoom, {roomid})
end

function AircraftModule:RequestCleanAndBuild(TT, spaceid, roomid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAircraftCleanAndBuild)
  request.space_id = spaceid
  request.room_id = roomid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshTopbar)
  return res, reply.msg
end

function AircraftModule:RequestRoomUpgrade(TT, spaceid)
  local result = self:SpaceOperate(TT, spaceid, AircraftRoomOperation.Upgrade)
  return result
end

function AircraftModule:RequestRoomDegrade(TT, spaceid)
  local result = self:SpaceOperate(TT, spaceid, AircraftRoomOperation.Degrade)
  return result
end

function AircraftModule:RequestEnterPet(TT, spaceid, petlist)
  return self:SpaceOperate(TT, spaceid, AircraftRoomOperation.ReplacePets, petlist)
end

function AircraftModule:RequestUseFireflyBuildRoom(TT, spaceid, count)
  return self:SpaceOperate(TT, spaceid, AircraftRoomOperation.BuildSpeedUp, {count})
end

function AircraftModule:RequestUseFireflyUpgradeRoom(TT, spaceid, count)
  return self:SpaceOperate(TT, spaceid, AircraftRoomOperation.UpgradeSpeedUp, {count})
end

function AircraftModule:RequestUseFireflyPurify(TT, spaceid, count)
  return self:SpaceOperate(TT, spaceid, AircraftRoomOperation.PurifySpeedUp, {count})
end

function AircraftModule:RequestCollectAsset(TT, spaceid)
  return self:SpaceOperate(TT, spaceid, AircraftRoomOperation.CollectAsset)
end

function AircraftModule:RequestUseFireflyCleanSpace(TT, spaceid, count)
  return self:SpaceOperate(TT, spaceid, AircraftRoomOperation.CleanSpeedUp, {count})
end

function AircraftModule:RequestUseFireflyDegradeRoom(TT, spaceid, count)
  return self:SpaceOperate(TT, spaceid, AircraftRoomOperation.DegradeSpeedUp, {count})
end

function AircraftModule:RequestCheckInOnePet(TT, spaceid, index, petid, spSpaceID, spPetIdx)
  local res = AsyncRequestRes:New()
  local res1 = self:SpaceOperate(TT, spaceid, AircraftRoomOperation.CheckInOnePet, {
    index,
    petid,
    spSpaceID,
    spPetIdx
  })
  if res1:GetSucc() then
    local res2 = self:AircraftUpdate(TT, false)
    if res2:GetSucc() then
      res:SetSucc(true)
      return res
    else
      Log.error("入住后更新风船数据失败")
    end
  else
    Log.error("入住星灵消息失败")
  end
  res:SetSucc(false)
  return res
end

function AircraftModule:OneKeyCollectAsset(TT)
  local l_canCollectSpace = {}
  for i, room in pairs(self._rooms) do
    if room and room:CanCollect() then
      local l_space_id = room:SpaceId()
      l_canCollectSpace[#l_canCollectSpace + 1] = l_space_id
    end
  end
  return self:SpaceOperate(TT, 0, AircraftRoomOperation.OneKeyCollectAsset, l_canCollectSpace)
end

function AircraftModule:SpaceOperate(TT, spaceid, operation, params)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAircraftRoomOperate)
  request.space_id = spaceid
  request.option = operation
  request.operate_params = params or {}
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshTopbar)
  return res, reply.msg
end

function AircraftModule:RedeemFirefly(TT, count)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAircraftRedeemFirfly)
  request.physic_point = count
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function AircraftModule:PushViewNewFurniture(furniture_id)
  if furniture_id <= 0 then
    return
  end
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventPushViewNewFurniture)
  msg.furniture_item_id = furniture_id
  self:Push(msg)
end

function AircraftModule:ReqFurnitureInfo(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAircraftFurnitureInfoReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return {}
  end
  local l_RepMsg = reply.msg
  local furnitures = l_RepMsg.mobile_furniture_info
  self:_UpdateFurnitureId(furnitures, nil)
  return furnitures
end

function AircraftModule:_UpdateFurnitureId(mobile_furniture_info, area_id)
  if mobile_furniture_info == nil then
    return
  end
  if self._areaFurniture == nil or area_id == nil then
    self._areaFurniture = {}
  end
  if area_id ~= nil and 0 < area_id then
    self._areaFurniture[area_id] = nil
  end
  for _, value in ipairs(mobile_furniture_info) do
    local areaId = value.area_id
    if self._areaFurniture[areaId] == nil then
      self._areaFurniture[areaId] = {}
    end
    table.insert(self._areaFurniture[areaId], value)
  end
end

function AircraftModule:ReqUpdateAreaFurniture(TT, area_id, update_furniture_info)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAircraftFurnitureInfoUpReq)
  request.area_id = area_id
  request.update_furniture_info = update_furniture_info
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return AircraftEventResult.AircraftEventResult_INVALID
  end
  local l_RepMsg = reply.msg
  if l_RepMsg.ret == AircraftEventResult.AircraftEventResult_Succ then
    self:_UpdateFurnitureId(update_furniture_info, area_id)
  end
  return l_RepMsg.ret
end

function AircraftModule:GetFurnitureList()
  local itemMd = self:GetModule(ItemModule)
  local furniture_list = itemMd:GetItemListBySubType(ItemSubType.ItemSubType_Furniture)
  return furniture_list
end

function AircraftModule:PushLeaveAircraft(furniture_id)
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventAircraftLeave)
  self:Push(msg)
end

function AircraftModule:AircraftUpdate(TT, enter)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAircraftUpdate)
  if enter then
    request.enter = 1
  else
    request.enter = 0
  end
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function AircraftModule:GetErrorMsg(errno)
  if errno == AircraftEventResult.INVALID_SPACE_OPERATION then
    return StringTable.Get("str_aircraft_invalid_space_operation")
  elseif errno == AircraftEventResult.INVALID_ROOM_OPERATION then
    return StringTable.Get("str_aircraft_invalid_room_operation")
  elseif errno == AircraftEventResult.SPACE_NOT_FOUND then
    return StringTable.Get("str_aircraft_space_not_found")
  elseif errno == AircraftEventResult.AIRCRAFT_ROOM_NOT_FOUND then
    return StringTable.Get("str_aircraft_aircraft_room_not_found")
  elseif errno == AircraftEventResult.PET_NOT_FOUND then
    return StringTable.Get("str_aircraft_pet_not_found")
  elseif errno == AircraftEventResult.AIRCRAFT_ROOM_LEVEL_MAX then
    return StringTable.Get("str_aircraft_aircraft_room_level_max")
  elseif errno == AircraftEventResult.ASSET_NOT_ENOUGH then
    return StringTable.Get("str_aircraft_asset_not_enough")
  elseif errno == AircraftEventResult.STAR_POWER_NOT_ENOUGH then
    return StringTable.Get("str_aircraft_star_power_not_enough")
  elseif errno == AircraftEventResult.SPACE_NOT_CONNECTED then
    return StringTable.Get("space_not_connected")
  elseif errno == AircraftEventResult.AIRCRAFT_ROOM_BUILDING then
    return StringTable.Get("aircraft_room_building")
  elseif errno == AircraftEventResult.INVALID_OPERATION then
    return StringTable.Get("invalid_operation")
  elseif errno == AircraftEventResult.BUILD_TYPE_ERROR then
    return StringTable.Get("build_type_error")
  elseif errno == AircraftEventResult.ROOM_LEVEL_NOT_ZERO then
    return StringTable.Get("room_level_not_zero")
  elseif errno == AircraftEventResult.SPACE_NOT_AVAILABLE then
    return StringTable.Get("str_aircraft_space_not_available")
  elseif errno == AircraftEventResult.DESTROY_WILL_CREATE_ISLAND then
    return StringTable.Get("str_aircraft_destroy_will_create_island")
  elseif errno == AircraftEventResult.PREVLEVEL_CANNOT_CONTAIN_EVIL then
    return StringTable.Get("prevlevel_cannot_contain_evil")
  elseif errno == AircraftEventResult.CANNOT_DESTROY_EVILROOM then
    return StringTable.Get("cannot_destroy_evilroom")
  elseif errno == AircraftEventResult.PREVLEVEL_POWER_NOT_ENOUGH then
    return StringTable.Get("prevlevel_power_not_enough")
  elseif errno == AircraftEventResult.CENTRALROOM_CANNOT_DEGRADE then
    return StringTable.Get("str_aircraft_centralroom_cannot_degrade")
  elseif errno == AircraftEventResult.PET_NOT_IN_ROOM then
    return StringTable.Get("pet_not_in_room")
  elseif errno == AircraftEventResult.PET_COUNT_EXCEED_LIMIT then
    return StringTable.Get("pet_count_exceed_limit")
  elseif errno == AircraftEventResult.PURIFY_ROOM_FULL then
    return StringTable.Get("purify_room_full")
  elseif errno == AircraftEventResult.PURIFY_ROOM_EMPTY then
    return StringTable.Get("purify_room_empty")
  elseif errno == AircraftEventResult.EVIL_IS_PURIFIED then
    return StringTable.Get("evil_is_purified")
  elseif errno == AircraftEventResult.PURIFY_ROOM_NO_AWARD then
    return StringTable.Get("purify_room_no_award")
  elseif errno == AircraftEventResult.CELL_INDEX_ERROR then
    return StringTable.Get("cell_index_error")
  elseif errno == AircraftEventResult.REFRESH_INDEX_ERROR then
    return StringTable.Get("refresh_index_error")
  elseif errno == AircraftEventResult.ROOM_NOT_PURIFYROOM then
    return StringTable.Get("room_not_purifyroom")
  elseif errno == AircraftEventResult.ROOM_NOT_EVILROOM then
    return StringTable.Get("room_not_evilroom")
  elseif errno == AircraftEventResult.CANNOT_TRACE_MORE_EVIL then
    return StringTable.Get("cannot_trace_more_evil")
  elseif errno == AircraftEventResult.EVIL_IS_TRACING then
    return StringTable.Get("evil_is_tracing")
  elseif errno == AircraftEventResult.NO_EVIL_TRACING then
    return StringTable.Get("no_evil_tracing")
  elseif errno == AircraftEventResult.FIREFLY_NOT_ENOUGH then
    return StringTable.Get("str_aircraft_firefly_not_enough")
  elseif errno == AircraftEventResult.MOOD_NOT_ENOUGH then
    return StringTable.Get("str_aircraft_mood_not_enough")
  elseif errno == AircraftEventResult.BUILD_NO_NEED_SPEEDUP then
    return StringTable.Get("str_aircraft_build_no_need_speedup")
  elseif errno == AircraftEventResult.SPACE_STATE_CANNOT_CLEAN then
    return StringTable.Get("str_aircraft_space_state_cannot_clean")
  elseif errno == AircraftEventResult.ADJACENT_SPACE_NOT_STATEFULL then
    return StringTable.Get("str_aircraft_adjacent_space_not_statefull")
  elseif errno == AircraftEventResult.LEVEL_LIMIT then
    return StringTable.Get("str_aircraft_build_room_level_limit")
  elseif errno == AircraftEventResult.COUNT_LIMIT then
    return StringTable.Get("str_aircraft_build_room_count_limit")
  elseif errno == AircraftEventResult.ROOM_LEVEL_NOT_ZERO then
    return StringTable.Get("str_aircraft_build_room_must_1_level")
  elseif errno == AircraftEventResult.SPACE_NOT_AVAILABLE then
    return StringTable.Get("str_aircraft_space_not_available")
  elseif errno == AircraftEventResult.NETWORK_ERROR then
    return StringTable.Get("str_common_tip_network_error")
  elseif errno == AircraftEventResult.SAME_PET_ID_REPEAT then
    return StringTable.Get("str_aircraft_the_same_pet_enter_room")
  elseif errno == AircraftEventResult.COLLECT_ASSET_EMPTY then
    return StringTable.Get("str_aircraft_no_object_collect")
  elseif errno == AircraftEventResult.COLLECT_ASSET_ERROR_PHY then
    return StringTable.Get("str_physicalpower_error_phy_add_full")
  elseif errno == AircraftEventResult.ROOM_UNKOWN_ERROR then
    return StringTable.Get("str_aircraft_error_120")
  elseif errno == AircraftEventResult.ROOM_STATE_ERROR then
    return StringTable.Get("str_aircraft_error_121")
  elseif errno == AircraftEventResult.SMELTROOM_OPERATE_NUM then
    return StringTable.Get("str_aircraft_error_122")
  elseif errno == AircraftEventResult.SMELTROOM_CFG_NOT then
    return StringTable.Get("str_aircraft_error_123")
  elseif errno == AircraftEventResult.SMELTROOM_ITEM_NOT_ENOUGH then
    return StringTable.Get("str_aircraft_error_124")
  elseif errno == AircraftEventResult.SMELTROOM_ITEM_NOT_CONDITION then
    return StringTable.Get("str_aircraft_error_125")
  elseif errno == AircraftEventResult.FIREFLYTOATOM_OPERATE_NUM then
    return StringTable.Get("str_aircraft_error_130")
  elseif errno == AircraftEventResult.FIREFLYTOATOM_ITEM_NOT_ENOUGH then
    return StringTable.Get("str_aircraft_error_131")
  elseif errno == AircraftEventResult.AIRCRAFT_DISPATCH_TASK_STATE then
    return StringTable.Get("str_dispatch_room_erro_code_207")
  end
  return StringTable.Get("str_aircraft_unkown_error") .. ":" .. errno
end

function AircraftModule:HandleItemSmelt(TT, cfgId, num, inputIds)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventItemSmelt)
  request.id = cfgId
  request.num = num
  if inputIds ~= nil then
    request.ids = inputIds
  end
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:HandleMultItemSmelt(TT, itemlist)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMultItemSmelt)
  request.id_num_list = itemlist
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:HandleAIMultItemSmelt(TT, itemlist)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAIMultItemSmelt)
  request.id_num_list = itemlist
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:HandleFireflyToAtom(TT, num)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventFireflyToAtom)
  request.num = num
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:HandleCEventDispatchSite(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDispatchSite)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:HandleCEventDispatchLook(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDispatchLook)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:HandleCEventDispatchAcceptTask(TT, siteId, pstIds)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDispatchAcceptTask)
  request.site_id = siteId
  request.team_member = pstIds
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:HandleCEventDispatchCancelTask(TT, siteId)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDispatchCancelTask)
  request.site_id = siteId
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:HandleCEventDispatchTaskAward(TT, siteId)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDispatchTaskAward)
  request.site_id = siteId
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:SetClientMain(m)
  self._aircraftMain = m
end

function AircraftModule:GetClientMain()
  return self._aircraftMain
end

function AircraftModule:IsPetDispatch(templateId)
  local roomData = self:GetRoomByRoomType(AirRoomType.DispatchRoom)
  if roomData then
    return roomData:IsPetDispatch(templateId)
  end
  return false
end

function AircraftModule:IsDecorateUnLocked()
  return GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_Funiture)
end

function AircraftModule:IsAllAmusementRoomUnlock()
  local rooms = {
    AirRoomType.RestRoom,
    AirRoomType.CoffeeRoom,
    AirRoomType.WaterBarRoom,
    AirRoomType.GameRoom
  }
  for i, type in pairs(rooms) do
    local room = self:GetRoomByRoomType(type)
    if room == nil then
      return false
    end
    if room:Level() <= 1 then
      return false
    end
  end
  return true
end

function AircraftModule:GetSmeltLockInfo(cfg)
  if cfg.Condition then
    for _, data in ipairs(cfg.Condition) do
      local type = data[1]
      local param = data[2]
      if type == SmeltItemType.SIT_Mission then
        local missionModule = self:GetModule(MissionModule)
        if not missionModule:IsPassMissionID(param) then
          return SmeltItemType.SIT_Mission, param
        end
      elseif type == SmeltItemType.SIT_Lv then
        local smeltRoom = self:GetSmeltRoom()
        if smeltRoom == nil then
          return SmeltItemType.SIT_Lv, param
        elseif param > smeltRoom:Level() then
          return SmeltItemType.SIT_Lv, param
        end
      end
    end
  end
end

function AircraftModule:RequestRefreshTacticRoom(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestTacticRoomData)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:RequestOpenCartridgeGift(TT)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local item_template_id = Cfg.cfg_aircraft_values[AirValueID.CartridgeGiftID].IntValue
  return itemModule:RequestUseItemByTemplateID(TT, item_template_id, 1)
end

function AircraftModule:RequestMakeCartridgeFree(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCartridgeFreeProduce)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:RequestDeleteCartridge(TT, pstid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventDelCartridge)
  request.pstid = pstid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:RequestExchangeFirefly(TT, count)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCartridgeProSpeedUp)
  request.firefly_count = count
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:RequestTakeWeeklyAward(TT, num)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTakeWeeklyAward)
  request.pass_num = num
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:RequestWeeklyReset(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTacticWeekReset)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:TacticPeakRewardedList()
  local room = self:GetRoomByRoomType(AirRoomType.TacticRoom)
  return room:TacticPeakRewardedList()
end

function AircraftModule:TacticPeakScore()
  local item_mod = self:GetModule(ItemModule)
  local itemid = Cfg.cfg_aircraft_values[AirValueID.PeakScoreItemID]
  return item_mod.GetItemCount(itemid)
end

function AircraftModule:TacticPeakReward(TT, level_list)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTacticPeakReward)
  request.level = level_list
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
    local room = self:GetRoomByRoomType(AirRoomType.TacticRoom)
    room:SetPeakRewardedList(replyEvent.received_peak_lv_list)
  end
  return res, replyEvent.received_peak_lv_list, replyEvent.award_list
end

function AircraftModule:GetThemeList()
  local room = self:GetRoomByRoomType(AirRoomType.TacticRoom)
  return room:GetThemeList()
end

function AircraftModule:TacticUnlockTheme(TT, themeid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTacticUnlockTheme)
  request.themeid = themeid
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
    local room = self:GetRoomByRoomType(AirRoomType.TacticRoom)
    room:SetThemeList(replyEvent.theme_list)
  end
  return res, replyEvent.theme_list
end

function AircraftModule:TacticGetInformation(TT, themeid, infoid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTacticGetInformation)
  request.themeid = themeid
  request.infoid = infoid
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
    local room = self:GetRoomByRoomType(AirRoomType.TacticRoom)
    room:SetThemeList(replyEvent.theme_list)
  end
  return res, replyEvent.theme_list
end

function AircraftModule:UI_TopRankRed()
  local passList = self:TacticPeakRewardedList()
  local currentLv = self:UI_TopRankCurrentLv()
  local cfg_top_rank = Cfg.cfg_peak({})
  local red = false
  for i = 1, #cfg_top_rank do
    local cfg = cfg_top_rank[i]
    if i <= currentLv then
      if cfg.Award and not table.icontains(passList, i) then
        red = true
        break
      end
    else
      break
    end
  end
  return red
end

function AircraftModule:UI_TopRankCurrentLv()
  local expID = Cfg.cfg_aircraft_values[36].IntValue
  if not expID then
    Log.error("###[AircraftModule] Cfg.cfg_aircraft_values[36].IntValue is nil !")
  end
  local exp = GameGlobal.GetModule(RoleModule):GetAssetCount(expID)
  return self:GetLvByExp(exp)
end

function AircraftModule:GetLvByExp(exp)
  local cfg_top_rank = Cfg.cfg_peak({})
  local _lv = 0
  for i = 1, #cfg_top_rank do
    local cfg_unit = cfg_top_rank[i]
    if exp >= cfg_unit.Exp then
      _lv = i
    else
      break
    end
  end
  return _lv
end

function AircraftModule:UI_DB_one_node_red(nodeid)
  local red = false
  local roleModule = GameGlobal.GetModule(RoleModule)
  local cfg = Cfg.cfg_tactical_db_theme[nodeid]
  local nodePassList = self:GetThemeList()
  if nodePassList[nodeid] then
    local nodeData = nodePassList[nodeid]
    local nodePassInfos = nodeData.unlock_info_list
    local infoList = cfg.InfoIDList
    local lessInfoList = {}
    for i = 1, #infoList do
      local infoid = infoList[i]
      if not table.icontains(nodePassInfos, infoid) then
        table.insert(lessInfoList, infoid)
      end
    end
    if 0 < #lessInfoList then
      for i = 1, #lessInfoList do
        local infoid = lessInfoList[i]
        local enough = self:GetInfoMatEnough(infoid)
        if enough then
          red = true
          break
        end
      end
    elseif not nodeData.rewarded then
      red = true
    end
  else
    local preIDs = cfg.PreThemeID
    if preIDs then
      local allIn = true
      local oneNodeUnLock = false
      for i = 1, #preIDs do
        local preid = preIDs[i]
        local cfg_pre = Cfg.cfg_tactical_db_theme[preid]
        local pre_infos = cfg_pre.InfoIDList
        local preNodeData = nodePassList[preid]
        if preNodeData then
          local pre_unlock_infos = preNodeData.unlock_info_list
          local allInfoUnLock = true
          for j = 1, #pre_infos do
            local infoid = pre_infos[j]
            if not table.icontains(pre_unlock_infos, infoid) then
              allInfoUnLock = false
              break
            end
          end
          if allInfoUnLock then
            oneNodeUnLock = true
            break
          end
        end
      end
      if oneNodeUnLock then
        local infoList = cfg.InfoIDList
        for i = 1, #infoList do
          local infoid = infoList[i]
          local enough = self:GetInfoMatEnough(infoid)
          if enough then
            red = true
          end
        end
      end
    else
      local infoList = cfg.InfoIDList
      for i = 1, #infoList do
        local infoid = infoList[i]
        local enough = self:GetInfoMatEnough(infoid)
        if enough then
          red = true
        end
      end
    end
  end
  return red
end

function AircraftModule:GetInfoMatEnough(infoid)
  local cfg_info = Cfg.cfg_tactical_db_info[infoid]
  local unlocklist = cfg_info.UnlockItemList
  local enough = true
  local roleModule = GameGlobal.GetModule(RoleModule)
  for j = 1, #unlocklist do
    local asset = unlocklist[j]
    local assetid = asset[1]
    local count = asset[2]
    local haveCount = roleModule:GetAssetCount(assetid)
    if count > haveCount then
      enough = false
      break
    end
  end
  return enough
end

function AircraftModule:CheckOneNodeOpen(nodeid)
  local cfg = Cfg.cfg_tactical_db_theme[nodeid]
  if not cfg then
    Log.error("###[AircraftModule] cfg_tactical_db_theme is nil ! id --> ", nodeid)
  end
  local open = false
  local nodePassList = self:GetThemeList()
  if nodePassList[nodeid] then
    open = true
  else
    local preids = cfg.PreThemeID
    if preids then
      local andOr = cfg.UnlockCondType
      if andOr and andOr == 1 then
        local onePreIdPass = false
        for i = 1, #preids do
          local preid = preids[i]
          local cfg_pre = Cfg.cfg_tactical_db_theme[preid]
          local pre_infos = cfg_pre.InfoIDList
          local preNodeData = nodePassList[preid]
          if preNodeData then
            local pre_unlock_infos = preNodeData.unlock_info_list
            local allInfoUnLock = true
            for j = 1, #pre_infos do
              local infoid = pre_infos[j]
              if not table.icontains(pre_unlock_infos, infoid) then
                allInfoUnLock = false
                break
              end
            end
            if allInfoUnLock then
              onePreIdPass = true
            end
          end
        end
        if onePreIdPass then
          open = true
        end
      else
        local allPreIdPass = true
        for i = 1, #preids do
          local preid = preids[i]
          local cfg_pre = Cfg.cfg_tactical_db_theme[preid]
          local pre_infos = cfg_pre.InfoIDList
          local preNodeData = nodePassList[preid]
          if preNodeData then
            local pre_unlock_infos = preNodeData.unlock_info_list
            local allInfoUnLock = true
            for j = 1, #pre_infos do
              local infoid = pre_infos[j]
              if not table.icontains(pre_unlock_infos, infoid) then
                allInfoUnLock = false
                break
              end
            end
            if allInfoUnLock then
            else
              allPreIdPass = false
              break
            end
          else
            allPreIdPass = false
            break
          end
        end
        if allPreIdPass then
          open = true
        else
          open = false
        end
      end
    else
      open = true
    end
  end
  return open
end

function AircraftModule:UI_DB_all_node_red()
  local red = false
  local cfgs = Cfg.cfg_tactical_db_theme({})
  local nodePassList = self:GetThemeList()
  for i = 1, #cfgs do
    local cfg = cfgs[i]
    local preids = cfg.PreThemeID
    if preids then
      local preIn = true
      for j = 1, #preids do
        local preid = preids[j]
        if not nodePassList[preid] then
          preIn = false
          break
        end
      end
      if not preIn then
        break
      end
    end
    local nodeid = cfg.ID
    local oneRed = self:UI_DB_one_node_red(nodeid)
    if oneRed then
      red = true
      break
    end
  end
  return red
end

function AircraftModule:GetCartridgeMatchParam(select_hard_id, select_cartridge_pstid)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local item = itemModule:FindItem(select_cartridge_pstid)
  local cartridge_tpl_id = item:GetTemplateID()
  local n_matchComID = Cfg.cfg_item_cartridge[cartridge_tpl_id].MatchComId
  local l_paramKeyMap = {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_CSHardId] = select_hard_id,
    [ECampaignMissionParamKey.ECampaignMissionParamKey_CartridgePstId] = select_cartridge_pstid
  }
  return n_matchComID, l_paramKeyMap
end

function AircraftModule:RequestTacticFormationInfo(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetTacticFormationInfo)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  return res, replyEvent
end

function AircraftModule:RequestChangeTacticFormationInfo(TT, formation_id, name, pet_list)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChangeTacticFormationInfo)
  request.id = formation_id
  request.name = name
  request.pet_list = pet_list
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function AircraftModule:IsAircraftCartridgeMission(nComID)
  if nComID == ECampaignMissionComponentId.ECampaignMissionComponentId_AircraftNormal or nComID == ECampaignMissionComponentId.ECampaignMissionComponentId_AircraftBlackfist then
    return true
  end
  return false
end

function AircraftModule:GetSwitchOpenState(spaceid)
  local openTimeStr = Cfg.cfg_aircraft_space[spaceid].UnlockTime
  if not openTimeStr then
    Log.fatal("该空间没有开启条件:", spaceid)
    return false
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  local openTime = loginModule:GetTimeStampByTimeStr(openTimeStr, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local svrTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  return openTime <= svrTime
end
