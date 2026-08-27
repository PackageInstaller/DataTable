local UINDungeonInfoChipDetailAttr = class("UINDungeonInfoChipDetailAttr", UIBaseNode)
local base = UIBaseNode

function UINDungeonInfoChipDetailAttr:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDungeonInfoChipDetailAttr:InitAttrItem(attrId, value)
  local attrCfg = ConfigData.attribute[attrId]
  if attrCfg == nil or attrCfg.name == nil then
    error("Can't get attr config/name with ID:" .. attrId)
    return
  end
  local name = LanguageUtil.GetLocaleText(attrCfg.name)
  self.ui.tex_Tag.text = name
  local isRatio = attrCfg.num_type == 2
  local valueStr = isRatio and tostring(FormatNum(value / 10)) .. "%" or tostring(value)
  self.ui.tex_Num.text = valueStr
end

function UINDungeonInfoChipDetailAttr:OnDelete()
  base.OnDelete(self)
end

return UINDungeonInfoChipDetailAttr
