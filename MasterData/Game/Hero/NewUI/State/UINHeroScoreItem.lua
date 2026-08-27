local UINHeroScoreItem = class("UINHeroScoreItem", UIBaseNode)
local base = UIBaseNode

function UINHeroScoreItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHeroScoreItem:initScoreItem(cfg, growthNum, newGrowthNum)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(cfg.attribute_name)
  self.ui.img_Rate.fillAmount = growthNum / cfg.upper_limit
  if newGrowthNum ~= nil then
    self.ui.img_RateUpgrade.fillAmount = growthNum / cfg.upper_limit
  end
  for index, value in ipairs(cfg.score) do
    if newGrowthNum ~= nil and value <= newGrowthNum or value <= growthNum then
      self.ui.tex_Grade:SetIndex(index)
      break
    end
  end
end

function UINHeroScoreItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroScoreItem
