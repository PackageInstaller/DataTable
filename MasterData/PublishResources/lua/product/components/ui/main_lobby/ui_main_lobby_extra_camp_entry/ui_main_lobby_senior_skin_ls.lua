require("ui_main_lobby_extra_base")
_class("UIMainLobbySeniorSkinLS", UIMainLobbyExtraBase)
UIMainLobbySeniorSkinLS = UIMainLobbySeniorSkinLS

function UIMainLobbySeniorSkinLS:OnShow()
  self._costItemID = 7000518
  self._campModule = GameGlobal.GetModule(CampaignModule)
  self:AttachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinLS:OnHide()
  self:DetachEvent(GameEventType.RefreshSeniorSkinRedPoint, self.RefreshSampleData)
end

function UIMainLobbySeniorSkinLS:RefreshView()
  self:SetRed()
end

function UIMainLobbySeniorSkinLS:BtnOnClick(go)
  if self:CheckCampaignOpen() then
    self:ShowDialog("UISimpleHauteCoutureMainController")
  end
end

function UIMainLobbySeniorSkinLS:SetRed()
  local redGo = self:GetGameObject("redGo")
  local red = self._sample_info and self._sample_info:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
  local itemModule = GameGlobal.GetModule(ItemModule)
  red = red or itemModule:GetItemCount(self._costItemID) > 0
  redGo:SetActive(red)
end
