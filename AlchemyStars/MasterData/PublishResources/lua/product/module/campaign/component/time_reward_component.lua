_class("TimeRewardComponent", ICampaignComponent)
TimeRewardComponent = TimeRewardComponent

function TimeRewardComponent:Constructor()
  self._componentInfo = TimeRewardComponentInfo:New()
end

function TimeRewardComponent:ComponentInfo()
  if not self._componentInfo then
    self._componentInfo = TimeRewardComponentInfo:New()
  end
  return self._componentInfo
end

function TimeRewardComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function TimeRewardComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_TIME_REWARD
end

function TimeRewardComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self._componentInfo)
  return ret
end

function TimeRewardComponent:HandleTakeTimeRewardReward(TT, asyncRes, rewardID)
  local request = TakeRewardReq:New()
  request.reward_id = rewardID
  local response = TakeRewardRep:New()
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][TimeRewardComponent] HandleTakeTimeRewardReward ret:", asyncRes.m_result)
    return nil
  end
  local timeRewardInfo = self._componentInfo.m_reward_info[rewardID]
  if not timeRewardInfo then
    Log.error("[CampaignCom][TimeRewardComponent] no reward info, reward id: ", rewardID)
    return nil
  end
  timeRewardInfo.rec_reward_status = ETimeRewardRewardStatus.E_TIME_REWARD_RECVED
  return response.m_rewards
end

function TimeRewardComponent:Start_HandleTakeTimeRewardReward(rewardID, callback)
  local lockName = "Start_HandleTakeTimeRewardReward"
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewards = self:HandleTakeTimeRewardReward(TT, res, rewardID)
    GameGlobal.UIStateManager():UnLock(lockName)
    callback(res, rewards)
  end)
end

function TimeRewardComponent:GetReviewRewards()
  local tb = {}
  local info = self:GetComponentInfo()
  for _, v in pairs(info.m_reward_info) do
    for __, vv in pairs(v.rewards) do
      tb[vv.assetid] = tb[vv.assetid] or 0
      tb[vv.assetid] = tb[vv.assetid] + vv.count
    end
  end
  local ra = {}
  for k, v in pairs(tb) do
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = k
    roleAsset.count = v
    table.insert(ra, roleAsset)
  end
  return ra
end

function TimeRewardComponent:GetTimeRewards()
  local info = self:GetComponentInfo()
  return info.m_reward_info
end

function TimeRewardComponent:ClientRefreshRewards()
  local info = self:GetComponentInfo()
  local loginModule = GameGlobal.GetModule(LoginModule)
  local srvTime = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(srvTime:GetServerTime() * 0.001)
  for _, v in pairs(info.m_reward_info) do
    local unlock_time = loginModule:GetTimeStampByTimeStr(v.unlock_time, Enum_DateTimeZoneType.E_ZoneType_GMT)
    if v.rec_reward_status == ETimeRewardRewardStatus.E_TIME_REWARD_LOCK and curTime <= unlock_time then
      v.rec_reward_status = ETimeRewardRewardStatus.E_TIME_REWARD_CAN_RECV
    end
  end
  return info.m_reward_info
end

function TimeRewardComponent:GetTimeRewardsList()
  local info = self:GetComponentInfo()
  local tb = table.collect(info.m_reward_info)
  if #tb == 0 then
    Log.error("TimeRewardComponent:GetTimeRewardsList() TimeRewardComponentInfo.m_reward_info = nil")
  end
  return tb
end

function TimeRewardComponent:GetTimeRewardState(index)
  local list = self:GetTimeRewardsList()
  if not list[index] then
    Log.error("TimeRewardComponent:GetTimeRewardState() list[index] = nil, index = ", index)
  end
  return list[index] and list[index].rec_reward_status or 0
end

function TimeRewardComponent:GetTimeRewardId(index)
  local list = self:GetTimeRewardsList()
  if not list[index] then
    Log.error("TimeRewardComponent:GetTimeRewardId() list[index] = nil, index = ", index)
  end
  return list[index] and list[index].reward_id or 0
end
