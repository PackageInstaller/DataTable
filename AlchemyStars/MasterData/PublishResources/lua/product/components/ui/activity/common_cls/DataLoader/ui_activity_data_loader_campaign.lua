require("ui_activity_data_loader_base")
_class("UIActivityDataLoader_Campaign", UIActivityDataLoaderBase)
UIActivityDataLoader_Campaign = UIActivityDataLoader_Campaign

function UIActivityDataLoader_Campaign:SetData(params)
  self._campaignType = params and params.campaign_type
  self._componentIds = params and params.component_ids or {}
  self._campaignId = params and params.campaign_id
end

function UIActivityDataLoader_Campaign:LoadData(TT, res)
  self._campaign = UIActivityCampaign:New()
  if not self._campaignId then
    self._campaign:LoadCampaignInfo(TT, res, self._campaignType, table.unpack(self._componentIds))
  else
    self._campaign:LoadCampaignInfo_Id(TT, res, self._campaignId, table.unpack(self._componentIds))
  end
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
  end
  return self._campaign
end
