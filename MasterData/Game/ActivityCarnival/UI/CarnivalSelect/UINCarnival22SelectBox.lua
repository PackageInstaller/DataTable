local UINCarnival22SelectBox = class("UINCarnival22SelectBox", UIBaseNode)
local base = UIBaseNode

function UINCarnival22SelectBox:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCarnival22SelectBox:InitSelectBox(content, content2)
  self.ui.tex_Details.text = LanguageUtil.GetLocaleText(content)
  local content2 = LanguageUtil.GetLocaleText(content2)
  if string.IsNullOrEmpty(content2) then
    self.ui.tex_Sub.gameObject:SetActive(false)
  else
    self.ui.tex_Sub.gameObject:SetActive(true)
    self.ui.tex_Sub.text = content2
  end
end

return UINCarnival22SelectBox
