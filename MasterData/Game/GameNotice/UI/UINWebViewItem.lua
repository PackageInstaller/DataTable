local UINWebViewItem = class("UINWebViewItem", UIBaseNode)
local base = UIBaseNode

function UINWebViewItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWebViewItem:LoadWebViewByUrl(url, hasFade)
  self:Hide()
  if url == nil then
    return
  end
  self:Show()
  self.ui.uniWebView.ReferenceRectTransform = self.transform
  self.ui.uniWebView:SetZoomEnabled(false)
  self.ui.uniWebView:SetBackButtonEnabled(false)
  self.ui.uniWebView:Load(url)
  self.ui.uniWebView:Show(hasFade)
end

function UINWebViewItem:ClearCache()
  self.ui.uniWebView:CleanCache()
end

function UINWebViewItem:OnDelete()
  base.OnDelete(self)
end

return UINWebViewItem
