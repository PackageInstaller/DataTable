_class("UIMainCgDressUpGroupItem", UICustomWidget)
UIMainCgDressUpGroupItem = UIMainCgDressUpGroupItem

function UIMainCgDressUpGroupItem:OnShow(uiParams)
  self:InitWidget()
end

function UIMainCgDressUpGroupItem:InitWidget()
  self.pool = self:GetUIComponent("UISelectObjectPath", "Pool")
end

function UIMainCgDressUpGroupItem:SetData(initIndex, initInfos, setIndexDressCb, toggleOpenCb)
  self.setIndexDressCb = setIndexDressCb
  self.toggleOpenCb = toggleOpenCb
  self.items = self.pool:SpawnObjects("UIMainCgDressUpSingleSelectItem", 5)
  
  function self.selectCb(index)
    for i = 1, #self.items do
      local item = self.items[i]
      item:RefreshSelect(index)
    end
    self.setIndexDressCb(index)
  end
  
  function self.toggleCb(index, isopen)
    local OnCount = 0
    for i = 1, #self.items do
      local item = self.items[i]
      if item.openToggle.isOn then
        OnCount = OnCount + 1
      end
    end
    if OnCount < 1 then
      ToastManager.ShowToast(StringTable.Get("str_assistant_main_cg_dressup_warning_un_open"))
      local item = self.items[index]
      item:SetToggleOpen(true)
      return
    end
    self.toggleOpenCb(index, isopen)
  end
  
  for i = 1, #self.items do
    local item = self.items[i]
    local isopen = initInfos[i].range_select
    item:SetData(i, initIndex, isopen, self.selectCb, self.toggleCb)
  end
end

function UIMainCgDressUpGroupItem:SetToggleOpen(index, isopen)
  local item = self.items[index]
  item:SetToggleOpen(isopen)
end
