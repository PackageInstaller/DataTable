_class("GuideModule", GameModule)

function SetGuideServerClose(isGuide)
  if NOGUIDE == true then
    return
  end
  NOGUIDE = not isGuide
  GuideHelper.GuideLoadLock(false)
  GameGlobal.UIStateManager():UnLock("GuideDoneLock")
  local world = GameGlobal:GetInstance():GetMainWorld()
  if world ~= nil then
    world:GetService("Guide"):SetNeedYield(false)
  end
end

function GuideModule:Constructor()
  self.guides = {}
  self.triggerGuides = {}
  self.triggers = {}
  self._GuideCheck = GuideCheck:New(self)
  for _, name in pairs(GuideTriggerClassName) do
    local trigger = _createInstance(name, self)
    if not trigger then
      Log.error("_createInstance trigger error " .. name)
    end
    table.insert(self.triggers, trigger)
    trigger:AddListener()
  end
  self:PreHandleCfg()
  self.maxLockTime = 300
  self.curMissionId = 0
  self:MissionInfoChange()
  self.check = 0
  self:AttachEvent(GameEventType.OnCreateMe, self.SetGuideDatas)
  self:AttachEvent(GameEventType.UIClose, self.UIClose)
  self:AttachEvent(GameEventType.MissionInfoChange, self.MissionInfoChange)
  self:AttachEvent(GameEventType.QuestUpdate, self.OnQuestUpdate)
end

function GuideModule:Init()
  self.activatedGuides = {}
  self.activatedGuideTrigger = {}
  self.guide_id2count = {}
  self.inited = false
  self.lastCompleteGuide = 0
  self.reportCompleteGuide = {}
end

function GuideModule:Dispose()
  GuideModule.super.Dispose(self)
  for index, value in ipairs(self.triggers) do
    value:RemoveListener()
  end
  for k, v in pairs(self.guides) do
    v:Clear(true)
  end
  GameGlobal.GuideMessageBoxMng():ClosePopup()
end

function GuideModule:SetLastCompleteGuide(guideid)
  Log.debug("[guide] Complete ", guideid)
  self.lastCompleteGuide = guideid
end

function GuideModule:GetLastCompleteGuide()
  return self.lastCompleteGuide
end

function GuideModule:ReportCompleteGuide(guideid)
  Log.debug("[guide] Report ", guideid)
  self.reportCompleteGuide[guideid] = 1
  if self.lastCompleteGuide == guideid then
    self.lastCompleteGuide = 0
  end
end

function GuideModule:IsReportCompleteGuide(guideid)
  if self.reportCompleteGuide[guideid] == 1 then
    return true
  else
    return false
  end
end

function GuideModule:GuideInProgress()
  return self.activatedGuides and table.count(self.activatedGuides) > 0
end

function GuideModule:IsGuideProcess(guideId)
  if self.activatedGuides then
    if self.activatedGuides[guideId] then
      return self.activatedGuides[guideId] > 0
    else
      return false
    end
  else
    return false
  end
end

function GuideModule:IsGuideProcessKey(key)
  local cfg = Cfg.cfg_guide_const[key]
  return cfg and self:IsGuideProcess(cfg.IntValue)
end

function GuideModule:IsGuideDone(guideId)
  if GameSingle then
    return true
  end
  if self.guide_id2count[guideId] then
    return self.guide_id2count[guideId] > 0
  else
    return false
  end
end

function GuideModule:GuideError(id)
  Log.error(string.format("Guide error! Trigger guide %d not exists in Cfg_guide, please check!", id))
end

function GuideModule:PreHandleCfg()
  local cfg = Cfg.cfg_guide_trigger()
  if not cfg then
    return
  end
  for k, v in pairs(cfg) do
    for _, trigger in pairs(self.triggers) do
      trigger:PreHandleCfg(v)
    end
    if not self.guides[v.guide] then
      local guide = Guide:New(self, v)
      self.guides[v.guide] = guide
    end
    self.triggerGuides[v.id] = self.guides[v.guide]
  end
