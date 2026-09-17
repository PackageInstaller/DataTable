local this = class("cellAchieveTogItem", G_UIModuleBase)

function this.bind()
  return {
    textChoice = "",
    text = "",
    go_active = false,
    go_normal = false
  }
end

function this.methods()
  return {
    onClick_collect = function(self)
      self:emit("onClick_select", self)
    end
  }
end

function this:open()
  self:registerReddot()
end

function this:registerReddot()
  if not self.isBind then
    return
  end
  local id = self.bind.id
  L_ReddotManager:registerReddot(self.bindComponents.reddotNormal, string.format(L_ReddotManager.DotDef.Achieve, id))
end

function this:setActive(selectId)
  self._selectId = selectId
  self:refresh()
end

function this:refresh()
  local active = self.bind.id == self._selectId
  self.bind.go_active = active
  self.bind.go_normal = not active
end

return this
