local this = class("modulePetGeneSkillsNestCoopTips", G_UIModuleBase)

function this.bind()
  return {
    list_capacity = {
      moduleName = "pages/pet/new/cellPetTipsGene"
    },
    tog_Detail = nil
  }
end

function this.methods()
  return {
    onValueChanged_Detail = function(self, isOn)
    end
  }
end

function this:Init(listData)
  self:refreshModule(listData)
end

function this:refreshModule(listData)
  self.bind.list_capacity:clear()
  self.bind.list_capacity:insert_array(listData)
  self:refreshSizeDelta()
end

function this:showDetail(isOn)
  for i, v in pairs(self.modules.list_capacity) do
    v:showDetail(isOn)
  end
end

function this:refreshSizeDelta()
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rect_content)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rect)
  self:refreshBubbleBg()
end

function this:refreshBubbleBg()
  if self.tipRefreshBgFun ~= nil then
    self.tipRefreshBgFun()
  end
end

return this
