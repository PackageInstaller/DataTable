_class("CampaignManager", Object)
CampaignManager = CampaignManager

function CampaignManager:Constructor(a_module)
  self.m_campaign_dict = {}
  self.m_campaign_com_module = a_module
end

function CampaignManager:InitCampaignObj(a_campaign_id, a_campaign_load_info)
  local campaign_obj
  if not self.m_campaign_dict[a_campaign_id] then
    campaign_obj = CampaignObj:New(self.m_campaign_com_module)
    self.m_campaign_dict[a_campaign_id] = campaign_obj
  else
    campaign_obj = self.m_campaign_dict[a_campaign_id]
  end
  campaign_obj:Init(a_campaign_load_info)
  return campaign_obj
end

function CampaignManager:GetCampaignObj(a_campaign_id)
  return self.m_campaign_dict[a_campaign_id]
end

function CampaignManager:GetCampaignObjDic()
  return self.m_campaign_dict
end

function CampaignManager:UpdateCampaignSampleInfo(a_sample_info)
  local campaign_obj = self:GetCampaignObj(a_sample_info.id)
  if not campaign_obj then
    Log.debug("[Campaign][CampaignManager] UpdateCampaignSampleInfo GetCampaignObj not found! ", a_sample_info.id)
    local camp_info = CampaignLoadInfo:New()
    camp_info.m_sample_info = a_sample_info
    campaign_obj = self:InitCampaignObj(a_sample_info.id, camp_info, self.m_campaign_com_module)
  end
  campaign_obj:UpdateSampleInfo(a_sample_info)
end

function CampaignManager:UpdateComponentStep(a_campaign_id, a_component_id, a_step)
  local campaign_obj = self:GetCampaignObj(a_campaign_id)
  if not campaign_obj then
    Log.debug("[Campaign][CampaignManager] UpdateComponentStep GetCampaignObj not found! ", a_campaign_id)
    return
  end
  campaign_obj:UpdateComponentStep(a_component_id, a_step)
end

function CampaignManager:UpdateCampaignStep(campaignID, step, flag)
  local campaign_obj = self:GetCampaignObj(campaignID)
  if not campaign_obj then
    Log.debug("[Campaign][CampaignManager] UpdateCampaignStep GetCampaignObj not found! ", campaignID)
    return
  end
  campaign_obj:UpdateCampaignStep(step, flag)
end

function CampaignManager:SetCampaignStep(campaignID, step)
  local campaign_obj = self:GetCampaignObj(campaignID)
  if not campaign_obj then
    Log.debug("[Campaign][CampaignManager] SetCampaignStep GetCampaignObj not found! ", campaignID)
    return
  end
  campaign_obj:SetCampaignStep(step)
end

function CampaignManager:GetSampleByID(a_campaign_id, must_vaild)
  must_vaild = must_vaild or true
  local campaign_obj = self:GetCampaignObj(a_campaign_id)
  if not campaign_obj then
    Log.error("[Campaign][CampaignManager] GetSampleByID GetCampaignObj not found! ", a_campaign_id)
    return nil
  end
  local sample_info = campaign_obj.m_sample_info
  if not sample_info then
    Log.error("[Campaign][CampaignManager] GetSampleByID sample_info not found! ", a_campaign_id)
    return nil
  else
    local svrTime = GameGlobal.GetModule(SvrTimeModule)
    local cur_time = svrTime:GetServerTime() / 1000
    if sample_info.end_time ~= 0 and cur_time > sample_info.end_time then
      return nil
    elseif cur_time < sample_info.begin_time then
      return nil
    else
      return campaign_obj.m_sample_info
    end
  end
  return nil
end

function CampaignManager:GetSampleByType(a_campaign_type)
  for key, value in pairs(self.m_campaign_dict) do
    if value.m_sample_info.camp_type == a_campaign_type then
      return value.m_sample_info
    end
  end
  return nil
end

function CampaignManager:GetOpenSampleByType(a_campaign_type)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  for key, value in pairs(self.m_campaign_dict) do
    if value.m_sample_info.camp_type == a_campaign_type and value.m_sample_info:IsShow(curTime) then
      return value.m_sample_info
    end
  end
  return nil
end

function CampaignManager:GetAllOpenSampleCampaign()
  local l_openCampaignTable
  local l_CampaignIdList = {}
  local l_svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(l_svrTimeModule:GetServerTime() * 0.001)
  for key, value in pairs(self.m_campaign_dict) do
    if value.m_sample_info:IsShow(curTime) and value:IsReView() == false then
      l_openCampaignTable = l_openCampaignTable or {}
      l_openCampaignTable[key] = value
      l_CampaignIdList[#l_CampaignIdList + 1] = key
    end
  end
  return l_openCampaignTable, l_CampaignIdList
end

function CampaignManager:GetLatestCampaignObj()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local campaignObj
  local latestTime = 0
  for key, value in pairs(self.m_campaign_dict) do
    local campaign_cfg = Cfg.cfg_campaign[value.m_sample_info.id]
    if campaign_cfg == nil then
      Log.exception("cfg_campaign中找不到对应活动配置 id:" .. value.m_sample_info.id)
    end
    if campaign_cfg.EntranceIcon and not self:IsReview(value) and value.m_sample_info:IsShow(curTime) and latestTime < value.m_sample_info.begin_time then
      latestTime = value.m_sample_info.begin_time
      campaignObj = value
    end
  end
  return campaignObj
end

function CampaignManager:GetAllCampaignReviewSample()
  local sample_list = {}
  for key, value in pairs(self.m_campaign_dict) do
    if self:IsReview(value) then
      sample_list[value.m_sample_info.id] = value
    end
  end
  return sample_list
end

function CampaignManager:IsReview(obj)
  local campaign_cfg = Cfg.cfg_campaign[obj.m_sample_info.id]
  if campaign_cfg == nil then
    Log.exception("cfg_campaign中找不到对应活动配置 id:" .. obj.m_sample_info.id)
  end
  return campaign_cfg.CostItem ~= nil and #campaign_cfg.CostItem > 0
end
