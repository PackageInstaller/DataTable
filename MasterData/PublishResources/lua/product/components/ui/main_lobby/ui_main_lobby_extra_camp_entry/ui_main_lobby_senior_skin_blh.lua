require("ui_main_lobby_extra_base")
_class("UIMainLobbySeniorSkinBLH", UIMainLobbyExtraBase)
UIMainLobbySeniorSkinBLH = UIMainLobbySeniorSkinBLH

function UIMainLobbySeniorSkinBLH:OnShow()
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:AttachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinBLH:OnHide()
  self:DetachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinBLH:RefreshView()
  self:SetRed()
end

function UIMainLobbySeniorSkinBLH:BtnOnClick(go)
  if self:CheckCampaignOpen() then
    self:ShowDialog("UIHauteCoutureDrawV2ReviewController")
  end
end

function UIMainLobbySeniorSkinBLH:SetRed()
  local redGo = self:GetGameObject("redGo")
  local red = self._sample_info and self._sample_info:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_RAFFLE)
  redGo:SetActive(red)
end
