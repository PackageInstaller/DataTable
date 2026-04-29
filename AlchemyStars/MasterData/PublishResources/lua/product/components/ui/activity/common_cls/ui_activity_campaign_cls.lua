_class("UIActivityCampaign", Object)
UIActivityCampaign = UIActivityCampaign

function UIActivityCampaign:Constructor()
  self._campaign_module = GameGlobal.GetModule(CampaignModule)
  self._campaign_manager = self._campaign_module.m_campaign_manager
  self._type = -1
  self._id = -1
end

function UIActivityCampaign:LoadCampaignInfo(TT, res, campaignType, ...)
  self._type = campaignType
  self._id = self._campaign_module:GetCampaignInfo(TT, res, campaignType, ...)
end

function UIActivityCampaign:LoadCampaignInfo_Local(campaignType, ...)
  self._type = campaignType
  self._id = self._campaign_module:GetCampaignInfo_Local(campaignType, ...)
end

function UIActivityCampaign:LoadCampaignInfo_Id(TT, res, campaignId, ...)
  self._id = campaignId
  self:ReLoadCampaignInfo_Force(TT, res)
end

function UIActivityCampaign:LoadCampaignInfo_Id_Local(campaignId)
  self._id = campaignId
  local sample = self:GetSample()
  if not sample then
    return
  end
  self._type = sample.camp_type
end

function UIActivityCampaign:ReLoadCampaignInfo_Force(TT, res)
  local lockName = "UIActivityCampaign:ReLoadCampaignInfo_Force() id = " .. self._id
  GameGlobal.UIStateManager():Lock(lockName)
  self._campaign_module:CampaignComProtoLoadInfo(TT, res, self._id)
  GameGlobal.UIStateManager():UnLock(lockName)
  if res and res:GetSucc() then
    local obj = self._campaign_manager:GetCampaignObj(self._id)
    local sample = self:GetSample()
    if not sample then
      return
    end
    self._type = sample.camp_type
    local localProcess = self:GetLocalProcess()
    localProcess:InitComponent(obj)
  end
end

function UIActivityCampaign:GetLocalProcess()
  return self._campaign_module:GetCampaignLocalProcessByCampaignId_Local(self._type, self._id)
end

function UIActivityCampaign:GetSample()
  if not self._campaign_manager then
    return nil
  end
  if self._id ~= -1 then
    return self._campaign_manager:GetSampleByID(self._id)
  end
  return self._sample or self._campaign_manager:GetSampleByType(self._type)
end

function UIActivityCampaign:GetComponent(componentId)
  local localProcess = self:GetLocalProcess()
  return localProcess and localProcess:GetComponent(componentId)
end

function UIActivityCampaign:GetComponentInfo(componentId)
  local localProcess = self:GetLocalProcess()
  return localProcess and localProcess:GetComponentInfo(componentId)
end

function UIActivityCampaign:GetCampaignType()
  return self._type
end

function UIActivityCampaign:GetCampaignID()
  return self._id
end

function UIActivityCampaign:_GetComponentIdByType(type, idx)
  if not self._componentDict then
    local tb = {}
    local i = 1
    while true do
      local component = self:GetComponent(i)
      if component == nil then
        break
      end
      local type = component:GetComponentType()
      if not tb[type] then
        tb[type] = {}
      end
      table.insert(tb[type], i)
      i = i + 1
    end
    self._componentDict = tb
  end
  idx = idx or 1
  return self._componentDict[type] and self._componentDict[type][idx]
end

function UIActivityCampaign:GetComponentByType(type, idx)
  return self:GetComponent(self:_GetComponentIdByType(type, idx))
end

function UIActivityCampaign:GetComponentInfoByType(type, idx)
  return self:GetComponentInfo(self:_GetComponentIdByType(type, idx))
end

