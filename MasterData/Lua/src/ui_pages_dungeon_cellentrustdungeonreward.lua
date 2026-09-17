local this = class("cellEntrustDungeonReward", G_UIModuleBase)

function this.bind()
  return {
    module_cellIconBag = {
      moduleName = L_Const.ModuleInfo.CellIconBag
    },
    img_finishStar = "",
    activeExtra = false,
    active_FxNormal = false,
    active_FxGlod = false,
    active_self = true
  }
end

function this.methods()
  return {}
end

return this
