local Entity = import(".Entity")
local Pet = class("Pet", Entity)
local MOVE_UNIT = 180

function Pet:ctor(params)
  Pet.super.ctor(self, params)
  params = params or {}
  self.side = params.side or SIDE_LEFT
  self.id = params.id
  self.battle = params.battle
  self.map = params.map
  self.owner = params.owner
  self.xPos = params.xPos or 0
  self.idleTime = 0
  self.ownerDead = false
  self:bindEventListeners()
  self:initStatusMap()
end

function Pet:initStatusMap()
  self:setupState({
    initial = "None",
    events = {
      {
        name = "nothing",
        from = "None",
        to = "Idle"
      },
      {
        name = "nothing",
        from = "Move",
        to = "Idle"
      },
      {
        name = "round",
        from = "Idle",
        to = "Move"
      }
    },
    callbacks = {
      onenterIdle = function(event)
        if event.from ~= "None" then
          self.idleTime = math.randomInt(60, 180) / 60
        else
          self.idleTime = 1
        end
        self:onIdle(event)
      end,
      onenterMove = function(event)
        self:onMove(event)
      end
    }
  })
end

function Pet:bindEventListeners()
  self.owner:addEventListener("playerDead", function()
    self.ownerDead = true
    if self:canDoEvent("round") then
      self:doEvent("round")
    end
    local scaleX = self.armatureNode:getScaleX()
    if self.side == SIDE_LEFT and 0 < scaleX or self.side == SIDE_RIGHT and scaleX < 0 then
      self.armatureNode:setScaleX(self.armatureNode:getScaleX() * -1)
    end
    self.battle:getCamp(self.side):removePet(self)
    local time = 5
    local dis = time * MOVE_UNIT
    self.armatureNode:runAction(transition.sequence({
      cc.MoveBy:create(time, cc.p((self.side == SIDE_LEFT and -1 or 1) * dis, 0)),
      cc.CallFunc:create(function()
        self:dispose()
      end)
    }))
  end)
end

function Pet:update(dt)
  if self.hasPaused then
    return
  end
  if self.ownerDead then
    return
  end
  local state = self:getState()
  local idleStates = {
    Idle = {event = "round"}
  }
  local eventData = idleStates[state]
  if eventData then
    self.idleTime = self.idleTime - dt
    if self.idleTime < 0 or self.owner and self.battle:distance(self.owner, self) > math.random(50, 100) then
      if self:canDoEvent(eventData.event) then
        self:doEvent(eventData.event)
      end
      return
    end
  end
  local moveStep = MOVE_UNIT * dt
  if state == "Move" then
    local center = self.owner and self.owner.xPos or self.xPos
    local forward = self.side == SIDE_LEFT and center > self.xPos + 20 or self.side == SIDE_RIGHT and center < self.xPos - 20
    if math.abs(center - self.xPos) < moveStep + math.random(1, 30) then
      self:doEvent("nothing")
    end
    self:move(forward, moveStep)
    return
  end
end

function Pet:move(forward, distance)
  if forward then
    self.xPos = self.side == SIDE_LEFT and self.xPos + distance or self.xPos - distance
  else
    self.xPos = self.side == SIDE_LEFT and self.xPos - distance or self.xPos + distance
  end
  self:onUpdatePosition()
end

return Pet
