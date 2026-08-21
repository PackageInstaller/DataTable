_class("UIFeatureScanTrapElement", UICustomWidget)
UIFeatureScanTrapElement = UIFeatureScanTrapElement

function UIFeatureScanTrapElement:OnShow(uiParams)
  self:InitWidget()
end

function UIFeatureScanTrapElement:InitWidget()
  self.enableFakeInput = true
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.selected = self:GetGameObject("selected")
  self.selected:SetActive(false)
end

function UIFeatureScanTrapElement:SetData(index, id, selected, replaceIcon)
  self._dataIndex = index
  self._dataTrapID = id
  local cfgTrapScan = Cfg.cfg_trap_scan[id]
  local iconPath = cfgTrapScan.Icon
  local petID = cfgTrapScan.PetID
  if petID then
    local matchPet = InnerGameHelperRender.GetLocalMatchPetByTemplateID(petID)
    if matchPet then
      iconPath = matchPet:GetPetHead(PetSkinEffectPath.HEAD_ICON_CHAIN_SKILL_PREVIEW)
    end
  end
  self.icon:LoadImage(iconPath)
  self.selected:SetActive(selected)
end

function UIFeatureScanTrapElement:AutoTestClick(index)
  if self._dataIndex == index then
    self:UIFeatureScanTrapElementOnClick(nil)
  end
end

function UIFeatureScanTrapElement:UIFeatureScanTrapElementOnClick(go)
  self._callback(self._dataIndex)
end

function UIFeatureScanTrapElement:SetElementSelectedCallback(cb)
  self._callback = cb
end

function UIFeatureScanTrapElement:SetSelected(b)
  self.selected:SetActive(b)
end
