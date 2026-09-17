local this = class("cellIconRole", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _eleTpl = L_GameTpl:getElementTypeTpl()
local _heroClothingTpl = L_GameTpl:getHeroClothingTpl()
local petGradeTpl = L_GameTpl:getPetGradeTpl()

function this.bind()
  return {
    petGradeIcon = "",
    lock = false,
    go_imageIcon = false,
    imageIcon = "",
    go_rect_hero = false,
    img_texIconHeroM = nil,
    imageColor = "",
    imageColor2 = "",
    activeSelect = false,
    petGradeIconActive = false,
    listStar = {},
    textLevel = "",
    nodeProfess = false,
    imgEleBg = "",
    imageProfess = "",
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
    new = false
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
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
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
  if L_FormationManager:getRuntimeFormationType() then
    AzurWorld.formationMgr:UnregisterEvent(C_EFormationEvent.ESyncFormationServerData, self._ESyncFormationServerDataHandler)
  end
  L_PhotoManager:clearPhotoEntity(self)
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
end

function this:setHeroDataContent(guid, params)
  params = params or {}
  local heroData = params.dataSrc or L_HeroStore:getHero(guid)
  self.bind.callback = params.callback
  if heroData then
    local configId = L_HeroStore:getHeroConfigId(heroData)
    local heroConf = L_ItemTplManager:getHeroItem(configId)
    self.bind.go_rect_hero = true
    local clothingId = heroData.skin or AzurWorld.heroMgr:GetUsingClothingId(guid, configId)
    local clothingTpl = _heroClothingTpl:getTplById(clothingId)
    self.bind.img_texIconHeroM = _heroClothingTpl:getAvatarTexture(clothingTpl, L_Const.resourceIndexOfAvatarTextureInHeroTpl.mid) or ""
    self.bind.imageColor = L_RarityTpl:getIconByType(heroConf.quality, L_Const.qualityPathType.cell2_frame)
    self.bind.imageColor2 = L_RarityTpl:getIconByType(heroConf.quality, L_Const.qualityPathType.cell2_bg)
    self:_setStars(heroConf.quality + 1)
    self.bind.textLevel = string.format("%2d", tostring(L_HeroStore:getHeroLevel(heroData)))
    local tpl = _heroTpl:getTplById(L_HeroStore:getHeroConfigId(heroData))
    local position = _heroTpl:getPosition(tpl)
    self.bind.nodeProfess = true
    local elementId = _heroTpl:getElement(tpl)
    local eTpl = _eleTpl:getTplById(elementId)
    self.bind.imgEleBg = _eleTpl:getProfessionColor(eTpl, L_Const.professionColorType.square)
    local professionTpl = L_GameTpl:getProfessionTpl()
    local professionIcon = professionTpl:getIcon(professionTpl:getTplById(position))
    self.bind.imageProfess = professionIcon
    self.bind.go_die = params.die == true
    self:setFormationData(params)
    local modName = params.headUrl or L_PlayerStore:getAvatarTexturePath(L_Const.avatarTextureIndex.head_talk)
    if heroData.type == L_Const.HeroType.HT_MAIN then
      L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.img_texIconHeroM, modName)
    else
      L_PhotoManager:clearPhotoEntity(self)
    end
    if L_HeroStore:getHeroPetGuid(heroData) ~= 0 and not self.bind.ignorePet then
      self.bind.activeHead = true
      local petItem = L_PetStore:getPetItem(L_HeroStore:getHeroPetGuid(heroData))
      if petItem then
        local petTpl = L_GameTpl:getPetTpl():getTplById(petItem.id)
        local icon = L_GameTpl:getPetTpl():getPetIcon(petTpl, petItem:isSpecialPet())
        self.bind.imageHead = icon
      end
    else
      self.bind.activeHead = false
    end
  end
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
  self:setSelectState(needShowIndex)
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

function this:setSelectState(selstate)
  if self.bind.type or self.bind.type == L_Const.cellIconRoleType.quickTeamUp then
    self.bind.activeSelect = self.bind.posIndex == self.parent.SelHeroPosIndex
    if self.bind.posIndex and self.bind.posIndex > 0 then
      self.bind.activeAdd = true
    else
      self.bind.activeAdd = false
    end
  else
    self._isSelect = selstate
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

function this:getRaycastGo()
  if self.isBind then
    return self.bindComponents.bgButton.gameObject
  end
end

return this
