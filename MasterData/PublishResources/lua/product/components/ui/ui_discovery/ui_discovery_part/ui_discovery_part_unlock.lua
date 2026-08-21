_class("UIDiscoveryPartUnlock", UIController)
UIDiscoveryPartUnlock = UIDiscoveryPartUnlock

function UIDiscoveryPartUnlock:Constructor()
  self.module = self:GetModule(MissionModule)
  self.data = self.module:GetDiscoveryData()
end

function UIDiscoveryPartUnlock:OnShow(uiParams)
  local sectionId = uiParams[1]
  local section = self.data:GetDiscoverySectionBySectionId(sectionId)
  self.txtHint = self:GetUIComponent("UILocalizationText", "txtHint")
  self.txtHint:SetText(StringTable.Get("str_discovery_section_unlock", section.index_name))
end

function UIDiscoveryPartUnlock:OnHide()
end

function UIDiscoveryPartUnlock:BgOnClick(go)
  self:CloseDialog()
end
