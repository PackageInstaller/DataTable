local module = class("cellCataloguePet", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()
local NO_PREFIX = "NO."
local FLASH_AFFIX = "B"

function module.bind()
  return {
    imgSelectActive = false,
    imgSelectMaskActive = false,
    imgFullBgActive = false,
    imgTaskLevel = "",
    taskLevelActive = false,
    txtNoneActive = false,
    redDotActive = false,
    modulePetPixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    txtIndex = "",
    color_txtIndex = C_Color(0.5686275, 0.5294118, 0.4745098, 1),
    listAttrActive = false,
    list_attrAdd = {
      moduleName = "pages/petCatalogue/cellCatalogAttr"
    },
    totalAlpha = 1
  }
end

function module.methods()
  return {
    onClick = function(self)
      if self.bind.onClickCb then
        self.bind.onClickCb(self)
      end
      if self.isBind and self.bind.petId then
        L_CatalogStore:setNotNew(self.bind.petId)
        self.bind.redDotActive = L_CatalogStore:getIsNew(self.bind.petId)
        self:refreshRedDot()
      end
    end
  }
end

function module:created(...)
  module.super.created(self, ...)
end

function module:show()
  self:refreshRedDot()
end

function module:setDataContent(petId, isSelected, hideRedDot)
  self.bind.petId = petId
  self.isSelected = isSelected
  self.hideRedDot = hideRedDot
  self:refresh()
end

function module:refresh()
  if not self.bind.petId then
    return
  end
  local petData = _petTpl:getTplById(self.bind.petId)
  local petCatalogData = L_CatalogStore:getPetCatalogByPetId(self.bind.petId) or {}
  local taskLevel = petCatalogData.lv or 1
  local isFull = taskLevel == 10
  local isGet = L_CatalogStore:isGetPet(self.bind.petId)
  self.bind.imgSelectActive = self.isSelected
  self.bind.imgSelectMaskActive = self.isSelected
  self:setCatalogPet(self.bind.petId, isFull, taskLevel, isGet)
  self:refreshAttrView(self.bind.isAttrView or false)
  self:refreshRedDot()
end

function module:setCatalogPet(petId, isFull, taskLevel, isGet)
  local petData = _petTpl:getTplById(petId)
  local idx = petData.iconographyNum
  self.modules.modulePetPixelIcon:setConfigId(petId)
  self.bind.imgFullBgActive = isFull or false
  self.bind.txtIndex = NO_PREFIX .. tostring(idx) .. petData.iconographyNumSuffix
  self.bind.color_txtIndex = isFull and C_Color(0.7098039, 0.5294118, 0.2117647, 1) or C_Color(0.5686275, 0.5294118, 0.4745098, 1)
  if taskLevel and 0 < taskLevel then
    self.bind.taskLevelActive = true
    local tpl = L_GameTpl:getIconographyLevelTpl():getTplByLvPetId(taskLevel, petId)
    self.bind.imgTaskLevel = tpl.iconlist
  else
    self.bind.taskLevelActive = false
  end
  self.bind.txtNoneActive = false
  if isGet then
    self.modules.modulePetPixelIcon:setIconBlack(false)
    self.bind.taskLevelActive = true
  else
    self.modules.modulePetPixelIcon:setIconBlack(true)
    self.bind.taskLevelActive = false
  end
end

function module:refreshAttrView(isAttr)
  local petCatalogData = L_CatalogStore:getPetCatalogByPetId(self.bind.petId) or {}
  local taskLevel = petCatalogData.lv or 1
  local isFull = taskLevel == 10
  local isGet = L_CatalogStore:isGetPet(self.bind.petId)
  if isAttr then
    if self.bind.redDotActive then
      self.bind.redDotActive = false
      self.isShowReadDot = true
    end
    self.bind.totalAlpha = 0.15
    if isGet then
      self.bind.listAttrActive = true
      self.bind.list_attrAdd:clear()
      local attrList = {}
      local tempList = L_CatalogStore:getPetAllAttr(self.bind.petId)
      for attrId, attrVal in pairs(tempList) do
        local attrTpl = L_GameTpl:getBattleInfoTpl():getTplById(attrId)
        table.insert(attrList, {
          attrId = attrId,
          attrVal = attrVal,
          index = L_GameTpl:getBattleInfoTpl():getPetSort(attrTpl),
          isFull = isFull
        })
      end
      table.sort(attrList, function(a, b)
        return a.index < b.index
      end)
      for i = 1, #attrList do
        attrList[i].index = i
      end
      self.bind.list_attrAdd:insert_array(attrList)
    else
      self.bind.txtNoneActive = true
    end
  else
    if self.isShowReadDot and L_CatalogStore:getIsNew(self.bind.petId) then
      self.bind.redDotActive = true
    end
    self.bind.totalAlpha = 1
    if isGet then
      self.bind.listAttrActive = false
    else
      self.bind.txtNoneActive = false
    end
  end
end

function module:setSelect(isSelect, needAnim)
  self.isSelected = isSelect
  self.bind.imgSelectActive = isSelect
  self.bind.imgSelectMaskActive = isSelect
  if needAnim and self.isBind then
    self.bindComponents.anim:Stop()
    self.bindComponents.anim:Play("Anim_cellCatalogPet_detail_selected")
  end
end

function module:refreshRedDot()
  local showRedDot
  if self.hideRedDot then
    showRedDot = false
  else
    showRedDot = L_CatalogStore:getIsNew(self.bind.petId)
  end
  self.bind.redDotActive = showRedDot
end

return module
