_class("SeasonCoverManager", Object)
SeasonCoverManager = SeasonCoverManager

function SeasonCoverManager:Constructor()
  self._flag = "_cover"
end

function SeasonCoverManager:OnInit(seasonID)
  self._covers = {}
  self._waitClearing = {}
end

function SeasonCoverManager:Update(deltaTime)
end

function SeasonCoverManager:OnCoverCheck(position)
  table.clear(self._waitClearing)
  for transform, cover in pairs(self._covers) do
    if tolua.isnull(transform) then
      table.insert(self._waitClearing, transform)
    elseif cover:OnCoverCheck(position) then
      cover:IncreaseBuildingY()
    else
      cover:ReduceBuildingY()
    end
  end
  self:_TryCleanCover()
end

function SeasonCoverManager:Dispose()
  for _, cover in pairs(self._covers) do
    cover:Dispose()
  end
  table.clear(self._covers)
end

function SeasonCoverManager:CoverFlag()
  return self._flag
end

function SeasonCoverManager:AddCover(transform, cover)
  if transform and cover then
    if not self._covers[transform] then
      self._covers[transform] = SeasonCoverBase:New(transform)
    end
    self._covers[transform]:AddBuildingCover(cover)
  end
end

function SeasonCoverManager:ClearCover(transform)
  self._covers[transform] = nil
end

function SeasonCoverManager:_TryCleanCover()
  for _, transform in pairs(self._waitClearing) do
    self._covers[transform] = nil
  end
end
