local this = class("cellStaminaItem", G_UIModuleBase)

function this.bind()
  return {
    tag = false,
    txtTag = "",
    cellIconBag = L_Const.ModuleInfo.CellIconBag
  }
end

function this:setGeneral(type, id, param)
  self.modules.cellIconBag:setGeneralContent(type, id, param)
end

return this
