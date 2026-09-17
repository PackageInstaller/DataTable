local this = class("cellHeroHeadItemCircle", G_UIModuleBase)
local _selectScale = 1.2
local _heroTpl = L_GameTpl:getHeroTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    goSelect1 = nil,
    goSelect2 = nil,
    scale = nil,
    txtLevel = nil,
    imgCarrer = nil,
    scaleReddot = nil,
    carrerBg = "",
    qualityColor = C_Color.white,
    activeCarrer = false,
    activeTeamPosIndex = false,
    txtTeamPosIndex = "",
    activeElement = false,
    activeSingleElement = false,
    activeDoubleElement = false,
    imgElementBG = nil,
    imgMainElementBG = nil,
    imgSubElementBG = nil
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

function this:unBind()
  self.super.unBind(self)
  L_PhotoManager:releaseHead(self)
end

function this:unBindFromArray()
  L_PhotoManager:releaseHead(self)
  self.super.unBindFromArray(self)
end

function this:refresh()
  self:refreshSelState(self.bind.selected)
  if not self.bind.isPhotoHead then
    self.bind.scaleReddot = self.bind.selected and L_Vector3.new(1 / _selectScale, 1 / _selectScale, 1.0) or L_Vector3.new(1, 1, 1)
    if self.bind.id then
      self:registerReddot(self.bindComponents.redotNew, string.format(L_ReddotManager.DotDef.HeroNew, self.bind.id))
      AzurWorld.RedDotMgr:BindRedDotRenderer(string.format(L_ReddotManager.DotDef.HeroHead, self.bind.id), self.bindComponents.redotNormal.gameObject)
    end
    self.bind.activeElement = true
  else
    local showCarrer = self.bind.blockCarrer ~= true
    self.bind.activeElement = showCarrer
  end
  if self.bind.id then
    if self.bindComponents.imgHead and self.bind.id == L_HeroStore:getDefaultHeroGuid() then
      self.bindComponents.imgHead.gameObject:SetActive(false)
      L_PhotoManager:fillMainHead(self, self.bindComponents.imgHead.gameObject, nil, L_Const.avatarTextureIndex.head, function()
        self.bindComponents.imgHead.gameObject:SetActive(true)
      end)
    else
      L_PhotoManager:releaseHead(self)
      local heroConfigId
      if self.bind.heroConfigId then
        heroConfigId = self.bind.heroConfigId
      else
        heroConfigId = L_HeroStore:getHeroConfigId(L_HeroStore:getHero(self.bind.id))
      end
      local clothingId = AzurWorld.heroMgr:GetUsingClothingId(self.bind.id, heroConfigId)
      local heroHeadAvatarTexture = L_GameUtil.getAvatarTexturePath(clothingId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
      self.bindComponents.imgHead.gameObject:SetActive(true)
      self.bindComponents.img_texIconHeroS:LoadSprite(heroHeadAvatarTexture)
    end
    if self.bind.teamPosIndex ~= nil and self.bind.teamPosIndex > 0 then
      self.bind.activeTeamPosIndex = true
      self.bind.txtTeamPosIndex = tostring(self.bind.teamPosIndex)
    else
      self.bind.activeTeamPosIndex = false
    end
    if self.bind.heroConfigId then
      self:refreshElementIcons(self.bind.heroConfigId)
    end
  end
end

function this:refreshElementIcons(heroConfigId)
  local heroTpl = _heroTpl:getTplById(heroConfigId)
  local mainElementId = _heroTpl:getElement(heroTpl)
  local mainElementTypeTpl = _elementTypeTpl:getTplById(mainElementId)
  local subElementId = _heroTpl:getSubElement(heroTpl)
  if subElementId ~= nil and 0 < subElementId then
    self.bind.activeSingleElement = false
    self.bind.activeDoubleElement = true
    local subElementTypeTpl = _elementTypeTpl:getTplById(subElementId)
    self.bind.imgMainElementBG = _elementTypeTpl:getElementIcon(mainElementTypeTpl, L_Const.elementIconType.main)
    self.bind.imgSubElementBG = _elementTypeTpl:getElementIcon(subElementTypeTpl, L_Const.elementIconType.sub)
  else
    self.bind.activeSingleElement = true
    self.bind.activeDoubleElement = false
    self.bind.imgElementBG = _elementTypeTpl:getElementIcon(mainElementTypeTpl, L_Const.elementIconType.single)
  end
end

function this:refreshSelState(bSel)
  self.bind.goSelect1 = bSel
  self.bind.goSelect2 = bSel
  self.bind.scale = self.bind.selected and L_Vector3.new(_selectScale, _selectScale, 1) or L_Vector3.new(1, 1, 1)
end

function this:setHeroGUID(guid)
  self.bind.id = guid
  local _heroTpl = L_GameTpl:getHeroTpl()
  local hero = L_HeroStore:getHero(guid)
  if hero then
    local heroConfigId = L_HeroStore:getHeroConfigId(hero)
    local clothingId = AzurWorld.heroMgr:GetUsingClothingId(guid, heroConfigId)
    local heroHeadAvatarTexture = L_GameUtil.getAvatarTexturePath(clothingId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
    local tpl = _heroTpl:getTplById(heroConfigId)
    local elementId = _heroTpl:getElement(tpl)
    local elementTypeTpl = L_GameTpl:getElementTypeTpl()
    local bgIconPath = elementTypeTpl:getProfessionColor(elementTypeTpl:getTplById(elementId), L_Const.professionColorType.circle)
    local professionTpl = L_GameTpl:getProfessionTpl()
    local professionIcon = professionTpl:getIcon(professionTpl:getTplById(_heroTpl:getPosition(tpl)))
    local rarity = _heroTpl:getRarity(tpl)
    local rarityTpl = L_RarityTpl:getTplById(rarity)
    local colorCfg = L_RarityTpl:getColorCircle(rarityTpl)
    local _, color = C_ColorUtility.TryParseHtmlString(colorCfg)
    if self.bind.id == L_HeroStore:getDefaultHeroGuid() and self.bindComponents.imgHead then
      L_PhotoManager:fillMainHead(self, self.bindComponents.imgHead.gameObject, nil, L_Const.avatarTextureIndex.head)
    else
      L_PhotoManager:releaseHead(self)
      self.bindComponents.img_texIconHeroS:LoadSprite(heroHeadAvatarTexture)
    end
    self.bind.txtLevel = string.format("%02d", L_HeroStore:getHeroLevel(hero))
    self.bind.imgCarrer = professionIcon
    self.bind.carrerBg = bgIconPath
    self.bind.qualityColor = color
    self:refresh()
  end
end

function this:setHeroConfigID(configID)
  local _heroTpl = L_GameTpl:getHeroTpl()
  local heroHeadAvatarTexture = L_GameUtil.getAvatarTexturePath(configID, L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
  local tpl = _heroTpl:getTplById(configID)
  local elementId = _heroTpl:getElement(tpl)
  local elementTypeTpl = L_GameTpl:getElementTypeTpl()
  local bgIconPath = elementTypeTpl:getProfessionColor(elementTypeTpl:getTplById(elementId), L_Const.professionColorType.circle)
  local professionTpl = L_GameTpl:getProfessionTpl()
  local professionIcon = professionTpl:getIcon(professionTpl:getTplById(_heroTpl:getPosition(tpl)))
  local rarity = _heroTpl:getRarity(tpl)
  local rarityTpl = L_RarityTpl:getTplById(rarity)
  local colorCfg = L_RarityTpl:getColorCircle(rarityTpl)
  local _, color = C_ColorUtility.TryParseHtmlString(colorCfg)
  self.bindComponents.img_texIconHeroS:LoadSprite(heroHeadAvatarTexture)
  self.bind.txtLevel = "0"
  self.bind.imgCarrer = professionIcon
  self.bind.carrerBg = bgIconPath
  self.bind.qualityColor = color
end

function this:playOpenAnim()
  self.bindComponents.anim_heroHead:Play("anim_cellheroheaditemcircle")
end

function this:setIsPhotoHead(isPhotoHead)
  self.bind.isPhotoHead = isPhotoHead
end

function this:setSelected(selected)
  self.bind.selected = selected
end

return this