end

function GuideModule:SetGuideDatas()
  local module = GameGlobal.GetModule(RoleModule)
  local dones = module.m_char_info.guide_info.guide_id2count
  if GuideDebug.TestGudie then
    for k, testId in pairs(GuideDebug.TestGudie) do
      dones[testId] = nil
    end
  end
  for id, count in pairs(dones) do
    local guide = self.guides[id]
    if not guide then
      Log.error(string.format("Guide error! guide %d not exists in Cfg_guide, please check server data! no guidetrigger", id))
    else
      guide:SetCount(count - 1)
    end
  end
  for id, count in pairs(dones) do
    self:DoneGuide(id, false)
  end
  self.guide_id2count = dones
  if not self.inited then
    self:InitGuides()
    self.inited = true
  end
end

function GuideModule:IsGuideMissionDone(missionId)
  return missionId <= self.curMissionId
end

function GuideModule:ChecMissionPassed(missionId)
  local missionModule = GameGlobal.GetModule(MissionModule)
  return missionModule:IsPassMissionID(missionId)
end

function GuideModule:ChecChapterPassed(chapterID)
  local missionModule = GameGlobal.GetModule(MissionModule)
  local missionData = missionModule:GetDiscoveryData()
  local chapter = missionData:GetChapterByChapterId(chapterID)
  return chapter:IsThreeComplete()
end

function GuideModule:InitGuides()
end

function GuideModule:RequestDoneGuide(TT, id, force)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventMobileRoleSetGuideInfo)
  local guide = GuideInfo:New()
  if self.guide_id2count[id] then
    self.guide_id2count[id] = self.guide_id2count[id] + 1
  else
    self.guide_id2count[id] = 1
  end
  guide.guide_id2count = self.guide_id2count
  request.guide_info = guide
  request.cur_guide_id = id
  request.force = force
  YIELD(TT)
  if self:IsReportCompleteGuide(id) == false then
    local reply = self:Call(TT, request)
    if reply:Succ() then
      self:ReportCompleteGuide(id)
      Log.debug("CEventMobileRoleSetGuideInfo Succ.", id)
      self:InitGuides()
    end
  end
end

function GuideModule:DoneGuide(id, notice, remain)
  Log.info("[Guide] DoneGuide id:" .. id .. " notice:" .. tostring(notice) .. " remain:" .. tostring(remain))
  local guide = self.guides[id]
  if not guide then
    return
  end
  if not remain then
    self.activatedGuides[id] = nil
  end
  if not guide:Done(remain) then
    return
  end
  if notice then
    GameGlobal.TaskManager():StartTask(self.RequestDoneGuide, self, id, 0)
  end
end

function GuideModule:ActivateGuide(id, callBack)
  GameGlobal.UIStateManager():Lock("ActivateGuide")
  GameGlobal.TaskManager():StartTask(self._ActivateGuideTaskWrapper, self, id, callBack)
end

function GuideModule:_ActivateGuideTaskWrapper(TT, id, callBack)
  self:_ActivateGuideTask(TT, id, callBack)
  GameGlobal.UIStateManager():UnLock("ActivateGuide")
end

