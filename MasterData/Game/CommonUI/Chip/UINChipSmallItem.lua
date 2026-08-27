local base = UIBaseNode
local UINChipSmallItem = class("UINChipSmallItem", base)

function UINChipSmallItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINChipSmallItem:InitChipSmallItem(chipData)
  local color = chipData:GetColor()
  self.ui.img_Quality.color = color
  if chipData:IsConsumeSkillChip() then
    self.ui.img_Icon.sprite = CRH:GetSprite(chipData:GetIcon(), CommonAtlasType.SkillIcon)
  else
    self.ui.img_Icon.sprite = CRH:GetSprite(chipData:GetIcon())
  end
end

return UINChipSmallItem
