local this = class("cellFish", G_UIModuleBase)

function this.bind()
  return {
    go_lock = false,
    go_unLock = false,
    module_icon = L_Const.ModuleInfo.CellIcon,
    txt_name = "",
    go_active = false,
    go_new = false
  }
end

function this:refresh()
  self.modules.module_icon:setGeneralContent(L_Const.resType.commonItem, self.bind.id, {
    noTip = self.bind.noTip,
    callback = self.bind.select and function()
      self:emit("onClick_select", self.bind)
    end or nil
  })
end

return this
