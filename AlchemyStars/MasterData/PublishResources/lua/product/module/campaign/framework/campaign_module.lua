_class("CampaignModule", GameModule)
CampaignModule = CampaignModule

function CampaignModule:Constructor()
  self.m_component_factory = CampaignComponentFactory:New()
  self.m_component_factory:InitComponentRegister(self)
  self.m_adapter_pool = CampaignComponentLocalProcessPool:New()
  self.m_adapter_pool:InitComponentRegister(self)
  self.m_campaign_manager = CampaignManager:New(self)
  self.m_LastCampaignLoadInfoListTime = 0
  self.m_LastCampaignLoadInfoOpenTime = 0
  self.m_LastCampaignLoadInfoListRes = nil
  self.campaign_review_time_start = 0
end

function CampaignModule:Init()
  self.cb = GameHelper:GetInstance():CreateCallback(self.OnLoginFinish, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnCreateMe, self.cb)
  self.caller:RegisterPushHandler(CEventStepChangeNotify, self.HandleCampaignStepChange, self)
  self.caller:RegisterPushHandler(CEventCampaignPushNotify, self.HandleCampaignProtoPushNotify, self)
  self.caller:RegisterPushHandler(CEventChangeCampaignSampleNotify, self.HandleChangeCampaignSampleNotify, self)
end

function CampaignModule:Dispose()
  CampaignModule.super.Dispose(self)
  self.m_campaign_manager = nil
  if self.cb ~= nil then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnCreateMe, self.cb)
  end
end

function CampaignModule:OnLoginFinish()
  GameGlobal.TaskManager():StartTask(self.LoadCampaignInfoListTask, self)
  GameGlobal.TaskManager():StartTask(self.CampaignReviewLoadInfoList, self)
end

function CampaignModule:LoadCampaignInfoListTask(TT)
  local res = AsyncRequestRes:New()
  self:CampaignLoadInfoList(TT, res)
  if res.m_result ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] LoadCampaignInfoListTask failed!")
  end
end

function CampaignModule:SetCampaignLoadInfoListResResult(res, eResult)
  res.m_result = eResult
  self.m_LastCampaignLoadInfoListRes.m_result = eResult
end

function CampaignModule:SetCampaignLoadInfoListResSuccess(res, bSetSuccess)
  res:SetSucc(bSetSuccess)
  self.m_LastCampaignLoadInfoListRes:SetSucc(bSetSuccess)
end

function CampaignModule:CampaignLoadInfoList(TT, res)
  local l_curTime = os.time()
  if l_curTime - self.m_LastCampaignLoadInfoListTime <= 2 and self.m_LastCampaignLoadInfoListRes ~= nil and self.m_LastCampaignLoadInfoListRes:GetSucc() then
    res.m_result = self.m_LastCampaignLoadInfoListRes.m_result
    res:SetSucc(true)
    return
  end
  self.m_LastCampaignLoadInfoListTime = l_curTime
  self.m_LastCampaignLoadInfoListRes = AsyncRequestRes:New()
  local request = CEventRequestCampaignLoadInfoList:New()
  local game_module = self:GetModule(LoginModule)
  local reply = game_module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] CampaignLoadInfoList Call failed!")
    self:SetCampaignLoadInfoListResResult(res, CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR)
    return
  end
  local replyEvent = CEventReplyCampaignLoadInfoList(reply.msg)
  if not replyEvent then
    Log.fatal("[Campaign][CampaignModule] CampaignLoadInfoList failed with replyEvent == nil")
    self:SetCampaignLoadInfoListResResult(res, CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    return
  end
  self:SetCampaignLoadInfoListResResult(res, replyEvent.ret)
  if replyEvent.ret ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] CampaignLoadInfoList failed with ret= ", replyEvent.ret)
    return
  else
    self:SetCampaignLoadInfoListResSuccess(res, true)
    for i = 1, #replyEvent.sample_list do
      self.m_campaign_manager:UpdateCampaignSampleInfo(replyEvent.sample_list[i])
    end
  end
end

function CampaignModule:CampaignComProtoLoadInfo(TT, res, a_campaign_id)
  local request = CEventRequestCampaignLoadInfo:New()
  request.m_id = a_campaign_id
  local game_module = self:GetModule(LoginModule)
  local reply = game_module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] CampaignComProtoLoadInfo Call failed!")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR
    return
  end
  local replyEvent = CEventReplyCampaignLoadInfo(reply.msg)
  if not replyEvent then
    Log.fatal("[Campaign][CampaignModule] CampaignComProtoLoadInfo failed with replyEvent == nil")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE
    return
  end
  res.m_result = replyEvent.ret
  if replyEvent.ret ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] CampaignComProtoLoadInfo failed with ret= ", replyEvent.ret)
    return
  else
    res:SetSucc(true)
    self.m_campaign_manager:InitCampaignObj(a_campaign_id, replyEvent.m_campaign_load_info)
  end
end

function CampaignModule:CampaignListComProtoLoadInfo(TT, res, a_campaign_id_list)
  local request = CEventRequestCampaignPreviewList:New()
  request.campaign_list = a_campaign_id_list
  local game_module = self:GetModule(LoginModule)
  local reply = game_module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] CampaignListComProtoLoadInfo Call failed!")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR
    return
  end
  local replyEvent = CEventReplyCampaignPreviewList(reply.msg)
  if not replyEvent then
    Log.fatal("[Campaign][CampaignModule] CampaignListComProtoLoadInfo failed with replyEvent == nil")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE
    return
  end
  res.m_result = replyEvent.ret
  if replyEvent.ret ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] CampaignListComProtoLoadInfo failed with ret= ", replyEvent.ret)
    return
  else
    res:SetSucc(true)
    for k, v in pairs(replyEvent.m_campaign_preview_info_list) do
      self.m_campaign_manager:InitCampaignObj(k, v)
    end
  end
end

function CampaignModule:CampaignClearNewFlag(TT, res, campaignID)
  local request = CEventRequestCampaignClearNewFlag:New()
  request.m_campaign_id = campaignID
  local game_module = self:GetModule(LoginModule)
  local reply = game_module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] CampaignClearNewFlag Call failed!")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR
    return
  end
  local replyEvent = CEventReplyCampaignClearNewFlag(reply.msg)
  if not replyEvent then
    Log.fatal("[Campaign][CampaignModule] CampaignClearNewFlag failed with replyEvent == nil")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE
    return
  end
  res.m_result = replyEvent.m_ret
  if replyEvent.m_ret ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] CampaignClearNewFlag failed with ret= ", replyEvent.m_ret)
    return
  else
    res:SetSucc(true)
    self.m_campaign_manager:UpdateCampaignStep(campaignID, ECampaignStep.CAMPAIGN_STEP_NEW, false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignComponentStepChange, campaignID, nil, nil)
  end
end

function CampaignManager:SetRemind(TT, res, a_campaign_id, is_close_remind)
  local campaign_obj = self.m_campaign_manager:GetCampaignObj(a_campaign_id)
  if not campaign_obj then
    Log.fatal("[Campaign][CampaignModule] SetRemind not found campaign! ", a_campaign_id)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_ID_ERROR
    return
  end
  local request = CEventRequestCampaignSetRemind:New()
  request.campaign_id = a_campaign_id
  request.is_close_remind = is_close_remind
  request.cfg_version = campaign_obj.m_sample_info.config_version
  request.com_last_interactive_time = campaign_obj.m_server_time
  local game_module = self:GetModule(LoginModule)
  local reply = game_module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] SetRemind Call failed!")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR
    return
  end
  local replyEvent = CEventReplyCampaignSetRemind(reply.msg)
  if not replyEvent then
    Log.fatal("[Campaign][CampaignModule] SetRemind failed with replyEvent == nil")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE
    return
  end
  res.m_result = replyEvent.ret
  if replyEvent.ret ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] SetRemind failed with ret= ", replyEvent.ret)
    return
  else
    res:SetSucc(true)
  end
