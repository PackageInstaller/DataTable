local DetectIntervals = {
  [1] = 0.5,
  [2] = 1.5
}
local AILogic = class("AILogic")

function AILogic:ctor(params)
  self.player = params.player
  self.battle = self.player.battle
  self.aiLevel = params.ailevel
  self.detectInterval = DetectIntervals[1]
end

function AILogic:update(dt)
  self.detectInterval = self.detectInterval - dt
  if self.detectInterval > 0 then
    return
  end
  self.detectInterval = DetectIntervals[1]
  local change = {Idle = true, Move = true}
  if not change[self.player:getState()] then
    return
  end
  local nearestPlayer = self.battle:nearestEnemy(self.player)
  if not nearestPlayer then
    return
  end
  local distance = nearestPlayer.xPos - self.player.xPos
  if math.abs(distance) > 150 then
    local cmd = self.player.direction == Direction.left and "left" or "right"
    if self.player.direction == Direction.left and 0 < distance or self.player.direction == Direction.right and distance < 0 then
      cmd = self.player.direction == Direction.left and "right" or "left"
    end
    self.player:setControlCmd("move_" .. cmd)
    self.detectInterval = DetectIntervals[1]
  else
    self.detectInterval = DetectIntervals[2]
  end
end

return AILogic
