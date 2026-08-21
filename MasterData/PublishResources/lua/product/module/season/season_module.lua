_class("SeasonModule", GameModule)
SeasonModule = SeasonModule

function SeasonModule:Constructor()
  self._seasonCampaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON
  self._levelExpress = nil
  self.uiModule = self.uiModule
  self._debris_mission = nil
  self._castle_lv = nil
  self._onceMissionData = SeasonOnceMissionData:New()
end

function SeasonModule:Init()
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self._seasonObj = nil
  self._ext_info = nil
  self._debris_mission = nil
  self._castle_lv = nil
  self._waitShowCollectionRewards = {}
end

function SeasonModule:Update(deltaTime)
  if self.uiModule then
    self.uiModule:Update(deltaTime)
  end
end

function SeasonModule:Dispose()
  if self.uiModule then
    self.uiModule:Dispose()
  end
  self:ClearLevelExpress()
end

function SeasonModule:UIModule()
  return self.uiModule
end

function SeasonModule:RecordLevelExpress(eventPointID, groupID, expressType)
  Log.debug("SeasonModule:RecordLevelExpress ", eventPointID, groupID, expressType)
  self:ClearLevelExpress()
  self._levelExpress = {}
  self._levelExpress.eventPointID = eventPointID
  self._levelExpress.groupID = groupID
  self._levelExpress.expressType = expressType
end

function SeasonModule:GetLevelExpress()
  return self._levelExpress
end

function SeasonModule:ClearLevelExpress()
  self._levelExpress = nil
end

function SeasonModule:SetExtData(info)
  self._ext_info = info
end

function SeasonModule:CheckExtMask(state)
  local mask = self._ext_info.mask
  mask = mask & state
  return mask == 1
end

function SeasonModule:AppendExtMaskData(state)
  local mask = self._ext_info.mask
  mask = mask | state
  return mask
end

function SeasonModule:GetCurSeasonSample()
  local curSample
  if not self._campModule:IsDisposed() then
    curSample = self._campModule:GetOpenSampleByType(self._seasonCampaignType)
  end
  if not curSample then
    Log.info("无法获取当前赛季sample数据")
    return nil
  end
  return curSample
end