end

function CampaignModule:CampaignComProtoRequest(TT, res, a_campaign_id, a_component_id, req, rep)
  local request = CEventCampaignRequest:New()
  request.m_id = a_campaign_id
  request.m_component_id = a_component_id
  request.m_opt = req.GetHandleCode()
  local ret, msg = lua_dc.SaveStream(req._className, req)
  if not ret then
    Log.fatal("[Campaign][CampaignModule] CampaignComProtoRequest SaveStream failed! _classname:", req._classname, ", msg:", msg)
    return
  else
    request.m_req_data = msg
  end
  local campaign_obj = self.m_campaign_manager:GetCampaignObj(a_campaign_id)
  if nil ~= campaign_obj and nil ~= campaign_obj.m_sample_info then
    request.m_config_version = campaign_obj.m_sample_info.config_version
    request.m_last_interactive_time = campaign_obj.m_server_time
    Log.debug("[Campaign][CampaignModule] CampaignProtoRequest id:", a_campaign_id, "ver:", request.m_config_version)
  end
  local game_module = self:GetModule(LoginModule)
  local reply = game_module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] CampaignProtoRequest Call failed!")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR
    return
  end
  local replyEvent = CEventCampaignReply(reply.msg)
  if replyEvent == nil then
    Log.fatal("[Campaign][CampaignModule] CampaignProtoRequest failed with replyEvent == nil")
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE
    return
  end
  res.m_result = replyEvent.ret
  if replyEvent.ret == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CONFIG_CHANGE then
    Log.debug("[Campaign][CampaignModule] CampaignProtoRequest failed with E_CAMPAIGN_ERROR_TYPE_CONFIG_CHANGE, ret= ", replyEvent.ret)
  end
  if res.m_result == CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    local ret, msg = lua_dc.LoadStream(rep._className, replyEvent.m_rep_data, rep)
    if not ret then
      Log.error("[Campaign][CampaignModule]CampaignProtoRequest lua_dc.LoadStream, _className:", rep._className, ", msg = ", msg)
    end
    if nil ~= campaign_obj then
      campaign_obj:UpdateComponentStep(a_component_id, replyEvent.m_component_step)
    else
      Log.error("[Campaign][CampaignModule] CampaignProtoRequest Request is error. Result: ", res.m_result, ", a_id:", a_campaign_id, ", a_component_id: ", a_component_id)
    end
    res:SetSucc(true)
  end
end

function CampaignModule:HandleCampaignStepChange(msg)
  Log.debug("[Campaign][CampaignModule] HandleCampaignStepChange msg:", msg.m_process:to_string())
  self.m_campaign_manager:SetCampaignStep(msg.m_process.id, msg.m_process.step)
  self:SetComponentSteps(msg.m_process.id, msg.m_component_steps)
  local questModule = GameGlobal.GetModule(QuestModule)
  questModule:CalcRedPoint()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonQuestRedUpdate)
end

function CampaignModule:HandleCampaignProtoPushNotify(msg)
  local campaign_obj = self.m_campaign_manager:GetCampaignObj(msg.m_campaign_id)
  if campaign_obj then
    campaign_obj:CampaignComProtoPushNotify(msg)
  else
    Log.debug("[Campaign][CampaignModule] CampaignComProtoPushNotify GetCampaignObj error! id:", msg.m_campaign_id)
    GameGlobal.TaskManager():StartTask(self.LoadDataAndCampaignComProtoPushNotify, self, msg)
  end
end

function CampaignModule:LoadDataAndCampaignComProtoPushNotify(TT, msg)
  local res = AsyncRequestRes:New()
  self:CampaignComProtoLoadInfo(TT, res, msg.m_campaign_id)
  if res.m_result ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.error("[Campaign][CampaignModule] LoadDataAndCampaignComProtoPushNotify load error!", res.m_result, " id:", msg.m_campaign_id)
    return
  end
  local campaign_obj = self.m_campaign_manager:GetCampaignObj(msg.m_campaign_id)
  if campaign_obj then
    campaign_obj:CampaignComProtoPushNotify(msg)
  else
    Log.error("[Campaign][CampaignModule] LoadDataAndCampaignComProtoPushNotify GetCampaignObj error! id:", msg.m_campaign_id)
  end
end

function CampaignModule:HandleChangeCampaignSampleNotify(msg)
  for i = 1, #msg.sample_list do
    local new_or_change_camp = msg.sample_list[i]
    local camp_obj = self.m_campaign_manager:GetCampaignObj(new_or_change_camp.id)
    if camp_obj and camp_obj:GetSampleInfo().config_version ~= new_or_change_camp.config_version then
      local res = AsyncRequestRes:New()
      GameGlobal.TaskManager():StartTask(self.CampaignComProtoLoadInfo, self, res, new_or_change_camp.id)
    end
    self.m_campaign_manager:UpdateCampaignSampleInfo(msg.sample_list[i])
  end
end

function CampaignModule:GetCampaignLocalProcess(campaign_type)
  local adapter_obj = self.m_adapter_pool:GetLocalProcess(campaign_type)
  if not adapter_obj then
    Log.error("[Campaign][CampaignModule] GetCampaignLocalProcess not found! campaign_type:", campaign_type)
    return nil
  end
  return adapter_obj
end

function CampaignModule:GetCampaignLocalProcessByCampaignId(TT, campaign_type, campaign_id)
  local l_pLocalProcess = self:GetCampaignLocalProcess(campaign_type)
  if not l_pLocalProcess then
    return nil
  end
  local l_Obj = l_pLocalProcess:CampaignObjInfo()
  if not (l_Obj and l_Obj.m_sample_info) or l_Obj.m_sample_info.id ~= campaign_id then
    l_Obj = self.m_campaign_manager:GetCampaignObj(campaign_id)
    if not l_Obj then
      local res = AsyncRequestRes:New()
      self:CampaignComProtoLoadInfo(TT, res, campaign_id)
      if res and res:GetSucc() then
        l_Obj = self.m_campaign_manager:GetCampaignObj(campaign_id)
      else
        return nil
      end
    end
    l_pLocalProcess:InitComponent(l_Obj)
  end
  return l_pLocalProcess
end

function CampaignModule:GetCampaignLocalProcessByCampaignId_Local(campaign_type, campaign_id)
  local l_pLocalProcess = self:GetCampaignLocalProcess(campaign_type)
  if not l_pLocalProcess then
    return nil
  end
  local l_Obj = l_pLocalProcess:CampaignObjInfo()
  if not (l_Obj and l_Obj.m_sample_info) or l_Obj.m_sample_info.id ~= campaign_id then
    l_Obj = self.m_campaign_manager:GetCampaignObj(campaign_id)
    if not l_Obj then
      return nil
    end
    l_pLocalProcess:InitComponent(l_Obj)
  end
  return l_pLocalProcess
end

function CampaignModule:GetSampleByType(campaign_type)
  return self.m_campaign_manager:GetSampleByType(campaign_type)
end

