_class("SeasonMazeCoverBase", Object)
SeasonMazeCoverBase = SeasonMazeCoverBase

function SeasonMazeCoverBase:Constructor(transform)
  self._yDelta = 2
  self._transform = transform
  self._rawPosition = transform.position
  self._covers = {}
end

function SeasonMazeCoverBase:AddBuildingCover(cover)
  table.insert(self._covers, cover)
end

function SeasonMazeCoverBase:OnCoverCheck(position)
  local z = position.z
  local x = position.x
  local targetCover
  for _, cover in pairs(self._covers) do
    if not targetCover then
      targetCover = cover
    elseif Mathf.Abs(cover.position.x - x) < Mathf.Abs(targetCover.position.x - x) then
      targetCover = cover
    end
  end
  if targetCover then
    return z < targetCover.position.z
  end
  return false
end

function SeasonMazeCoverBase:IncreaseBuildingY()
  self._transform.position = Vector3(self._rawPosition.x, self._rawPosition.y + self._yDelta, self._rawPosition.z)
end

function SeasonMazeCoverBase:ReduceBuildingY()
  self._transform.position = self._rawPosition + Vector3(0, 0.3, 0)
end

function SeasonMazeCoverBase:Dispose()
  self._transform = nil
  table.clear(self._covers)
end
