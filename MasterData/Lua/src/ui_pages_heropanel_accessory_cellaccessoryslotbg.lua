local this = class("cellAccessorySlotBg", G_UIModuleBase)

function this.bind()
  return {
    go_empty = false,
    go_half = false,
    go_halfdown = false,
    go_equipped = false
  }
end

function this:open()
end

function this:initModule(list_slot)
  if not list_slot then
    return
  end
  self:setModuleStatus()
  if list_slot[1].go_empty then
    if list_slot[2].go_empty then
      self.bind.go_empty = true
    else
      self.bind.go_halfdown = true
    end
  elseif list_slot[2].go_empty then
    self.bind.go_half = true
  else
    self.bind.go_equipped = true
  end
end

function this:setModuleStatus()
  self.bind.go_empty = false
  self.bind.go_half = false
  self.bind.go_halfdown = false
  self.bind.go_equipped = false
end

return this