function GuideModule:_ActivateGuideTask(TT, id, callBack)
  Log.notice("[guide ActivateGuide1] triggerid ", id)
  local guide = self.triggerGuides[id]
  if not guide then
    self:GuideError(id)
    return
  end
  if self:_CheckDateNotStart(id) then
    Log.error(string.format("Guide error! %d date not start!", id))
    return
  end
  if self:_CheckOutOfDate(id) then
    Log.error(string.format("Guide error! %d out of date!", id))
    return
  end
  if self:_CheckTaskNoFinish(id) then
    Log.error(string.format("Guide error! %d task not finish!", id))
    return
  end
  if self:_CheckTaskFinish(id) then
    Log.error(string.format("Guide error! %d task finish!", id))
    return
  end
  local cfgGuideTrigger = Cfg.cfg_guide_trigger[id]
  local missionId = cfgGuideTrigger.missionId
  if missionId then
    local done = self:IsGuideMissionDone(missionId)
    if done then
      Log.notice("[guide ActivateGuide1] mission done mission id ", missionId)
      if callBack then
        callBack(false)
      end
      return
    end
  end
  local passMissionId = cfgGuideTrigger.passMissionId
  if passMissionId then
    local passed = self:ChecMissionPassed(passMissionId)
    if not passed then
      Log.notice("[guide ActivateGuide1] mission not pass mission id ", passMissionId)
      if callBack then
        callBack(false)
      end
      return
    end
  end
  local campaignPassInfo = cfgGuideTrigger.campaignPassInfo
  if campaignPassInfo then
    local passed = false
    local campaignType = campaignPassInfo[1]
    local componentIndex = campaignPassInfo[2]
    local missionID = campaignPassInfo[3]
    local campModule = GameGlobal.GetModule(CampaignModule)
    if campModule then
      local localProcess = campModule:GetCampaignLocalProcess(campaignType)
      if localProcess then
        local component = localProcess:GetComponent(componentIndex)
        if component then
          passed = component:IsPassCamMissionID(missionID)
        end
      end
    end
    if not passed then
      Log.notice("[guide ActivateGuide1] campaign mission not pass mission id ", campaignType, componentIndex, missionID)
      if callBack then
        callBack(false)
      end
      return
    end
  end
  local campaignPassInfo = cfgGuideTrigger.campaignPassedInfo
  if campaignPassInfo then
    local passed = false
    local campaignType = campaignPassInfo[1]
    local componentIndex = campaignPassInfo[2]
    local missionID = campaignPassInfo[3]
    local campModule = GameGlobal.GetModule(CampaignModule)
    if campModule then
      local localProcess = campModule:GetCampaignLocalProcess(campaignType)
      if localProcess then
        local component = localProcess:GetComponent(componentIndex)
        if component then
          passed = component:IsPassCamMissionID(missionID)
        end
      end
    end
    if passed then
      Log.notice("[guide ActivateGuide1] campaign mission not pass mission id ", campaignType, componentIndex, missionID)
      if callBack then
        callBack(false)
      end
      return
    end
  end
  local chapterID = cfgGuideTrigger.chapterID
  if chapterID then
    local passed = self:ChecChapterPassed(chapterID)
    if not passed then
      Log.notice("[guide ActivateGuide1] chapter not pass chapterID id ", chapterID)
      if callBack then
        callBack(false)
      end
      return
    end
  end
  local levelExclusiveGuide = cfgGuideTrigger.LevelExclusiveGuide
  if levelExclusiveGuide then
    local done = self:IsGuideDone(levelExclusiveGuide)
    if done then
      Log.notice("[guide ActivateGuide1] levelExclusiveGuide done guide id ", levelExclusiveGuide)
      if callBack then
        callBack(false)
      end
      return
    end
  end
  local preGuideID = cfgGuideTrigger.preGuideID
  if preGuideID then
    local done = self:IsGuideDone(preGuideID)
    if not done then
      Log.notice("[guide ActivateGuide1] preGuideID not done guide id ", preGuideID)
      if callBack then
        callBack(false)
      end
      return
    end
  end
  Log.notice("[guide ActivateGuide2] guide ", guide:GetID(), " triggerid: ", id)
  if GameGlobal:GetInstance():IsCoreGameRunning() then
    self.triggerGuides[id]:SetIsCoreGameGuide(true)
  end
  if callBack then
    if guide:IsDone() then
      callBack(false)
    elseif guide:CheckGuide() then
      if not self.activatedGuideTrigger[id] then
        callBack(true)
      else
        callBack(false)
      end
    end
  end
  self.activatedGuideTrigger[id] = 1
  if guide:NoAct() then
    if self._GuideCheck:CheckGuideStartCondition(guide:GetID()) == false then
      self:_ForceDoneGuide(TT, guide:GetID())
      if callBack then
        callBack(false)
      end
    else
      if callBack then
        callBack(true)
      end
      Log.notice("[guide ActivateGuide3] guide ", guide:GetID(), " triggerid: ", id)
      local workModule = GameGlobal.GetModule(RoleModule)
      workModule:PushClientLog("[guide]", "ActivateGuide:" .. guide:GetID() .. " triggerid: " .. id)
      if GameGlobal:GetInstance():IsCoreGameRunning() then
        self.guides[guide:GetID()]:SetIsCoreGameGuide(true)
      end
      self.activatedGuides[guide:GetID()] = 1
      self.guides[guide:GetID()]:SetData(Cfg.cfg_guide_trigger[id])
      guide:Init()
    end
    self:UpdateGuides()
  end
