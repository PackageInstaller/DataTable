_class("UIN15MainLobbyEntry", UICustomWidget)
UIN15MainLobbyEntry = UIN15MainLobbyEntry

function UIN15MainLobbyEntry:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN15MainLobbyEntry:OnShow(uiParams)
  self:_InitWidget()
  self:_RefView()
end

function UIN15MainLobbyEntry:_InitWidget()
  self._redPoint = self:GetGameObject("_redPoint")
  self._newFlag = self:GetGameObject("_newFlag")
end

function UIN15MainLobbyEntry:_RefView()
  self:StartTask(self._SetState, self)
end

function UIN15MainLobbyEntry:_SetState(TT)
  self:Lock("UIN15MainLobbyEntry")
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N15)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res:GetSucc() then
    local process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N15)
    local showNew = process:GetStepStatusNew()
    local showredPoint = process:GetEntryRedDot()
    self._newFlag:SetActive(showNew)
    self._redPoint:SetActive(showredPoint and not showNew)
  end
  self:UnLock("UIN15MainLobbyEntry")
end

function UIN15MainLobbyEntry:EntryBtnOnClick(go)
  self:SwitchState(UIStateType.UIN15MainController)
end
