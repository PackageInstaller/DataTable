local this = class("cellEditMount", G_UIModuleBase)
local _systemSorttypeTpl = L_GameTpl:getSystemSorttypeTpl()
local _heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {
    go_empty = true,
    go_content = false,
    module_mountMoveType = {
      moduleName = "pages/mount/moduleMountMoveType"
    },
    module_petGameplayStatus = {
      moduleName = "pages/pet/modulePetGameplayStatus"
    },
    go_checkInfo = false,
    module_checkInfo = {
      moduleName = "pages/pet/modulePetSSLCheckBar"
    },
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    go_owner = nil,
    img_owner = nil,
    go_equippedBg = false,
    go_equippedIndex = false,
    txt_index = nil,
    go_lockRiding = false
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      if self.bind.go_content then
        self:emit("onClick_select", self.bind)
      end
    end
  }
end

function this:open()
  this.super.open(self)
  self._pixelIconModule = self.modules.module_pixelIcon
  self:initCell()
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
end

function this:initCell()
  if not self.isBind then
    return
  end
  self.bind.go_empty = math.isEmpty(self.bind.guid)
  self.bind.go_content = not math.isEmpty(self.bind.guid)
  if not self.bind.go_content then
    return
  end
  local pet = AzurWorld.petMgr:GetPetItem(self.bind.guid)
  local isInRoulette = not math.isEmpty(pet.roulettePos)
  local isCurEquip = self.bind.guid == L_MountStore:getEquipMountId()
  local moduleMoveType = self.modules.module_mountMoveType
  moduleMoveType:setData(self.bind.guid)
  local moduleStatus = self.modules.module_petGameplayStatus
  moduleStatus:setData(self.bind.guid)
  if isCurEquip then
    moduleStatus:setCurSelectForMount()
  elseif isInRoulette then
    moduleStatus:setIsShow(false)
  end
  local isUnlockRide = L_MountManager:getIsMountUnlock(self.bind.guid)
  self.bind.go_lockRiding = not isUnlockRide
  self.bind.go_checkInfo = isUnlockRide
  if isUnlockRide then
    local moduleCheckInfo = self.modules.module_checkInfo
    moduleCheckInfo:setData(self.bind.guid)
  end
  self._pixelIconModule:setGuid(self.bind.guid)
  local hasOwner = not math.isEmpty(pet.heroId)
  self.bind.go_owner = hasOwner
  if hasOwner then
    if pet.heroId == L_HeroStore:getDefaultHeroGuid() then
      L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.img_owner, L_PlayerStore:getPlayerModHeadImgName())
    else
      L_PhotoManager:clearPhotoEntity(self)
      local heroConfigId = L_HeroStore:getHeroConfigId(L_HeroStore:getHero(pet.heroId))
      local clothingId = AzurWorld.heroMgr:GetUsingClothingId(pet.heroId, heroConfigId)
      local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
      self.bind.img_owner = heroClothingTpl:getAvatarTexture(heroClothingTpl:getTplById(clothingId), L_Const.avatarTextureIndex.half_formation)
    end
  end
  self.bind.go_equippedBg = isInRoulette
  self.bind.go_equippedIndex = isInRoulette
  self:setGifPlay(isInRoulette)
  if isInRoulette then
    self.bind.txt_index = tostring(pet.roulettePos)
  end
  self.bind.curEquip = isCurEquip
  local tpl_sortKey = _systemSorttypeTpl:getTplById(self.bind.firstSortKey)
  local sortType, sortPara = table.unpack(_systemSorttypeTpl:getSortPara(tpl_sortKey))
  if sortType == L_SortFilterConst.SortType.Satiety then
    self:setSortBySatiety()
  elseif sortType == L_SortFilterConst.SortType.Level then
    self:setSortByLevel()
  end
end

function this:setGifPlay(isPlay)
  if not self.isBind then
    return
  end
  if isPlay then
    self._pixelIconModule:playPixelGif()
  else
    self._pixelIconModule:stopPixelGif()
  end
end

function this:setSortBySatiety()
  if not self.bind.go_content then
    return
  end
  local moduleCheckInfo = self.modules.module_checkInfo
  moduleCheckInfo:setSatiety(self.bind.guid)
end

function this:setSortByLevel()
  if not self.bind.go_content then
    return
  end
  local moduleCheckInfo = self.modules.module_checkInfo
  moduleCheckInfo:setLevel(self.bind.guid)
end

return this
