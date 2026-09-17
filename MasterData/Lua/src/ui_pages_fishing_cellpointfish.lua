local this = class("cellPointFish", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    go_lock = false,
    go_unLock = false,
    module_icon = L_Const.ModuleInfo.CellIconCircle
  }
end

function this:refresh()
  if self.bind.go_unLock then
    self.modules.module_icon:setGeneralContent(L_Const.resType.commonItem, self.bind.itemId)
  end
end

return this