function CampaignModule:GetOpenSampleByType(campaign_type)
  return self.m_campaign_manager:GetOpenSampleByType(campaign_type)
end

function CampaignModule:SetComponentSteps(campaign_id, component_steps)
  local campaign_object = self.m_campaign_manager:GetCampaignObj(campaign_id)
  if not campaign_object then
    Log.debug("[Campaign][CampaignModule] SetComponentSteps not found! ", campaign_id)
    return
  end
  for key, value in pairs(component_steps) do
    local component = campaign_object.m_component_dict[key]
    if component then
      component:UpdateComponentStep(value)
    end
  end
end

function CampaignModule:GetCampaignInfo_Local(campaignType, ...)
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local campaign = {}
  campaign._type = campaignType
  campaign._id = -1
  campaign._sample = self.m_campaign_manager:GetSampleByType(campaign._type)
  if not campaign._sample then
    return campaign._id
  end
  campaign._id = campaign._sample.id
  if not campaign._sample:IsShow(curTime) then
    campaign._sample = nil
    return campaign._id
  end
  local component = {}
  local emptyFlag = false
  campaign._localProcess = self:GetCampaignLocalProcess(campaign._type)
  emptyFlag, component = self:_GetCampaignComponent(campaign._localProcess, ...)
  campaign._component = component
  return campaign._id
end

function CampaignModule:GetAllOpenCampaignCompInfo(TT, res)
  local l_openCampaignTable
  local l_openList = {}
  l_openCampaignTable, l_openList = self.m_campaign_manager:GetAllOpenSampleCampaign()
  local l_curTime = os.time()
  if l_curTime - self.m_LastCampaignLoadInfoOpenTime >= 10 then
    self.m_LastCampaignLoadInfoOpenTime = l_curTime
    self:CampaignLoadInfoList(TT, res)
    if not res or not res:GetSucc() then
      return {}
    end
    l_openCampaignTable, l_openList = self.m_campaign_manager:GetAllOpenSampleCampaign()
  end
  if not l_openCampaignTable then
    return {}
  end
  return l_openList
end

function CampaignModule:GetCampaignInfo(TT, res, campaignType, ...)
  local svrTimeModule = self:GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local campaign = {}
  campaign._type = campaignType
  campaign._id = -1
  campaign._sample = self.m_campaign_manager:GetSampleByType(campaign._type)
  if not campaign._sample or not campaign._sample:IsShow(curTime) then
    self:CampaignLoadInfoList(TT, res)
    if res and res:GetSucc() then
      campaign._sample = self.m_campaign_manager:GetSampleByType(campaign._type)
    end
  end
  if not campaign._sample then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
    return campaign._id
  end
  campaign._id = campaign._sample.id
  if not campaign._sample:IsShow(curTime) then
    campaign._sample = nil
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    return campaign._id
  end
  campaign._localProcess = self:GetCampaignLocalProcess(campaign._type)
  self:GetCampaignComponent(TT, res, campaign, ...)
  return campaign._id
end

function CampaignModule:GetCampaignComponent(TT, res, campaign, ...)
  if not campaign then
    return
  end
  local component = {}
  local emptyFlag = false
  emptyFlag, component = self:_GetCampaignComponent(campaign._localProcess, ...)
  if emptyFlag then
    self:CampaignComProtoLoadInfo(TT, res, campaign._id)
    if res and res:GetSucc() then
      local _obj = self.m_campaign_manager:GetCampaignObj(campaign._id)
      campaign._localProcess:InitComponent(_obj)
      emptyFlag, component = self:_GetCampaignComponent(campaign._localProcess, ...)
    end
  end
  campaign._component = component
end

function CampaignModule:_GetCampaignComponent(localProcess, ...)
  local emptyFlag = false
  local component = {}
  if not localProcess or not localProcess:CampaignObjInfo() then
    emptyFlag = true
    return emptyFlag, component
  end
  local args = {
    ...
  }
  for _, v in pairs(args) do
    local cmpt = localProcess:GetComponent(v)
    component[v] = cmpt
    if not cmpt then
      emptyFlag = true
      Log.info("CampaignModule:GetCampaignComponent() component == nil, componentId = ", v)
    end
  end
  return emptyFlag, component
end

function CampaignModule:CampaignSwitchState(showError, toState, defaultState, uiParamsTable, campaignId, ...)
  local sample = self.m_campaign_manager:GetSampleByID(campaignId)
  if sample and self:CheckComponentOpen(self:GetCampaignLocalProcess(sample.camp_type), ...) then
    uiParamsTable = uiParamsTable or {}
    GameGlobal.UIStateManager():SwitchState(toState, table.unpack(uiParamsTable))
  else
    if showError then
      self:ShowErrorToast(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK, true)
    end
    GameGlobal.UIStateManager():SwitchState(defaultState)
  end
end

function CampaignModule:SwitchState_Safe(showError, stateInfos)
  local curTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  
  local function checkSample(campaignId)
    local sample = self.m_campaign_manager:GetSampleByID(campaignId)
    if sample and sample:IsShow(curTime) then
      return true
    end
    return false
  end
  
  local function checkComponent(campaignId, componentId)
    local sample = self.m_campaign_manager:GetSampleByID(campaignId)
    if sample and sample:IsShow(curTime) then
      local lp = self:GetCampaignLocalProcessByCampaignId_Local(sample.camp_type, sample.id)
      if self:CheckComponentOpen(lp, componentId) then
        return true
      end
    end
    return false
  end
  
  local result
  for i, v in ipairs(stateInfos) do
    local check = true
    local campaignId, componentId = v.campaignId, v.componentId
    if campaignId ~= nil and componentId ~= nil then
      if not checkComponent(campaignId, componentId) then
        check = false
        result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE
      end
    elseif campaignId ~= nil and not checkSample(campaignId) then
      check = false
      result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    end
    if check then
      local stateType = v.stateType
      local uiParamsTable = v.uiParamsTable or {}
      GameGlobal.UIStateManager():SwitchState(stateType, table.unpack(uiParamsTable))
      break
    end
  end
  if showError and result ~= nil then
    UIActivityErrorHelper.ShowErrorToast(result, true)
  end
end

function CampaignModule:GetComponentByComponentId(cfgComponentId)
  local cam_id, comp_id, com_type = self:ParseCfgComponentID(cfgComponentId)
  local sample = self.m_campaign_manager:GetSampleByID(cam_id)
  if sample then
    local localProcess = self:GetCampaignLocalProcess(sample.camp_type)
    if localProcess then
      return localProcess:GetComponent(comp_id)
    end
  end
  return nil
end

function CampaignModule:GetSampleByID(cfgComponentId)
  local cam_id, comp_id, com_type = self:ParseCfgComponentID(cfgComponentId)
  local sample = self.m_campaign_manager:GetSampleByID(cam_id)
  return sample
end

function CampaignModule:CheckComponentOpen(localProcess, ...)
  if not localProcess then
    return false
  end
  local args = {
    ...
  }
  for _, v in pairs(args) do
    local component = localProcess:GetComponent(v)
    if not component or not component:ComponentIsOpen() then
      return false
    end
  end
  return true
end

function CampaignModule:CheckComponentRed(localProcess, ...)
  if not localProcess then
    return false
  end
  local args = {
    ...
  }
  for _, v in pairs(args) do
    local component = localProcess:GetComponent(v)
    if component and component:HaveRedPoint() then
      return true
    end
  end
  return false
end

