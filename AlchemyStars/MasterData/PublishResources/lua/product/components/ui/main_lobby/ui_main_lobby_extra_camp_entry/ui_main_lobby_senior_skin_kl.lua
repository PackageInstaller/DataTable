require("ui_main_lobby_extra_base")
_class("UIMainLobbySeniorSkinKL", UIMainLobbyExtraBase)
UIMainLobbySeniorSkinKL = UIMainLobbySeniorSkinKL

function UIMainLobbySeniorSkinKL:OnShow()
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:AttachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinKL:OnHide()
  self:DetachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinKL:RefreshView()
  self:SetRed()
end

function UIMainLobbySeniorSkinKL:BtnOnClick(go)
  if self:CheckCampaignOpen() then
    self:ShowDialog("UIHauteCoutureDrawController")
  end
end

function UIMainLobbySeniorSkinKL:SetRed()
  local redGo = self:GetGameObject("redGo")
  local red = self._sample_info and self._sample_info:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_RAFFLE)
  redGo:SetActive(red)
end
