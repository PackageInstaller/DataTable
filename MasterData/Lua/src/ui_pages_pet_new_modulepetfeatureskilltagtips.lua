local this = class("modulePetFeatureSkillTagTips", G_UIModuleBase)
local petInfoTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    list_capacity = {
      moduleName = "pages/pet/cellPetFeatureSkillTagTips"
    }
  }
end

function this:Init(petCfgId)
  self:refreshModule(petCfgId)
end

function this:refreshModule(configId)
  local tagData = {}
  local kiboFeatureSkill = L_PetManager:getFPropertySkillList(configId)
  for i, v in ipairs(kiboFeatureSkill) do
    table.insert(tagData, {
      type = i % 3 == 0 and 3 or i % 3,
      skillInfo = v
    })
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
