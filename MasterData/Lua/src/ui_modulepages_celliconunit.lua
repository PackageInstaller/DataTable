local this = class("cellIconUnit", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local _heroClothingTpl = L_GameTpl:getHeroClothingTpl()
local EAbbysEnemyType = {
  Boss = 1,
  Elite = 2,
  Normal = 3
}

function this.bind()
  return {
    lock = false,
    go_imageIcon = false,
    imageIcon = "",
    go_rect_hero = false,
    img_texIconHeroM = nil,
    imageColor = "",
    imageColor2 = "",
    activeSelect = false,
    listStar = {},
    textLevel = "",
    nodeProfess = false,
    imgEleBg = "",
    imgProfession = "",
    nodeTeam = false,
    textTeamIndex = "",
    activeHead = false,
    imageHead = "",
    module_gameplayStatus = {
      moduleName = "pages/pet/modulePetGameplayStatus"
    },
    nameActive = false,
    nameText = "",
    go_die = false,
    go_putMask = false,
    activeAdd = false,
    try = false,
    reddotNew = false,
    reddotNormal = false,
    go_content = true,
    go_contentEmpty = false,
    go_bossIcon = false,
    go_mask = false,
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
      self:updateSelectState()
      if self.bind.callback then
        self.bind.callback(self)
      end
    end,
    onLongClick = function(self)
      if self.bind.longCallback then
        self.bind.longCallback(self)
      end
      if self.longClickCallback then
        self.longClickCallback(self)
      end
    end,
    onLongTab = function(self)
      if self.bind.longTabCallback then
        self.bind.longTabCallback(self)
      end
    end
  }
end

function this:open()
  this.super.open(self)
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_refreshHero)
  self._ERefreshMainPlayerHandler = handler(self, self.onEvent_refreshMainPlayer)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ERefreshMainPlayer, self._ERefreshMainPlayerHandler)
  if L_FormationManager:getRuntimeFormationType() then
    self._ESyncFormationServerDataHandler = handler(self, self.refreshView)
    AzurWorld.formationMgr:RegisterEvent(C_EFormationEvent.ESyncFormationServerData, self._ESyncFormationServerDataHandler)
  end
  self:refreshView()
end

function this:refresh()
  self:refreshView()
end

function this:close()
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ERefreshMainPlayer, self._ERefreshMainPlayerHandler)
  if self._ESyncFormationServerDataHandler then
    AzurWorld.formationMgr:UnregisterEvent(C_EFormationEvent.ESyncFormationServerData, self._ESyncFormationServerDataHandler)
  end
end

function this:refreshView()
  if not self.isBind then
    return
  end
  local guid = self.bind.guid
  if self.bind.choice then
    self:updateSelectState()
  end
  self.bind.go_imageIcon = false
  self.bind.go_rect_hero = false
  self:setHeroDataContent(guid, self.bind)
  local reddotName = ""
  if self.bind and self.bind.reddotName then
    reddotName = self.bind.reddotName
  end
  if self.bindComponents.reddotNew then
    if string.isEmpty(reddotName) then
      self.bindComponents.reddotNew.gameObject:SetActive(false)
    else
      L_ReddotManager:registerReddot(self.bindComponents.reddotNew, reddotName)
    end
  end
  local reddotnormal = ""
  if self.bind and self.bind.reddotnormal then
    reddotnormal = self.bind.reddotnormal
  end
  if self.bindComponents.reddotnormal then
    if string.isEmpty(reddotName) then
      self.bindComponents.reddotnormal.gameObject:SetActive(false)
    else
      L_ReddotManager:registerReddot(self.bindComponents.reddotnormal, reddotName)
    end
  end
end