function SeasonModule:ForceRequestCurSeasonData(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local sample = self:GetCurSeasonSample()
  if not sample then
    Log.error("没有简易数据,无法请求赛季玩法详细数据")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
    return res
  end
  local id = sample.id
  Log.info("请求赛季详细数据:", id)
  self._campModule:CampaignComProtoLoadInfo(TT, res, id)
  if res:GetSucc() then
    local obj = self._campModule:GetCampaignObj(id)
    if not obj then
      Log.exception("强制拉取赛季数据成功 但无法获取详细数据:", id)
    end
    local localProcess = self:GetLocalProcess(self._seasonCampaignType, id)
    localProcess:InitComponent(obj)
    self._seasonObj = UISeasonObj:New(sample, obj)
  else
    Log.error("获取赛季详细数据失败:", res:GetResult())
  end
  self._onceMissionData:RefreshData()
  return res
end

function SeasonModule:GetOnceMissionData()
  return self._onceMissionData
end

function SeasonModule:GetLocalProcess(type, id)
  type = type or self._seasonCampaignType
  id = id or self:GetCurSeasonID()
  if not self._campModule:IsDisposed() then
    return self._campModule:GetCampaignLocalProcessByCampaignId_Local(type, id)
  end
end

function SeasonModule:GetCurSeasonObj()
  return self._seasonObj
end

function SeasonModule:IsOpen()
  if self._seasonObj then
    local seasonMissionComponent = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
    return seasonMissionComponent:ComponentIsOpen()
  end
  return false
end

function SeasonModule:GetCurSeasonID()
  local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  local sample = self:GetCurSeasonSample()
  return sample and sample:IsShow(svrTime) and sample.id or -1
end

function SeasonModule:CheckSeasonClose(res)
  if res and not res:GetSucc() then
    local result = res:GetResult()
    if result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED or result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE then
      self:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
      local seasonId = self:GetCurSeasonID()
      if 0 < seasonId then
        self.uiModule:ExitSeasonToSeasonMain(seasonId)
      else
        self.uiModule:ExitSeasonTo(UIStateType.UIMain)
      end
      return true
    end
  end
  return false
end

function SeasonModule:CheckSeasonClose_ShowClientError(seasonId)
  local id = self:GetCurSeasonID()
  if id == -1 then
    local result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    self:CheckErrorCode(result, seasonId)
    return true
  end
  return false
end

function SeasonModule:CheckErrorCode(result, id, refreshCallback, closeCallback)
  if not self._campModule:IsDisposed() then
    self._campModule:CheckErrorCode(result, id, refreshCallback, closeCallback)
  end
end

function SeasonModule:ReqSeasonChangeFormationInfo(TT, id, name, pets)
  local seasonMissionComponent = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  local reqRes = AsyncRequestRes:New()
  local formation = SeasonFormationItem:New()
  formation.id = id
  formation.name = name
  formation.pet_list = pets
  local response = seasonMissionComponent:HandleSeasonChangeFormation(TT, reqRes, formation)
  self:CheckSeasonClose(reqRes)
  return reqRes, response
end

function SeasonModule:GetSeasonMissionComponent()
  if self._seasonObj then
    local seasonMissionComponent = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
    return seasonMissionComponent
  end
end

function SeasonModule:HandleCompleteStoryMission(TT, missionId)
  local seasonMissionComponent = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  local reqRes = AsyncRequestRes:New()
  local ret = seasonMissionComponent:HandleCompleteStoryMission(TT, reqRes, missionId)
  self:CheckSeasonClose(reqRes)
  return reqRes, ret
end

function SeasonModule:HandleSeasonClientDataPoint(TT, x, y, z)
  local seasonMissionComponent = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  local reqRes = AsyncRequestRes:New()
  local ret = seasonMissionComponent:HandleSeasonClientDataPoint(TT, reqRes, x, y, z)
  self:CheckSeasonClose(reqRes)
  return reqRes, ret
end

function SeasonModule:HandleSeasonClientDataExt(TT, tables)
  local seasonMissionComponent = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  local reqRes = AsyncRequestRes:New()
  local ret = seasonMissionComponent:HandleSeasonClientDataExt(TT, reqRes, tables)
  self:CheckSeasonClose(reqRes)
  return reqRes, ret
end

function SeasonModule:HandleSeasonClientStageData(TT, id, type)
  local seasonMissionComponent = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  local reqRes = AsyncRequestRes:New()
  local ret = seasonMissionComponent:HandleSeasonClientStageData(TT, reqRes, id, type)
  self:CheckSeasonClose(reqRes)
  return reqRes, ret
end

function SeasonModule:HandleSeasonPointClientData(TT, point_info)
  local seasonMissionComponent = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  local reqRes = AsyncRequestRes:New()
  local ret = seasonMissionComponent:HandleSeasonPointClientData(TT, reqRes, point_info)
  self:CheckSeasonClose(reqRes)
  return reqRes, ret
end

function SeasonModule:HandleMissionTeamRecord(TT, asyncRes, num, mission)
  local seasonMissionComponent = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  local reqRes = AsyncRequestRes:New()
  local ret = seasonMissionComponent:HandleMissionTeamRecord(TT, asyncRes, num, mission)
  self:CheckSeasonClose(reqRes)
  return reqRes, ret
end

function SeasonModule:ExitBattle(missionCreateInfo, isWin, battleresultRt, dialogName)
  local seasonID = self.uiModule:GetSeasonID()
  local cfg = Cfg.cfg_season_map[seasonID]
  local mapRes = cfg and cfg.MapRes
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Season_Enter, mapRes, missionCreateInfo, isWin, dialogName)
end

function SeasonModule:Has3StarCondition(mission_id)
  return self:IsFightMission(mission_id)
