local this = class("cellIconItemSatiety", G_UIModuleBase)

function this.bind()
  return {
    cellItem = L_Const.ModuleInfo.CellIconBag,
    satiety = "",
    activeSatiety = true,
    isSelect = false
  }
end

function this.methods()
  return {}
end

function this:refresh()
  if not self.isBind then
    return
  end
  self.bind.activeSatiety = not self.bind.empty
  self.modules.cellItem:setContentActive(not self.bind.empty)
  if self.bind.empty then
    self.bind.satiety = ""
    return
  end
  self.modules.cellItem:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNum = self.bind.itemNum,
    noTip = true,
    callback = function()
      self:emit("onClick_item", self)
    end
  })
  self.bind.satiety = string.format("+%d", self.bind.satietyScore)
end

function this:getCellRect()
  if not self.isBind then
    return nil
  end
  if not self.bindComponents then
    return nil
  end
  return self.bindComponents.cellRect
end

function this:changeSelect(isSelect)
  self.bind.isSelect = isSelect
end

return this
