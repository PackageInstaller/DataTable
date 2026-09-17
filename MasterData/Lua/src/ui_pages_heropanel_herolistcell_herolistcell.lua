local this = class("heroListCell", G_UIModuleBase)
local QUALITY_IMAGE_PATH = {
  [1] = "Page/BSHero/tex_icon_raritysqrtt_n",
  [2] = "Page/BSHero/tex_icon_raritysqrtt_r",
  [3] = "Page/BSHero/tex_icon_raritysqrtt_sr",
  [4] = "Page/BSHero/tex_icon_raritysqrtt_ssr"
}

function this.bind()
  return {
    heroIconImg = "",
    heroRaryImg = "",
    heroSelectObj = false,
    heroLevelText = "",
    starList = {
      moduleName = "pages/HeroPanel/heroListCell/heroStarCell"
    }
  }
end

function this.methods()
  return {
    onClick_selectHero = function(self)
      self.bind.heroSelectObj = true
      if self.callBack ~= nil then
        self.callBack()
      end
    end
  }
end

function this:refresh()
end

function this:unBind()
  if self.bind.photoEntity then
    self.bind.photoEntity:dispose()
    self.bind.photoEntity = nil
  end
end

function this:tryInitCell(heroData, selectId, callBack)
  if heroData == nil then
    return
  end
  if callBack ~= nil then
    self.callBack = callBack
  end
  self:initCell(heroData, selectId)
end

function this:initCell(heroData, selectId)
  if heroData == nil then
    return
  end
  local heroId = L_HeroStore:getHeroGuid(heroData)
  local heroConfigId = L_HeroStore:getHeroConfigId(heroData)
  L_ReddotManager:registerReddot(self.bindComponents.redotNew, string.format(L_ReddotManager.DotDef.HeroNew, heroId))
  AzurWorld.RedDotMgr:BindRedDotRenderer(string.format(L_ReddotManager.DotDef.HeroGrade, heroId), self.bindComponents.redotNormal.gameObject)
  local star = L_HeroStore:getHeroStar(heroData)
  local heroTable = L_GameTpl:getHeroTpl()
  local heroTpl = heroTable:getTplById(heroConfigId)
  if heroTpl == nil then
    return
  end
  self.heroId = heroId
  local rarity = heroTable:getRarity(heroTpl)
  self.bind.heroRaryImg = QUALITY_IMAGE_PATH[rarity]
  self.bind.heroSelectObj = self.heroId == selectId
  local tempTable = {}
  for i = 1, star do
    tempTable[i] = {}
  end
  self.bind.starList:clear()
  self.bind.starList:insert_array(tempTable)
  if self.heroId == L_HeroStore:getDefaultHeroGuid() then
    local modUrl = L_PlayerStore:getPlayerModHalfBodyName()
    if not string.isEmpty(modUrl) then
      if self.bind.photoEntity == nil then
        self.bind.photoEntity = L_PhotoManager:bindPhotoEntity()
      end
      self.bind.photoEntity:bindGameObject(self.bindComponents.Icon.gameObject)
      self.bind.photoEntity:setImgName(modUrl, function()
        self.bindComponents.Icon:SetNativeSize()
      end)
    end
  else
    self.bind.heroIconImg = L_GameUtil.getAvatarTexturePath(self.heroId, L_Const.avatarTextureIndex.half_formation)
    self.bindComponents.Icon:SetNativeSize()
  end
  self.bind.heroLevelText = table.concat({
    L_WordsTpl:getValue("menu_common_lv"),
    tostring(L_HeroStore:getHeroLevel(heroData))
  })
end

return this