function CampaignModule:CheckErrorCode(result, campaignId, refreshCallback, closeCallback)
  return UIActivityErrorHelper.CheckErrorCode(result, campaignId, refreshCallback, closeCallback)
end

function CampaignModule:ShowErrorToast(result, hideErrorId)
  return UIActivityErrorHelper.ShowErrorToast(result, hideErrorId)
end

function CampaignModule:IsErrorNeedRefresh(result)
  return UIActivityErrorHelper.IsErrorNeedRefresh(result)
end

function CampaignModule:IsErrorNeedClose(result)
  return UIActivityErrorHelper.IsErrorNeedClose(result)
end

function CampaignModule:IsErrorNeedCloseAll(result)
  return UIActivityErrorHelper.IsErrorNeedCloseAll(result)
end

function CampaignModule:ParseCfgComponentID(cfg_id)
  local camp_id = cfg_id // CampaignConfigDefine.CONFIG_CAMPAIGN_ID_MOD
  local tmp_id = cfg_id % CampaignConfigDefine.CONFIG_CAMPAIGN_ID_MOD
  local comp_id = tmp_id % CampaignConfigDefine.CONFIG_COMPONENT_TYPE_MOD
  local comp_type = tmp_id // CampaignConfigDefine.CONFIG_COMPONENT_TYPE_MOD
  return camp_id, comp_id, comp_type
end

function CampaignModule:ParseCampaignMissionParams(ParamsMap)
  if ParamsMap[ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] then
    local nComCfgId = ParamsMap[ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId]
    return self:ParseCfgComponentID(nComCfgId)
  end
  return nil
end

function CampaignModule:GetLatestCampaignObj(TT)
  self:LoadCampaignInfoListTask(TT)
  if self.m_campaign_manager then
    return self.m_campaign_manager:GetLatestCampaignObj()
  end
end

function CampaignModule:GetCampaignSampleDic()
  return self.m_campaign_manager:GetCampaignObjDic()
end

function CampaignModule:Module_ConvertMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_Campaign
  uiMatchResult.m_nSubMatchType = recvResult.sub_type
  uiMatchResult.m_nID = recvResult.mission_id
  local cfgMission = Cfg.cfg_campaign_mission[uiMatchResult.m_nID]
  local strStageName = StringTable.Get(cfgMission.Name)
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.m_stShowDesc = StringTable.Get(cfgMission.Desc)
  uiMatchResult.m_vecCondition = {}
  if cfgMission.IgnoreThreeStar == 0 then
    uiMatchResult.m_vecCondition[1] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition1, 0)
    uiMatchResult.m_vecCondition[2] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition2, 0)
    uiMatchResult.m_vecCondition[3] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition3, 0)
  end
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  uiMatchResult.m_vecAwardPerfect = recvResult.star_rewards
  uiMatchResult.m_vecFirstPassAward = recvResult.first_rewards
  uiMatchResult.m_matchResRolInfo = recvResult.match_result_role_info
  if 0 < table.count(recvResult.combat_simulator_result.rewards) then
    table.appendArray(uiMatchResult.m_vecAwardNormal, recvResult.combat_simulator_result.rewards)
  end
  if 0 < table.count(recvResult.combat_simulator_result.random_rewards) then
    table.appendArray(uiMatchResult.m_vecExtAward, recvResult.combat_simulator_result.random_rewards)
  end
  if 0 < table.count(recvResult.combat_simulator_result.extra_rewards) then
    table.appendArray(uiMatchResult.m_vecDoubleExtAward, recvResult.combat_simulator_result.extra_rewards)
  end
  return uiMatchResult
end

function CampaignModule:Module_ConvertConquestMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_Conquest
  uiMatchResult.m_nID = recvResult.mission_id
  local comp_cfg_id = recvResult.comp_cfg_id
  local day_index = recvResult.random_index
  local cfgMission = Cfg.cfg_component_battlefield({
    CampaignMissionID = uiMatchResult.m_nID
  })
  local strStageName = StringTable.Get(cfgMission[1].MissionName)
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.m_vecAwardNormal = recvResult.wave_award
  return uiMatchResult
end

function CampaignModule:Module_ConvertBloodsuckerMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_MiniMaze
  uiMatchResult.m_nID = recvResult.mission_id
  local comp_cfg_id = recvResult.comp_cfg_id
  local cfgMission = Cfg.cfg_component_bloodsucker({
    CampaignMissionID = uiMatchResult.m_nID
  })
  local strStageName = StringTable.Get(cfgMission[1].MissionName)
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.wave = recvResult.pass_wave_index
  uiMatchResult.m_vecFirstPassAward = recvResult.first_rewards
  return uiMatchResult
end

function CampaignModule:Module_ConvertBlackFistMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_BlackFist
  uiMatchResult.m_nID = recvResult.mission_id
  local strStageName
  local cfg_blackfist_mission = Cfg.cfg_blackfist_mission[uiMatchResult.m_nID]
  if cfg_blackfist_mission and cfg_blackfist_mission.MissionName then
    strStageName = StringTable.Get(cfg_blackfist_mission.MissionName)
  else
    strStageName = StringTable.Get("str_n7_black_fight_" .. uiMatchResult.m_nID)
  end
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  if table.count(recvResult.combat_simulator_result.rewards) > 0 then
    table.appendArray(uiMatchResult.m_vecAwardNormal, recvResult.combat_simulator_result.rewards)
  end
  if 0 < table.count(recvResult.combat_simulator_result.random_rewards) then
    table.appendArray(uiMatchResult.m_vecExtAward, recvResult.combat_simulator_result.random_rewards)
  end
  if 0 < table.count(recvResult.combat_simulator_result.extra_rewards) then
    table.appendArray(uiMatchResult.m_vecDoubleExtAward, recvResult.combat_simulator_result.extra_rewards)
  end
  return uiMatchResult
end

function CampaignModule:Module_ConvertChessMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_Chess
  uiMatchResult.m_nID = recvResult.mission_id
  local cfgMission = Cfg.cfg_chess_mission[uiMatchResult.m_nID]
  local strStageName = StringTable.Get(cfgMission.Name)
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.m_stShowDesc = StringTable.Get(cfgMission.Desc)
  local cfg_campaign_mission = Cfg.cfg_campaign_mission[uiMatchResult.m_nID]
  uiMatchResult.m_vecCondition = {}
  if cfgMission.IgnoreThreeStar == 0 then
    uiMatchResult.m_vecCondition[1] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition1, 0)
    uiMatchResult.m_vecCondition[2] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition2, 0)
    uiMatchResult.m_vecCondition[3] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition3, 0)
  end
  if cfg_campaign_mission and cfg_campaign_mission.Name then
    strStageName = StringTable.Get(cfg_campaign_mission.Name)
  end
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  uiMatchResult.m_vecFirstPassAward = recvResult.first_rewards
  uiMatchResult.m_vecAwardPerfect = recvResult.star_rewards
  return uiMatchResult
end

function CampaignModule:Module_ConvertSeasonMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_Season
  uiMatchResult.m_nID = recvResult.mission_id
  local cfgMission = Cfg.cfg_season_mission[uiMatchResult.m_nID]
  local strStageName = StringTable.Get(cfgMission.Name)
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.m_stShowDesc = StringTable.Get(cfgMission.Desc)
  uiMatchResult.m_vecCondition = {}
  if cfgMission.ShowCondition == 1 then
    uiMatchResult.m_vecCondition[1] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition1, 0)
    uiMatchResult.m_vecCondition[2] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition2, 0)
    uiMatchResult.m_vecCondition[3] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition3, 0)
  end
  uiMatchResult.m_matchResRolInfo = recvResult.match_result_role_info
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  uiMatchResult.m_vecFirstPassAward = recvResult.first_rewards
  uiMatchResult.m_vecAwardPerfect = recvResult.star_rewards
  uiMatchResult.m_ext_star_rewards = recvResult.ext_star_rewards
  uiMatchResult.m_ext_first_rewards = recvResult.ext_first_rewards
  return uiMatchResult
