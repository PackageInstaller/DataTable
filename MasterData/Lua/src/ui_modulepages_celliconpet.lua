local this = class("cellIconPet", G_UIModuleBase)
local petGradeTpl = L_GameTpl:getPetGradeTpl()

function this.bind()
  return {
    go_content = false,
    petGradeIcon = "",
    lock = false,
    imageIcon = "",
    imageColor = "",
    imageColor2 = "",
    activeSelect = false,
    petGradeIconActive = false,
    listStar = {},
    textLevel = "",
    activeHead = false,
    imageHead = "",
    nameActive = false,
    nameText = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:updateSelectState()
      if self.bind.callback then
        self.bind.callback(self)
      end
      if self.clickCallback then
        self.clickCallback(self)
      end
    end,
    onLongClick = function(self)
      if self.bind.longCallback then
        self.bind.longCallback(self)
      end
      if self.longClickCallback then
        self.longClickCallback(self)
      end
    end
  }
end

function this:open()
  this.super.open(self)
  self:refreshView()
end

function this:refreshView()
  if not self.isBind then
    return
  end
  local itemType = self.bind.itemType
  local guid = self.bind.guid
  if math.isEmpty(guid) or math.isEmpty(itemType) then
    self:setContentActive(false)
    return
  end
  if self.bind.choice then
    self:updateSelectState()
  end
  if itemType == L_Const.resType.pet then
    self:setPetDataContent(guid, self.bind)
  elseif itemType == L_Const.resType.petEgg then
    self:setPetEggDataContent(guid, self.bind)
  end
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

function this:refresh()
  self:refreshView()
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
end

function this:setPetDataContent(guid, params)
  local petData = self.bind.dataSrc or L_PetStore:getPetItem(guid)
  if petData then
    self:setContentActive(true)
    local petConf = L_ItemTplManager:getPetItem(petData.id, petData:isSpecialPet())
    self.bind.imageIcon = petConf.icon
    self.bind.imageColor = ""
    self.bind.imageColor2 = ""
    self.bind.lock = petData.is_lock == true and true or false
    self:_setStars(petConf.quality + 1)
    self.bind.textLevel = string.format("%02d", tostring(petData.lv))
    if string.isEmpty(petData.pet_name) then
      self:setName(petConf.name, params.nameColor)
    else
      self:setName(petData.pet_name, params.nameColor)
    end
    if petData.hero_id and petData.hero_id ~= 0 then
      self.bind.activeHead = true
      local heroData = L_HeroStore:getHero(petData.hero_id)
      local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
      self.bind.imageHead = heroConf.icon
      local modName = L_PlayerStore:getPlayerModHeadImgName()
      if heroData.type == L_Const.HeroType.HT_MAIN and not string.isEmpty(modName) then
        L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.ImageHead, modName)
      else
        L_PhotoManager:clearPhotoEntity(self)
      end
    else
      self.bind.activeHead = false
    end
    self.bind.petGradeIconActive = true
    local property = L_PetStore:getPetOriginalProperty(petData)
    local gradeTpl = petGradeTpl:getTplById(property.gradeRank)
    self.bind.petGradeIcon = petGradeTpl:getIconSquare(gradeTpl)
  end
end

function this:setPetEggDataContent(guid, params)
  local petEggData = self.bind.dataSrc or L_PetStore:getPetEggItem(guid)
  if petEggData then
    self:setContentActive(true)
    local petEggConf = L_ItemTplManager:getPetEggItem(petEggData.configId, guid)
    self.bind.imageIcon = petEggConf.icon
    self.bind.imageColor = ""
    self.bind.imageColor2 = ""
    self.bind.lock = petEggData.lock_state == true and true or false
    self:_setStars(petEggConf.quality + 1)
    self.bind.textLevel = petEggConf.name
    if not string.isEmpty(petEggConf.desc) then
      self:setName(petEggConf.desc, params.nameColor)
    end
  end
end

function this:setName(nameStr, nameColor)
end

function this:setContentActive(active)
  self.bind.go_content = active
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

function this:setSelectState(state)
  self._isSelect = state
  self.bind.activeSelect = self._isSelect == true
end

return this
