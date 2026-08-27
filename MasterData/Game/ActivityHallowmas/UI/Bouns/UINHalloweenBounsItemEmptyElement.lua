local UINHalloweenBounsItemEmptyElement = class("UINHalloweenBounsItemEmptyElement", UIBaseNode)
local base = UIBaseNode

function UINHalloweenBounsItemEmptyElement:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHalloweenBounsItemEmptyElement:BindHalloweenBounsItemClass(itemClass, cycleClass)
  self._itemClass = itemClass
  self._cycleClass = cycleClass
end

function UINHalloweenBounsItemEmptyElement:InitBounsItem(hallowmasData, level, rewardFunc)
  if self._cycleItem ~= nil then
    self._cycleItem:Hide()
  end
  if self._item == nil then
    local go = self.ui.item:Instantiate(self.transform)
    go:SetActive(true)
    self._item = self._itemClass.New()
    self._item:Init(go)
    self:__SetBounsItemExtra()
  else
    self._item:Show()
  end
  self._item:InitBounsItem(hallowmasData, level, rewardFunc)
  self._item.transform.anchoredPosition = Vector2.zero
  self.transform.sizeDelta = self._item.transform.rect.size
  self.ui.layoutElement.preferredHeight = self.transform.sizeDelta.y
  self.ui.layoutElement.preferredWidth = self.transform.sizeDelta.x
end

function UINHalloweenBounsItemEmptyElement:__SetBounsItemExtra()
end

function UINHalloweenBounsItemEmptyElement:InitBounsCycleItem(hallowmasData, rewardFunc)
  if self._item ~= nil then
    self._item:Hide()
  end
  if self._cycleItem == nil then
    local go = self.ui.finalItem:Instantiate(self.transform)
    go:SetActive(true)
    self._cycleItem = self._cycleClass.New()
    self._cycleItem:Init(go)
  else
    self._cycleItem:Show()
  end
  self._cycleItem:InitBounsCycleItem(hallowmasData, rewardFunc)
  self._cycleItem.transform.anchoredPosition = Vector2.zero
  self.transform.sizeDelta = self._cycleItem.transform.rect.size
  self.ui.layoutElement.preferredHeight = self.transform.sizeDelta.y
  self.ui.layoutElement.preferredWidth = self.transform.sizeDelta.x
end

function UINHalloweenBounsItemEmptyElement:RefreshBounsElement()
  if self._item ~= nil and self._item.active then
    self._item:RefreshBounsItem()
  elseif self._cycleItem ~= nil and self._cycleItem.active then
    self._cycleItem:RefreshBounsCycleItem()
  end
end

return UINHalloweenBounsItemEmptyElement