end

function CampaignModule:Module_ConvertPopStarMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_PopStar
  uiMatchResult.m_nID = recvResult.mission_id
  local cfgMission = Cfg.cfg_popstar_mission[uiMatchResult.m_nID]
  local strStageName = StringTable.Get(cfgMission.Name)
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.m_stShowDesc = StringTable.Get(cfgMission.Desc)
  local cfg_campaign_mission = Cfg.cfg_campaign_mission[uiMatchResult.m_nID]
  uiMatchResult.m_vecCondition = {}
  if cfgMission.IgnoreThreeStar == 0 then
    uiMatchResult.m_vecCondition[1] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition1, 0)
    uiMatchResult.m_vecCondition[2] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition2, 0)
    uiMatchResult.m_vecCondition[3] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition3, 0)
  end
  if cfg_campaign_mission and cfg_campaign_mission.Name then
    strStageName = StringTable.Get(cfg_campaign_mission.Name)
  end
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  uiMatchResult.m_vecFirstPassAward = recvResult.first_rewards
  uiMatchResult.m_vecAwardPerfect = recvResult.star_rewards
  uiMatchResult._starNum = recvResult.star_num
  return uiMatchResult
end

function CampaignModule:Module_ConvertAniPopStarMatchResult(recvResult, battleStatistics)
  local uiMatchResult = UI_MatchResult:New()
  local aniPopModule = GameGlobal.GetModule(AnipopModule)
  local aniPopInfo = aniPopModule:GetAniPopInfo()
  local roundInfo = aniPopInfo.round_info
  uiMatchResult.m_nMatchType = MatchType.MT_PopStarPro
  uiMatchResult.m_nID = roundInfo.level_list[recvResult.mission_index].level_id
  local curMissionCfg = {}
  local missionCfgs = Cfg.cfg_anipop_mission({})
  for _, missionCfg in pairs(missionCfgs) do
    if table.icontains(missionCfg.FightLevelArray, uiMatchResult.m_nID) then
      curMissionCfg = missionCfg
      break
    end
  end
  local strStageName = StringTable.Get(curMissionCfg.Name)
  uiMatchResult.layer_mission_num = recvResult.mission_index
  uiMatchResult.m_ext_star_rewards = recvResult.relics
  uiMatchResult.m_ext_skill_rewards = recvResult.skill_relics
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  uiMatchResult.m_vecFirstPassAward = recvResult.first_rewards
  uiMatchResult.m_vecAwardPerfect = recvResult.star_rewards
  uiMatchResult._starNum = battleStatistics.GainChest
  return uiMatchResult
end

function CampaignModule:Module_ConvertEightPetsMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_EightPets
  uiMatchResult.m_nID = recvResult.mission_id
  local cfgMission = Cfg.cfg_eight_pets_mission[uiMatchResult.m_nID]
  local strStageName = StringTable.Get(cfgMission.Name)
  uiMatchResult.m_stShowName = strStageName
  uiMatchResult.m_stShowDesc = StringTable.Get(cfgMission.Desc)
  uiMatchResult.m_vecCondition = {}
  if cfgMission.IgnoreThreeStar == 0 then
    uiMatchResult.m_vecCondition[1] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition1, 0)
    uiMatchResult.m_vecCondition[2] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition2, 0)
    uiMatchResult.m_vecCondition[3] = self:_ConvertCondition(recvResult.star_condition, cfgMission.ThreeStarCondition3, 0)
  end
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  uiMatchResult.m_vecAwardPerfect = {}
  uiMatchResult.m_vecFirstPassAward = recvResult.first_rewards
  uiMatchResult.m_matchResRolInfo = recvResult.match_result_role_info
  if recvResult.combat_simulator_result ~= nil then
    if 0 < table.count(recvResult.combat_simulator_result.rewards) then
      table.appendArray(uiMatchResult.m_vecAwardNormal, recvResult.combat_simulator_result.rewards)
    end
    if 0 < table.count(recvResult.combat_simulator_result.random_rewards) then
      table.appendArray(uiMatchResult.m_vecExtAward, recvResult.combat_simulator_result.random_rewards)
    end
    if 0 < table.count(recvResult.combat_simulator_result.extra_rewards) then
      table.appendArray(uiMatchResult.m_vecDoubleExtAward, recvResult.combat_simulator_result.extra_rewards)
    end
  end
  return uiMatchResult
end

function CampaignModule:Module_ConvertSeasonMazeMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_SeasonMaze
  uiMatchResult.m_nID = recvResult.mission_id
  uiMatchResult.m_vecAwardNormal = recvResult.rewards
  uiMatchResult.m_damage = recvResult.total_damage
  uiMatchResult.m_last_damage = recvResult.last_damage
  return uiMatchResult
end

function CampaignModule:_ConvertCondition(vecPassCondition, nConditionID, nParam)
  local uiExtCondition = UI_DetailExtCondition:New()
  uiExtCondition.m_nID = nConditionID
  uiExtCondition.m_nParam = nParam
  uiExtCondition.m_stDest = self:Get3StarConditionDesc(nConditionID)
  uiExtCondition.m_bPass = self:_IsConditionPass(vecPassCondition, nConditionID)
  return uiExtCondition
end

function CampaignModule:Get3StarConditionDesc(condition_id, colorStr)
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

function CampaignModule:_IsConditionPass(vecCondition, nConditionID)
  for _, conditionPass in pairs(vecCondition) do
    if conditionPass == nConditionID then
      return true
    end
  end
  return false
end

function CampaignModule:IsFightMission(missionID)
  local config = Cfg.cfg_campaign_mission[missionID]
  if config then
    if config.Type == MissionType.MissionType_Story then
      return false
    else
      return true
    end
  end
end

function CampaignModule:IsFightChessMission(missionID)
  local c = Cfg.cfg_chess_mission[missionID]
  return c ~= nil
end

function CampaignModule:IsPopStarMission(missionID)
  local c = Cfg.cfg_popstar_mission[missionID]
  return c ~= nil
end

function CampaignModule:Has3StarCondition(mission_id)
  return self:IsFightMission(mission_id) or self:IsFightChessMission(mission_id) or self:IsPopStarMission(mission_id)
end

function CampaignModule:ExitBattle(missionCreateInfo, isWin, battleresultRt)
  local campID, comID, comType = self:ParseCampaignMissionParams(missionCreateInfo.CampaignMissionParams)
  local campConfig = Cfg.cfg_campaign[campID]
  if not campConfig then
    Log.exception("退局找不到活动ID:", campID)
    return
  end
  local campType = campConfig.CampaignType
  local stateInfos = CampaignConst.GetCampaignUIStateParams(campID, campType, comID, missionCreateInfo, isWin, battleresultRt)
  self:SwitchState_Safe(true, stateInfos)
end

function CampaignModule:OpenCampaignMainUI(TT, uiName, comType)
  YIELD(TT)
  GameGlobal.UIStateManager():ShowDialog(uiName, comType)
end

