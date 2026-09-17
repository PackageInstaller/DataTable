local this = class("cellSatietyDot", G_UIModuleBase)

function this.bind()
  return {active_white = false, active_black = true}
end

function this.methods()
  return {}
end

function this:refreshIsWhiteDot(isWhite)
  self.bind.active_white = isWhite
  self.bind.active_black = not self.bind.active_white
end

function this:getItemIndex()
  return self.bind.itemIndex
end

return this
