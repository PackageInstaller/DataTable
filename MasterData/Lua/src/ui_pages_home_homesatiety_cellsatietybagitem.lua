local this = class("cellSatietyBagItem", G_UIModuleBase)

function this.bind()
  return {
    cellItem = L_Const.ModuleInfo.CellIconBag,
    satiety = "",
    itemNumText = "",
    satietyBgActive = true
  }
end

function this.methods()
  return {}
end

function this:refresh()
  if not self.isBind then
    return
  end
  self.bind.satietyBgActive = not self.bind.empty
  self.modules.cellItem:setContentActive(not self.bind.empty)
  if self.bind.empty then
    self.bind.itemNumText = ""
    self.bind.satiety = ""
    return
  end
  self.modules.cellItem:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNumTxt = self.bind.itemName,
    noTip = true,
    callback = function()
      self:emit("onClick_item", self)
    end
  })
  self.bind.itemNumText = tostring(self.bind.itemNum)
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

return this
