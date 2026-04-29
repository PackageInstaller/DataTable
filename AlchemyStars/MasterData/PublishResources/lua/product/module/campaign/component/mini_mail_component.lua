require("component_base")
_class("MiniMailComponent", ICampaignComponent)
MiniMailComponent = MiniMailComponent

function MiniMailComponent:Constructor()
  self.m_component_info = MiniMailComponentInfo:New()
end

function MiniMailComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = MiniMailComponentInfo:New()
  end
  return self.m_component_info
end

function MiniMailComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function MiniMailComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_MINI_MAIL
end

function MiniMailComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function MiniMailComponent:HandleReadMiniMail(TT, asyncRes, id)
  local request = HandleReadMiniMailReq:New()
  request.id = id
  local response = HandleReadMiniMailReply:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][MiniMailComponent] HandleReadMiniMail ret:", asyncRes.m_result)
    return asyncRes.m_result
  end
  local iv = self.m_component_info.infos[id]
  if iv ~= nil then
    iv.state = MiniMailStateType.MMST_Read
  end
  return asyncRes.m_result
end

function MiniMailComponent:OnAdd(value)
  if self.m_component_info == nil then
    return
  end
  self.m_component_info.infos[value.id] = value
end

function MiniMailComponent:GetInfos()
  return self.m_component_info.infos
end

function MiniMailComponent:GetLatelyUnlockTime()
  local tv
  for key, value in pairs(self.m_component_info.infos) do
    if value.state == MiniMailStateType.MMST_Unread and value.unlock_time > 0 and (tv == nil or tv > value.unlock_time) then
      tv = value.unlock_time
    end
  end
  return tv
end

function MiniMailComponent:GetAllUnreadNum()
  local num = 0
  local maxnum = 0
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  for key, value in pairs(self.m_component_info.infos) do
    if value.state == MiniMailStateType.MMST_Unread then
      if curTime >= value.unlock_time then
        num = num + 1
      else
        maxnum = maxnum + 1
      end
    end
  end
  return num, maxnum
end

function MiniMailComponent:GetUnreadNum()
  local num = 0
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  for key, value in pairs(self.m_component_info.infos) do
    if value.state == MiniMailStateType.MMST_Unread and curTime >= value.unlock_time then
      num = num + 1
    end
  end
  return num
end

function MiniMailComponent:HaveRedPoint()
  return self:ComponentIsOpen() and self:GetUnreadNum() > 0
end

function MiniMailComponent:CampaignComponentPushNotify(notify_data)
  if MiniMailComponentNotifyType.MiniMailComponentNotifyType_Add == notify_data.m_notify_type then
    local ev = NotifyMiniMailAdd:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnAdd(ev.infos)
    else
      Log.error("[CampaignCom][MiniMailComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end
