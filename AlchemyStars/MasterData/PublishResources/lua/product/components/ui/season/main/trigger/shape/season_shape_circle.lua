_class("SeasonShapeCircle", SeasonShapeBase)
SeasonShapeCircle = SeasonShapeCircle

function SeasonShapeCircle:Constructor(position, param)
  self._position = position
  self._radius = param
end

function SeasonShapeCircle:Dispose()
end

function SeasonShapeCircle:OnCheck(position)
  return Vector2.Distance(Vector2(position.x, position.z), self._position) <= self._radius
end
