local this = class("cellMapNode", G_UIModuleBase)

function this.bind()
  return {imgIcon = nil, txtName = nil}
end

function this.methods()
  return {
    onClick_head = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

function this:toBind(uiBinding)
  this.super.toBind(self, uiBinding)
end

function this:setCellData(config)
  self.config = config
  self:refresh()
end

function this:refresh()
  if self.config == nil then
    return
  end
end

function this:destroy()
  self.config = nil
end

return this
