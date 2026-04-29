_class("UIN13MainLobbyEntry", UICustomWidget)
UIN13MainLobbyEntry = UIN13MainLobbyEntry

function UIN13MainLobbyEntry:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN13MainLobbyEntry:OnShow(uiParams)
  self:_GetComponent()
  self:_OnShow()
end

function UIN13MainLobbyEntry:_GetComponent()
  self._redPoint = self:GetGameObject("_redPoint")
  self._newFlag = self:GetGameObject("_newFlag")
end

function UIN13MainLobbyEntry:_OnShow()
  self:StartTask(self._SetState, self)
end

function UIN13MainLobbyEntry:_SetState(TT)
  self:Lock("UIN13MainLobbyEntry")
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N13)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res:GetSucc() then
    local process = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N13)
    local showNew = process:GetStepStatusNew()
    local showredPoint = process:GetEntryRedDot()
    self._newFlag:SetActive(showNew)
    self._redPoint:SetActive(showredPoint and not showNew)
  end
  self:UnLock("UIN13MainLobbyEntry")
end

function UIN13MainLobbyEntry:EntryBtnOnClick(go)
  self.uiOwner._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self.uiOwner:GetName())
  local rt = self.uiOwner._screenShot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  self:StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    self:SwitchState(UIStateType.UIN13MainController, cache_rt)
  end)
end
