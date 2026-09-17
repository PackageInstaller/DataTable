local this = class("modulePetGeneSkillsTips", G_UIModuleBase)

function this.bind()
  return {
    list_capacity = {
      moduleName = "pages/pet/new/cellPetTipsGene"
    }
  }
end

function this:Init(listData)
  self:refreshModule(listData)
end

function this:refreshModule(listData)
  self.bind.list_capacity:clear()
  self.bind.list_capacity:insert_array(listData)
end

function this:UpdateContainerVerticalLayout(rect)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local height = rect:GetComponent("VerticalLayoutGroup").preferredHeight + 2
  rect:SetSizeWithCurrentAnchors(1, height)
end

return this