function CampaignModule:HandleCampaignGetMatchMissionArrayExReward(TT, eMatchType, nMissionIdArray)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestCampaignGetMatchMissionArrayExReward)
  request.eMatchType = eMatchType
  request.nArrMissionId = nMissionIdArray
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    return AsyncRes
  end
  local reply_msg = reply.msg
  AsyncRes:SetSucc(true)
  return AsyncRes, reply_msg.campaign_reward_map
end

function CampaignModule:HandleCampaignGetMatchMissionExReward(TT, eMatchType, nMissionId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestCampaignGetMatchMissionExReward)
  request.eMatchType = eMatchType
  request.nMissionId = nMissionId
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE)
    return AsyncRes
  end
  local reply_msg = reply.msg
  AsyncRes:SetSucc(true)
  return AsyncRes, reply_msg.campaign_reward
end

function CampaignModule:CheckMissionCanAutoFight(missionCreateInfo)
  local cfg = Cfg.cfg_global.auto_fight_need_pass
  local errorStr = ""
  if cfg and cfg.StrValue then
    errorStr = cfg.StrValue
  end
  local campID, comID, comType = self:ParseCampaignMissionParams(missionCreateInfo.CampaignMissionParams)
  local missionCfg = Cfg.cfg_campaign_mission[missionCreateInfo.nCampaignMissionId]
  if not missionCfg then
    return false, errorStr
  end
  local enableParam = missionCfg.EnableAutoFight
  if enableParam == CampainMissionCanAutoFightType.E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_DISABLE then
    local cfgGlobal = Cfg.cfg_global.auto_fight_can_not_use
    return false, cfgGlobal.StrValue
  end
  if enableParam == CampainMissionCanAutoFightType.E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_ENABLE then
    return true
  end
  if enableParam == CampainMissionCanAutoFightType.E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_NEED_UNLOCK then
    local component = {}
    local emptyFlag = false
    local _obj = self.m_campaign_manager:GetCampaignObj(campID)
    if _obj then
      local cmptInfo = _obj:GetComponentInfo(comID)
      if cmptInfo and cmptInfo and cmptInfo.m_pass_mission_info then
        local passInfo = cmptInfo.m_pass_mission_info[missionCreateInfo.nCampaignMissionId]
        if passInfo then
          return true
        else
          return false, errorStr
        end
      end
    end
  end
  return false, errorStr
end

function CampaignModule:CheckEightPetsMissionCanAutoFight(missionCreateInfo)
  local cfg = Cfg.cfg_global.auto_fight_need_pass
  local errorStr = ""
  if cfg and cfg.StrValue then
    errorStr = cfg.StrValue
  end
  local campID, comID, comType = self:ParseCampaignMissionParams(missionCreateInfo.CampaignMissionParams)
  local missionCfg = Cfg.cfg_eight_pets_mission[missionCreateInfo.mission_id]
  if not missionCfg then
    return false, errorStr
  end
  local enableParam = missionCfg.EnableAutoFight
  if enableParam == CampainMissionCanAutoFightType.E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_DISABLE then
    return false, errorStr
  end
  if enableParam == CampainMissionCanAutoFightType.E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_ENABLE then
    return true
  end
  if enableParam == CampainMissionCanAutoFightType.E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_NEED_UNLOCK then
    local obj = self.m_campaign_manager:GetCampaignObj(campID)
    if obj then
      local cmptInfo = obj:GetComponentInfo(comID)
      if cmptInfo and cmptInfo and cmptInfo.m_pass_mission_info then
        local passInfo = cmptInfo.m_pass_mission_info[missionCreateInfo.mission_id]
        if passInfo then
          return true
        else
          return false, errorStr
        end
      end
    end
  end
  return false, errorStr
end

function CampaignModule:GetGraveRobberData()
  if not self.graveRobberData then
    self.graveRobberData = GraveRobberData:New()
  end
  return self.graveRobberData
end

function CampaignModule:GetSummerTwoLevelData(TT)
  local res = AsyncRequestRes:New()
  res.m_result = 0
  res.m_call_err = CallResultType.Normal
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SUMMER_II, ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
  if res and not res:GetSucc() then
    self:CheckErrorCode(res.m_result, campaign._id, nil, nil)
    return nil
  end
  if not campaign or not campaign:CheckComponentOpen() then
    return
  end
  local missionComponentInfo = campaign:GetComponentInfo(ECampaignSummerIIComponentID.ECAMPAIGN_SUMMERII_MISSION)
  return UISummerActivityTwoLevelDatas:New(missionComponentInfo)
end

function CampaignModule:GetSummer1Data()
  if not self._summer1Data then
    self._summer1Data = Summer1Data:New()
  end
  return self._summer1Data
end

function CampaignModule:GetN5Data()
  if not self._uIN5NewFlagRedPoint then
    self._uIN5NewFlagRedPoint = UIN5NewFlagRedPoint:New()
  end
  return self._uIN5NewFlagRedPoint
end

function CampaignModule:GetN7BlackFightData()
  if not self._blackFightData then
    self._blackFightData = BlackFightData:New()
  end
  return self._blackFightData
end

function CampaignModule:GetEveSinsaNewFlagRedPoint()
  if not self._eveSinsaNewFlagRedPoint then
    self._eveSinsaNewFlagRedPoint = UIActivityEveSinaNewFlagRedPoint:New()
  end
  return self._eveSinsaNewFlagRedPoint
end

function CampaignModule:GetN11Data()
  if not self._n11Data then
    self._n11Data = N11Data:New()
  end
  return self._n11Data
end

function CampaignModule:GetN20AVGData()
  if not self._n20AvgData then
    self._n20AvgData = N20AVGData:New()
  end
  return self._n20AvgData
end

function CampaignModule:GetN22Data()
  if not self._n22Data then
    self._n22Data = N22Data:New()
  end
  return self._n22Data
end

function CampaignModule:GetN23Data()
  if not self._n23Data then
    self._n23Data = N23Data:New()
  end
  return self._n23Data
end

function CampaignModule:GetN24Data()
  if not self._n24Data then
    self._n24Data = N24Data:New()
  end
  return self._n24Data
end

function CampaignModule:GetN25Data()
  if not self._n25Data then
    self._n25Data = N25Data:New()
  end
  return self._n25Data
end

function CampaignModule:GetN7DataReview()
  if not self._n7DataReview then
    self._n7DataReview = N7DataReview:New()
  end
  return self._n7DataReview
end

function CampaignModule:GetN28AVGData()
  if not self._n28AvgData then
    self._n28AvgData = N28AVGData:New()
  end
  return self._n28AvgData
end

function CampaignModule:GetDoubleDropValue(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_HAVESTTIME, ECampaignRewardDoubleComponentID.ECAMPAIGN_REWARD_DOUBLE)
  if res and not res:GetSucc() then
    return 0
  end
  if not campaign then
    return 0
  end
  local localProcess = campaign:GetLocalProcess()
  if not localProcess then
    return 0
  end
  local rewardDoubleComponent = localProcess:GetComponent(ECampaignRewardDoubleComponentID.ECAMPAIGN_REWARD_DOUBLE)
  if not rewardDoubleComponent then
    return 0
  end
  if not rewardDoubleComponent:ComponentIsOpen() then
    return 0
  end
  local rewardDoubleComponentInfo = localProcess:GetComponentInfo(ECampaignN6ComponentID.ECAMPAIGN_N6_BUILD)
  if not rewardDoubleComponentInfo then
    return 0
  end
  return rewardDoubleComponentInfo.ExRewardPercent
