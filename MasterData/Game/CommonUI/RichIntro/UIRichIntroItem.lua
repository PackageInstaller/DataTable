local UIRichIntroItem = class("UIRichIntroItem", UIBaseNode)
local base = UIBaseNode

function UIRichIntroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIRichIntroItem:InitRichIntroItem(richIntroCfg)
  if richIntroCfg.icon ~= nil and not string.IsNullOrEmpty(richIntroCfg.icon) then
    self.ui.img_icon.sprite = CRH:GetSprite(richIntroCfg.icon, CommonAtlasType.ExplorationIcon)
    self.ui.img_icon.gameObject:SetActive(true)
  else
    self.ui.img_icon.gameObject:SetActive(false)
  end
  self.ui.tex_name.text = LanguageUtil.GetLocaleText(richIntroCfg.name)
  self.ui.tex_describe.text = LanguageUtil.GetLocaleText(richIntroCfg.describe)
  local setColor = self.ui.colorList[richIntroCfg.icon_color]
  if setColor ~= nil then
    self.ui.col_title.color = setColor
  end
end

function UIRichIntroItem:OnDelete()
  base.OnDelete(self)
end

return UIRichIntroItem