end

function SeasonModule:IsFightMission(missionID)
  local config = Cfg.cfg_season_mission[missionID]
  if config then
    return config.IsFightLevel
  end
  return false
end

function SeasonModule:Get3StarConditionDesc(condition_id, colorStr)
  local star_condition = Cfg.cfg_threestarcondition[condition_id]
  if not star_condition then
    return nil
  else
    local paramStrArray = star_condition.ConditionNumber
    local paramCount = #paramStrArray
    local ret = "no condition"
    colorStr = colorStr or "FFFFFF"
    if paramCount == 1 then
      ret = StringTable.Get(star_condition.Name, tonumber(paramStrArray[1]), colorStr)
    elseif paramCount == 2 then
      ret = StringTable.Get(star_condition.Name, tonumber(paramStrArray[2]), colorStr)
    else
      ret = StringTable.Get(star_condition.Name)
    end
    return ret
  end
end

function SeasonModule:GetRecordBuffLevel()
  if not self._oldBuffLevelInfo then
    return -1, 0
  end
  return self._oldBuffLevelInfo.level, self._oldBuffLevelInfo.progress
end

function SeasonModule:RecordBuffLevel(buffLevel, progress)
  if not self._oldBuffLevelInfo then
    self._oldBuffLevelInfo = {}
  end
  self._oldBuffLevelInfo.level = buffLevel
  self._oldBuffLevelInfo.progress = progress
end

function SeasonModule:ProcressPetEnhance(oriPet, seasonMissionId)
  local hasEnhance = false
  local enhanceGrade, enhanceEquip, enhanceLv
  local missionCfg = Cfg.cfg_season_mission[seasonMissionId]
  if missionCfg then
    if missionCfg.PetGrade and missionCfg.PetLv then
      local oriValue = oriPet:GetPetGrade()
      local maxValue = oriPet:GetMaxGrade()
      local toGrade = missionCfg.PetGrade
      local toLv = missionCfg.PetLv
      if maxValue < missionCfg.PetGrade then
        toGrade = maxValue
        toLv = self:_CalcPetMaxLevel(oriPet:GetTemplateID(), toGrade)
      end
      if oriValue < toGrade then
        hasEnhance = true
        enhanceGrade = toGrade
        local maxLvValue = self:_CalcPetMaxLevel(oriPet:GetTemplateID(), toGrade)
        if toLv > maxLvValue then
          toLv = maxLvValue
        end
        enhanceLv = toLv
      elseif toGrade == oriValue then
        local oriLvValue = oriPet:GetPetLevel()
        local maxLvValue = self:_CalcPetMaxLevel(oriPet:GetTemplateID(), toGrade)
        if toLv > maxLvValue then
          toLv = maxLvValue
        end
        if oriLvValue < toLv then
          hasEnhance = true
          enhanceLv = toLv
        end
      end
    end
    if missionCfg.PetEquip then
      local oriValue = oriPet:GetEquipLv()
      local maxValue = 0
      local petId = oriPet:GetTemplateID()
      local cfg_equip = Cfg.cfg_pet_equip({PetID = petId})
      if cfg_equip and 0 < #cfg_equip then
        maxValue = cfg_equip[#cfg_equip].Level
      end
      if 0 < maxValue then
        local toEquipLv = missionCfg.PetEquip
        if maxValue < missionCfg.PetEquip then
          toEquipLv = maxValue
        end
        if oriValue < toEquipLv then
          hasEnhance = true
          enhanceEquip = toEquipLv
        end
      end
    end
  end
  if hasEnhance then
    local codeCheckPetData = _G.pet_data
    local tempData = codeCheckPetData:New()
    tempData.template_id = oriPet:GetTemplateID()
    local tmpPet = Pet:New(tempData)
    tempData.pet_pstid = oriPet:GetPstID()
    tempData.grade = enhanceGrade and enhanceGrade or oriPet:GetPetGrade()
    tempData.level = enhanceLv and enhanceLv or oriPet:GetPetLevel()
    tempData.awakening = oriPet:GetPetAwakening()
    tempData.awake_lock = oriPet:GetAwakeLock()
    tempData.equip_lv = enhanceEquip and enhanceEquip or oriPet:GetEquipLv()
    tempData.affinity_level = oriPet:GetPetAffinityLevel()
    tempData.b_pet_like = oriPet:IsLike()
    tempData.equip_refine_lv = oriPet:GetEquipRefineLv()
    tmpPet:SetData(tempData)
    tmpPet:CalAttr()
    tmpPet:SetFastTeamMemID(oriPet:FastTeamMemID())
    return tmpPet, hasEnhance
  else
    local codeCheckPetData = _G.pet_data
    local tempData = codeCheckPetData:New()
    tempData.template_id = oriPet:GetTemplateID()
    local tmpPet = Pet:New(tempData)
    tempData.pet_pstid = oriPet:GetPstID()
    tempData.grade = oriPet:GetPetGrade()
    tempData.level = oriPet:GetPetLevel()
    tempData.awakening = oriPet:GetPetAwakening()
    tempData.awake_lock = oriPet:GetAwakeLock()
    tempData.equip_lv = oriPet:GetEquipLv()
    tempData.affinity_level = oriPet:GetPetAffinityLevel()
    tempData.b_pet_like = oriPet:IsLike()
    tempData.equip_refine_lv = oriPet:GetEquipRefineLv()
    tmpPet:SetData(tempData)
    tmpPet:CalAttr()
    tmpPet:SetFastTeamMemID(oriPet:FastTeamMemID())
    return tmpPet, hasEnhance
  end
end

function SeasonModule:_CalcPetMaxLevel(templateId, grade)
  local cfgs = Cfg["cfg_pet_level_" .. templateId .. "_" .. grade]()
  local max = 1
  for _, c in pairs(cfgs) do
    if max < c.Level then
      max = c.Level
    end
  end
  return max
end

function SeasonModule:AppendWaitShowCollectionRewards(reward)
  if not self._waitShowCollectionRewards then
    self._waitShowCollectionRewards = {}
  end
  table.insert(self._waitShowCollectionRewards, reward)
end

function SeasonModule:EraseFirstWaitShowCollectionRewards()
  table.remove(self._waitShowCollectionRewards, 1)
end

function SeasonModule:ClearWaitShowCollectionRewards()
  self._waitShowCollectionRewards = {}
end

function SeasonModule:GetWaitShowCollectionRewards()
  return self._waitShowCollectionRewards
end

function SeasonModule:GetHasPassedDebris(missionId)
  local info = self._debris_mission[missionId]
  if info == nil then
    return false
  end
  local cfg = Cfg.cfg_season_debris_mission[missionId]
  if cfg == nil then
    return false
  end
  return true
end

function SeasonModule:GetCastleLv(seasonID)
  local info = self._castle_lv[seasonID]
  if info == nil then
    return 1
  end
  return info
end

function SeasonModule:GetCurSeasonQuestComponent()
  local componentId = ECCampaignSeasonComponentID.QUEST
  local proccess = self:GetLocalProcess()
  return proccess and proccess:GetComponent(componentId)
end

function SeasonModule:GetCurSeasonExchangeComponent()
  local componentId = ECCampaignSeasonComponentID.EXCHANGE_SHOP
  local proccess = self:GetLocalProcess()
  return proccess and proccess:GetComponent(componentId)
end

function SeasonModule:GetCurSeasonActionPointComponent()
  local componentId = ECCampaignSeasonComponentID.ACTION_POINT
  local proccess = self:GetLocalProcess()
  return proccess and proccess:GetComponent(componentId)
end

function SeasonModule:CheckMissionCanAutoFight(missionCreateInfo)
  local cfg = Cfg.cfg_global.auto_fight_can_not_use
  local errorStr = ""
  if cfg and cfg.StrValue then
    errorStr = cfg.StrValue
  end
  local missionCfg = Cfg.cfg_season_mission[missionCreateInfo.mission_id]
  if not missionCfg then
    return false, errorStr
  end
  local enableParam = missionCfg.EnableAutoFight
  if enableParam == CampainMissionCanAutoFightType.E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_DISABLE then
    return false, errorStr
  elseif enableParam == CampainMissionCanAutoFightType.E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_ENABLE then
    return true
  end
  if missionCfg.Type == SeasonEventPointType.DailyLevel then
    return true
  end
  local seasonObj = self:GetCurSeasonObj()
  if seasonObj then
    cfg = Cfg.cfg_global.auto_fight_need_3_star
    errorStr = cfg.StrValue
    local cmptInfo = seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
    if cmptInfo and cmptInfo and cmptInfo.m_pass_mission_info then
      local checkMissionCfgs = {}
      local missionGroupId = missionCfg.GroupID
      local missionGroupCfgs = Cfg.cfg_season_mission({GroupID = missionGroupId})
      if 0 < #missionGroupCfgs then
        for index, value in ipairs(missionGroupCfgs) do
          if value.OrderID >= missionCfg.OrderID then
            table.insert(checkMissionCfgs, value)
          end
        end
        for index, harderMissionCfg in ipairs(checkMissionCfgs) do
          local harderPassInfo = cmptInfo.m_pass_mission_info[harderMissionCfg.ID]
          if harderPassInfo then
            local passThreeStar = self:HasPassThreeStar(harderMissionCfg, harderPassInfo)
            if passThreeStar then
              return true
            end
          end
        end
      end
    end
  end
  return false, errorStr
end

function SeasonModule:HasPassThreeStar(missionCfg, passInfo)
  local missionFinishInfo = passInfo
  if missionCfg.ThreeStarCondition1 and missionFinishInfo.star & 1 == 0 then
    return false
  end
  if missionCfg.ThreeStarCondition2 and missionFinishInfo.star & 2 == 0 then
    return false
  end
  if missionCfg.ThreeStarCondition3 and missionFinishInfo.star & 4 == 0 then
    return false
  end
  return true
end

function SeasonModule:ReqCEventSeasonStory(TT, mask)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSeasonStoryReq)
  request.mask = mask
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return ROLE_RESULT_CODE.ROLE_FAILED, _
  end
  self._ext_info.mask = mask
  return reply.msg
