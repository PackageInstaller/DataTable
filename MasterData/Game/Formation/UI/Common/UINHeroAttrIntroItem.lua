local UINHeroAttrIntroItem = class("UINHeroAttrItem", UIBaseNode)
local base = UIBaseNode

function UINHeroAttrIntroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.gameObject, self.ui)
end

function UINHeroAttrIntroItem:ShowAttrPopIntro(attrId, iconSprite)
  if iconSprite ~= nil then
    self.ui.img_icon.sprite = iconSprite
  end
  local cfg = ConfigData.attribute[attrId]
  if cfg == nil then
    error("Can't find attribute, id = " .. tostring(attrId))
    return
  end
  if cfg.name ~= nil then
    local name = LanguageUtil.GetLocaleText(cfg.name)
    self.ui.text_title.text = name
  end
  if cfg.attribute_detail ~= nil then
    local introStr = LanguageUtil.GetLocaleText(cfg.attribute_detail)
    self.ui.text_detail.text = introStr
  end
end

function UINHeroAttrIntroItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroAttrIntroItem
