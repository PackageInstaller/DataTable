local item = class("cellStatusRewardItem", G_UIModuleBase)

function item.bind()
  return {
    module_cellIcon = L_Const.ModuleInfo.CellIconBag,
    finishMask = false
  }
end

function item.methods()
  return {}
end

function item:open()
end

function item:hide()
end

function item:refresh()
  self:init()
end

function item:init()
  self.bind.finishMask = self.bind.isFinish == true
  self.modules.module_cellIcon:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNum = self.bind.itemNum
  })
end

return item
