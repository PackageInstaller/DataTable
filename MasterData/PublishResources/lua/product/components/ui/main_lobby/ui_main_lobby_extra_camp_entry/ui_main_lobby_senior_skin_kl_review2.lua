require("ui_main_lobby_extra_base")
_class("UIMainLobbySeniorSkinKLReview2", UIMainLobbyExtraBase)
UIMainLobbySeniorSkinKLReview2 = UIMainLobbySeniorSkinKLReview2

function UIMainLobbySeniorSkinKLReview2:OnShow()
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:AttachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinKLReview2:OnHide()
  self:DetachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinKLReview2:RefreshView()
  self:SetRed()
end

function UIMainLobbySeniorSkinKLReview2:BtnOnClick(go)
  if self:CheckCampaignOpen() then
    self:ShowDialog("UIHauteCoutureDrawControllerKLReview2")
  end
end

function UIMainLobbySeniorSkinKLReview2:SetRed()
  local redGo = self:GetGameObject("redGo")
  local red = self._sample_info and self._sample_info:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_RAFFLE)
  redGo:SetActive(red)
end
