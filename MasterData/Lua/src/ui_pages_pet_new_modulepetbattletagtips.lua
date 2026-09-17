local this = class("modulePetBattleTagTips", G_UIModuleBase)

function this.bind()
  return {
    list_capacity = {
      moduleName = "pages/pet/cellPetBattleTagTips"
    }
  }
end

function this:Init(data)
  local petCfgId = data.configId
  local pet = data.pet
  self:refreshModule(petCfgId, pet)
end

function this:refreshModule(configId, pet)
  local tagData = {}
  local kiboFeatureSkill = pet ~= nil and L_PetStore:getPetFeatureSkill(pet) or L_PetManager:getFPropertySkillList(configId)
  for i, v in ipairs(kiboFeatureSkill) do
    local typeId = i % 3 == 0 and 3 or i % 3
    local parms = {
      label = string.format("%s", v.skillName),
      itemIcon = v.itemIcon,
      describe = v.describe,
      type = typeId
    }
    table.insert(tagData, {type = "featureTag", parms = parms})
  end
  self.bind.list_capacity:clear()
  self.bind.list_capacity:insert_array(tagData)
  self:UpdateContainerVerticalLayout(self.bindComponents.rect)
end

function this:UpdateContainerVerticalLayout(rect)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local height = rect:GetComponent("VerticalLayoutGroup").preferredHeight + 2
  rect:SetSizeWithCurrentAnchors(1, height)
end

return this
