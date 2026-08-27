local UIDormFntItem = class("UIDormFntItem", UIBaseNode)
local base = UIBaseNode

function UIDormFntItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self.OnClickFntRoot)
end

function UIDormFntItem:InitUIFntItem(fntEntity, clickEvent)
  self.fntEntity = fntEntity
  self.fntData = fntEntity.fntData
  self._clickEvent = clickEvent
  self.ui.img_Icon.sprite = CRH:GetSprite(self.fntData:GetFntIcon())
  self.ui.tex_Name.text = self.fntData:GetName()
  self.ui.tex_Type:SetIndex(self.fntData:GetFntType())
end

function UIDormFntItem:OnClickFntRoot()
  if self._clickEvent ~= nil then
    self._clickEvent(self.fntEntity)
  end
end

function UIDormFntItem:OnDelete()
  base.OnDelete(self)
end

return UIDormFntItem
