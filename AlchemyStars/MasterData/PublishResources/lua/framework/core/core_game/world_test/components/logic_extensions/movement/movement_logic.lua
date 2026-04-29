_class("MovementByDirection", IMovement)

function MovementByDirection:Constructor(dir, maxspeed)
  self.Direction = dir
  self.max_speed = maxspeed
end

function MovementByDirection:Update(owner_entity, curPos, curDir, delta_time)
  if curDir ~= self.Direction then
    curDir = self.Direction:Clone()
    self.NextDirection = curDir
  end
  self.NextPosition = curPos:Add(curDir:Mul(delta_time * self.max_speed))
end

function MovementByDirection:SetMaxSpeed(max_speed)
  self.max_speed = max_speed
end

_class("MovementAlongPath", IMovement)

function MovementAlongPath:Constructor()
  self.m_cur_way_point = -1
  self.remain_time = 0
  self.path = ArrayList:New()
end

function MovementAlongPath:Update(curPos, curDir, delta_time)
end
