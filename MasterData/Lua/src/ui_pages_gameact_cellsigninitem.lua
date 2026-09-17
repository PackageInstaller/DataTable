local this = class("cellSignInItem", G_UIModuleBase)

function this:created(...)
  this.super.created(self, ...)
end

function this.bind()
  return {
    show_important_icon = false,
    show_received_icon = false,
    show_today = false,
    item_icon = "",
    day_num = "",
    item_num = "",
    group_alpha = 1
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

function this:fresh()
end

function this:open()
  self.bind.group_alpha = self.bind.show_received_icon == true and 0.2 or 1
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.numBg)
end

return this
