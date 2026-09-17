local this = class("cellEquipmentItem", G_UIModuleBase)
local starManualLevelTpl = L_GameTpl:getStarManualLevelTpl()

function this:created(...)
  this.super.created(self, ...)
end

function this.bind()
  return {
    openTime = "",
    cost = "",
    icon = "",
    show_close = false,
    show_goto = false,
    show_lock = false,
    close_reason = "",
    topTips = false
  }
end

function this.methods()
  return {
    onClick_goto = function(self)
      self:emit("onClick_goto", self.bind)
    end
  }
end

function this:open()
  self.bind.topTips = self.bind.up_status and true or false
end

function this:refresh()
end

return this
