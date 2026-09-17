local item = class("dialogButtonItem2", G_UIModuleBase)

function item.bind()
  return {dialogButtonText = ""}
end

function item.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.branchNodeGuid)
    end
  }
end

return item
