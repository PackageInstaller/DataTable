local UINAthRfctSubAttrItem = class("UINAthRfctSubAttrItem", UIBaseNode)
local base = UIBaseNode

function UINAthRfctSubAttrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickLock)
end

function UINAthRfctSubAttrItem:InitAthRfctDetailAttr(index, attrId, attrValue, color, showLock, lock, lockFunc)
  self.index = index
  self.lockFunc = lockFunc
  self.showLock = showLock
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  self.ui.tex_AttriNum.text = "+" .. valueStr
  self.ui.tex_Name.text = name
  self.ui.img_Icon.color = color
  self.ui.tex_AttriNum.color = color
  self.ui.tex_Name.color = color
  self.ui.img_LinkIcon.gameObject:SetActive(self.showLock)
  self:SetAthRfctSubAttrLock(lock)
end

function UINAthRfctSubAttrItem:SetAthRfctSubAttrLock(lock)
  self.ui.img_LinkIcon:SetIndex(lock and 0 or 1)
  self.ui.img_bg:SetIndex(lock and 0 or 1)
end

function UINAthRfctSubAttrItem:_OnClickLock()
  if self.showLock and self.lockFunc ~= nil then
    self.lockFunc(self.index)
  end
end

function UINAthRfctSubAttrItem:OnDelete()
  base.OnDelete(self)
end

return UINAthRfctSubAttrItem
