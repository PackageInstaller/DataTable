local this = class("cellText", G_UIModuleBase)

function this.bind()
  return {text = "", image = ""}
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.callback then
        self.bind.callback()
      end
    end
  }
end

return this
