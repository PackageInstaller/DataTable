local state = class("petDuelCardDrag.dragging")

function state:ctor(parent)
  self.owner = parent
  self.stateName = "dragging"
end

function state:enter(lastState)
end

function state:exit(nextState)
end

function state:onUpdate()
end

return state