function this:setBossDataContent(configId, params)
  params = params or {}
  local tpl = _enemyTpl:getTplById(configId)
  local typeTpl = _elementTypeTpl:getTplById(_enemyTpl:getElement(tpl)[1])
  self.bind.go_content = true
  self.bind.nodeProfess = true
  self.bind.go_imageIcon = true
  self.bind.go_content = true
  self.bind.go_contentEmpty = false
  self.bind.textLevel = tostring(params.level)
  self.bind.imageIcon = _enemyTpl:getAvatarTexture(tpl)
  self.bind.imgEleBg = _elementTypeTpl:getProfessionColor(typeTpl, 2)
  self.bind.imgProfession = _elementTypeTpl:getPetPuzzleIcon(typeTpl, 2)
  self.bind.go_bossIcon = _enemyTpl:getEnemyType(tpl) == EAbbysEnemyType.Boss
  self.bind.callback = params.callback
  self.bind.index = params.index
  self.bind.activeElement = false
end

function this:setHeroDataContent(guid, params)
  params = params or {}
  local heroData = params.dataSrc or L_HeroStore:getHero(guid)
  self.bind.callback = params.callback
  self.bind.itemType = params.itemType
  if heroData then
    self.bind.go_content = true
    self.bind.go_contentEmpty = false
    local configId = L_HeroStore:getHeroConfigId(heroData)
    local heroConf = L_ItemTplManager:getHeroItem(configId)
    self.bind.go_rect_hero = true
    local isMain = configId == L_GameUtil.getDefaultHeroId(L_Const.sexType.male) or configId == L_GameUtil.getDefaultHeroId(L_Const.sexType.female)
    if isMain then
      self.bind.img_texIconHeroM = ""
    else
      local clothingId = AzurWorld.heroMgr:GetUsingClothingId(guid, configId)
      local clothingTpl = _heroClothingTpl:getTplById(clothingId)
      self.bind.img_texIconHeroM = _heroClothingTpl:getAvatarTexture(clothingTpl, L_Const.resourceIndexOfAvatarTextureInHeroTpl.mid) or ""
    end
    self.bind.imageColor = L_RarityTpl:getIconByType(heroConf.quality, L_Const.qualityPathType.cell2_frame)
    self.bind.imageColor2 = L_RarityTpl:getIconByType(heroConf.quality, L_Const.qualityPathType.cell2_bg)
    self:_setStars(heroConf.quality + 1)
    self.bind.textLevel = string.format("%2d", tostring(L_HeroStore:getHeroLevel(heroData)))
    self:refreshElementIcons(L_HeroStore:getHeroConfigId(heroData), params)
    self.bind.go_die = params.die == true
    self:setFormationData(params)
    local modName = params.headUrl or L_PlayerStore:getAvatarTexturePath(L_Const.avatarTextureIndex.head_talk)
    if heroData.type == L_Const.HeroType.HT_MAIN or isMain then
      L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.img_texIconHeroM, modName)
    else
      L_PhotoManager:clearPhotoEntity(self)
    end
    local petGuid = params.displayPetGuid
    if petGuid == nil then
      petGuid = L_HeroStore:getHeroPetGuid(heroData)
    end
    if petGuid ~= 0 and not self.bind.ignorePet then
      self.bind.activeHead = true
      local petItem = L_PetStore:getPetItem(petGuid)
      if petItem then
        local petTpl = L_GameTpl:getPetTpl():getTplById(petItem.id)
        local icon = L_GameTpl:getPetTpl():getPetIcon(petTpl, petItem:isSpecialPet())
        self.bind.imageHead = icon
      end
    else
      self.bind.activeHead = false
    end
  else
    self.bind.go_content = false
    self.bind.go_contentEmpty = true
  end
end

function this:refreshElementIcons(heroConfigId, params)
  if not heroConfigId then
    return
  end
  if params.hideElement then
    self.bind.activeElement = false
    return
  end
  self.bind.nodeProfess = false
  self.bind.activeElement = true
  local heroTpl = _heroTpl:getTplById(heroConfigId)
  local mainElementId = _heroTpl:getElement(heroTpl)
  local mainElementTypeTpl = _elementTypeTpl:getTplById(mainElementId)
  local subElementId = _heroTpl:getSubElement(heroTpl)
  if subElementId ~= nil and 0 < subElementId then
    self.bind.activeSingleElement = false
    self.bind.activeDoubleElement = true
    local subElementTypeTpl = _elementTypeTpl:getTplById(subElementId)
    self.bind.imgMainElementBG = _elementTypeTpl:getRoleElementIcon(mainElementTypeTpl, L_Const.elementIconType.main)
    self.bind.imgSubElementBG = _elementTypeTpl:getRoleElementIcon(subElementTypeTpl, L_Const.elementIconType.sub)
  else
    self.bind.activeSingleElement = true
    self.bind.activeDoubleElement = false
    self.bind.imgElementBG = _elementTypeTpl:getRoleElementIcon(mainElementTypeTpl, L_Const.elementIconType.single)
  end