end

function SeasonModule:CheckUISatisfy(cfgId, progress, dataInfo)
  local cfg = Cfg.cfg_season_mission[cfgId]
  if cfg == nil then
    return false
  end
  local conStr = cfg["Condition" .. progress]
  return self:CheckCondition(conStr, dataInfo)
end

function SeasonModule:CheckCondition(conditionStr, map)
  if string.isnullorempty(conditionStr) then
    return true
  end
  
  local function cb(cfgInfo)
    local infoIt = map[cfgInfo[1]]
    if infoIt == nil then
      return false
    elseif infoIt ~= cfgInfo[2] then
      return false
    end
    return true
  end
  
  return ResourceHelper:GetInstance():CheckTermSatisfy(conditionStr, CfgTermEntity:New(), cb)
end

function SeasonModule:CheckMissionSatisfy(cfgId, dataInfo)
  local cfg = Cfg.cfg_season_mission[cfgId]
  if cfg == nil then
    return false
  end
  local conStr = cfg.NeedMission
  if conStr == nil or conStr == "" then
    return true
  end
  
  local function cb(cfgInfo)
    local infoIt = dataInfo[cfgInfo[1]]
    if infoIt == nil then
      return false
    end
    return true
  end
  
  local tt = CfgTermEntity:New()
  return ResourceHelper:GetInstance():CheckTermSatisfy(conStr, tt, cb)
end

function SeasonModule:HandleSeasonMiniGameInfoReq(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSeasonMiniGameInfoReq)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  self._debris_mission = reply.msg.debris_mission
  self._castle_lv = reply.msg.castle_lv
  return reply.msg
