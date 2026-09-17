local this = class("cellDungeonReward", G_UIModuleBase)

function this.bind()
  return {
    cellIcon_item = L_Const.ModuleInfo.CellIconBag,
    go_up = false
  }
end

function this.methods()
  return {}
end

function this:open()
  if self.isBind then
    self:initCell()
  end
end

function this:initCell()
  local cellIcon = self.modules.cellIcon_item
  cellIcon:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNumTxt = self.bind.itemNumTxt
  })
end

return this
