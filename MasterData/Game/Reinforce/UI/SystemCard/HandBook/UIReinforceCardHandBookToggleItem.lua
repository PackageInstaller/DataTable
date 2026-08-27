local base = UIBaseNode
local UIReinforceCardHandBookToggleItem = class("UIReinforceCardHandBookToggleItem", base)
local cs_MessageCommon = CS.MessageCommon

function UIReinforceCardHandBookToggleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Page, self, self._OnClickTog)
  self._toggleGroup = self.ui.tog_Page.group
end

function UIReinforceCardHandBookToggleItem:InitReinforceCardHandBookToggleItem(index, collectionCfg, isCanBatchUpgrade, clickFunc)
  self.index = index
  self.collectionCfg = collectionCfg
  self._clickFunc = clickFunc
  self.ui.tex_PageName.text = LanguageUtil.GetLocaleText(collectionCfg.theme_name)
  self:RefreshLock(self.collectionCfg.lock)
  self:RefreshRedDot(isCanBatchUpgrade)
  self:_OnClickTog(false)
end

function UIReinforceCardHandBookToggleItem:SetComRankPageItemIsOn()
  self.ui.tog_Page.isOn = true
  self:_OnClickTog(true)
end

function UIReinforceCardHandBookToggleItem:RefreshLock(isLock)
  self.ui.obj_Lock:SetActive(isLock)
  self.ui.img_PageBG.gameObject:SetActive(not isLock)
  self.ui.tex_PageName.gameObject:SetActive(not isLock)
  if isLock then
    self.ui.tog_Page.group = nil
  else
    self.ui.tog_Page.group = self._toggleGroup
  end
end

function UIReinforceCardHandBookToggleItem:RefreshRedDot(isCanBatchUpgrade)
  self.ui.redDot:SetActive(isCanBatchUpgrade)
end

function UIReinforceCardHandBookToggleItem:_OnClickTog(isOn)
  if isOn and self.collectionCfg.lock then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(59013))
    return
  end
  self.ui.tex_PageName.color = isOn and self.ui.col_NameSel or self.ui.col_NameUnSel
  self.ui.img_PageBG:SetIndex(isOn and 0 or 1)
  if self._clickFunc ~= nil and isOn then
    self._clickFunc(self.collectionCfg)
  end
end

function UIReinforceCardHandBookToggleItem:OnDelete()
  base.OnDelete(self)
end

return UIReinforceCardHandBookToggleItem
