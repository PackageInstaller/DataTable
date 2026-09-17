local this = class("cellPetPuzzle", G_UIModuleBase)
local petInfoTpl = L_GameTpl:getPetTpl()
local elementTypeTpl = L_GameTpl:getElementTypeTpl()

function this.bind()
  return {
    petIcon = "",
    havePetNode = false,
    emptyPetNode = true,
    modulePetAttributeList = {
      moduleName = "pages/petPuzzleRoulette/cellPetAttribute"
    }
  }
end

function this.methods()
  return {
    onClick_selectPet = function(self)
      self:emit("onClick_selectPet", self.isFake, self.bind.id, self.bind.petConfId)
    end
  }
end

function this:setPetId(id)
  self.isFake = false
  self.bind.id = id
  self.petItemData = L_PetStore:getPetItem(self.bind.id)
  self.bind.petConfId = nil
  if self.petItemData then
    self.bind.petConfId = self.petItemData.petId
  end
  self:refreshPetInfo()
end

function this:setPetConfId(petConfId)
  self.isFake = true
  self.bind.petConfId = petConfId
  self:refreshPetInfo()
end

function this:refreshPetInfo()
  if self.bind.petConfId then
    local tpl = petInfoTpl:getTplById(self.bind.petConfId)
    local unitID = petInfoTpl:getUnitID(tpl)
    if unitID then
      self.bind.petIcon = petInfoTpl:getPetIcon(tpl, self.petItemData and self.petItemData:isSpecialPet() or 0)
      local elements = petInfoTpl:getPuzzleType(tpl)
      local attributeData = {}
      for i, element in pairs(elements) do
        local elementColor = L_Const.petElementColor[element]
        local isSuccess, color = C_ColorUtility.TryParseHtmlString(elementColor)
        local tpl = elementTypeTpl:getTplById(element)
        local puzzleIcon = ""
        if tpl then
          local icon = elementTypeTpl:getPetPuzzleIcon(tpl)
          if icon then
            puzzleIcon = icon[2]
          end
        end
        table.insert(attributeData, {icon = puzzleIcon, attributeColor = color})
      end
      self.bind.modulePetAttributeList:clear()
      self.bind.modulePetAttributeList:insert_array(attributeData)
    end
  end
  local havePet = self.bind.petConfId ~= nil
  self.bind.emptyPetNode = not havePet
  self.bind.havePetNode = havePet
end

return this
