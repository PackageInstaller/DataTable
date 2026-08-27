local UINLtrResultHero = class("UINLtrResultHero", UIBaseNode)
local base = UIBaseNode

function UINLtrResultHero:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.starItemList = {}
  self.ui.img_star.gameObject:SetActive(false)
  self.starRareColor = {
    [eHeroCardRareType.SSR] = Color.New(1, 0.974, 0.58, 1),
    [eHeroCardRareType.SR] = Color.New(0.997, 0.853, 1, 1),
    [eHeroCardRareType.R] = Color.New(0.643, 0.952, 1, 1)
  }
end

function UINLtrResultHero:InitLtrResultHero(heroData, isNew, resLoader)
  self._heroData = heroData
  self.ui.canvasGroup.alpha = 1
  local campPath = PathConsts:GetCampPicPath(heroData:GetCampCfg().icon)
  UIUtil.LoadABAssetAsyncAndSetTexture(resLoader, campPath, self.ui.img_Camp)
  local heroPicPath = PathConsts:GetCharacterPicPath(heroData:GetResPicName(true))
  UIUtil.LoadABAssetAsyncAndSetTexture(resLoader, heroPicPath, self.ui.img_Hero)
  self.ui.img_Carrer.sprite = CRH:GetSprite(heroData:GetCareerCfg().icon, CommonAtlasType.CareerCamp)
  self.ui.obj_IsNew:SetActive(isNew)
  local rankCfg = ConfigData.hero_rank[heroData.heroCfg.rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(heroData.heroCfg.rank))
  end
  self.rankCfg = rankCfg
  self:__HideAllStar()
  self:__UpdateStar(rankCfg.star, self.starRareColor[heroData.rare])
  for k, go in ipairs(self.ui.rareBg) do
    go:SetActive(rankCfg.rare == k)
  end
  for k, go in ipairs(self.ui.rareStarBg) do
    go:SetActive(rankCfg.rare == k + 1)
  end
end

function UINLtrResultHero:GetRepeatExtraItemList()
  local ids = self.rankCfg.repeat_extra_trans_id
  local nums = self.rankCfg.repeat_extra_trans_num
  local itemList = {}
  for k, id in ipairs(ids) do
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("Cant get itemCfg, id = " .. tostring(id))
    else
      table.insert(itemList, {
        itemCfg = itemCfg,
        num = nums[k]
      })
    end
  end
  return itemList
end

function UINLtrResultHero:GetRepeatExtraFragList()
  local itemList = {}
  local itemCfg = ConfigData.item[self._heroData.fragId]
  local num = self.rankCfg.repeat_frag_trans
  table.insert(itemList, {itemCfg = itemCfg, num = num})
  return itemList
end

function UINLtrResultHero:__UpdateStar(starCount, rareColor)
  local twoStarCount = starCount // 2
  local oneStarCount = starCount % 2
  for i = 1, twoStarCount do
    local starItem = self:__GetStar(i)
    starItem:SetIndex(0)
    starItem.image.color = rareColor
  end
  if oneStarCount ~= 0 then
    local starItem = self:__GetStar(twoStarCount + 1)
    starItem:SetIndex(1)
    starItem.image.color = rareColor
  end
end

function UINLtrResultHero:__GetStar(index)
  local starItem = self.starItemList[index]
  if starItem == nil then
    starItem = self.ui.img_star:Instantiate()
    self.starItemList[index] = starItem
  end
  starItem.gameObject:SetActive(true)
  return starItem
end

function UINLtrResultHero:__HideAllStar()
  for k, v in pairs(self.starItemList) do
    v.gameObject:SetActive(false)
  end
end

function UINLtrResultHero:SetLtrHeroConvertAlpha()
  self.ui.canvasGroup.alpha = 0.2
end

function UINLtrResultHero:SetStarQualityActive(active)
  self.ui.obj_quality:SetActive(active)
end

function UINLtrResultHero:ShowFlashFx()
  for k, go in ipairs(self.ui.rareFlash) do
    go:SetActive(self.rankCfg.rare == k)
  end
end

function UINLtrResultHero:GetLtrResultHeroUIRoot()
  return self.ui.root
end

function UINLtrResultHero:SetLtrRsultHeroQulityItemHolderParent(parentTransfrom)
  self.ui.quailtyItem:SetParent(parentTransfrom)
end

function UINLtrResultHero:OnDelete()
  base.OnDelete(self)
end

return UINLtrResultHero
