local this = class("modulePetNewSimpleTags", G_UIModuleBase)
local petInfoTpl = L_GameTpl:getPetTpl()
local _elementTypeTpl = L_GameTpl:getElementTypeTpl()
local _petHomeSizeTpl = L_GameTpl:getPetHomeSizeTpl()
local _petHomeTalentTpl = L_GameTpl:getPetHomeTalentTpl()
local modulePetBattleTagTips_Path = "UI/Pages/PetBox/modulePetBattleTagTips.prefab"
local modulePetBattleTagTips = "ui.pages.pet.new.modulePetBattleTagTips"

function this.bind()
  return {
    list_element = {
      moduleName = "pages/Pet/cellPetElement"
    },
    tagList_feather = {
      moduleName = "pages/pet/new/cellNewTagItem"
    },
    list_capacity = {
      moduleName = "pages/Pet/cellTagItem"
    },
    active_special_obj = false,
    active_flashTag = false,
    active_starcolorTag = false,
    active_one = false,
    active_two = false,
    active_LayoutTop = true,
    active_shape = true,
    txt_body = "",
    levelIconMain = "",
    levelIconSub = ""
  }
end

function this.methods()
  return {
    onClickTag = function(self)
      if self.BtnTagCellFunc ~= nil then
        self.BtnTagCellFunc()
      end
    end,
    onClickElementTwo = function(self)
      L_UI:open("pageElementalRestraint", {
        elements = self.allElement
      })
    end
  }
end

function this:showDetail(isOn)
  for i, v in pairs(self.modules.list_tagTip_feather) do
    v:showDetail(isOn)
  end
end

function this:setGuid(guid, bShowTips, bPageGetPet, bHideTopIcon, params)
  self.tagInfoFlag = false
  self.pet = L_PetStore:getPetItem(guid)
  self:refreshModule(self.pet.id, bShowTips, params)
  self.bind.active_special_obj = self.pet:isSpecialPet() and self.pet:isSpecialPet() > 0 and not bHideTopIcon
  self.bind.active_flashTag = self.pet:hasFlashGene() and not bHideTopIcon
  self.bind.active_starcolorTag = self.pet:isStarColorPet() and not bHideTopIcon
  self:refreshGetPetStyle(bPageGetPet)
end

function this:setConfigId(configId, bShowTips, params)
  self:refreshModule(configId, bShowTips, params)
  self:refreshGetPetStyle(true, configId)
end

function this:refreshModule(configId, bShowTips, params)
  local petTpl = petInfoTpl:getTplById(configId)
  local elementData = {}
  local element = petInfoTpl:getElement(petTpl)
  for _, v in ipairs(element) do
    table.insert(elementData, {element = v, allElement = element})
  end
  self.allElement = element
  local mainElementId = element[1]
  local subElementId = element[2]
  local mainElementTypeTpl = mainElementId and _elementTypeTpl:getTplById(mainElementId)
  if subElementId ~= nil and 0 < subElementId then
    self.bind.active_one = false
    self.bind.active_two = true
    local subElementTypeTpl = _elementTypeTpl:getTplById(subElementId)
    self.bind.levelIconMain = mainElementTypeTpl and _elementTypeTpl:getElementIcon(mainElementTypeTpl, L_Const.elementIconType.main) or ""
    self.bind.levelIconSub = subElementTypeTpl and _elementTypeTpl:getElementIcon(subElementTypeTpl, L_Const.elementIconType.sub) or ""
  else
    self.bind.active_one = true
    self.bind.active_two = false
  end
  self.bind.list_element:clear()
  self.bind.list_element:insert_array(elementData)
  local onBtnTagCell
  if params then
    function onBtnTagCell()
      if self.tagInfoFlag then
        self.tagInfoFlag = false
        
        L_UI:close("pageTipBubble")
        return
      end
      self.tagInfoFlag = true
      local temp = {
        configId = configId,
        pet = self.pet
      }
      L_UI:open("pageTipBubble", {
        data = {
          modulePetBattleTagTips_Path,
          modulePetBattleTagTips,
          temp,
          self.bindComponents.rectTagList,
          params.pointTo,
          true,
          1,
          params.borderDistance,
          params.transSize,
          nil,
          nil,
          nil,
          nil,
          true
        }
      })
    end
  else
    function onBtnTagCell()
      if self.tagInfoFlag then
        self.tagInfoFlag = false
        
        L_UI:close("pageTipBubble")
        return
      end
      self.tagInfoFlag = true
      local temp = {
        configId = configId,
        pet = self.pet
      }
      local offset
      local isMobile = L_DeviceTpl:getIsMobile()
      if isMobile then
        offset = C_Vector3(0, -40, 0)
      end
      L_UI:open("pageTipBubble", {
        data = {
          modulePetBattleTagTips_Path,
          modulePetBattleTagTips,
          temp,
          self.bindComponents.rectTagList,
          0,
          true,
          1,
          C_Vector2(26, 12),
          C_Vector2(10, 10),
          offset,
          nil,
          nil,
          nil,
          true
        }
      })
    end
  end
  self.BtnTagCellFunc = onBtnTagCell
  local simpleTagData = {}
  local battleTag = petInfoTpl:getBattleTag(petTpl)
  if battleTag then
    for _, id in ipairs(battleTag) do
      table.insert(simpleTagData, {id = id, cbk = nil})
    end
  end
  self.bind.list_capacity:clear()
  self.bind.list_capacity:insert_array(simpleTagData)
  self:setFeatureList(configId)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rectTagList)
end

function this:setFeatureList(configId)
  if self.bind.tagList_feather == nil or self.bind.tagList_feather.clear == nil then
    return
  end
  local pet = self.pet
  self.bind.tagList_feather:clear()
  local tagData = {}
  local featureList = pet ~= nil and L_PetStore:getPetFeatureSkill(pet) or L_PetManager:getFPropertySkillList(configId)
  for i, v in ipairs(featureList) do
    table.insert(tagData, {
      type = i % 3 == 0 and 3 or i % 3,
      label = string.format("%s", v.skillName)
    })
  end
  self.bind.tagList_feather:insert_array(tagData)
end

function this:refreshGetPetStyle(bPageGetPet, configId)
  if bPageGetPet then
    self.bind.active_LayoutTop = false
    self.bind.active_shape = true
    local id = configId or self.pet and self.pet.id
    self:setPetSizeTag(id)
  else
    self.bind.active_shape = false
    self.bind.active_LayoutTop = true
  end
end

function this:setPetSizeTag(id)
  local petHomeTalentTpl = _petHomeTalentTpl:getTplById(id)
  local petSize = _petHomeTalentTpl:getSizeType(petHomeTalentTpl)
  local petHomeSizeTpl = _petHomeSizeTpl:getTplById(petSize)
  self.bind.txt_body = _petHomeSizeTpl:getSizeName(petHomeSizeTpl)
end

function this:setSpecialAndFlash(isSpecial, isFlash)
  self.bind.active_special_obj = isSpecial
  self.bind.active_flashTag = isFlash
end

return this
