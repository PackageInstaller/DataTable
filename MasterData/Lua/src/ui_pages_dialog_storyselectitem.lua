local item = class("storySelectItem", G_UIModuleBase)

function item.bind()
  return {storySelectButtonText = ""}
end

function item.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.storyId)
    end
  }
end

return item
