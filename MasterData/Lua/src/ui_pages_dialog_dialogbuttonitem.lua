local item = class("dialogButtonItem", G_UIModuleBase)

function item.bind()
  return {
    toggle_select = false,
    active_buttonBg = false,
    dialogButtonText = ""
  }
end

function item.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.selectDialogue)
    end,
    onPointEnter = function(self)
      self:emit("onPointEnter", self.bind.selectDialogue)
    end
  }
end

return item
