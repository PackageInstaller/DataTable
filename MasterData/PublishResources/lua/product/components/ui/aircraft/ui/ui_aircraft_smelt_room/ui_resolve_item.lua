_class("UIResolveItem", UICustomWidget)
UIResolveItem = UIResolveItem

function UIResolveItem:OnShow(uiParams)
  self:InitWidget()
end

function UIResolveItem:OnHide()
end

function UIResolveItem:InitWidget()
  self.item = self:GetUIComponent("UISelectObjectPath", "item")
  self.selector = self:GetGameObject("selector")
  self._root = self:GetGameObject()
end

function UIResolveItem:SetData(cfg, index, onSelect, onLongPress)
  self._index = index
  self._onSelect = onSelect
  self._onLongPress = onLongPress
  self._itemID = cfg.Input[1][1]
  local module = self:GetModule(ItemModule)
  local itemCfg = Cfg.cfg_item[self._itemID]
  self._itemWidget = self.item:SpawnObject("UIItem")
  self._itemWidget:SetForm(UIItemForm.Base, 0.9)
  self._itemWidget:SetData({
    icon = itemCfg.Icon,
    quality = itemCfg.Color,
    text1 = module:GetItemCount(self._itemID),
    showNumber = true,
    itemId = self._itemID
  })
  self._itemWidget:SetClickCallBack(function()
    onSelect(index)
  end)
  self._itemWidget:SetLongPressCallBack(function()
    onLongPress(self._index, self:GetGameObject())
  end, nil, 1000, nil)
  self._showSelector = nil
  self._showSelectBox = nil
  self:ShowSelector(false)
  self:ShowSelectBox(false)
end

function UIResolveItem:Active(active)
  if self._show == active then
    return
  end
  self._show = active
  self._root:SetActive(active)
end

function UIResolveItem:ShowSelector(show)
  if not self._show or self._showSelector == show then
    return
  end
  self._showSelector = show
  self.selector:SetActive(show)
end

function UIResolveItem:ShowSelectBox(show)
  if not self._show or self._showSelectBox == show then
    return
  end
  self._showSelectBox = show
  self._itemWidget:Select(show, true)
end