end

function this:setData(guid)
  self.bind.guid = guid
end

function this:setFormationData(params)
  if not L_FormationManager:getRuntimeFormationType() then
    return
  end
  local pos = L_FormationStore:getHeroPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), params.guid)
  self:setPosIndex(pos)
end

function this:setPosIndex(index)
  self.bind.posIndex = index
  local needShowIndex = not math.isEmpty(index)
  if needShowIndex then
    self.bind.textTeamIndex = tostring(index)
  end
  self.bind.nodeTeam = needShowIndex
  self:setSelectState()
end

function this:setName(nameStr, nameColor)
  self.bind.nameActive = not math.isEmpty(nameStr)
  if nameColor ~= nil then
    self.bind.nameText = L_GameUtil.fillColor(nameStr, nameColor)
  else
    self.bind.nameText = nameStr
  end
end

function this:_setStars(num)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.listStar:clear()
  self.bind.listStar:insert_array(stars)
end

function this:updateSelectState()
  if self.bind.selectMode then
    self._isSelect = not self._isSelect
    self.bind.activeSelect = self._isSelect == true
  end
end

function this:isSelect()
  return self._isSelect
end

function this:isActiveSelect()
  return self.bind.activeSelect
end

function this:setOnTeamShow(isOnTeam, teamIndex)
  self.bind.activeAdd = isOnTeam
  self.bind.nodeTeam = isOnTeam
  self.bind.textTeamIndex = tostring(teamIndex)
end

function this:setSelectShow(isSelected)
  self.bind.activeSelect = isSelected
end

function this:setSelectState(selstate)
  if self.bind.type and self.bind.type == L_Const.cellIconUnitType.quickTeamUp then
    self.bind.activeSelect = self.bind.posIndex == self.parent.SelHeroPosIndex
    if self.bind.posIndex and self.bind.posIndex > 0 then
      self.bind.activeAdd = true
    else
      self.bind.activeAdd = false
    end
  elseif self.bind.systemId and self.bind.systemId == L_SystemConst.enum.formationBaseHero then
    self._isSelect = self.bind.posIndex == L_FormationManager:getFocusIndex()
    self.bind.activeSelect = self._isSelect
    if self.bind.posIndex and self.bind.posIndex > 0 then
      self.bind.activeAdd = true
    else
      self.bind.activeAdd = false
    end
  else
    self._isSelect = selstate
    self.bind.activeSelect = self._isSelect
    self.bind.activeSelect = self._isSelect == true
    self.bind.activeAdd = false
  end
end

function this:onEvent_refreshHero(enum, varList)
  local hero = varList:GetObject(0)
  if self.bind.itemType == L_Const.resType.hero and self.bind.guid == L_HeroStore:getHeroGuid(hero) then
    self:refreshView()
  end
end

function this:onEvent_refreshMainPlayer(enum, varList)
  if self.bind.itemType == L_Const.resType.hero and self.bind.guid == L_HeroStore:getDefaultHeroGuid() then
    local modName = L_PlayerStore:getAvatarTexturePath(L_Const.avatarTextureIndex.head_talk)
    L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.img_texIconHeroM, modName)
  end
end

function this:getRaycastGo()
  if self.isBind then
    return self.bindComponents.bgButton.gameObject
  end
end

function this:destroy()
  L_PhotoManager:clearPhotoEntity(self)
end

function this:setMaskShow(isShow)
  self.bind.go_mask = isShow
end

return this
