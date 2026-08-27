local UINDungeonInfoHeroDetailAttr = class("UINDungeonInfoHeroDetailAttr", UIBaseNode)
local base = UIBaseNode

function UINDungeonInfoHeroDetailAttr:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDungeonInfoHeroDetailAttr:InitAttr(attrId, attrVal, attrOriginVal)
  local attrCfg = ConfigData.attribute[attrId]
  if attrCfg == nil then
    error("can't read attrCfg with ID:" .. attrId)
    return
  end
  self.ui.tex_attrName.text = LanguageUtil.GetLocaleText(attrCfg.name)
  self.ui.img_Icon.sprite = CRH:GetSprite(attrCfg.icon)
  if attrCfg.num_type == 2 then
    self.ui.tex_Num.text = tostring(attrVal / 10) .. "%"
  else
    self.ui.tex_Num.text = tostring(attrVal)
  end
  self.ui.tex_Add.gameObject:SetActive(false)
  if attrVal == attrOriginVal then
    self.ui.tex_Add.gameObject:SetActive(false)
  else
    local marker = "+"
    if attrVal - attrOriginVal < 0 then
      marker = ""
    end
    if attrCfg.num_type == 2 then
      self.ui.tex_Add:SetIndex(1, tostring(marker .. (attrVal - attrOriginVal) / 10) .. "%")
    else
      self.ui.tex_Add:SetIndex(1, tostring(marker .. attrVal - attrOriginVal))
    end
    self.ui.tex_Add.gameObject:SetActive(true)
  end
end

function UINDungeonInfoHeroDetailAttr:OnDelete()
  base.OnDelete(self)
end

return UINDungeonInfoHeroDetailAttr