function UIActivityCampaign:OpenMainUI(useStateUI)
  local cfg = Cfg.cfg_campaign[self._id]
  local uiName = cfg and cfg.MainUI
  if string.isnullorempty(uiName) then
    Log.error("UIActivityCampaign:OpenMainUI() uiName == nil")
  elseif useStateUI then
    GameGlobal.UIStateManager():SwitchState(uiName)
  else
    GameGlobal.UIStateManager():ShowDialog(uiName)
  end
end

function UIActivityCampaign:CheckCampaignOpen()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = svrTimeModule and math.floor(svrTimeModule:GetServerTime() * 0.001) or 0
  local sample = self:GetSample()
  return sample and sample.is_open and sample:IsShow(curTime) or false
end

function UIActivityCampaign:CheckCampaignRed()
  local sample = self:GetSample()
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD)
end

function UIActivityCampaign:CheckCampaignNew()
  local sample = self:GetSample()
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function UIActivityCampaign:ClearCampaignNew(TT)
  if self:CheckCampaignNew() then
    local res = AsyncRequestRes:New()
    self._campaign_module:CampaignClearNewFlag(TT, res, self._id)
    Log.info("UIActivityCampaign:ClearCampaignNew() CampaignClearNewFlag res.m_result = ", res.m_result)
  end
end

function UIActivityCampaign:CheckComponentOpen(...)
  return self._campaign_module:CheckComponentOpen(self:GetLocalProcess(), ...)
end

function UIActivityCampaign:CheckComponentRed(...)
  return self._campaign_module:CheckComponentRed(self:GetLocalProcess(), ...)
end

function UIActivityCampaign:ShowErrorToast(result, hideErrorId)
  UIActivityErrorHelper.ShowErrorToast(result, hideErrorId)
end

function UIActivityCampaign:CheckErrorCode(result, refreshCallback, closeCallback)
  UIActivityErrorHelper.CheckErrorCode(result, self._id, refreshCallback, closeCallback)
end

function UIActivityCampaign:CheckCampaignClose_ShowClientError()
  if not self:CheckCampaignOpen() then
    local result = self:_GetClientError_Campaign()
    self:CheckErrorCode(result)
    return true
  end
  return false
end

function UIActivityCampaign:CheckComponentClose_ShowClientError(...)
  if not self:CheckComponentOpen(...) then
    local result = self:_GetClientError_Component(...)
    self:CheckErrorCode(result)
    return true
  end
  return false
end

function UIActivityCampaign:_GetClientError_Campaign()
  local errorCode = {
    [0] = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED,
    [1] = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN,
    [2] = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED,
    [3] = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS
  }
  local sample = self:GetSample()
  if sample == nil then
    return errorCode[2]
  end
  local result = UIActivityCampaign._CalcClientError_Time(sample.begin_time, sample.end_time, errorCode)
  return result
end

function UIActivityCampaign:_GetClientError_Component(...)
  local errorCode = {
    [0] = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_ID_ERROR,
    [1] = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK,
    [2] = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE,
    [3] = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS
  }
  local succ = errorCode[3]
  local args = {
    ...
  }
  for _, v in pairs(args) do
    local componentInfo = self:GetComponentInfo(v)
    if componentInfo then
      local openTime = componentInfo.m_unlock_time
      local closeTime = componentInfo.m_close_time
      local result = UIActivityCampaign._CalcClientError_Time(openTime, closeTime, errorCode)
      if result ~= succ then
        return result
      end
    else
      local result = errorCode[0]
      Log.debug("UIActivityCampaign:CheckComponentOpenClientError() id = ", v, ", result = ", result)
      return result
    end
  end
  return succ
end

function UIActivityCampaign._CalcClientError_Time(openTime, closeTime, errorCode)
  if not openTime or not closeTime then
    return errorCode[0]
  end
  local curTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  if openTime > curTime then
    return errorCode[1]
  end
  if closeTime < curTime then
    return errorCode[2]
  end
  return errorCode[3]
end

function UIActivityCampaign:CheckComponentOpenClientError(...)
  return self:_GetClientError_Component(...)
end
