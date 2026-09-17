local this = class("cellActivitySurveyAward", G_UIModuleBase)

function this.bind()
  return {
    cell_award = {
      moduleName = "modulePages/cellIconBag"
    },
    active_mask = false,
    active_finish = false
  }
end

function this.methods()
  return {}
end

function this:open()
  self.modules.cell_award:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNum = self.bind.itemNum
  })
end

function this:show()
end

return this
