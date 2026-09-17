local this = class("cellActivitySubmitItem", G_UIModuleBase)

function this.bind()
  return {
    module_cellIconBag = {
      moduleName = L_Const.ModuleInfo.CellIconBag
    }
  }
end

function this.methods()
  return {}
end

return this
