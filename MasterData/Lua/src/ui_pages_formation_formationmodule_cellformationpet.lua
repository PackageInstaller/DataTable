local this = class("cellFormationPet", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local GifPath = "UI/Texture/PetPixelIcon/tex_icon_pet_%s_%d.png"
local _petTpl = L_GameTpl:getPetTpl()
local _petGradeTpl = L_GameTpl:getPetGradeTpl()
local _petTalentTpl = L_GameTpl:getPetTalentTpl()

function this.bind()
  return {
    selectRoot = false,
    sel = false,
    Panel_pet_empty = false,
    Panel_content = false,
    img_petIcon = "",
    txt_posIndex = "1",
    activeAdd = false,
    img_icon_outline = "",
    modulePetFlashEft = {
      moduleName = "pages/pet/modulePetFlashEft"
    },
    module_petLevel = {
      moduleName = "pages/pet/cellPixelPetLevel"
    },
    img_base = nil,
    active_annoy = false
  }
end

function this.methods()
  return {}
end

function this:open()
  self:initCell()
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
end

function this:close()
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
end

function this:initCell()
  if not self.isBind then
    return
  end
  self:refreshView()
end

function this:refresh()
  self:refreshView()
end

function this:refreshView()
  if not self.isBind then
    return
  end
  local isEmpty = math.isEmpty(self.bind.guid)
  if isEmpty then
    self.bind.active_annoy = false
  end
  if not isEmpty then
    local serverData = L_PetStore:getPetItem(self.bind.guid)
    self.bind.active_annoy = serverData:getPetAbilityLimited()
    local tpl = petTpl:getTplById(serverData.id)
    self.bind.img_petIcon = _petTpl:getPetPixelIcon(tpl, serverData:isSpecialPet())
    self._initFrameIcon = petTpl:getPetPixelIcon(tpl, 0)
    self._curFrame = 1
    self._defaultPixelId = string.match(self._initFrameIcon, "%a*%d+")
    local iconPath = string.format(GifPath, self._defaultPixelId, self._curFrame)
    self.bind.active_baseShadow = not string.isEmpty(self._initFrameIcon)
    self.bindComponents.img_icon_outline:LoadSprite(iconPath, false)
    self.modules.modulePetFlashEft:setModulePetFlashEftData(self.bind.guid)
    self:_refreshPixelBase(self.bind.guid)
    self:_SetLvAndElement()
  end
end

function this:setSelectNew(isSelect)
  self.bind.selectRoot = isSelect
  self.bind.sel = isSelect
end

function this:_refreshPixelBase(guid)
  local serverData = L_PetStore:getPetItem(guid)
  local talentPixelBase
  if serverData and serverData.comprehension then
    local talentGradeTpl
    if not math.isEmpty(serverData.petTalentId) then
      talentGradeTpl = _petTalentTpl:getTplById(serverData.petTalentId)
    else
      local totalIV = L_PetStore:getPetSixDimPotentialQualification(serverData)
      talentGradeTpl = L_PetStore:getPetTalentGradeTplByTotalIV(totalIV)
    end
    if talentGradeTpl then
      talentPixelBase = _petTalentTpl:getPetPixelBase(talentGradeTpl)
    end
  end
  if not string.isEmpty(talentPixelBase) then
    self.bind.img_base = talentPixelBase
    return
  end
  local _, gradeRank = L_PetStore:getPetGradeNew(guid)
  local gradeTpl = gradeRank and gradeRank ~= 0 and _petGradeTpl:getTplById(gradeRank) or nil
  self.bind.img_base = gradeTpl and _petGradeTpl:getPetPixelBase(gradeTpl) or ""
end

function this:_SetLvAndElement()
  local serverData = L_PetStore:getPetItem(self.bind.guid)
  self.levelValue = string.format("Lv.%d", serverData.lv)
  local modulePetLevel = self.modules.module_petLevel
  if modulePetLevel and modulePetLevel.refreshData then
    modulePetLevel:refreshData({
      levelValue = self.levelValue,
      petConfigId = serverData.id
    })
  end
end

function this:setPetDataContent(guid)
  local petData = L_PetStore:getPetItem(guid)
  if petData then
    self.bind.Panel_content = true
    self.bind.Panel_pet_empty = false
    self.bind.guid = guid
    self.bind.active_annoy = petData:getPetAbilityLimited()
    local tpl = _petTpl:getTplById(petData.id)
    self.bind.img_petIcon = _petTpl:getPetPixelIcon(tpl, petData:isSpecialPet())
    self._initFrameIcon = petTpl:getPetPixelIcon(tpl, 0)
    self._curFrame = 1
    self._defaultPixelId = string.match(self._initFrameIcon, "%a*%d+")
    local iconPath = string.format(GifPath, self._defaultPixelId, self._curFrame)
    self.bindComponents.img_icon_outline:LoadSprite(iconPath, false)
    self.modules.modulePetFlashEft:setModulePetFlashEftData(guid)
    self:_refreshPixelBase(guid)
    self:_SetLvAndElement()
  else
    self.bind.Panel_content = false
    self.bind.Panel_pet_empty = true
    self.bind.active_annoy = false
  end
end

function this:setPosIndex(index)
  local needShowFormationData = index ~= nil and 0 < index or false
  self.bind.posIndex = index
  if needShowFormationData then
    self.bind.txt_posIndex = tostring(index)
  end
  self.bind.go_posIndex = needShowFormationData
end

function this:onEvent_refreshPet(pet)
  if pet.guid == self.bind.guid then
    self:refreshView()
  end
end

return this