end

function CampaignModule:EnterCampaignReiew(TT)
  local res = AsyncRequestRes:New()
  local request = CEventEnterCampaignReviewReq:New()
  local game_module = self:GetModule(LoginModule)
  local reply = game_module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] EnterCampaignReiew Call failed!")
    res:SetSucc(false)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR
    return res
  end
  local replyEvent = CEventEnterCampaignReviewRes(reply.msg)
  if not replyEvent then
    Log.fatal("[Campaign][CampaignModule] EnterCampaignReiew failed with replyEvent == nil")
    res:SetSucc(false)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE
    return res
  end
  if replyEvent.ret ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] EnterCampaignReiew failed with ret= ", replyEvent.ret)
    res:SetSucc(false)
    return res
  else
    res:SetSucc(true)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS
    return res
  end
end

function CampaignModule:CampaignReviewLoadInfoList(TT)
  local res = AsyncRequestRes:New()
  local request = CEventRequestCampaignReviewLoadInfoList:New()
  local game_module = self:GetModule(LoginModule)
  local reply = game_module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] CampaignReviewLoadInfoList Call failed!")
    res:SetSucc(false)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR
    return
  end
  local replyEvent = CEventReplyCampaignReviewLoadInfoList(reply.msg)
  if not replyEvent then
    Log.fatal("[Campaign][CampaignModule] CampaignReviewLoadInfoList failed with replyEvent == nil")
    res:SetSucc(false)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE
    return
  end
  if replyEvent.ret ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] CampaignReviewLoadInfoList failed with ret= ", replyEvent.ret)
    res:SetSucc(false)
    return
  else
    res:SetSucc(true)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS
    self.campaign_review_time_start = replyEvent.campaing_review_time_start
    for i = 1, #replyEvent.sample_list do
      self.m_campaign_manager:UpdateCampaignSampleInfo(replyEvent.sample_list[i])
    end
  end
end

function CampaignModule:HandUnlockReviewCampaign(TT, capaign_id)
  local request = CEventUnlockCampaignReq:New()
  request.campaign_id = capaign_id
  local game_module = self:GetModule(LoginModule)
  local reply = game_module:Call(TT, request)
  local res = AsyncRequestRes:New()
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] HandUnlockReviewCampaign Call failed!")
    res:SetSucc(false)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR
    return res
  end
  local replyEvent = CEventUnlockCampaignRes(reply.msg)
  if not replyEvent then
    Log.fatal("[Campaign][CampaignModule] HandUnlockReviewCampaign failed with replyEvent == nil")
    res:SetSucc(false)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE
    return res
  end
  if replyEvent.ret ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] HandUnlockReviewCampaign failed with ret= ", replyEvent.ret)
    res:SetSucc(false)
    res.m_result = replyEvent.ret
    return res
  else
    res:SetSucc(true)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS
    self.campaign_review_time_start = reply.campaing_review_time_start
    for i = 1, #replyEvent.sample_list do
      self.m_campaign_manager:UpdateCampaignSampleInfo(replyEvent.sample_list[i])
    end
    return res
  end
end

function CampaignModule:GetAllReviewCampaignSample()
  return self.m_campaign_manager:GetAllCampaignReviewSample()
end

function CampaignModule:GetReviewCampaignSampleByCampaignId(campaign_id)
  return self.m_campaign_manager:GetSampleByID(campaign_id, true)
end

function CampaignModule:GetReviewData()
  local uiModule = self.uiModule
  return uiModule:GetReviewData()
end

function CampaignModule:SetDB(id, capName, funcName)
  local login_mod = GameGlobal.GameLogic():GetModule(LoginModule)
  local dbkey = login_mod:GetRoleShowID() .. capName .. funcName .. id
  LocalDB.SetInt(dbkey, 1)
end

function CampaignModule:GetDB(id, capName, funcName)
  local login_mod = GameGlobal.GameLogic():GetModule(LoginModule)
  local dbkey = login_mod:GetRoleShowID() .. capName .. funcName .. id
  return LocalDB.GetInt(dbkey, 0)
end

function CampaignModule:IsActivityReview(campaignID)
  local uiMod = self:GetUIModule(CampaignModule)
  return uiMod:GetReviewData():ContainsID(campaignID)
end

