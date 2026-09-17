local this = class("cellSituationStampItem", G_UIModuleBase)

function this.bind()
  return {icon = ""}
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.id)
    end
  }
end

function this:open()
end

function this:close()
end

return this
