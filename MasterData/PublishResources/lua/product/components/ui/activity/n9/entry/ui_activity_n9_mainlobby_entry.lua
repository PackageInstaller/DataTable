_class("UIActivityN9MainLobbyEntry", UICustomWidget)
UIActivityN9MainLobbyEntry = UIActivityN9MainLobbyEntry

function UIActivityN9MainLobbyEntry:OnShow(uiParams)
  self._subjectTipsPanel = self:GetGameObject("SubjectTipsPanel")
  self._subjectTipsLabel = self:GetUIComponent("UILocalizationText", "SubjectTips")
  self._subjectTipsRollingText = self:GetUIComponent("RollingText", "SubjectTips")
  self._hardLevelTipsPanel = self:GetGameObject("HardLevelTipsPanel")
  self._hardLevelTipsLabel = self:GetUIComponent("UILocalizationText", "HardLevelTips")
  self._hardLevelTipsRollingText = self:GetUIComponent("RollingText", "HardLevelTips")
  self:_AttachEvents()
  self._stateType = UIStateType.UIActivityN9MainController
  self:_LoadCampaignInfo(false, ECampaignType.CAMPAIGN_TYPE_N9, ECampaignN9ComponentID.ECAMPAIGN_N9_SHOP, ECampaignN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN, ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_COMMON, ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD, ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_FIXTEAM, ECampaignN9ComponentID.ECAMPAIGN_N9_ACTION_POINT, ECampaignN9ComponentID.ECAMPAIGN_N9_STORY, ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
end

function UIActivityN9MainLobbyEntry:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:_DetachEvents()
end

function UIActivityN9MainLobbyEntry:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIActivityN9MainLobbyEntry:_LoadCampaignInfo(isLocal, camType, ...)
  self._campaign = UIActivityCampaign:New()
  if isLocal then
    self._campaign:LoadCampaignInfo_Local(camType, ...)
    self:_CheckPoint()
  else
    GameGlobal.TaskManager():StartTask(function(TT, ...)
      local lockName = "UIActivityMainLobbyEntry_LoadCampaignInfo"
      self:Lock(lockName)
      local res = AsyncRequestRes:New()
      self._campaign:LoadCampaignInfo(TT, res, camType, ...)
      self:_CheckPoint()
      self._hardComponent = self._campaign:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD)
      self._hardComponentInfo = self._campaign:GetComponentInfo(ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD)
      self._cumulativeSubjectComponent = self._campaign:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
      self._cumulativeSubjectComponentInfo = self._campaign:GetComponentInfo(ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
      self:StartCheckActivityStatus()
      self:UnLock(lockName)
    end)
  end
end

function UIActivityN9MainLobbyEntry:EntryBtnOnClick(go)
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(self._stateType, cache_rt)
    end)
  else
    self:SwitchState(self._stateType)
  end
end

function UIActivityN9MainLobbyEntry:_AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityN9MainLobbyEntry:_DetachEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIActivityN9MainLobbyEntry:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:_CheckPoint()
  end
end

function UIActivityN9MainLobbyEntry:_OnQuestUpdate()
end

function UIActivityN9MainLobbyEntry:_CheckPoint()
  local newObj = self:GetGameObject("new")
  local redObj = self:GetGameObject("red")
  local new = UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign)
  local red = UIActivityHelper.CheckCampaignSampleRedPoint(self._campaign)
  new = new or self:CheckNewState(ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD)
  new = new or self:CheckNewState(ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  local componentInfo = self._campaign:GetComponentInfo(ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  if componentInfo and not red then
    red = UIN9Const.HasNewOpenSubjectLevel(componentInfo)
  end
  UIActivityHelper.SetWidgetNewAndRed(newObj, new, redObj, red)
end

function UIActivityN9MainLobbyEntry:StartCheckActivityStatus()
  self:CheckActivityStatus()
  self._hardLevelTipsLabel:SetText(StringTable.Get("str_activity_n9_hard_level_open_tips"))
  self._hardLevelTipsRollingText:RefreshText(StringTable.Get("str_activity_n9_hard_level_open_tips"))
  self._subjectTipsLabel:SetText(StringTable.Get("str_activity_n9_subject_open_tips"))
  self._subjectTipsRollingText:RefreshText(StringTable.Get("str_activity_n9_subject_open_tips"))
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:CheckActivityStatus()
  end)
end

function UIActivityN9MainLobbyEntry:CheckActivityStatus()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local hardCmpUnLockTime = self._hardComponentInfo.m_unlock_time
  local subjectCmpUnLockTime = self._cumulativeSubjectComponentInfo.m_unlock_time
  local hardCompIsOpen = curTime >= hardCmpUnLockTime
  local subjectCompIsOpen = curTime >= subjectCmpUnLockTime
  if hardCmpUnLockTime >= subjectCmpUnLockTime then
    if hardCompIsOpen then
      self._hardLevelTipsPanel:SetActive(true)
      self._subjectTipsPanel:SetActive(false)
    else
      self._hardLevelTipsPanel:SetActive(false)
      self._subjectTipsPanel:SetActive(subjectCompIsOpen)
    end
  elseif subjectCompIsOpen then
    self._subjectTipsPanel:SetActive(true)
    self._hardLevelTipsPanel:SetActive(false)
  else
    self._subjectTipsPanel:SetActive(false)
    self._hardLevelTipsPanel:SetActive(hardCompIsOpen)
  end
end

function UIActivityN9MainLobbyEntry:CheckNewState(args)
  local isOpen = false
  local componentId = args
  local component = self._campaign:GetComponent(componentId)
  if not component then
    return false
  end
  isOpen = component:ComponentIsOpen()
  local dbStr = args == ECampaignN9ComponentID.ECAMPAIGN_N9_LEVEL_HARD and "UIActivityN9HardLevel" or "UIActivityN9Subject"
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  dbStr = dbStr .. pstid
  local hadSave = not LocalDB.HasKey(dbStr)
  return isOpen and hadSave
end
