local UINFmtRankPreviewItem = class("UINFmtRankPreviewItem", UIBaseNode)
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINFmtRankPreviewItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroItem = UINHeroHeadItem:New()
  self.heroItem:Init(self.ui.heroHeadItem)
end

function UINFmtRankPreviewItem:InitFmtRankPreviewItem(index, passStat)
  self.ui.tex_Rank.text = tostring(index)
  self.ui.tex_UseTimes:SetIndex(0, tostring(passStat.cnt))
  if passStat.rate == 0 then
    self.ui.tex_Rate.text = "0%"
  else
    self.ui.tex_Rate.text = string.format("%.1f%%", math.max(passStat.rate / 100, 0.1))
  end
  local heroId = passStat.heroId
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(heroId))
    return
  end
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self.heroItem:InitHeroHeadItemWithId(heroId, nil)
end

return UINFmtRankPreviewItem
