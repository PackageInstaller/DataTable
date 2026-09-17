local this = class("cellPetBoxEntrance", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    txtIndex = "",
    go_isFull = false,
    go_selected = false,
    hitArea = nil
  }
end

function this.methods()
  return {}
end

function this:refresh(data)
  if data then
    self.bind.boxIndex = data.boxIndex
    self.bind.isFull = data.isFull
  end
  self:refreshView()
end

function this:refreshView()
  if not self.isBind then
    return
  end
  if self.bind.boxIndex then
    self.bind.txtIndex = tostring(self.bind.boxIndex)
  end
  self.bind.go_isFull = self.bind.isFull or false
  self.bind.go_selected = false
end

function this:setSelected(isSelected)
  if self.isBind then
    self.bind.go_selected = isSelected and not self.bind.isFull
  end
end

return this
