local base = UIBaseNode
local UINMlstShetBandListHeroItem = class("UINMlstShetBandListHeroItem", base)

function UINMlstShetBandListHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.startList = {
    self.ui.img_Star
  }
end

function UINMlstShetBandListHeroItem:InitMlstShetBandListHeroItem(heroId)
  local heroData = PlayerDataCenter.heroDic[heroId]
  local hasHero = heroData ~= nil
  if hasHero then
    self:_SetHeroHeadIcon(heroData.heroCfg, heroData.skinId)
    self.ui.tex_Lvl:SetIndex(0, tostring(heroData.level))
    local rare = heroData.rankCfg.rare
    self.ui.img_Quality.color = HeroRareColor[rare]
    self:_UpdStar(math.ceil(heroData.star / 2), heroData:IsHalfStar())
  else
    local heroCfg = ConfigData.hero_data[heroId]
    self:_SetHeroHeadIcon(heroCfg)
    self.ui.img_Quality.color = self.ui.color_notGet
    self:_UpdStar(0, false)
  end
  self.ui.lvlBg:SetActive(hasHero)
  self.ui.obj_LockMask:SetActive(not hasHero)
  self.ui.obj_Notget:SetActive(not hasHero)
end

function UINMlstShetBandListHeroItem:_UpdStar(starCount, isHalfStar)
  for i = 1, #self.startList do
    local starItem = self.startList[i]
    starItem.gameObject:SetActive(true)
    if i < starCount then
      starItem:SetIndex(0)
    elseif i == starCount then
      starItem:SetIndex(isHalfStar and 1 or 0)
    else
      starItem.gameObject:SetActive(false)
    end
  end
  for i = #self.startList + 1, starCount do
    local starItem = self.ui.img_Star:Instantiate()
    table.insert(self.startList, starItem)
    starItem.gameObject:SetActive(true)
    if i < starCount then
      starItem:SetIndex(0)
    else
      starItem:SetIndex(isHalfStar and 1 or 0)
    end
  end
end

function UINMlstShetBandListHeroItem:_SetHeroHeadIcon(heroCfg, skinId)
  local resName
  if (skinId or 0) ~= 0 then
    local skinCfg = ConfigData.skin[skinId]
    if skinCfg ~= nil and not string.IsNullOrEmpty(skinCfg.src_id_icon) then
      resName = skinCfg.src_id_icon
    end
  end
  if string.IsNullOrEmpty(resName) and heroCfg.fragment ~= nil then
    local itemCfg = ConfigData.item[heroCfg.fragment]
    if itemCfg ~= nil then
      resName = itemCfg.icon
    end
  end
  if string.IsNullOrEmpty(resName) ~= nil then
    self.ui.img_HeroPic.sprite = CRH:GetSprite(resName, CommonAtlasType.HeroHeadIcon)
  end
end

function UINMlstShetBandListHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINMlstShetBandListHeroItem
