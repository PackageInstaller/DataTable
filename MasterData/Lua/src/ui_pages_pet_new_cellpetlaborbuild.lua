local this = class("cellPetLaborBuild", G_UIModuleBase)

function this.bind()
  return {
    img_select = "",
    active_select = false,
    module_basicItem = L_Const.ModuleInfo.CellBasicItem
  }
end

function this:open()
end

function this:setCellIconBagShowParams(params)
  params = params or {}
  self.modules.module_basicItem:setDataContent(params)
end

return this
