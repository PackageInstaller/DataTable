local UINLtrOwnedHeroItem = class("UINLtrOwnedHeroItem", UIBaseNode)
local base = UIBaseNode

function UINLtrOwnedHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrOwnedHeroItem:InitLtrOwnedHeroItem(heroId)
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(heroId))
    return
  end
  local resName
  local itemCfg = ConfigData.item[heroCfg.fragment]
  if itemCfg ~= nil then
    resName = itemCfg.icon
    self.ui.img_Pic.sprite = CRH:GetSprite(resName, CommonAtlasType.HeroHeadIcon)
  end
  self.ui.isOwned:SetActive(PlayerDataCenter.heroDic[heroId] ~= nil)
end

function UINLtrOwnedHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINLtrOwnedHeroItem
