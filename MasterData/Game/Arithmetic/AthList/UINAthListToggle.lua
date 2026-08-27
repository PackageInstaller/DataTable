local UINAthListToggle = class("UINAthListToggle", UIBaseNode)
local base = UIBaseNode

function UINAthListToggle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Root, self, self._OnClickToggle)
end

function UINAthListToggle:InitAthListToggle(selectFunc)
  self.selectFunc = selectFunc
end

function UINAthListToggle:SetAthListTogSelect(select)
  self.ui.tog_Root.isOn = select
end

function UINAthListToggle:_OnClickToggle(isOn)
  self.ui.text.color = isOn and Color.black or Color.white
  if self.selectFunc ~= nil then
    self.selectFunc(isOn)
  end
end

function UINAthListToggle:OnDelete()
  base.OnDelete(self)
end

return UINAthListToggle
