require("aircraft_room_base")
_class("AircraftDispatchRoom", AircraftRoomBase)
AircraftDispatchRoom = AircraftDispatchRoom

function AircraftDispatchRoom:Constructor()
  self._do_count = 0
  self._team_count = 0
  self._start_time = 0
  self._is_look = true
  self._sur_time = 0
  self._sur_cur_time = 0
end

function AircraftDispatchRoom:SetClientData(client_data)
  self._cur_speed = client_data[1]
  self._sur_time = client_data[2]
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._sur_cur_time = timeModule:GetServerTime() / 1000
end

function AircraftDispatchRoom:SetExtData(data)
  self._siteData = nil
  if data then
    local info = DispatchRoomExtData:New()
    local ret, msg = lua_dc.LoadStream(info._className, data, info)
    if ret == nil then
      Log.fatal("AircraftDispatchRoom:SetExtData lua_dc.LoadStream fail! ", msg)
    else
      self._do_count = info.do_count
      self._team_count = info.team_count
      self._start_time = info.start_time
      self._is_look = info.is_look
      self._siteData = {}
      for index, value in pairs(info.site_list) do
        self._siteData[index] = nil
        if value.state ~= DispatchTaskStateType.DTST_Invalid then
          self._siteData[index] = {}
          self._siteData[index].state = value.state
          self._siteData[index].endTime = value.end_time
          self._siteData[index].teamMember = value.team_member
          if value.state == DispatchTaskStateType.DTST_New then
            self._siteData[index].taskId = value.task_refresh_id
            self._siteData[index].awardId = value.award_id
          else
            self._siteData[index].taskId = value.task_doing_id
            self._siteData[index].awardId = value.award_doing_id
          end
        end
      end
    end
  end
end

function AircraftDispatchRoom:GetRoomConfig()
  local cfg = Cfg.cfg_aircraft_dispatch_room[self._roomid]
  return cfg
end

function AircraftDispatchRoom:GetSiteMaxNum()
  return DispatchDBSize.DDBS_SiteMaxNum
end

function AircraftDispatchRoom:GetDispatchCount()
  return self._do_count
end

function AircraftDispatchRoom:GetDispatchTeamCount()
  return self._team_count
end

function AircraftDispatchRoom:GetTeamMemberMaxNum()
  return DispatchDBSize.DDBS_TeamMemberMaxNum
end

function AircraftDispatchRoom:IsLook()
  return self._is_look
end

function AircraftDispatchRoom:GetRestoreTime()
  return self._cur_speed
end

function AircraftDispatchRoom:GetSpeedUpTime()
  local c = self:GetRoomConfig()
  return c.OneSpeed - self:GetRestoreTime()
end

function AircraftDispatchRoom:GetSurplusSecond()
  local roomCfg = self:GetRoomConfig()
  if self:GetDispatchCount() >= roomCfg.DispatchMax then
    return -1
  end
  if self._start_time == 0 then
    return 0
  end
  local ct = self:GetRestoreTime()
  if ct == 0 then
    return 0
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime() / 1000
  local endTime = self._start_time + ct
  if nowTime < endTime then
    local seconds = endTime - nowTime
    if seconds < 1 then
      return 0
    end
    return seconds
  end
  return 0
end

function AircraftDispatchRoom:GetStartTime()
  return self._start_time
end