function CampaignModule:GetSeniorSkinDuplicateRewardIndexs(cfgs, cmpInfo)
  if not cfgs or not next(cfgs) then
    return nil
  end
  local idxs = {}
  local iModule = self:GetModule(ItemModule)
  for index, cfg in ipairs(cfgs) do
    if cfg.ReplaceRewardID and cfg.ReplaceRewardID > 0 then
      if cfg.RewardCount > 1 then
        Log.exception("高级时装需要替换奖励，但原奖励的数量不为1，无法判断:", cfg.ID)
        return nil
      end
      if cfg.RewardID > RoleAssetID.RoleAssetPetSkinBegin and cfg.RewardID < RoleAssetID.RoleAssetPetSkinEnd then
        local time = cmpInfo.skin_gain_time[cfg.RewardID]
        if not time then
        elseif time < cmpInfo.m_unlock_time then
          idxs[#idxs + 1] = index
        end
      else
        local count = iModule:GetItemCount(cfg.RewardID)
        if count == 0 then
        else
          local tmp, item = next(iModule:GetItemByTempId(cfg.RewardID))
          if item:GetGainTime() < cmpInfo.m_unlock_time then
            idxs[#idxs + 1] = index
          end
        end
      end
    end
  end
  return idxs
end

function CampaignModule:GetCurHauteCouture()
  local uiMod = self:GetUIModule(CampaignModule)
  return uiMod:GetHauteCoutureData():GetCurHauteCouture()
end

function CampaignModule:GetCurHauteCouture_Review(isAsync, fnAsync)
  local uiMod = self:GetUIModule(CampaignModule)
  local reviewData = uiMod:GetHauteCoutureData():GetCurHauteCoutureReview()
  if not isAsync then
    return reviewData
  end
  if reviewData ~= nil then
    fnAsync(reviewData)
    return reviewData
  end
  GameGlobal.TaskManager():StartTask(function(TT)
    local lockName = "CampaignModule:GetCurHauteCouture_Review"
    GameGlobal.UIStateManager():Lock(lockName)
    local campaign = UIActivityCampaign:New()
    local resC = AsyncRequestRes:New()
    campaign:LoadCampaignInfo(TT, resC, ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN_COPY)
    campaign:ReLoadCampaignInfo_Force(TT, resC)
    local hauteCoutureData = uiMod:GetHauteCoutureData()
    hauteCoutureData:RefreshCurInfo()
    local reviewData = hauteCoutureData:GetCurHauteCoutureReview()
    fnAsync(reviewData)
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
  return reviewData
end

function CampaignModule:RefreshCurHauteCoutureInfo()
  local uiMod = self:GetUIModule(CampaignModule)
  uiMod:GetHauteCoutureData():RefreshCurInfo()
end

function CampaignModule:ProcressPetEnhance(oriPet, missionComponentId)
  local hasEnhance = false
  local enhanceGrade, enhanceAwakening, enhanceEquip, enhanceLv, enhanceEquipRefineLv, correctCfg
  local petTemplateId = oriPet:GetTemplateID()
  local cfgGroup = Cfg.cfg_campaign_mission_pet_correct({ComponentID = missionComponentId, PetId = petTemplateId})
  if cfgGroup and 0 < #cfgGroup then
    correctCfg = cfgGroup[1]
  end
  if correctCfg then
    if correctCfg.GradeLv then
      local oriValue = oriPet:GetPetGrade()
      local maxValue = oriPet:GetMaxGrade()
      if oriValue < correctCfg.GradeLv and maxValue >= correctCfg.GradeLv then
        hasEnhance = true
        enhanceGrade = correctCfg.GradeLv
      end
    end
    if correctCfg.AwakeningLv then
      local oriValue = oriPet:GetPetAwakening()
      local maxValue = oriPet:GetMaxAwakening()
      if oriValue < correctCfg.AwakeningLv and maxValue >= correctCfg.AwakeningLv then
        hasEnhance = true
        enhanceAwakening = correctCfg.AwakeningLv
      end
    end
    if correctCfg.EquipLv then
      local oriValue = oriPet:GetEquipLv()
      local maxValue = 0
      local petId = oriPet:GetTemplateID()
      local cfg_equip = Cfg.cfg_pet_equip({PetID = petId})
      if cfg_equip and 0 < #cfg_equip then
        maxValue = cfg_equip[#cfg_equip].Level
      else
        maxValue = 10
      end
      if oriValue < correctCfg.EquipLv and maxValue >= correctCfg.EquipLv then
        hasEnhance = true
        enhanceEquip = correctCfg.EquipLv
      end
    end
    if enhanceGrade and correctCfg.Level then
      local grade = enhanceGrade
      local maxValue = self:_CalcPetMaxLevel(oriPet:GetTemplateID(), grade)
      if maxValue >= correctCfg.Level then
        hasEnhance = true
        enhanceLv = correctCfg.Level
      end
    else
    end
    if correctCfg.EquipRefineLv then
      local oriValue = oriPet:GetEquipRefineLv()
      local maxValue = oriPet:GetEquipRefineMaxLv()
      if oriValue < correctCfg.EquipRefineLv and maxValue >= correctCfg.EquipRefineLv then
        hasEnhance = true
        enhanceEquipRefineLv = correctCfg.EquipRefineLv
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
    tempData.awakening = enhanceAwakening and enhanceAwakening or oriPet:GetPetAwakening()
    tempData.equip_lv = enhanceEquip and enhanceEquip or oriPet:GetEquipLv()
    tempData.equip_refine_lv = enhanceEquipRefineLv and enhanceEquipRefineLv or oriPet:GetEquipRefineLv()
    tempData.affinity_level = oriPet:GetPetAffinityLevel()
    tmpPet:SetData(tempData)
    tmpPet:CalAttr()
    return tmpPet, hasEnhance
  else
    return oriPet, hasEnhance
  end
end

function CampaignModule:ProcressCampaignPetEnhance(oriPet, missionId)
  local hasEnhance = false
  local enhanceGrade, enhanceAwakening, enhanceEquip, enhanceLv, enhanceEquipRefineLv, correctCfg
  local cfgGroup = Cfg.cfg_campaign_mission({CampaignMissionId = missionId})
  if cfgGroup and 0 < #cfgGroup then
    correctCfg = cfgGroup[1]
  end
  if correctCfg then
    if correctCfg.PetGrade and correctCfg.PetLv then
      local oriValue = oriPet:GetPetGrade()
      local maxValue = oriPet:GetMaxGrade()
      local toGrade = correctCfg.PetGrade
      local toLv = correctCfg.PetLv
      if maxValue < correctCfg.PetGrade then
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
    if correctCfg.PetEquip then
      local oriValue = oriPet:GetEquipLv()
      local maxValue = 0
      local petId = oriPet:GetTemplateID()
      local cfg_equip = Cfg.cfg_pet_equip({PetID = petId})
      if cfg_equip and 0 < #cfg_equip then
        maxValue = cfg_equip[#cfg_equip].Level
      else
        maxValue = 10
      end
      if oriValue < correctCfg.PetEquip and maxValue >= correctCfg.PetEquip then
        hasEnhance = true
        enhanceEquip = correctCfg.PetEquip
      end
    end
    if correctCfg.EquipRefineLv then
      local oriValue = oriPet:GetEquipRefineLv()
      local maxValue = oriPet:GetEquipRefineMaxLv()
      if oriValue < correctCfg.EquipRefineLv and maxValue >= correctCfg.EquipRefineLv then
        hasEnhance = true
        enhanceEquipRefineLv = correctCfg.EquipRefineLv
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
    tempData.awakening = enhanceAwakening and enhanceAwakening or oriPet:GetPetAwakening()
    tempData.equip_lv = enhanceEquip and enhanceEquip or oriPet:GetEquipLv()
    tempData.equip_refine_lv = enhanceEquipRefineLv and enhanceEquipRefineLv or oriPet:GetEquipRefineLv()
    tempData.affinity_level = oriPet:GetPetAffinityLevel()
    tempData.b_pet_like = oriPet:IsLike()
    tmpPet:SetData(tempData)
    tmpPet:CalAttr()
    return tmpPet, hasEnhance
  else
    return oriPet, hasEnhance
  end
end

function CampaignModule:_CalcPetMaxLevel(templateId, grade)
  local cfgs = Cfg["cfg_pet_level_" .. templateId .. "_" .. grade]()
  local max = 1
  for _, c in pairs(cfgs) do
    if max < c.Level then
      max = c.Level
    end
  end
  return max
end

function CampaignModule:GetCampaignManager()
  return self.m_campaign_manager
end

function CampaignModule:GetCampaignObj(campaignID)
  return self.m_campaign_manager:GetCampaignObj(campaignID)
end

function CampaignModule:CampaignTeamRecord(TT, campaign_id, component_id, num, mission)
  local request = CEventCampaignTeamRecordReq:New()
  request.num = num
  request.mission = mission
  request.campaign_id = campaign_id
  request.component_id = component_id
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] CampaignTeamRecord Call failed!")
    res:SetSucc(false)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR
    return nil
  end
  local replyEvent = CEventCampaignTeamRecordRes(reply.msg)
  if not replyEvent then
    Log.fatal("[Campaign][CampaignModule] CampaignTeamRecord failed with replyEvent == nil")
    res:SetSucc(false)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE
    return nil
  end
  if replyEvent.ret ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] CampaignTeamRecord failed with ret= ", replyEvent.ret)
    res:SetSucc(false)
    return nil
  end
  res:SetSucc(true)
  res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS
  return replyEvent
end

function CampaignModule:IsDisposed()
  return self.m_campaign_manager == nil
end

function CampaignModule:CampaignLoadComponentRank(TT, res, component_cfg_id, sub_key)
  local request = CEventCampaignLoadComponentRankReq:New()
  request.component_cfg_id = component_cfg_id
  request.rank_sub_key = sub_key
  local game_module = self:GetModule(LoginModule)
  local reply = game_module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("[Campaign][CampaignModule] CampaignReviewLoadInfoList Call failed!")
    res:SetSucc(false)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_NET_ERROR
    return nil
  end
  local replyEvent = CEventCampaignLoadComponentRankRes(reply.msg)
  if not replyEvent then
    Log.fatal("[Campaign][CampaignModule] CampaignLoadComponentRank failed with replyEvent == nil")
    res:SetSucc(false)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_FAILURE
    return nil
  end
  if replyEvent.ret ~= CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS then
    Log.fatal("[Campaign][CampaignModule] CampaignLoadComponentRank failed with ret= ", replyEvent.ret)
    res:SetSucc(false)
    return nil
  else
    res:SetSucc(true)
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS
    return replyEvent.rank_list
  end
end