end

function GuideModule:_ForceDoneGuide(TT, id)
  Log.info("[Guide] ForceDoneGuide id:", id)
  local guide = self.guides[id]
  if not guide then
    return
  end
  guide:Done(false)
  self.activatedGuides[id] = nil
  self:RequestDoneGuide(TT, id, 1)
  if guide:IsCoreGameGuide() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideYieldBreak)
  end
end

function GuideModule:UpdateGuides()
end

function GuideModule:Update(curTimeMS)
  if NOGUIDE then
    return
  end
  if not self.inited then
    return
  end
  local lockId
  for id, _ in pairs(self.activatedGuides) do
    local guide = self.guides[id]
    if guide:CheckShow() then
      if guide:IsLockScreen() then
        lockId = id
      else
        guide:Show()
      end
    end
  end
  if lockId then
    local guide = self.guides[lockId]
    guide:Show()
  end
end

function GuideModule:UIClose(uiName)
  if uiName == "UIBattle" and self.activatedGuides then
    local clearIds = {}
    for guideId, guide in pairs(self.guides) do
      if guide:IsCoreGameGuide() and not guide:IsDone() then
        self.guides[guideId]:Clear()
        table.insert(clearIds, guideId)
      end
    end
    for _, guideId in ipairs(clearIds) do
      Log.debug("[guide] UIClose activatedGuides set nil guide ", guideId)
      self.activatedGuides[guideId] = nil
    end
    clearIds = {}
    for guideTriggerId, guide in pairs(self.triggerGuides) do
      if guide:IsCoreGameGuide() and not guide:IsDone() then
        self.triggerGuides[guideTriggerId]:Clear()
        table.insert(clearIds, guideTriggerId)
      end
    end
    for _, triggerId in ipairs(clearIds) do
      Log.debug("[guide] UIClose activatedGuideTrigger set nil triggerid ", triggerId)
      self.activatedGuideTrigger[triggerId] = nil
    end
  end
end

function GuideModule:MissionInfoChange()
  local missionModule = GameGlobal.GetModule(MissionModule)
  self.curMissionId = missionModule:GetCurMissionID()
end

function GuideModule:DirectEnterStage2(TT)
  if NOGUIDE then
    return
  end
  local stage1GuideID = Cfg.cfg_global.stage_1_guide_id.IntValue
  if not self:IsGuideDone(stage1GuideID) then
    GameGlobal.TaskManager():StartTask(self._ForceDoneGuide, self, stage1GuideID)
  end
  local module = self:GetModule(MissionModule)
  local data = module:GetDiscoveryData()
  local targetMissionId = Cfg.cfg_guide_const.guide_direct_mission.IntValue
  data:UpdatePosByEnter(5, targetMissionId)
  local game = GameGlobal.GetModule(GameMatchModule)
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_Mission, targetMissionId)
  local res = game:StartMatchTask(TT, MatchType.MT_Mission, 1, createInfo)
  if not res:GetSucc() then
    ToastManager.ShowToast(game:GetErrorMsg(res:GetResult()))
  end
