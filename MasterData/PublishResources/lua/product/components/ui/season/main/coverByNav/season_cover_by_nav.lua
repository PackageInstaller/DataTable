_class("SeasonCoverByNav", Object)
SeasonCoverByNav = SeasonCoverByNav

function SeasonCoverByNav:Constructor(transform, areaName)
  self._transform = transform
  self._rawPosition = transform.position
  self._navAreaName = areaName
  self._yDelta = 1
end

function SeasonCoverByNav:OnCoverCheck(areaName)
  return self._navAreaName == areaName
end

function SeasonCoverByNav:IncreaseBuildingY()
  self._transform.position = Vector3(self._rawPosition.x, self._rawPosition.y + self._yDelta, self._rawPosition.z)
end

function SeasonCoverByNav:ReduceBuildingY()
  self._transform.position = self._rawPosition
end

function SeasonCoverByNav:Dispose()
  self._transform = nil
end
