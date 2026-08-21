_class("ICampaignComponentLocalProcessBase", Object)
ICampaignComponentLocalProcessBase = ICampaignComponentLocalProcessBase

function ICampaignComponentLocalProcessBase:Constructor()
  self.m_adapter_pool = nil
end

function ICampaignComponentLocalProcessBase:Init(a_adapter_pool)
  self.m_adapter_pool = a_adapter_pool
end

function ICampaignComponentLocalProcessBase:GetCampaignType()
end