function AircraftDispatchRoom:GetDispatchPetList()
  local petModule = GameGlobal.GetModule(PetModule)
  local allpets = petModule:GetPets()
  local plist = {}
  for _i, pet in pairs(allpets) do
    if pet:IsDispatch() == true then
      plist[#plist + 1] = pet
    end
  end
  return plist
end

function AircraftDispatchRoom:GetScore(petList, taskCfgId)
  if petList == nil then
    return 0
  end
  local taskCfg = Cfg.cfg_aircraft_dispatch_task[taskCfgId]
  if taskCfg == nil then
    return 0
  end
  local scoreCfg = Cfg.cfg_aircraft_dispatch_referrals[taskCfg.Star]
  if scoreCfg == nil then
    return 0
  end
  local totalScore = 0
  for key, pet in pairs(petList) do
    if pet ~= nil then
      if taskCfg.ExtraForce ~= 0 then
        local tags = pet:GetPetTags()
        if table.icontains(tags, taskCfg.ExtraForce) then
          totalScore = totalScore + scoreCfg.ReferralsScore
        end
      end
      if taskCfg.ExtraElement == pet:GetPetFirstElement() then
        totalScore = totalScore + scoreCfg.ReferralsScore
      end
      if taskCfg.ExtraJop == pet:GetJob() then
        totalScore = totalScore + scoreCfg.ReferralsScore
      end
      local glv = pet:GetPetGrade()
      local ggg = scoreCfg["GradeScore" .. glv]
      if ggg ~= nil then
        totalScore = totalScore + ggg
      end
    end
  end
  return totalScore
end

function AircraftDispatchRoom:GetSiteInfo(indexs)
  if self._siteData == nil then
    return nil
  end
  if indexs < 0 or indexs >= self:GetSiteMaxNum() then
    return nil
  end
  return self._siteData[indexs]
end

function AircraftDispatchRoom:GetUpgradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_dispatch_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_dispatch_room[room_cfg.NextLevelID]
  local cur_room_cfg = Cfg.cfg_aircraft_room[room_cfg.ID]
  local next_room_cfg = Cfg.cfg_aircraft_room[room_cfg.NextLevelID]
  local infos = {
    {
      AirLevelInfoTitle.DispatchTeamChange,
      AirRoomChangeLevelDataType.NumberInt,
      cur_cfg.TeamMax,
      next_cfg.TeamMax
    },
    {
      AirLevelInfoTitle.DispatchPetCount,
      AirRoomChangeLevelDataType.NumberInt,
      cur_room_cfg.PetNum,
      next_room_cfg.PetNum
    }
  }
  if cur_cfg.RefreshTaskId ~= next_cfg.RefreshTaskId then
    infos[#infos + 1] = {
      next_cfg.UpgradeRefreshTaskDes,
      AirRoomChangeLevelDataType.TextData
    }
  end
  return infos
end

function AircraftDispatchRoom:GetDegradeInfo()
  local room_cfg = self:GetConfig()
  local cur_cfg = Cfg.cfg_aircraft_dispatch_room[room_cfg.ID]
  local next_cfg = Cfg.cfg_aircraft_dispatch_room[room_cfg.PrevLevelID]
  local cur_room_cfg = Cfg.cfg_aircraft_room[room_cfg.ID]
  local next_room_cfg = Cfg.cfg_aircraft_room[room_cfg.PrevLevelID]
  local infos = {
    {
      AirLevelInfoTitle.DispatchTeamChange,
      AirRoomChangeLevelDataType.NumberInt,
      cur_cfg.TeamMax,
      next_cfg.TeamMax
    },
    {
      AirLevelInfoTitle.DispatchPetCount,
      AirRoomChangeLevelDataType.NumberInt,
      cur_room_cfg.PetNum,
      next_room_cfg.PetNum
    }
  }
  if cur_cfg.RefreshTaskId ~= next_cfg.RefreshTaskId then
    infos[#infos + 1] = {
      next_cfg.DegradeRefreshTaskDes,
      AirRoomChangeLevelDataType.TextData
    }
  end
  return infos
end

function AircraftDispatchRoom:GetAward(awardId, taskId)
  local baseRewards = {}
  local extraRewards = {}
  local bookOrFuniture = {}
  if awardId then
    local awardCfgs = Cfg.cfg_aircraft_dispatch_award({ID = awardId})
    if awardCfgs then
      local awardCfg = awardCfgs[1]
      if awardCfg then
        local dropId = awardCfg.DropId
        if dropId then
          local rewards = Cfg.cfg_drop({DropID = dropId})
          for i = 1, #rewards do
            baseRewards[#baseRewards + 1] = {
              id = rewards[i].AssetID,
              count = rewards[i].MinCount
            }
          end
        end
        if awardCfg.ExtraAward then
          extraRewards[#extraRewards + 1] = {
            id = awardCfg.ExtraAward[1][1],
            count = awardCfg.ExtraAward[1][2]
          }
        end
      end
    end
  end
  if taskId then
    local taskCfg = Cfg.cfg_aircraft_dispatch_task({ID = taskId})
    if taskCfg then
      local itemCfg = taskCfg[1].ItemId
      if itemCfg and 0 < itemCfg then
        bookOrFuniture[#bookOrFuniture + 1] = {id = itemCfg, count = 1}
      end
    end
  end
  return baseRewards, extraRewards, bookOrFuniture
end

function AircraftDispatchRoom:HasNewTask()
  return self:IsLook()
end

function AircraftDispatchRoom:CanCollect()
  return self:HasCompleteTask() or self:HasNewTask()
end

function AircraftDispatchRoom:HasCompleteTask()
  return self:GetCompleteCount() > 0
end

function AircraftDispatchRoom:GetCompleteCount()
  if not self._siteData then
    return 0
  end
  local completeCount = 0
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime() / 1000
  for _, siteData in pairs(self._siteData) do
    if siteData.state == DispatchTaskStateType.DTST_Complete then
      completeCount = completeCount + 1
    elseif siteData.state == DispatchTaskStateType.DTST_Doing and nowTime >= siteData.endTime then
      completeCount = completeCount + 1
    end
  end
  return completeCount
end

function AircraftDispatchRoom:IsPetDispatch(templateId)
  if not self._siteData then
    return false
  end
  if not templateId then
    return false
  end
  local petModule = GameGlobal.GetModule(PetModule)
  for _, siteInfo in pairs(self._siteData) do
    if siteInfo then
      local teamMembers = siteInfo.teamMember
      if teamMembers then
        for _, pstId in pairs(teamMembers) do
          local pet = petModule:GetPet(pstId)
          if pet:GetTemplateID() == templateId then
            return true
          end
        end
      end
    end
  end
  return false
end

function AircraftDispatchRoom:GetDispatchTaskRefreshRemainTime(pointIndex)
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime() / 1000
  local scr = self._sur_time - (nowTime - self._sur_cur_time)
  if scr <= 0 then
    return 0
  end
  local tt = math.modf(scr / 1)
  return tt
end

function AircraftDispatchRoom:GetDispatchRecoverTotalTime()
  local roomCfg = self:GetRoomConfig()
  local curn = self:GetDispatchCount()
  if curn >= roomCfg.DispatchMax then
    return 0
  end
  if self._start_time == 0 then
    return 0
  end
  local ct = self:GetRestoreTime()
  if ct == 0 then
    return 0
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime() / 1000
  local surn = roomCfg.DispatchMax - curn
  local tt = self._start_time + ct * surn - nowTime
  if tt <= 0 then
    return 0
  end
  tt = math.modf(tt / 1)
  return tt
end
