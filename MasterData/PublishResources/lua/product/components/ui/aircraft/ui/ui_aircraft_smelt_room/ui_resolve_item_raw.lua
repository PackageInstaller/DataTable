_class("UIResolveItemRaw", UICustomWidget)
UIResolveItemRaw = UIResolveItemRaw

function UIResolveItemRaw:OnShow(uiParams)
  self:InitWidget()
end

function UIResolveItemRaw:InitWidget()
  self.item1 = self:GetUIComponent("UISelectObjectPath", "item1")
  self.item2 = self:GetUIComponent("UISelectObjectPath", "item2")
  self.item3 = self:GetUIComponent("UISelectObjectPath", "item3")
  self._itemPool = {
    self.item1,
    self.item2,
    self.item3
  }
  self._items = {}
  self:AttachEvent(GameEventType.UIAircraftResolveItemOnclick, self.OnSelectionChanged)
end

function UIResolveItemRaw:SetData(tab2, cfgs, rawIndex, onClick, onLongPress, selections)
  for i = 1, 3 do
    local index = (rawIndex - 1) * 3 + i
    if index <= #cfgs then
      if not self._items[i] then
        self._items[i] = self._itemPool[i]:SpawnObject("UIResolveItem")
      end
      self._items[i]:Active(true)
      self._items[i]:SetData(cfgs[index], index, onClick, onLongPress)
    elseif self._items[i] then
      self._items[i]:Active(false)
    end
  end
  self._tab2 = tab2
  self._rawIdx = rawIndex
  self:OnSelectionChanged(self._tab2, selections)
end

function UIResolveItemRaw:OnSelectionChanged(tab2, selections)
  if self._tab2 ~= tab2 then
    AirLog("tab2严重错误：", tab2)
    return
  end
  if tab2 == ResolveTab2.JuXiang then
    local selected = selections[1]
    for idx, item in ipairs(self._items) do
      local index = (self._rawIdx - 1) * 3 + idx
      item:ShowSelectBox(index == selected)
    end
  elseif tab2 == ResolveTab2.XinPo then
    for idx, item in ipairs(self._items) do
      local index = (self._rawIdx - 1) * 3 + idx
      item:ShowSelector(table.icontains(selections, index))
    end
  end
end
