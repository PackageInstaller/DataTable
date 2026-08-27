local UINChipTagItem = class("UINChipTagItem", UIBaseNode)

function UINChipTagItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINChipTagItem:InitChipTag(tagId)
  local chipTagCfg = ConfigData.chip_tag[tagId]
  if chipTagCfg == nil then
    error("chip tag cfg is null,id:" .. tostring(tagId))
  end
  local name = LanguageUtil.GetLocaleText(chipTagCfg.tag_name)
  self.ui.tex_Tag.text = name
  self.ui.eff_Tag:SetActive(false)
end

function UINChipTagItem:InitChipTagAndSuit(tagId, haveCount, maxCount, owner)
  local chipTagCfg = ConfigData.chip_tag[tagId]
  if chipTagCfg == nil then
    error("chip tag cfg is null,id:" .. tostring(tagId))
  end
  local name = LanguageUtil.GetLocaleText(chipTagCfg.tag_name)
  local countStr = string.format("(%d/%d)", haveCount, maxCount)
  self.ui.tex_Tag.text = name .. countStr
  if not owner and 0 < haveCount then
    self.ui.eff_Tag:SetActive(true)
  else
    self.ui.eff_Tag:SetActive(false)
  end
end

function UINChipTagItem:SetChipTagColor(color)
  self.ui.img_Tag.color = color
end

return UINChipTagItem
