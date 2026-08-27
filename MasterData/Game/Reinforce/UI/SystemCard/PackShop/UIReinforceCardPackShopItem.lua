local base = UIBaseNode
local UIReinforceCardPackShopItem = class("UIReinforceCardPackShopItem", base)
local cs_MessageCommon = CS.MessageCommon

function UIReinforceCardPackShopItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.Item, self, self._OnClick)
  self._toggleGroup = self.ui.Item.group
end

function UIReinforceCardPackShopItem:InitReinforceCardPackShopItem(themeId, name, rate, isLocked, clickFunc)
  self.themeId = themeId
  self.isLocked = isLocked
  self._clickFunc = clickFunc
  self:RefreshName(name)
  self:RefreshCollectionRate(isLocked, rate)
  self:RefreshLocked(isLocked)
end

function UIReinforceCardPackShopItem:RefreshName(name)
  self.ui.tex_PackageName.text = name
end

function UIReinforceCardPackShopItem:RefreshCollectionRate(isLocked, rate)
  if isLocked then
    self.ui.tex_Collected:SetIndex(1)
  else
    self.ui.tex_Collected:SetIndex(0, string.format("%.1f", rate * 100))
  end
end

function UIReinforceCardPackShopItem:RefreshLocked(isLocked)
  self.ui.obj_Lock:SetActive(isLocked)
  if isLocked then
    self.ui.Item.group = nil
  else
    self.ui.Item.group = self._toggleGroup
  end
  self.ui.Item.graphic.gameObject:SetActive(not isLocked)
end

function UIReinforceCardPackShopItem:SetComRankPageItemIsOn()
  self.ui.Item.isOn = true
  self:_OnClick(true)
end

function UIReinforceCardPackShopItem:_OnClick(isOn)
  if isOn and self.isLocked then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(59013))
    return
  end
  self.transform.localScale = isOn and Vector3.one * 1.2 or Vector3.one
  if self._clickFunc ~= nil and isOn then
    self._clickFunc(self.themeId)
  end
end

function UIReinforceCardPackShopItem:OnDelete()
  base.OnDelete(self)
end

return UIReinforceCardPackShopItem
