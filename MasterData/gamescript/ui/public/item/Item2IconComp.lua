local Item2IconComp, Super = System.NewComponent("Item2IconComp", ItemIconCompBase)

function Item2IconComp:ctor(uiNode, dataSourceType, data)
  Super.ctor(self, uiNode, UI_Awaker_Item_Weapon_ArticleResource, dataSourceType, data)
end

function Item2IconComp:OnBind(binder)
  Super.OnBind(self, binder)
  if self.dataSourceType == CommonDefine.ItemDataSourceType.Runtime then
    self.ui.Image_Tick:SetActive(false)
    binder:BindToRaw(function(_, locked)
      self.ui.Image_Lock:SetActive(locked)
      if self.showCheckMark then
        if self.selected.value and not locked then
          self:CheckStateChanged(true)
        else
          self:CheckStateChanged(false)
        end
      end
    end, function()
      return self.runtimeData.locked
    end)
    binder:BindToRaw(function(_, selected)
      if self.showCheckMark and not self.runtimeData.locked then
        self:CheckStateChanged(selected)
      end
    end, function()
      return self.selected.value
    end)
    binder:BindToVisible(self.ui.Group_Awaker_Head, function()
      return self.runtimeData.awaker ~= nil and 0 ~= self.runtimeData.awaker
    end)
    binder:BindToImage(self.ui.Icon_Awaker, function()
      if self.runtimeData.awaker == nil or 0 == self.runtimeData.awaker then
        return ""
      end
      do return AwakerDataUtils.GetLittleIcon end
      return AwakerDataUtils.GetLittleIcon, self.runtimeData.awaker
    end)
    binder:BindToRaw(function(_, value)
      local groupStarTransform = self.ui.Group_Stars.transform
      local childCount = groupStarTransform.childCount
      for i = 0, childCount - 1 do
        if i < value then
          groupStarTransform:GetChild(i).gameObject:SetActive(true)
        else
          groupStarTransform:GetChild(i).gameObject:SetActive(false)
        end
      end
    end, function()
      return self.runtimeData.level
    end)
  else
    self.ui.Image_Tick:SetActive(false)
    self.ui.Image_Lock:SetActive(false)
    self.ui.Group_Awaker_Head:SetActive(false)
    self.ui.Group_Stars:SetActive(false)
  end
end

function Item2IconComp:CheckStateChanged(checked)
  self.ui.Image_Tick:SetActive(checked)
  if self.checkCallback then
    self.checkCallback(self.dataSourceType, self.data)
  end
end

function Item2IconComp:SetSelectionState(selected)
  Super.SetSelectionState(self, selected)
  if selected and self.showCheckMark and self.runtimeData.locked then
    Alert.Show(10476)
  end
end

function Item2IconComp:SetShowCheckMark(showCheckMark, checkCallback)
  self.showCheckMark = showCheckMark
  self.checkCallback = checkCallback
  if not showCheckMark then
    self.ui.Image_Tick:SetActive(false)
  elseif self.selected.value and not self.runtimeData.locked then
    self:CheckStateChanged(true)
  else
    self:CheckStateChanged(false)
  end
end

function Item2IconComp:BindNumSource(data)
end

return Item2IconComp
