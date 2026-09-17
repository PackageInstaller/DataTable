local this = class("cellResourceItem", G_UIModuleBase)

function this:created(...)
  this.super.created(self, ...)
  self.data = {
    position = {
      [1] = {-724, 51},
      [2] = {-358, -161},
      [3] = {-28, 32},
      [4] = {307, 143},
      [5] = {739, -53}
    }
  }
end

function this.bind()
  return {
    openTime = "",
    name = "",
    desc = "",
    cost = "",
    icon = "",
    itemPos = C_Vector3(0, 0, 0),
    cost_group = false,
    show_limit = false,
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
  self:refreshPos()
  self.bind.cost_group = not self.bind.show_close
  self.bind.topTips = self.bind.up_status and true or false
end

function this:refresh()
  self:refreshPos()
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.bg)
end

function this:refreshPos()
  local pos = self.data.position[self.bind.index]
  self.bind.itemPos = C_Vector3(pos[1], pos[2], 0)
  self.bindComponents.itemColor.color = self.bind.show_close == true and C_Color(0.75, 0.75, 0.75) or C_Color(1, 1, 1)
end

return this
