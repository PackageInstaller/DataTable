local MoveJoyDataUtils = {}

function MoveJoyDataUtils.SetMoveJoyAngle(angle1, angle2)
  DataCenter.moveJoyData.angle1 = angle1
  DataCenter.moveJoyData.angle2 = angle2
end

return MoveJoyDataUtils
