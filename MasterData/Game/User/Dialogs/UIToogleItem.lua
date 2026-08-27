local UIToogleItem = class("UIToogleItem", UIBaseNode)
local base = UIBaseNode

function UIToogleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_SwitchItem, self, self.OnSwitchValueChange)
end

function UIToogleItem:InitData(clickFun)
  self.changeValueFunc = clickFun
end

function UIToogleItem:SelectActivityTag()
  if self.ui.tog_SwitchItem.isOn then
    self:OnSwitchValueChange(true)
  else
    self.ui.tog_SwitchItem.isOn = true
  end
end

function UIToogleItem:OnSwitchValueChange(flag)
  if flag then
    self.ui.tog_Txt.color = self.ui.color_Txtselected
    self.ui.tog_Icon.color = self.ui.color_IconSelected
  else
    self.ui.tog_Txt.color = self.ui.color_TxtUnselect
    self.ui.tog_Icon.color = self.ui.color_IconUnselect
  end
  if self.changeValueFunc ~= nil then
    self.changeValueFunc(self, flag)
  end
end

function UIToogleItem:OnDelete()
  base.OnDelete(self)
end

return UIToogleItem
