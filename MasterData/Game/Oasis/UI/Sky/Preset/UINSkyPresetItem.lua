local UINSkyPresetItem = class("UINSkyPresetItem", UIBaseNode)
local base = UIBaseNode

function UINSkyPresetItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Root, self, self._OnTogValueChange)
end

function UINSkyPresetItem:InitSkyPresetItem(index, name, selectFunc)
  if index == 0 then
    self.ui.tex_Name:SetIndex(0)
  else
    self.ui.tex_Name.text.text = name
  end
  self.index = index
  self.selectFunc = selectFunc
end

function UINSkyPresetItem:SetSkyPresetItemTogOn()
  self.ui.tog_Root.isOn = true
end

function UINSkyPresetItem:_OnTogValueChange(isOn)
  self.ui.tex_Name.text.color = isOn and Color.black or Color.white
  if isOn and self.selectFunc ~= nil then
    self.selectFunc(self.index)
  end
end

function UINSkyPresetItem:OnDelete()
  base.OnDelete(self)
end

return UINSkyPresetItem
