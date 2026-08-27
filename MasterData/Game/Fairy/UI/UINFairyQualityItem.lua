local UINFairyQualityItem = class("UINFairyQualityItem", UIBaseNode)
local base = UIBaseNode

function UINFairyQualityItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFairyQualityItem:InitFairyQualityItem(level)
  if level then
    self.ui.img_Quality.gameObject:SetActive(true)
    self.ui.img_Quality:SetIndex(level - 1)
  else
    self.ui.img_Quality.gameObject:SetActive(false)
  end
end

return UINFairyQualityItem
