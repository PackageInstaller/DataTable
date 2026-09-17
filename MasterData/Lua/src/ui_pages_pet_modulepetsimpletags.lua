local this = class("modulePetSimpleTags", G_UIModuleBase)
local wordsTpl = L_GameTpl:getWordsTpl()
local petInfoTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    active_special_obj = false,
    list_element = {
      moduleName = "pages/Pet/cellPetElement"
    },
    txt_stage = "",
    list_race = {
      moduleName = "pages/Pet/cellTagItem"
    }
  }
end

function this:setGuid(guid)
  local pet = L_PetStore:getPetItem(guid)
  if pet:isSpecialPet() and pet:isSpecialPet() > 0 then
    self.bind.active_special_obj = true
  else
    self.bind.active_special_obj = false
  end
  local petTpl = petInfoTpl:getTplById(pet.id)
  local elementData = {}
  local element = petInfoTpl:getElement(petTpl)
  for i, v in ipairs(element) do
    table.insert(elementData, {element = v, allElement = element})
  end
  self.bind.list_element:clear()
  self.bind.list_element:insert_array(elementData)
  local stage = petInfoTpl:getPetStage(petTpl)
  self.bind.txt_stage = wordsTpl:getTplById("ui_pet_stage" .. stage)
  local simpleTagData = {}
  local race = petInfoTpl:getRace(petTpl)
  for i = 1, #race do
    table.insert(simpleTagData, {
      label = wordsTpl:getTplById("pet_races_" .. race[i])
    })
  end
  self.bind.list_race:clear()
  self.bind.list_race:insert_array(simpleTagData)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.layoutNode)
end

function this:setConfigId(configId)
  self.bind.active_special_obj = false
  local petTpl = petInfoTpl:getTplById(configId)
  local elementData = {}
  local element = petInfoTpl:getElement(petTpl)
  for i, v in ipairs(element) do
    table.insert(elementData, {element = v, allElement = element})
  end
  self.bind.list_element:clear()
  self.bind.list_element:insert_array(elementData)
  local stage = petInfoTpl:getPetStage(petTpl)
  self.bind.txt_stage = wordsTpl:getTplById("ui_pet_stage" .. stage)
  local simpleTagData = {}
  local race = petInfoTpl:getRace(petTpl)
  for i = 1, #race do
    table.insert(simpleTagData, {
      label = wordsTpl:getTplById("pet_races_" .. race[i])
    })
  end
  self.bind.list_race:clear()
  self.bind.list_race:insert_array(simpleTagData)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.layoutNode)
end

return this
