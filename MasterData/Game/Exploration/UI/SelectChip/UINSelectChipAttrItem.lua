local UINSelectChipAttrItem = class("UINSelectChipAttrItem", UIBaseNode)

function UINSelectChipAttrItem:OnInit()
  self.ui.tex_AttrName = self.transform:FindComponent("Tex_AttrName", eUnityComponentID.ExText)
  self.ui.tex_Num = self.transform:FindComponent("Tex_Num", eUnityComponentID.ExText)
end

function UINSelectChipAttrItem:InitChipAttrItem(attrId, initValue, increaseValue, count)
  local attibuteCfg = ConfigData.attribute[attrId]
  if attibuteCfg == nil then
    error("Can't find attibuteCfg, id = " .. tostring(attrId))
    return
  end
  count = count or 1
  local atrName = LanguageUtil.GetLocaleText(attibuteCfg.name)
  local isRatio = attibuteCfg.num_type == 2
  local value = initValue + (increaseValue or 0) * (count - 1)
  local valueStr = isRatio and tostring(FormatNum(value / 10)) .. "%" or tostring(value)
  local sign
  if value < 0 then
    sign = ""
  else
    sign = "+"
  end
  self.ui.tex_AttrName.text = atrName
  self.ui.tex_Num.text = sign .. valueStr
end

return UINSelectChipAttrItem
