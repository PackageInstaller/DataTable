local cls = class("cellIconPetDuelReward", G_UIModuleBase)

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
  self.bind.active_img_receive = L_PetDuelStore:getIsSuccess(self.bind.selectLevelId)
end

return cls
