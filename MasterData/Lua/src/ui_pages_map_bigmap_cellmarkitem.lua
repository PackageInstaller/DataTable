local this = class("cellMarkItem", G_UIModuleBase)

function this.bind()
  return {
    icon = "",
    mask = false,
    mouseMark = false
  }
end

function this:open()
  self.bindComponents.icon:SetNativeSize()
end

function this.methods()
  return {
    onClick_choose = function(self)
      self:emit("onClick_choose", self.bind.id)
    end,
    onPointDown = function(self)
      self.bind.mouseMark = true
    end,
    onPointUp = function(self)
      self.bind.mouseMark = false
    end
  }
end

return this
