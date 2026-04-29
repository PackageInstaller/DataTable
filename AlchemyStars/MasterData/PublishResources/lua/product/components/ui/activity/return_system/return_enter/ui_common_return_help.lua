_class("UICommonReturnHelp", UICustomWidget)
UICommonReturnHelp = UICommonReturnHelp

function UICommonReturnHelp:Constructor()
end

function UICommonReturnHelp:OnShow(uiParams)
end

function UICommonReturnHelp:SetData(left)
  self._go = self:GetGameObject("rect")
  if self:ReturnHelpOpen() then
    self._go:SetActive(true)
    local layoutGroup = self:GetUIComponent("RectTransform", "layoutGroup")
    if left then
      layoutGroup.pivot = Vector2(0, 0.5)
      layoutGroup.anchoredPosition = Vector2(-142, 0)
    else
      layoutGroup.pivot = Vector2(1, 0.5)
      layoutGroup.anchoredPosition = Vector2(142, 0)
    end
  else
    self._go:SetActive(false)
  end
end

function UICommonReturnHelp:ReturnHelpOpen()
  local campaignType = UIActivityReturnSystemHelper.GetCampaignType()
  local campaign = UIActivityHelper.LoadCampaign_Local(campaignType)
  local isOpen = campaign:CheckCampaignOpen()
  return isOpen
end

function UICommonReturnHelp:OnHide()
end

function UICommonReturnHelp:returnHelpBtnOnClick(go)
  local campaignType = UIActivityReturnSystemHelper.GetCampaignType()
  self:ShowDialog("UISideEnterCenterController", {
    campaign_type = campaignType,
    params = {true},
    single_mode = true
  })
end
