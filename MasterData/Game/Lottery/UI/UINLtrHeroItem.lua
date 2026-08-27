local UINLtrHeroItem = class("UINLtrHeroItem", UIBaseNode)
local base = UIBaseNode

function UINLtrHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.img_star.gameObject:SetActive(false)
  self.starItemList = {}
end

function UINLtrHeroItem:InitLtrHeroItem(heroId, resLoader, heroPara)
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(heroId))
    return
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self.ui.img_Carrer:SetIndex(heroCfg.career - 1)
  local rankCfg = ConfigData.hero_rank[heroCfg.rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(heroCfg.rank))
  end
  self:__HideAllStar()
  self:__UpdateStar(rankCfg.star)
  local resCfg = ConfigData.resource_model[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return
  end
  DestroyUnityObject(self.bigImgGameObject)
  resLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resCfg.res_Name), function(prefab)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder)
    local comPerspHandle = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle:SetPosType("HeroList")
  end)
  self.ui.heroHolder.anchoredPosition3D = Vector3.New(heroPara[1], heroPara[2], heroPara[3])
  self.ui.heroHolder.localScale = Vector3.New(heroPara[4], heroPara[5], heroPara[6])
  self.ui.heroInfo.anchoredPosition3D = Vector3.New(heroPara[7], heroPara[8], heroPara[9])
end

function UINLtrHeroItem:__UpdateStar(starCount)
  local twoStarCount = starCount // 2
  local oneStarCount = starCount % 2
  for i = 1, twoStarCount do
    local starItem = self:__GetStar(i)
    starItem:SetIndex(0)
  end
  if oneStarCount ~= 0 then
    local starItem = self:__GetStar(twoStarCount + 1)
    starItem:SetIndex(1)
  end
end

function UINLtrHeroItem:__GetStar(index)
  local starItem = self.starItemList[index]
  if starItem == nil then
    starItem = self.ui.img_star:Instantiate()
    self.starItemList[index] = starItem
  end
  starItem.gameObject:SetActive(true)
  return starItem
end

function UINLtrHeroItem:__HideAllStar()
  for k, v in pairs(self.starItemList) do
    v.gameObject:SetActive(false)
  end
end

function UINLtrHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINLtrHeroItem
