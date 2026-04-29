_class("MissionModule", GameModule)
MissionModule = MissionModule

function MissionModule:Constructor()
  self._cfg_discovery = Cfg.cfg_discovery()
  self._cfg_discovery_path = Cfg.cfg_discovery_path()
  self._curMissionID = 0
  self._passMissionList = {}
  self._canActiveMissionList = {}
  self._curNode = 0
  self._discoveryData = DiscoveryData:New()
  self._alreadyReturnPowerMissionList = {}
  self._alreadyReturnPowerCamMissionList = {}
  self._teamCtx = TeamsContext:New()
  self._activeStoryInfo = {}
  self._chapter_info = {}
  self._showChapterPreview = true
end

function MissionModule:Init()
  self.caller:RegisterPushHandler(CEventMobilePushMissionInfoChange, self.HandleMissionInfoChange, self)
  self.caller:RegisterPushHandler(CEventMobilePushAlreadyReturnPowerMissionInfoChange, self.HandlePushAlreadyReturnPowerMissionInfoChange, self)
  self.caller:RegisterPushHandler(CEventMobilePushAlreadyReturnPowerCamMissionInfoChange, self.HandlePushAlreadyReturnPowerCamMissionInfoChange, self)
  self.caller:RegisterPushHandler(CEventMobilePushMissionActiveStoryData, self.HandleActiveStoryDataChange, self)
  self.caller:RegisterPushHandler(CEventPushOneMissionInfoChange, self.HandleOneMissionInfoChange, self)
end

function MissionModule:InitMissionInfo(mission_id, passMissionList)
  self:SetPassMissionList(passMissionList)
  self:SetCurMissionID(mission_id)
  self._curNode = self:InitCurNode()
  self:InitDiscoveryData()
end

function MissionModule:GetPassMissionList()
  return self._passMissionList
end

function MissionModule:SetPassMissionList(passMissionList)
  self._passMissionList = passMissionList
  self:UpdateCanActiveMissionList()
end

function MissionModule:GetCanActiveMissionList()
  return self._canActiveMissionList
end

function MissionModule:IsMissionCanActive(mission_id)
  if self._canActiveMissionList then
    for _, v in pairs(self._canActiveMissionList) do
      if v.ID == mission_id then
        return true
      end
    end
  end
  return false
end

function MissionModule:GetPassMissionById(id)
  if self._passMissionList then
    for i, v in ipairs(self._passMissionList) do
      if v.id == id then
        return v
      end
    end
  end
  return nil
end

function MissionModule:GetCanActiveMissionById(id)
  if self._canActiveMissionList then
    for i, v in ipairs(self._canActiveMissionList) do
      if v.ID == id then
        return v
      end
    end
  end
  return nil
end

function MissionModule:IsInitPlayer()
  if self._curMissionID == 0 then
    return true
  end
  return false
end

function MissionModule:GetPlayerStayWayPointID()
  if self:IsInitPlayer() then
    return 0
  else
    return self:GetWayPointIDByMissionID(self._curMissionID)
  end
end

function MissionModule:SetCurMissionID(mission_id)
  self._curMissionID = mission_id
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MissionInfoChange)
end

function MissionModule:IsPassMissionID(mission_id)
  for i, v in pairs(self._passMissionList) do
    if v.id == mission_id then
      return true
    end
  end
  return false
end

function MissionModule:GetPassMaxMissionID()
  local cfg_mission_chapter_config = Cfg.cfg_mission_chapter()
  local max_chapter_index = 0
  local missionID = 0
  for _, v in HelperProxy:GetInstance():pairsByKeys(self._passMissionList) do
    for _, config in HelperProxy:GetInstance():pairsByKeys(cfg_mission_chapter_config) do
      if config.MissionID == v.id and config.Type == WayPointType.WayPointType_Main and max_chapter_index < config.ID then
        max_chapter_index = config.ID
        missionID = v.id
      end
    end
  end
  return missionID
end

function MissionModule:_GetMaxMissionIDAndIndex()
  local cfg_mission_chapter_config = Cfg.cfg_mission_chapter()
  local max_chapter_index = 0
  for _, v in HelperProxy:GetInstance():pairsByKeys(self._passMissionList) do
    for _, config in HelperProxy:GetInstance():pairsByKeys(cfg_mission_chapter_config) do
      if config.MissionID == v.id and max_chapter_index < config.ID then
        max_chapter_index = config.ID
      end
    end
  end
  return max_chapter_index
end

function MissionModule:IsBigMission(mission_id)
  local mission_config = Cfg.cfg_mission[mission_id]
  if mission_config and mission_config.Type == MissionType.MissionType_Big then
    return true
  end
  return false
end

function MissionModule:_GetPassWayPointID()
  local cfg_mission_chapter_config = Cfg.cfg_mission_chapter()
  local wayponitlist = {}
  for _, v in pairs(self._passMissionList) do
    for _, config in pairs(cfg_mission_chapter_config) do
      if config.MissionID == v.id and not table.intable(wayponitlist, config.WayPointID) then
        table.insert(wayponitlist, config.WayPointID)
      end
    end
  end
  return wayponitlist
end

function MissionModule:Concat(tb1, tb2)
  for i, t1 in pairs(tb1) do
    if not table.intable(tb2, t1) then
      table.insert(tb2, t1)
    end
  end
  return tb2
end

function MissionModule:GetWayPointIDByMissionID(mission_id)
  local cfg_mission_chapter_config = Cfg.cfg_mission_chapter()
  for i, v in pairs(cfg_mission_chapter_config) do
    if v.MissionID == mission_id then
      return v.WayPointID
    end
  end
  return 0
end

function MissionModule:_GetCanActiveWayPointList()
  local waypointid_list = {}
  for i, v in pairs(self._canActiveMissionList) do
    if not table.intable(waypointid_list, self:GetWayPointIDByMissionID(v.ID)) then
      table.insert(waypointid_list, self:GetWayPointIDByMissionID(v.ID))
    end
  end
  return waypointid_list
end

function MissionModule:GetAllShowWayPointID()
  self:UpdateCanActiveMissionList()
  local waypointList = self:_GetPassWayPointID()
  waypointList = self:Concat(waypointList, self:_GetCanActiveWayPointList())
  return waypointList
end

function MissionModule:GetDiscoveryData()
  return self._discoveryData
end

function MissionModule:InitDiscoveryData()
  if self._cfg_discovery then
    self._discoveryData:Init(self._cfg_discovery)
    self._discoveryData:Update(self._passMissionList, self._canActiveMissionList)
  end
end

function MissionModule:InitCurNode()
  local serializedCurNodeId = 0
  if serializedCurNodeId ~= 0 and self:IsNodeExist(serializedCurNodeId) then
    return serializedCurNodeId
  end
  local serCurNodeId = self:GetPlayerStayWayPointID()
  if serCurNodeId ~= 0 then
    return serCurNodeId
  end
  return 0
end

function MissionModule:GetCurNode()
  return self._curNode
end

function MissionModule:SetCurNode(nodeId)
  self._curNode = nodeId
end

function MissionModule:UpdateCanActiveMissionList()
  local canActiveMissionList = {}
  local cfg_mission_config = Cfg.cfg_mission()
  for _, v in pairs(cfg_mission_config) do
    if self:IsUnLockMission(v, self._passMissionList) then
      table.insert(canActiveMissionList, v)
    end
  end
  for _, v in pairs(self._passMissionList) do
    for key, canActiveMission in pairs(canActiveMissionList) do
      if v.id == canActiveMission.ID then
        table.remove(canActiveMissionList, key)
        break
      end
    end
  end
  table.sort(canActiveMissionList, function(m1, m2)
    return m1.ID < m2.ID
  end)
  self._canActiveMissionList = canActiveMissionList
end

function MissionModule:IsUnLockMission(mission_config, passMissionList)
  if #mission_config.NeedMissionList == 0 then
    return true
  end
  if not passMissionList then
    return false
  end
  local roleModule = self:GetModule(RoleModule)
  local nPlayerLevel = roleModule:GetLevel()
  if nPlayerLevel < mission_config.NeedLevel then
    return false
  end
  for _, p in pairs(mission_config.NeedMissionList) do
    local needMissionID = tonumber(p)
    local isFind = false
    for _, v in pairs(passMissionList) do
      if v.id == needMissionID then
        isFind = true
        break
      end
    end
    if isFind == false then
      return false
    end
    if EngineGameHelper.EnableAppleVerifyBulletin() and needMissionID == 4002120 then
      return false
    end
  end
  return true
end

function MissionModule:HandleMissionInfoChange(msg)
  self:SetCurMissionID(msg.m_cur_mission_id)
  local add_mission_list = {}
  if table.count(self._passMissionList) ~= 0 then
    for _new, p in pairs(msg.m_change_pass_mission_list) do
      local bFind = false
      for _old, v in pairs(self._passMissionList) do
        if v.id == p.id then
          self._passMissionList[_old] = p
          bFind = true
          break
        end
      end
      if bFind == false then
        table.insert(add_mission_list, p)
      end
    end
  else
    add_mission_list = msg.m_change_pass_mission_list
  end
  for _, v in pairs(add_mission_list) do
    table.insert(self._passMissionList, v)
  end
  self:SetPassMissionList(self._passMissionList)
  self._discoveryData:Update(self._passMissionList, self._canActiveMissionList)
end

function MissionModule:HandleOneMissionInfoChange(msg)
  for i, v in ipairs(self._passMissionList) do
    if v.id == msg.m_change_mission_info.id then
      self._passMissionList[i] = msg.m_change_mission_info
      break
    end
  end
end

function MissionModule:ReqMissionPassData(TT, nId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyMissionPassDataReq)
  request.nMissionId = nId
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(-1)
    return AsyncRes, nil
  end
  local replyEvent = reply.msg
  AsyncRes:SetSucc(true)
  return AsyncRes, replyEvent.info
end

function MissionModule:UpdateMainFormationInfo(TT, formation_id, formation_name, pet_list)
  local str_pet_list = ""
  local l_role_module = GameGlobal.GetModule(RoleModule)
  if not l_role_module:CheckModuleUnlock(GameModuleID.MD_ForceGuideEnd) then
    local petModule = self:GetModule(PetModule)
    for index, value in ipairs(pet_list) do
      local l_pet = petModule:GetPet(value)
      if l_pet then
        str_pet_list = str_pet_list .. l_pet:GetTemplateID() .. ","
      end
    end
  end
  GameGlobal.UAReportForceGuideEvent("UITeamsChangeFormationBegin", {
    str_pet_list,
    formation_id,
    formation_name
  }, true)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileChangeMainFormationInfo)
  request.m_formation_id = formation_id
  request.m_formation_name = formation_name
  request.m_formation_pet_list = pet_list
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  if replyEvent.m_result == 0 then
    self:SetFormationInfos(replyEvent.m_formation_info)
    GameGlobal.UAReportForceGuideEvent("UITeamsChangeFormationEnd", {
      str_pet_list,
      formation_id,
      formation_name
    }, true)
  end
  return res, replyEvent.m_formation_info
end

function MissionModule:GetPathByNodeId(sNodeId, eNodeId)
  if not self._cfg_discovery_path then
    return nil
  end
  return self._cfg_discovery_path[sNodeId .. "_" .. eNodeId]
end

function MissionModule:IsNodeExist(nodeId)
  if self._discoveryData and self._discoveryData.map_nodes[nodeId] then
    return true
  end
  return false
end

function MissionModule:GetCurPos()
  local node = self._discoveryData:GetNodeDataByNodeId(self._curNode)
  if node then
    return node.pos
  end
  return self._discoveryData.walker_origin_pos
end

function MissionModule:GetNodeDataByNodeId(nodeId)
  if self._discoveryData then
    return self._discoveryData:GetNodeDataByNodeId(nodeId)
  end
  return nil
end

function MissionModule:GetChapterIDByMissionID(mission_id)
  local cfg_mission_chapter_config = Cfg.cfg_mission_chapter()
  for i, v in pairs(cfg_mission_chapter_config) do
    if v.MissionID == mission_id then
      return v.ID
    end
  end
  return 0
end

function MissionModule:GetChapterMainIDByMissionID(mission_id)
  local cfg_mission_chapter_config = Cfg.cfg_mission_chapter()
  for i, v in pairs(cfg_mission_chapter_config) do
    if v.MissionID == mission_id then
      return v.MainChapterID
    end
  end
  return 0
end

function MissionModule:GetCurMissionID()
  return self._curMissionID
end

function MissionModule:_GetMissionChapterType(mission_id)
  local cfg_mission_chapter_config = Cfg.cfg_mission_chapter()
  local mission_chapter_type = 0
  for i, v in pairs(cfg_mission_chapter_config) do
    if v.MissionID == mission_id then
      return v.Type
    end
  end
end

function MissionModule:_GetMissionChapterID(mission_id)
  local cfg_mission_chapter_config = Cfg.cfg_mission_chapter()
  local mission_chapter_type = 0
  for i, v in pairs(cfg_mission_chapter_config) do
    if v.MissionID == mission_id then
      return v.MainChapterID, v.BranchChapterID
    end
  end
  return
end

function MissionModule:IsChapterComplete(mission_id)
  local cfg_mission_chapter_config = Cfg.cfg_mission_chapter()
  local mission_main_id, mission_branch_id = self:_GetMissionChapterID(mission_id)
  if mission_main_id and mission_branch_id then
    for i, config in pairs(cfg_mission_chapter_config) do
      if config.MainChapterID == mission_main_id and config.BranchChapterID == mission_branch_id and not self:IsPassMissionID(config.MissionID) then
        return false
      end
    end
    return true
  end
  return false
end

function MissionModule:SingleMatch(stageId, teamId)
  local game = GameGlobal.GetModule(GameMatchModule)
  local info = MissionCreateInfo:New()
  info.mission_id = stageId
  info.formation_id = teamId
  game:StartMatch(MatchType.MT_Mission, teamId, info)
end

function MissionModule:Get3StarConditionDesc(condition_id, colorStr)
  local star_condition = Cfg.cfg_threestarcondition[condition_id]
  if not star_condition then
    return nil
  else
    local paramStrArray = star_condition.ConditionNumber
    local paramCount = #paramStrArray
    local ret = "no condition"
    colorStr = colorStr or "FFFFFF"
    if star_condition.ConditionType == BonusObjectiveType.KillMonstersInLimitedRound then
      ret = StringTable.Get(star_condition.Name, tonumber(paramStrArray[1]), colorStr)
    elseif star_condition.ConditionType == BonusObjectiveType.HitBySkill then
      ret = StringTable.Get(star_condition.Name, tonumber(paramStrArray[1]), colorStr)
    elseif star_condition.ConditionType == BonusObjectiveType.KillMonstersWithBuff then
      ret = StringTable.Get(star_condition.Name, tonumber(paramStrArray[1]), colorStr)
    elseif star_condition.ConditionType == BonusObjectiveType.MonsterEscapeLessThan then
      ret = StringTable.Get(star_condition.Name)
    elseif paramCount == 1 then
      ret = StringTable.Get(star_condition.Name, tonumber(paramStrArray[1]), colorStr)
    elseif paramCount == 2 then
      ret = StringTable.Get(star_condition.Name, tonumber(paramStrArray[2]), colorStr)
    else
      ret = StringTable.Get(star_condition.Name)
    end
    return ret
  end
end

function MissionModule:GetMissionName(mission_id)
  local mission_config = Cfg.cfg_mission[mission_id]
  if mission_config then
    return StringTable.Get(mission_config.Name)
  end
  return nil
end

function MissionModule:GetMissionDesc(mission_id)
  local mission_config = Cfg.cfg_mission[mission_id]
  if mission_config then
    return StringTable.Get(mission_config.Desc)
  end
  return nil
end

function MissionModule:HandlePushAlreadyReturnPowerMissionInfoChange(msg)
  self:SetAlreadyReturnMissionList(msg.m_already_return_power_mission_list)
end

function MissionModule:HandlePushAlreadyReturnPowerCamMissionInfoChange(msg)
  self:SetAlreadyReturnCamMissionList(msg.m_already_return_power_cam_mission_list)
end

function MissionModule:SetAlreadyReturnMissionList(list)
  self._alreadyReturnPowerMissionList = list
end

function MissionModule:IsAlreadyReturnPower(mission_id)
  for k, v in pairs(self._alreadyReturnPowerMissionList) do
    if mission_id == v then
      return true
    end
  end
  return false
end

function MissionModule:SetAlreadyReturnCamMissionList(list)
  self._alreadyReturnPowerCamMissionList = list
end

function MissionModule:IsAlreadyReturnPowerCamMission(cam_mission_id)
  for k, v in pairs(self._alreadyReturnPowerCamMissionList) do
    if cam_mission_id == v then
      return true
    end
  end
  return false
end

function MissionModule:GetNextBigMissionID(mission_id)
  local cfg_mission_chapter = Cfg.cfg_mission_chapter()
  if mission_id == 0 then
    for k, v in HelperProxy:GetInstance():pairsByKeys(cfg_mission_chapter) do
      if self:IsBigMission(v.MissionID) and v.ChapterType == WayPointType.WayPointType_Main then
        return v.MissionID, v.WayPointID
      end
    end
  end
  if self:_GetMissionChapterType(mission_id) == WayPointType.WayPointType_Branch then
    return nil, nil
  end
  local chapter_id = 0
  local next_mission_id, next_waypoint_id
  for k, v in HelperProxy:GetInstance():pairsByKeys(cfg_mission_chapter) do
    if chapter_id == 0 then
      if v.MissionID == mission_id then
        chapter_id = v.ID
      end
    elseif chapter_id < v.ID and self:IsBigMission(v.MissionID) and v.ChapterType == WayPointType.WayPointType_Main then
      next_mission_id = v.MissionID
      next_waypoint_id = v.WayPointID
      break
    end
  end
  return next_mission_id, next_waypoint_id
end

function MissionModule:IsFightMission(missionID)
  local config = Cfg.cfg_mission[missionID]
  if config then
    if config.Type == MissionType.MissionType_Story then
      return false
    else
      return true
    end
  end
end

function MissionModule:Has3StarCondition(mission_id)
  return self:IsFightMission(mission_id)
end

function MissionModule:SetFormationInfos(infos)
  self._teamCtx:InitByServerData(infos)
end

function MissionModule:TeamCtx()
  return self._teamCtx
end

function MissionModule:_IsConditionPass(vecCondition, nConditionID)
  for _, conditionPass in pairs(vecCondition) do
    if conditionPass == nConditionID then
      return true
    end
  end
  return false
end

function MissionModule:_ConvertCondition(vecPassCondition, nConditionID, nParam)
  local uiExtCondition = UI_DetailExtCondition:New()
  uiExtCondition.m_nID = nConditionID
  uiExtCondition.m_nParam = nParam
  uiExtCondition.m_stDest = self:Get3StarConditionDesc(nConditionID)
  uiExtCondition.m_bPass = self:_IsConditionPass(vecPassCondition, nConditionID)
  return uiExtCondition
end

function MissionModule:Module_ConvertMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_Mission
  uiMatchResult.m_nID = recvResult.mission_id
  local cfgMission = Cfg.cfg_mission[uiMatchResult.m_nID]
  local strStageIndex = DiscoveryStage.GetStageIndexString(uiMatchResult.m_nID)
  local strStageName = StringTable.Get(cfgMission.Name)
  uiMatchResult.m_stShowName = strStageIndex .. " " .. strStageName
  uiMatchResult.m_stShowDesc = StringTable.Get(cfgMission.Desc)
  uiMatchResult.m_vecCondition = {}
  if self:Has3StarCondition(uiMatchResult.m_nID) then
    uiMatchResult.m_vecCondition[1] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition1, 0)
    uiMatchResult.m_vecCondition[2] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition2, 0)
    uiMatchResult.m_vecCondition[3] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition3, 0)
  end
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  uiMatchResult.m_vecAwardPerfect = recvResult.star_rewards
  uiMatchResult.m_vecFirstPassAward = recvResult.first_rewards
  uiMatchResult.m_matchResRolInfo = recvResult.match_result_role_info
  return uiMatchResult
end

function MissionModule:GetMissionGetWayDetails(mission_id)
  local isShow = false
  local isUnLock = false
  local chapterConfig = Cfg.cfg_mission_chapter({MissionID = mission_id})
  if self:GetCurMissionID() == 0 then
    if chapterConfig[1].MainChapterID == 1 then
      return true, false
    else
      return false, false
    end
  end
  local currentChapterConfig = Cfg.cfg_mission_chapter({
    MissionID = self:GetCurMissionID()
  })
  if currentChapterConfig and chapterConfig and chapterConfig[1].MainChapterID <= currentChapterConfig[1].MainChapterID then
    isShow = true
  end
  if self:IsPassMissionID(mission_id) or self:IsMissionCanActive(mission_id) then
    isUnLock = true
  end
  return isShow, isUnLock
end

function MissionModule:SetStoryActiveData(mission_story_data)
  self._activeStoryInfo = mission_story_data
end

function MissionModule:SetMissionStoryActive(TT, mission_id, activeStoryType)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileSaveActiveStoryInfo)
  request.m_mission_id = mission_id or 0
  request.m_story_type = activeStoryType or ActiveStoryType.ActiveStoryType_None
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  return res
end

function MissionModule:IsMissionStoryActive(mission_id, activeStoryType)
  if GameSingle then
    return true
  end
  if self._activeStoryInfo then
    for k, v in pairs(self._activeStoryInfo) do
      if k == mission_id then
        local t = v.active_story_type & activeStoryType
        return t ~= 0
      end
    end
  end
  return false
end

function MissionModule:HandleActiveStoryDataChange(msg)
  self:SetStoryActiveData(msg.active_story_data.active_story_map)
end

function MissionModule:GetErrorMsg(errCode)
  local vecErrorMsg = {}
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_FAILED] = StringTable.Get("str_mission_error_failed")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_INVALID_LEVEL] = StringTable.Get("str_mission_error_invalid_level")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_INVALID_POWER] = StringTable.Get("str_mission_error_invalid_power")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_NOT_EXIST] = StringTable.Get("str_mission_error_not_exist")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_IS_LOCK] = StringTable.Get("str_mission_error_is_lock")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_STORY_ALREADY_ACTIVE] = StringTable.Get("str_mission_error_story_already_active")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_INVALID_ID] = StringTable.Get("str_mission_error_invalid_id")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_STORY_INVALID_TYPE] = StringTable.Get("str_mission_error_story_invalid_type")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_INVALID_CHAPTER_AWARD] = StringTable.Get("str_mission_error_invalid_chapter_award")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_INVALID_CHAPTER_AWARD_INVALID_STAR] = StringTable.Get("str_mission_error_invalid_chapter_award_star")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_INVALID_CHAPTER_AWARD_RECEIVE] = StringTable.Get("str_mission_error_invalid_chapter_award_receive")
  vecErrorMsg[MISSION_RESULT_CODE.MISSION_INVALID_CHAPTER_AWARD_CONFIG] = StringTable.Get("str_mission_error_invalid_chapter_award_config")
  vecErrorMsg[FORMATION_RESUTL_CODE.FORMATION_DIRTY_NAME] = StringTable.Get("str_mission_error_dirty_name")
  vecErrorMsg[FORMATION_RESUTL_CODE.FORMATION_INVALID_NAME] = StringTable.Get("str_maze_FORMATION_INVALID_NAME")
  local EIGHT_PETS_INVALID_NAME = 107600
  vecErrorMsg[EIGHT_PETS_INVALID_NAME] = StringTable.Get("str_maze_FORMATION_INVALID_NAME")
  local stErrorMsg = vecErrorMsg[errCode]
  if nil == stErrorMsg then
    return StringTable.Get("str_match_error_server_error")
  end
  return stErrorMsg
end

function MissionModule:GetChapterName(chapterID)
  local config = Cfg.cfg_mission_chapter_award()
  for k, v in pairs(config) do
    if v.ChapterID == chapterID then
      return v.ChapterIdx, v.ChapterName
    end
  end
  return nil, nil
end

function MissionModule:ParseStarInfo(star)
  local starCount = 0
  local completeStarList = {}
  if star & 1 ~= 0 then
    starCount = starCount + 1
    table.insert(completeStarList, 1)
  end
  if star & 2 ~= 0 then
    starCount = starCount + 1
    table.insert(completeStarList, 2)
  end
  if star & 4 ~= 0 then
    starCount = starCount + 1
    table.insert(completeStarList, 3)
  end
  return starCount, completeStarList
end

function MissionModule:GetStarCount(star)
  local starCount = 0
  if star & 1 ~= 0 then
    starCount = starCount + 1
  end
  if star & 2 ~= 0 then
    starCount = starCount + 1
  end
  if star & 4 ~= 0 then
    starCount = starCount + 1
  end
  return starCount
end

function MissionModule:CompleteStoryMission(TT, missionID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileCompleteStoryMission)
  request.m_mission_id = missionID or 0
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return MISSION_RESULT_CODE.MISSION_FAILED, _
  end
  local replyEvent = reply.msg
  return replyEvent.m_result, replyEvent.reward
end

function MissionModule:ReceiveChapterAward(TT, chapterID, starCount)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileReceiveChapterAward)
  request.m_chapter_id = chapterID or 0
  request.star_count = starCount or 0
  local reply = self:Call(TT, request)
  local replyEvent = reply.msg
  if reply.res ~= CallResultType.Normal then
    return MISSION_RESULT_CODE.MISSION_FAILED, _
  end
  if replyEvent.m_result == MISSION_RESULT_CODE.MISSION_SUCCEED then
    self:SetChapterInfo(replyEvent.already_receive_chapter_award)
  end
  return replyEvent.m_result, replyEvent.reward
end

function MissionModule:GetNextByMissionID(mission_id)
  local cfg_mission_chapter = Cfg.cfg_mission_chapter()
  if mission_id == 0 then
    for k, v in HelperProxy:GetInstance():pairsByKeys(cfg_mission_chapter) do
      if v.ChapterType == WayPointType.WayPointType_Main then
        return v.MissionID, v.WayPointID
      end
    end
  end
  if self:_GetMissionChapterType(mission_id) == WayPointType.WayPointType_Branch then
    return nil, nil
  end
  local chapter_id = 0
  local next_mission_id, next_waypoint_id
  for k, v in HelperProxy:GetInstance():pairsByKeys(cfg_mission_chapter) do
    if chapter_id == 0 then
      if v.MissionID == mission_id then
        chapter_id = v.ID
      end
    elseif chapter_id < v.ID and v.ChapterType == WayPointType.WayPointType_Main then
      next_mission_id = v.MissionID
      next_waypoint_id = v.WayPointID
      break
    end
  end
  return next_mission_id, next_waypoint_id
end

function MissionModule:GetMissionType(mission_id)
  local config = Cfg.cfg_mission[mission_id]
  if config then
    return config.Type
  else
    return nil
  end
end

function MissionModule:SetChapterInfo(data)
  self._chapter_info = {}
  for _, v in pairs(self._passMissionList) do
    local chapter_id = self:GetChapterMainIDByMissionID(v.id)
    local bFind = false
    for _, k in pairs(data.receive_star_award_map) do
      if k.chapter_id == chapter_id then
        bFind = true
        if k.star_count then
          k.star_count = k.star_count + self:GetStarCount(v.star)
        else
          k.star_count = self:GetStarCount(v.star)
        end
      end
    end
    if not bFind then
      local tmp = mission_chapter_award_info:New()
      tmp.chapter_id = chapter_id
      tmp.star_count = self:GetStarCount(v.star)
      tmp.receive_star_award_list = {}
      table.insert(data.receive_star_award_map, tmp)
    end
  end
  self._chapter_info = data.receive_star_award_map
end

function MissionModule:_ClearChapterStarCount()
  for _, k in pairs(self._chapter_info) do
    k.star_count = 0
  end
end

function MissionModule:UpdateChapterData()
  self:_ClearChapterStarCount()
  for _, v in pairs(self._passMissionList) do
    local chapter_id = self:GetChapterMainIDByMissionID(v.id)
    local bFind = false
    for _, k in pairs(self._chapter_info) do
      if k.chapter_id == chapter_id then
        bFind = true
        if k.star_count then
          k.star_count = k.star_count + self:GetStarCount(v.star)
        else
          k.star_count = self:GetStarCount(v.star)
        end
      end
    end
    if not bFind then
      local tmp = mission_chapter_award_info:New()
      tmp.chapter_id = chapter_id
      tmp.star_count = self:GetStarCount(v.star)
      tmp.receive_star_award_list = {}
      table.insert(self._chapter_info, tmp)
    end
  end
end

function MissionModule:GetChapterInfo()
  return self._chapter_info
end

function MissionModule:GetShowChapterPreview()
  return self._showChapterPreview
end

function MissionModule:SetShowChapterPreview(show)
  self._showChapterPreview = show
end

function MissionModule:IsFirstPassMission(id)
  return not self:IsPassMissionID(id)
end

function MissionModule:IsMissionFirstPassCanIgnorPower(id)
  if id == EFirstPassCanIgnorPowerMission.EFirstPassCanIgnorPowerMission_1_1 or id == EFirstPassCanIgnorPowerMission.EFirstPassCanIgnorPowerMission_1_2 or id == EFirstPassCanIgnorPowerMission.EFirstPassCanIgnorPowerMission_1_3 then
    return true
  end
  return false
end

function MissionModule:GetStoryByStageIdStoryType(missionID, storyTriggerType)
  local cfg = Cfg.cfg_mission_story[missionID]
  if not cfg then
    return nil
  end
  local index
  for i = 1, #cfg.StoryActiveType do
    if cfg.StoryActiveType[i] == storyTriggerType then
      index = i
    end
  end
  if not index then
    return nil
  end
  return cfg.StoryID[index]
end
