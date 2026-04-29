_class("CampaignDataBase", Object)
CampaignDataBase = CampaignDataBase

function CampaignDataBase:Constructor()
  self.activityCampaign = UIActivityCampaign:New()
end

function CampaignDataBase:RequestCampaign(TT, campaignType, res)
  res = res and res or AsyncRequestRes:New()
  if self.activityCampaign._type == -1 or self.activityCampaign._id == -1 then
    self.activityCampaign:LoadCampaignInfo(TT, res, campaignType)
  else
    self.activityCampaign:ReLoadCampaignInfo_Force(TT, res)
  end
  if res and res:GetSucc() then
  else
    Log.fatal("### [RequestCampaign]CampaignComProtoLoadInfo failed.")
  end
  return res
end

function CampaignDataBase:GetLocalProcess()
  return self.activityCampaign:GetLocalProcess()
end

function CampaignDataBase:GetCampaignTypeId()
  return self.activityCampaign._type, self.activityCampaign._id
end

function CampaignDataBase:GetCampaignSample()
  return self.activityCampaign:GetSample()
end

function CampaignDataBase:GetCampaignModule()
  return self.activityCampaign._campaign_module
end

function CampaignDataBase:GetActivityCampaign()
  return self.activityCampaign
end

function CampaignDataBase:GetCurrencyId()
  local cfg = Cfg.cfg_activity_shop_common_client[self.activityCampaign._id]
  if cfg then
    return cfg.CurrencyId
  end
  return 3000271
end
