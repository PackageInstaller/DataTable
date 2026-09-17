local cls = class("cellEntrustTrainTaskReward", G_UIModuleBase)

function cls.bind()
  return {
    active_img_receive = false,
    module_cellIcon = L_Const.ModuleInfo.CellIconBag
  }
end

function cls:refresh()
  self.modules.module_cellIcon:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNum = self.bind.num
  })
end

return cls
