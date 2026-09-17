local this = class("cellCookRecipes", G_UIModuleBase)

function this.bind()
  return {
    icon = "",
    name = "",
    bg = "",
    type = "",
    choice = false
  }
end

function this.methods()
  return {
    onClick_curRecipes = function(self)
      self:emit("curRecipes", self.bind.id)
    end
  }
end

function this:open()
  local id = self.bind.id
  L_ReddotManager:registerReddot(self.bindComponents.reddotNew, string.format(L_ReddotManager.DotDef.CookNew, id))
end

return this
