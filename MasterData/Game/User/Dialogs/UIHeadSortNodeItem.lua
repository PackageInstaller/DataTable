local UIHeadSortNodeItem = class("UIHeadSortNodeItem", UIBaseNode)
local base = UIBaseNode

function UIHeadSortNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_SortItem, self, self.OnSwitchValueChange)
  self.portrait_types = ConfigData.portrait.types
  self.portrait_frame_types = ConfigData.portrait_frame.types
end

function UIHeadSortNodeItem:InitNodeItem(name, id)
  self.ui.img_IsSelect:SetActive(false)
end

function UIHeadSortNodeItem:InitNodeItemCId(id, isHead)
  self.isHead = isHead
  if isHead then
    self.ui.tex_Types.text = LanguageUtil.GetLocaleText(self.portrait_types[id])
    self.typeId = id
    self.ui.img_IsSelect:SetActive(false)
  else
    self.ui.tex_Types.text = LanguageUtil.GetLocaleText(self.portrait_frame_types[id])
    self.typeId = id
    self.ui.img_IsSelect:SetActive(false)
  end
end

function UIHeadSortNodeItem:SelectActivityTag(typeId)
  if self.typeId == typeId then
    self:OnSwitchValueChange(true)
    self.ui.tog_SortItem.isOn = true
  else
    self:OnSwitchValueChange(false)
    self.ui.tog_SortItem.isOn = false
  end
end

function UIHeadSortNodeItem:OnSwitchValueChange(flag)
  if flag then
    self.ui.img_IsSelect:SetActive(true)
    if self.changeValueFunc ~= nil then
      self.changeValueFunc(self.typeId, self.ui.tex_Types.text)
    end
  else
    self.ui.img_IsSelect:SetActive(false)
  end
end

function UIHeadSortNodeItem:OnDelte()
  base.OnDelete(self)
end

return UIHeadSortNodeItem
