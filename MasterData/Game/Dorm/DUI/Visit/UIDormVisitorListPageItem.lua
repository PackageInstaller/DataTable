local UIDormVisitorListPageItem = class("UIDormVisitorListPageItem", UIBaseNode)
local base = UIBaseNode

function UIDormVisitorListPageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.pageItem, self, self.OnClickPage)
end

function UIDormVisitorListPageItem:InitUIDormVisitorListPageItem(pageId, pageName, callback)
  self._pageId = pageId
  self.ui.tex_PageName.text = LanguageUtil.GetLocaleText(pageName)
  self.ui.img_Icon:SetIndex(pageId - 1)
  self._callback = callback
end

function UIDormVisitorListPageItem:RefreshPageState(pageId)
  local flag = self._pageId == pageId
  self.ui.selected:SetActive(flag)
  if flag then
    self.ui.tex_PageName.color = self.ui.color_tex_selected
  else
    self.ui.tex_PageName.color = self.ui.color_tex_unselect
  end
end

function UIDormVisitorListPageItem:OnClickPage()
  if self._callback ~= nil then
    self._callback(self._pageId, self)
  end
end

function UIDormVisitorListPageItem:OnDelete()
  base.OnDelete(self)
end

return UIDormVisitorListPageItem
