_class("UIMainCgDressUpSingleSelectItem", UICustomWidget)
UIMainCgDressUpSingleSelectItem = UIMainCgDressUpSingleSelectItem

function UIMainCgDressUpSingleSelectItem:OnShow(uiParams)
  self:InitWidget()
end

function UIMainCgDressUpSingleSelectItem:InitWidget()
  self.selectBG = self:GetUIComponent("Image", "SelectBG")
  self.title = self:GetUIComponent("UILocalizationText", "Title")
  self.openToggle = self:GetUIComponent("Toggle", "OpenToggle")
end

function UIMainCgDressUpSingleSelectItem:SetData(index, curSelectIndex, isopen, selectDressCb, toggleCb)
  self.title:SetText(StringTable.Get("str_assistant_main_cg_dressup_single_name_" .. index))
  self.index = index
  self.selectDressCb = selectDressCb
  self.toggleCb = toggleCb
  if curSelectIndex ~= index then
    self.selectBG.gameObject:SetActive(false)
  else
    self.selectBG.gameObject:SetActive(true)
  end
  if isopen == 1 then
    self.openToggle.isOn = true
  else
    self.openToggle.isOn = false
  end
  self.openToggle.onValueChanged:AddListener(function(value)
    if self.toggleCb then
      self.toggleCb(self.index, value)
    end
  end)
end

function UIMainCgDressUpSingleSelectItem:RefreshSelect(selectIndex)
  if selectIndex == self.index then
    self.selectBG.gameObject:SetActive(true)
  else
    self.selectBG.gameObject:SetActive(false)
  end
end

function UIMainCgDressUpSingleSelectItem:SetToggleOpen(isopen)
  self.openToggle.isOn = isopen
end

function UIMainCgDressUpSingleSelectItem:selectTogOnClick(go)
end

function UIMainCgDressUpSingleSelectItem:SelectBtnOnClick(go)
  if self.selectDressCb then
    self.selectDressCb(self.index)
  end
end
