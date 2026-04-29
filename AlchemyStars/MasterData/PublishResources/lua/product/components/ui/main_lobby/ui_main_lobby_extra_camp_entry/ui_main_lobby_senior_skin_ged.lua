require("ui_main_lobby_extra_base")
_class("UIMainLobbySeniorSkinGED", UIMainLobbyExtraBase)
UIMainLobbySeniorSkinGED = UIMainLobbySeniorSkinGED

function UIMainLobbySeniorSkinGED:OnShow()
  self._costItemID = 7000512
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:AttachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinGED:OnHide()
  self:DetachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinGED:RefreshView()
  self:SetRed()
end

function UIMainLobbySeniorSkinGED:BtnOnClick(go)
  if self:CheckCampaignOpen() then
    self:ShowDialog("UISimpleHauteCoutureMainController")
  end
end

function UIMainLobbySeniorSkinGED:SetRed()
  local redGo = self:GetGameObject("redGo")
  local red = self._sample_info and self._sample_info:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
  local itemModule = GameGlobal.GetModule(ItemModule)
  red = red or itemModule:GetItemCount(self._costItemID) > 0
  redGo:SetActive(red)
end
