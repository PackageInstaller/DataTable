require("ui_main_lobby_extra_base")
_class("UIMainLobbySeniorSkinPLMReview", UIMainLobbyExtraBase)
UIMainLobbySeniorSkinPLMReview = UIMainLobbySeniorSkinPLMReview

function UIMainLobbySeniorSkinPLMReview:OnShow()
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:AttachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinPLMReview:OnHide()
  self:DetachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinPLMReview:RefreshView()
  self:SetRed()
end

function UIMainLobbySeniorSkinPLMReview:BtnOnClick(go)
  if self:CheckCampaignOpen() then
    self:ShowDialog("UIHauteCoutureDrawV2ReviewController")
  end
end

function UIMainLobbySeniorSkinPLMReview:SetRed()
  local redGo = self:GetGameObject("redGo")
  local red = self._sample_info and self._sample_info:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_RAFFLE)
  redGo:SetActive(red)
end
