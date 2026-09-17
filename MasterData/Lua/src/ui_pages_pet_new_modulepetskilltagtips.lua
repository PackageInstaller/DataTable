local this = class("modulePetSkillTagTips", G_UIModuleBase)
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    list_capacity = {
      moduleName = "pages/pet/cellPetSkillTagTips"
    }
  }
end

function this:Init(petCfgId)
  self:refreshModule(petCfgId)
end

function this:refreshModule(configId)
  local petData = _petTpl:getTplById(configId)
  local skillList = _petTpl:getSignatureSkillList(petData)
  local sList = {}
  for _, skill in ipairs(skillList) do
    table.insert(sList, {
      petId = configId,
      id = skill[2],
      ele = _petTpl:getFirstElement(petData)
    })
  end
  self.bind.list_capacity:clear()
  self.bind.list_capacity:insert_array(sList)
  self:UpdateContainerVerticalLayout(self.bindComponents.rect)
end

function this:UpdateContainerVerticalLayout(rect)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local height = rect:GetComponent("VerticalLayoutGroup").preferredHeight + 2
  rect:SetSizeWithCurrentAnchors(1, height)
end

return this
