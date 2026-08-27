local UINWinter23TechSpSidePageItem = class("UINWinter23TechSpSidePageItem", UIBaseNode)

function UINWinter23TechSpSidePageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickPageItem)
end

function UINWinter23TechSpSidePageItem:InitWinter23TechSpSidePageItem(index, callback)
  self.ui.tex_Text:SetIndex(index - 1)
  self._callback = callback
  self._index = index
end

function UINWinter23TechSpSidePageItem:SetWinter23TechSpSidePageSelect(index)
  local flag = self._index == index
  self.ui.Bottom1:SetActive(flag)
  self.ui.Bottom2:SetActive(not flag)
  self.ui.obj_Selected:SetActive(flag)
  self.ui.tex_Text.text.color = flag and Color.white or self.ui.color_unSelect
end

function UINWinter23TechSpSidePageItem:OnClickPageItem()
  if self._callback then
    self._callback(self._index)
  end
end

return UINWinter23TechSpSidePageItem
