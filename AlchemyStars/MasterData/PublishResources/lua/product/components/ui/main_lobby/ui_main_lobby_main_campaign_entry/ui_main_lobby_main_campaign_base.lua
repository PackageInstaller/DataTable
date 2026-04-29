_class("UIMainLobbyMainCampaignBase", UICustomWidget)
UIMainLobbyMainCampaignBase = UIMainLobbyMainCampaignBase

function UIMainLobbyMainCampaignBase:Constructor()
end

function UIMainLobbyMainCampaignBase:SetData(sampleInfo, ctl)
  self:GetComponent()
  self.sampleInfo = sampleInfo
  self:RefreshView()
end

function UIMainLobbyMainCampaignBase:RefreshView()
end

function UIMainLobbyMainCampaignBase:BtnOnClick()
  local campid = self.sampleInfo.id
  Log.debug("###[UIMainLobbyMainCampaignBase] TowerPointReq campid:", campid)
end
