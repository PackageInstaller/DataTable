local UINSpecWeaponPointItem = class("UINSpecWeaponPointItem", UIBaseNode)
local base = UIBaseNode

function UINSpecWeaponPointItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickPoint)
end

function UINSpecWeaponPointItem:InitSpecWeaponPoint(level, callback)
  self._level = level
  self._callback = callback
end

function UINSpecWeaponPointItem:ForbidSpecWeaponBtn(flag)
  self.ui.btn_root.enabled = flag
end

function UINSpecWeaponPointItem:PlaySpecWeaponPoint()
  self.ui.tween_root:DORewind()
  self.ui.tween_root:DOPlayForward()
end

function UINSpecWeaponPointItem:OnClickPoint()
  if self._callback then
    self._callback(self._level)
  end
end

function UINSpecWeaponPointItem:OnDelete()
  self.ui.tween_root:DOKill()
  base.OnDelete(self)
end

return UINSpecWeaponPointItem
