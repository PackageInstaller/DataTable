local this = class("cellHealingItem", G_UIModuleBase)

function this.bind()
  return {
    cellItem = L_Const.ModuleInfo.CellIconBag,
    arrowActive = false
  }
end

function this:refresh()
  self.modules.cellItem:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNum = self.bind.itemNum,
    callback = self.bind.callback
  })
  self.modules.cellItem:setActive(self.bind.arrowActive)
end

function this:setActive(active)
  self.bind.arrowActive = active
  if self.modules.cellItem then
    self.modules.cellItem:setActive(active)
  end
end

function this:getItemId()
  return self.bind.itemId
end

return this
