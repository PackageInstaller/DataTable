_class("SMazePathMovement", Object)
SMazePathMovement = SMazePathMovement

function SMazePathMovement:Constructor(player, speed)
  self._player = player
  self._speed = speed
  self._idx = 0
  self._timer = 0
  self._duration = 0
end

function SMazePathMovement:Start(points)
  self._points = points
  self._run = true
  self._timer = 0
  self._from = self._player:Position():Clone()
  self._idx = 1
  self._to = self._points[self._idx]
  local distance = Vector3.Distance(self._from, self._to)
  self._duration = distance / self._speed * 1000
end

function SMazePathMovement:Update(dt)
  if not self._run then
    return
  end
  self._timer = self._timer + dt
  local percent = self._timer / self._duration
  if 1 <= percent then
    self._idx = self._idx + 1
    if self._idx > #self._points then
      self._run = false
    else
      self._timer = 0
      self._from = self._to
      self._to = self._points[self._idx]
      local distance = Vector3.Distance(self._from, self._to)
      self._duration = distance / self._speed * 1000
    end
  else
    local pos = Vector3.Lerp(self._from, self._to, percent)
    self._player:SetPos(pos)
  end
end

function SMazePathMovement:BeFinished()
  return not self._run
end

function SMazePathMovement:Target()
  return self._to
end
