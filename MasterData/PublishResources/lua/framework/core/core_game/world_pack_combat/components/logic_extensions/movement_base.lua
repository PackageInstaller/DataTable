_class("IMovement", Object)

function IMovement:Constructor()
  self.NextPosition = Vector3(0, 0, 0)
  self.NextDirection = Vector3(0, 0, 0)
end

function IMovement:IsFinish()
  return false
end

function IMovement:Update(curPos, curDir, delta_time)
end
