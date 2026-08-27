local UINStarUpAttrItem = class("UINStarUpAttrItem", UIBaseNode)
local base = UIBaseNode

function UINStarUpAttrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINStarUpAttrItem:InitAttrItem(value, newValue, attrId)
  local attrCfg = ConfigData.attribute[attrId]
  if attrCfg == nil then
    error("can't read attrCfg with id=" .. attrId)
    return
  end
  self.ui.tex_attrName.text = LanguageUtil.GetLocaleText(attrCfg.name)
  self.ui.img_Icon.sprite = CRH:GetSprite(attrCfg.icon)
  if attrCfg.num_type == 1 then
    if newValue ~= nil then
      self.ui.tex_Num:SetIndex(0, tostring(value), tostring(newValue))
    else
      self.ui.tex_Num:SetIndex(1, tostring(value))
    end
  elseif attrCfg.num_type == 2 then
    if newValue ~= nil then
      self.ui.tex_Num:SetIndex(0, tostring(FormatNum(value / 10)) .. "%", tostring(FormatNum(newValue / 10)) .. "%")
    else
      self.ui.tex_Num:SetIndex(1, tostring(FormatNum(value / 10)) .. "%")
    end
  end
end

function UINStarUpAttrItem:OnDelete()
  base.OnDelete(self)
end

return UINStarUpAttrItem
