require("ui_main_lobby_extra_base")
_class("UIMainLobbySeniorSkinEntryReviewCommon", UIMainLobbyExtraBase)
UIMainLobbySeniorSkinEntryReviewCommon = UIMainLobbySeniorSkinEntryReviewCommon

function UIMainLobbySeniorSkinEntryReviewCommon:OnShow()
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:AttachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinEntryReviewCommon:OnHide()
  self:DetachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinEntryReviewCommon:RefreshView()
  self:SetRed()
end

function UIMainLobbySeniorSkinEntryReviewCommon:BtnOnClick(go)
  if self:CheckCampaignOpen() then
    self:ShowDialog("UIHauteCoutureDrawV2ReviewController")
  end
end

function UIMainLobbySeniorSkinEntryReviewCommon:SetRed()
  local redGo = self:GetGameObject("redGo")
  local red = self._sample_info and self._sample_info:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_RAFFLE)
  redGo:SetActive(red)
end
