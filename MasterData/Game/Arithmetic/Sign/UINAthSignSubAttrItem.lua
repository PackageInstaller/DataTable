local UINAthSignSubAttrItem = class("UINAthSignSubAttrItem", UIBaseNode)
local base = UIBaseNode

function UINAthSignSubAttrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
end

function UINAthSignSubAttrItem:InitAthSignDetailAttr(index, attrId, attrValue, color, lock, lockFunc)
  self.index = index
  self.lockFunc = lockFunc
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  self.ui.tex_AttriNum.text = "+" .. valueStr
  self.ui.tex_Name.text = name
  self.ui.img_Icon.color = color
  self.ui.tex_AttriNum.color = color
  self.ui.tex_Name.color = color
  self:SetAthSignSubAttrLock(lock)
end

function UINAthSignSubAttrItem:SetAthSignSubAttrLock(lock)
  self.ui.img_LinkIcon:SetIndex(lock and 0 or 1)
  self.ui.img_bg:SetIndex(lock and 0 or 1)
end

function UINAthSignSubAttrItem:_OnClickRoot()
  if self.lockFunc ~= nil then
    self.lockFunc(self.index)
  end
end

function UINAthSignSubAttrItem:OnDelete()
  base.OnDelete(self)
end

return UINAthSignSubAttrItem
