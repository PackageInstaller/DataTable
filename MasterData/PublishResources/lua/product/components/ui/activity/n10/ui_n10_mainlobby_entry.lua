_class("UIN10MainLobbyEntry", UICustomWidget)
UIN10MainLobbyEntry = UIN10MainLobbyEntry

function UIN10MainLobbyEntry:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN10MainLobbyEntry:OnShow(uiParams)
  self:_GetComponents()
  self:StartTask(self.RequestData, self)
end

function UIN10MainLobbyEntry:_GetComponents()
  self._redPoint = self:GetGameObject("RedPoint")
  self._newFlag = self:GetGameObject("NewFlag")
end

function UIN10MainLobbyEntry:RequestData(TT)
  self:Lock("UIN10MainLobbyEntry")
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N10, ECampaignN10ComponentID.ECAMPAIGN_N10_STORY, ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY, ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM, ECampaignN10ComponentID.ECAMPAIGN_N10_CUMULATIVE_LOGIN)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res:GetSucc() then
    local process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N10)
    local showNew = process:HaveNewFlag()
    local showredPoint = process:HaveRedPoint()
    self._newFlag:SetActive(showNew)
    self._redPoint:SetActive(showredPoint and not showNew)
  end
  self:UnLock("UIN10MainLobbyEntry")
end

function UIN10MainLobbyEntry:EntryBtnOnClick(go)
  self:SwitchState(UIStateType.UIN10MainController)
end
