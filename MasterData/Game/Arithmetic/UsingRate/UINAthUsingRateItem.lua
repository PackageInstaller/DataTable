local base = UIBaseNode
local UINAthUsingRateItem = class("UINAthUsingRateItem", base)

function UINAthUsingRateItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAthUsingRateItem:InitAthUsingRateItem(statEelem)
  local cfg = ConfigData.attribute[statEelem.id]
  if cfg == nil then
    error("Can't find attribute, id = " .. tostring(statEelem.id))
    return
  end
  local name = LanguageUtil.GetLocaleText(cfg.name)
  if cfg.num_type ~= 1 then
    name = name .. "%"
  end
  self.ui.Tex_Name.text = name
  self.ui.Tex_Rate:SetIndex(0, GetPreciseDecimalStr(statEelem.ratio // 100, 2))
end

function UINAthUsingRateItem:OnDelete()
  base.OnDelete(self)
end

return UINAthUsingRateItem