end

function SeasonModule:HandleSeasonCastleReq(TT, cfgId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSeasonCastleReq)
  request.id = cfgId
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  if reply.msg.ret == SeasonTaskErrorType.E_SEASONTASK_ERROR_TYPE_SUCCESS then
    local cfg = Cfg.cfg_season_castle[cfgId]
    if cfg ~= nil then
      if self._castle_lv[cfg.SeasonID] == nil then
        self._castle_lv[cfg.SeasonID] = 2
      else
        self._castle_lv[cfg.SeasonID] = cfg.Lv + 1
      end
    end
  end
  return res, reply.msg
end

function SeasonModule:HandleSeasonDebrisMissionReq(TT, cfgId, score)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSeasonDebrisMissionReq)
  request.mission_id = cfgId
  request.score = score
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  if reply.msg.ret == SeasonTaskErrorType.E_SEASONTASK_ERROR_TYPE_SUCCESS then
    self._debris_mission[cfgId] = score
  end
  return reply.msg
end

function SeasonModule:GetSeasonBuildContext()
  return self._seasonBuildContext
end

function SeasonModule:SetSeasonBuildContext(context)
  self._seasonBuildContext = context
end

function SeasonModule:CheckSeasonBuildOpen()
  local seasonId = self:GetCurSeasonID()
  if not seasonId or seasonId == -1 then
    return false
  end
  local id = math.ceil(seasonId * 1000)
  local cfg = Cfg.cfg_common_activity_time[id]
  if not cfg then
    return false
  end
  local missionId = cfg.SeasonMissionID
  if missionId and 0 < missionId then
    local missionComponnet = self:GetSeasonMissionComponent()
    if not missionComponnet or not missionComponnet:IsPassCamMissionID(missionId) then
      return false
    end
  end
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  local timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
  if cfg.TimeTransform == 1 then
    timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
  end
  local loginModule = GameGlobal.GameLogic():GetModule(LoginModule)
  local beginTime = loginModule:GetTimeStampByTimeStr(cfg.DateTimeBegin, timeType)
  local endTime = loginModule:GetTimeStampByTimeStr(cfg.DateTimeEnd, timeType)
  if tmNowTime > beginTime and tmNowTime < endTime then
    return true
  end
  return false
end

function SeasonModule:CheckSeasonAndMissionCoseAndJump()
  return self:CheckSeasonAndComponentCloseAndJump(ECCampaignSeasonComponentID.SEASON_MISSION)
end

function SeasonModule:CheckSeasonCloseAndJump()
  return self:CheckSeasonAndComponentCloseAndJump()
end

function SeasonModule:CheckSeasonAndComponentCloseAndJump(cptID)
  if self:IsSeaonActivityClosed() then
    self:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
    self.uiModule:ExitSeasonTo(UIStateType.UIMain)
    return false
  end
  if cptID and self:IsComponentClosed(cptID) then
    local seaonId = self:GetCurSeasonID()
    self:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
    self._uiModule:ExitSeasonToSeasonMain(seaonId)
    return false
  end
  return true
end

function SeasonModule:CheckComCloseAndTips(cptID, tipsKey)
  local key = tipsKey
  key = key or "str_activity_error_109"
  if self:IsSeaonActivityClosed() then
    ToastManager.ShowToast(StringTable.Get(key))
    return false
  end
  if self:IsComponentClosed(cptID) then
    ToastManager.ShowToast(StringTable.Get(key))
    return false
  end
  return true
end

function SeasonModule:IsSeaonActivityClosed()
  return self:GetCurSeasonID() < 0
end

function SeasonModule:IsComponentClosed(cptID)
  local seasonObj = self:GetCurSeasonObj()
  if not seasonObj then
    return true
  end
  local comInfo = seasonObj:GetComponentInfo(cptID)
  if not comInfo then
    return true
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local closeTime = comInfo.m_close_time
  if curTime > closeTime then
    return true
  end
  return false
end
