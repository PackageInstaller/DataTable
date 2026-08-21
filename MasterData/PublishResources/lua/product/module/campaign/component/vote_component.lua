_class("VoteComponent", ICampaignComponent)
VoteComponent = VoteComponent

function VoteComponent:Constructor()
  self.m_component_info = VoteComponentInfo:New()
end

function VoteComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = VoteComponentInfo:New()
  end
  return self.m_component_info
end

function VoteComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function VoteComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_VOTE
end

function VoteComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function VoteComponent:HandleVote(TT, asyncRes, item_id, num)
  local request = DoVoteReq:New()
  request.pet_id = item_id
  request.num = num
  local response = DoVoteRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][VoteComponent] HandleVote ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.pet2vote[item_id] = response.pet_num
  if self.m_component_info.zone_pet2vote[item_id] ~= nil then
    self.m_component_info.zone_pet2vote[item_id] = request.num + self.m_component_info.zone_pet2vote[item_id]
  else
    self.m_component_info.zone_pet2vote[item_id] = request.num
  end
  return response.ret
end

function VoteComponent:HandleGetZoneInfo(TT, asyncRes)
  local request = GetZonePetVoteReq:New()
  local response = GetZonePetVoteRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][VoteComponent] HandleVote ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.zone_pet2vote = response.zone_pet2vote
  return response.ret
end

function VoteComponent:Start_HandleVote(item_id, num, callback)
  local lockName = "Start_HandleVote"
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local ret = self:HandleVote(TT, res, item_id, num)
    GameGlobal.UIStateManager():UnLock(lockName)
    callback(res, ret)
  end)
end

function VoteComponent:Start_HandleGetZoneInfo(callback)
  local lockName = "Start_HandleGetZoneInfo"
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local ret = self:HandleGetZoneInfo(TT, res)
    GameGlobal.UIStateManager():UnLock(lockName)
    callback(res, ret)
  end)
end

function VoteComponent:GetPetVote(petId)
  local info = self:GetComponentInfo()
  return info.pet2vote[petId] or 0
end

function VoteComponent:GetZonePetVote(petId)
  local info = self:GetComponentInfo()
  return info.zone_pet2vote[petId] or 0
end

function VoteComponent:CalcZonePetVoteChampion()
  local info = self:GetComponentInfo()
  local tb = {}
  local maxVote = 0
  for k, v in pairs(info.zone_pet2vote) do
    if v > maxVote then
      maxVote = v
      tb = {}
    end
    if v == maxVote then
      table.insert(tb, k)
    end
  end
  return tb[1]
end

function VoteComponent:GetVoteCostItemId()
  local cfgId = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_vote_cost_item({ComponentID = cfgId})
  local cfg = cfgs and cfgs[1] or {}
  return cfg.CostItemID
end

function VoteComponent:GetVoteItemCfg()
  local cfgId = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_vote_item({ComponentID = cfgId})
  return cfgs or {}
end

function VoteComponent:GetAllVoteItemId()
  local cfgs = self:GetVoteItemCfg()
  local tb = {}
  for _, v in pairs(cfgs) do
    table.insert(tb, v.ItemId)
  end
  return tb
end

function VoteComponent:GetVoteItemCostCount(itemId)
  local cfgs = self:GetVoteItemCfg()
  for _, v in pairs(cfgs) do
    if v.ItemId == itemId then
      return v.CostItemCount
    end
  end
  return 1
end
