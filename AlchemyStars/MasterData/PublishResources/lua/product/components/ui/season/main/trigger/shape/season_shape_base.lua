_class("SeasonShapeBase", Object)
SeasonShapeBase = SeasonShapeBase

function SeasonShapeBase:Constructor(seasonID)
  self._position = nil
end

function SeasonShapeBase:Dispose()
end

function SeasonShapeBase:OnCheck(position)
  return false
end
