_class("CumulativeLoginComponent", ICampaignComponent)
CumulativeLoginComponent = CumulativeLoginComponent

function CumulativeLoginComponent:Constructor()
  self._componentInfo = CumulativeLoginComponentInfo:New()
end

function CumulativeLoginComponent:ComponentInfo()
  if not self._componentInfo then
    self._componentInfo = CumulativeLoginComponentInfo:New()
  end
  return self._componentInfo
end

function CumulativeLoginComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CumulativeLoginComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_CUMULATIVE_LOGIN
end

function CumulativeLoginComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self._componentInfo)
  return ret
end

function CumulativeLoginComponent:HandleReceiveCumulativeLoginReward(TT, asyncRes, rewardID)
  local request = CumulativeLoginComponentReceiveRewardReq:New()
  request.m_reward_id = rewardID
  local response = CumulativeLoginComponentReceiveRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CumulateLogin] HandleReceiveCumulativeLoginReward ret:", asyncRes.m_result)
    return nil
  end
  local cumulativeInfo = self._componentInfo.m_cumulative_info[rewardID]
  if not cumulativeInfo then
    Log.error("[CampaignCom][CumulateLogin] no reward info, login day: ", rewardID)
    return nil
  end
  cumulativeInfo.m_reward_status = ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED
  return response.m_rewards
end

function CumulativeLoginComponent:Start_HandleReceiveCumulativeLoginReward(rewardID, callback)
  local lockName = "CumulativeLoginComponent:Start_HandleReceiveCumulativeLoginReward"
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewards = self:HandleReceiveCumulativeLoginReward(TT, res, rewardID)
    GameGlobal.UIStateManager():UnLock(lockName)
    callback(res, rewards)
  end)
end

function CumulativeLoginComponent:GetCumulativeRewardInfo()
  local tb = {}
  local info = self:GetComponentInfo()
  for _, v in pairs(info.m_cumulative_info) do
    table.insert(tb, v)
  end
  table.sort(tb, function(a, b)
    return a.m_login_days < b.m_login_days
  end)
  return tb
end