end

function GuideModule:CheckMissionGuide(curMissionID)
  local stage2MissionID = Cfg.cfg_global.stage_2_id.IntValue
  local stage3MissionID = Cfg.cfg_global.stage_3_id.IntValue
  local stage2GuideID = Cfg.cfg_global.stage_2_guide_id.IntValue
  local stage3GuideID = Cfg.cfg_global.stage_3_guide_id.IntValue
  if curMissionID == stage2MissionID then
    if not self:IsGuideDone(stage2GuideID) then
      GameGlobal.TaskManager():StartTask(self._ForceDoneGuide, self, stage2GuideID)
    end
  elseif curMissionID == stage3MissionID and not self:IsGuideDone(stage3GuideID) then
    GameGlobal.TaskManager():StartTask(self._ForceDoneGuide, self, stage3GuideID)
  end
end

function GuideModule:_CheckDateNotStart(id)
  local cfg = Cfg.cfg_guide_trigger[id]
  if cfg and cfg.StartTime then
    local loginModule = self:GetModule(LoginModule)
    local svrTimeModule = self:GetModule(SvrTimeModule)
    local startTime = loginModule:GetTimeStampByTimeStr(cfg.StartTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local nowTime = svrTimeModule:GetServerTime() * 0.001
    return startTime > nowTime
  end
  return false
end

function GuideModule:_CheckOutOfDate(id)
  local cfg = Cfg.cfg_guide_trigger[id]
  if cfg and cfg.EndTime then
    local loginModule = self:GetModule(LoginModule)
    local svrTimeModule = self:GetModule(SvrTimeModule)
    local endTime = loginModule:GetTimeStampByTimeStr(cfg.EndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local nowTime = svrTimeModule:GetServerTime() * 0.001
    return endTime < nowTime
  end
  return false
end

function GuideModule:_CheckTaskNoFinish(id)
  local cfg = Cfg.cfg_guide_trigger[id]
  if cfg and cfg.TaskID then
    local questModule = GameGlobal.GetModule(QuestModule)
    local quest = questModule:GetQuest(cfg.TaskID)
    if quest then
      return quest:QuestInfo().status ~= QuestStatus.QUEST_Taken
    end
  end
  return false
end

function GuideModule:_CheckTaskFinish(id)
  local cfg = Cfg.cfg_guide_trigger[id]
  if cfg and cfg.TaskIDs then
    local questModule = GameGlobal.GetModule(QuestModule)
    for _, taskID in pairs(cfg.TaskIDs) do
      local quest = questModule:GetQuest(taskID)
      if quest and quest:QuestInfo().status == QuestStatus.QUEST_Taken then
        return true
      end
    end
  end
  return false
end

function GuideModule:GetCurGuides()
  if self.activatedGuides then
    local guides = {}
    for id, _ in pairs(self.activatedGuides) do
      table.insert(guides, self.guides[id])
    end
    return guides
  end
end

function GuideModule:OnQuestUpdate(quests)
  if self.activatedGuides then
    for id, _ in pairs(self.activatedGuides) do
      local guide = self.guides[id]
      if guide and not guide.currStep then
        for _, guideStep in pairs(guide.allSteps) do
          if guideStep and (guideStep.last or guideStep.data.coreStep) and guideStep.btnGuideCfg and guideStep.btnGuideCfg.completeRule == GuideCompleteType.TaskState then
            local questid = guideStep.btnGuideCfg.completeRuleParam[1]
            local status = guideStep.btnGuideCfg.completeRuleParam[2]
            if quests then
              for _, quest in pairs(quests) do
                if questid == quest:QuestInfo().quest_id and status == quest:QuestInfo().status then
                  GameGlobal.TaskManager():StartTask(self._ForceDoneGuide, self, guide.data.id)
                  return
                end
              end
            end
          end
        end
      end
    end
  end
end
