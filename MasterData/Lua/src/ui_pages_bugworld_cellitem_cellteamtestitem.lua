local this = class("cellTeamTestItem", G_UIModuleBase)

function this.bind()
  return {txt_name = ""}
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.id)
    end
  }
end

return this
