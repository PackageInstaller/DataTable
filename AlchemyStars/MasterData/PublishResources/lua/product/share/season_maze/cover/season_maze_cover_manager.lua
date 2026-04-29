_class("SeasonMazeCoverManager", Object)
SeasonMazeCoverManager = SeasonMazeCoverManager

function SeasonMazeCoverManager:Constructor()
  self._flag = "_cover"
end

function SeasonMazeCoverManager:OnInit(seasonID)
  self._covers = {}
  self._waitClearing = {}
end

function SeasonMazeCoverManager:Update(deltaTime)
end

function SeasonMazeCoverManager:OnCoverCheck(position)
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

function SeasonMazeCoverManager:Dispose()
  for _, cover in pairs(self._covers) do
    cover:Dispose()
  end
  table.clear(self._covers)
end

function SeasonMazeCoverManager:CoverFlag()
  return self._flag
end

function SeasonMazeCoverManager:AddCover(transform, cover)
  if transform and cover then
    if not self._covers[transform] then
      self._covers[transform] = SeasonMazeCoverBase:New(transform)
    end
    self._covers[transform]:AddBuildingCover(cover)
  end
end

function SeasonMazeCoverManager:ClearCover(transform)
  self._covers[transform] = nil
end

function SeasonMazeCoverManager:_TryCleanCover()
  for _, transform in pairs(self._waitClearing) do
    self._covers[transform] = nil
  end
end
