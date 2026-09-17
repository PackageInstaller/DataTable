local cls = class("cellIconPetDuelEntrance", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local elementTpl = L_GameTpl:getElementTypeTpl()
local petGradeTpl = L_GameTpl:getPetGradeTpl()
local colorEnums = {
  [1] = "#595959",
  [2] = "#595959",
  [3] = "#1c795e",
  [4] = "#1c795e",
  [5] = "#234edb",
  [6] = "#234edb",
  [7] = "#935fd9",
  [8] = "#b87500"
}

function cls.bind()
  return {
    toggle_empty = false,
    active_img_select = false,
    img_Icon = "",
    img_elementIcon = "",
    txt_cost = "",
    txt_level = "",
    active_gradeNode = false,
    txt_gradeValue = "",
    img_grade = "",
    active_slotNode = false,
    txt_slotNum = ""
  }
end

function cls.methods()
  return {
    onClick_select = function(self)
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function cls:refresh()
  self.petCfgId = self.bind.petCfgId
  self.petLv = self.bind.petLv
  self.petGuid = self.bind.petGuid
  self.cellMode = self.bind.cellMode
  self.slotId = self.bind.slotId
  self.selectSlotId = self.bind.selectSlotId
  self:refreshView()
end

function cls:refreshView()
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.Entrance or self.cellMode == L_PetConst.PetDuelEntranceCellMode.PrepareEnemy then
    self.bind.toggle_empty = false
    self.bind.active_img_select = false
    self.bind.active_gradeNode = false
    self.bind.active_slotNode = false
    local petCfg = petTpl:getTplById(self.petCfgId)
    self.bind.img_Icon = petTpl:getPetIcon(petCfg)
    self.bind.txt_level = tostring(self.petLv)
    self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(self.petCfgId))
    local elementId = petTpl:getFirstElement(petCfg)
    local eTpl = elementTpl:getTplById(elementId)
    self.bind.img_elementIcon = elementTpl:getPetElem(eTpl)
    return
  end
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.PrepareSelf then
    self.bind.active_img_select = false
    self.bind.toggle_empty = self.petGuid <= 0
    if self.petGuid <= 0 then
      return
    end
    self.bind.active_gradeNode = false
    self.bind.active_slotNode = false
    local petItem = L_PetStore:getPetItem(self.petGuid)
    local petCfg = petTpl:getTplById(petItem:petCfgId())
    self.bind.img_Icon = petTpl:getPetIcon(petCfg, petItem:isSpecialPet())
    self.bind.txt_level = tostring(petItem:petLv())
    self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(petItem:petCfgId()))
    local elementId = petTpl:getFirstElement(petCfg)
    local eTpl = elementTpl:getTplById(elementId)
    self.bind.img_elementIcon = elementTpl:getPetElem(eTpl)
    return
  end
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationSlot then
    self.bind.active_img_select = self.slotId == self.selectSlotId
    self.bind.toggle_empty = self.petGuid <= 0
    if self.petGuid <= 0 then
      return
    end
    self.bind.active_gradeNode = true
    self.bind.active_slotNode = false
    local petItem = L_PetStore:getPetItem(self.petGuid)
    local petCfg = petTpl:getTplById(petItem:petCfgId())
    self.bind.img_Icon = petTpl:getPetIcon(petCfg, petItem:isSpecialPet())
    self.bind.txt_level = tostring(petItem:petLv())
    self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(petItem:petCfgId()))
    local elementId = petTpl:getFirstElement(petCfg)
    local eTpl = elementTpl:getTplById(elementId)
    self.bind.img_elementIcon = elementTpl:getPetElem(eTpl)
    local property = L_PetStore:getPetOriginalProperty(petItem)
    self.bind.txt_gradeValue = tostring(property.grade)
    local gradeTpl = petGradeTpl:getTplById(property.gradeRank)
    self.bind.img_grade = petGradeTpl:getIcon(gradeTpl)
    if property.gradeRank == 9 then
      self.bindComponents.gradeBgEffect:LoadSprite("Page/PetGet/tex_pet_bg_pzysbg2")
      local _, color = C_ColorUtility.TryParseHtmlString("#FFFFFF")
      self.bindComponents.gradeBgEffect.color = color
    else
      self.bindComponents.gradeBgEffect:LoadSprite("Page/PetGet/tex_pet_bg_pzysbg")
      local _, color = C_ColorUtility.TryParseHtmlString(colorEnums[property.gradeRank])
      self.bindComponents.gradeBgEffect.color = color
    end
    return
  end
  if self.cellMode == L_PetConst.PetDuelEntranceCellMode.FormationPetPool then
    self.bind.active_img_select = false
    self.bind.toggle_empty = false
    self.bind.active_gradeNode = true
    self.bind.active_slotNode = self.slotId and 0 < self.slotId
    if self.slotId and 0 < self.slotId then
      self.bind.txt_slotNum = tostring(self.slotId)
    end
    local petItem = L_PetStore:getPetItem(self.petGuid)
    local petCfg = petTpl:getTplById(petItem:petCfgId())
    self.bind.img_Icon = petTpl:getPetIcon(petCfg, petItem:isSpecialPet())
    self.bind.txt_level = tostring(petItem:petLv())
    self.bind.txt_cost = tostring(L_PetStore:getPetOriginalCost(petItem:petCfgId()))
    local elementId = petTpl:getFirstElement(petCfg)
    local eTpl = elementTpl:getTplById(elementId)
    self.bind.img_elementIcon = elementTpl:getPetElem(eTpl)
    local property = L_PetStore:getPetOriginalProperty(petItem)
    self.bind.txt_gradeValue = tostring(property.grade)
    local gradeTpl = petGradeTpl:getTplById(property.gradeRank)
    self.bind.img_grade = petGradeTpl:getIcon(gradeTpl)
    if property.gradeRank == 9 then
      self.bindComponents.gradeBgEffect:LoadSprite("Page/PetGet/tex_pet_bg_pzysbg2")
      local _, color = C_ColorUtility.TryParseHtmlString("#FFFFFF")
      self.bindComponents.gradeBgEffect.color = color
    else
      self.bindComponents.gradeBgEffect:LoadSprite("Page/PetGet/tex_pet_bg_pzysbg")
      local _, color = C_ColorUtility.TryParseHtmlString(colorEnums[property.gradeRank])
      self.bindComponents.gradeBgEffect.color = color
    end
    return
  end
end

return cls
