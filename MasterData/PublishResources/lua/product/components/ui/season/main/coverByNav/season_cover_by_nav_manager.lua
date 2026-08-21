_class("SeasonCoverByNavManager", Object)
SeasonCoverByNavManager = SeasonCoverByNavManager

function SeasonCoverByNavManager:Constructor()
  self._flag = "_navcover"
end

function SeasonCoverByNavManager:OnInit(seasonID)
  self._covers = {}
end

function SeasonCoverByNavManager:Update(deltaTime)
end

function SeasonCoverByNavManager:OnCoverCheck(areaName)
  for k, cover in pairs(self._covers) do
    if cover:OnCoverCheck(areaName) then
      cover:IncreaseBuildingY()
    else
      cover:ReduceBuildingY()
    end
  end
end

function SeasonCoverByNavManager:Dispose()
  for _, cover in pairs(self._covers) do
    cover:Dispose()
  end
  table.clear(self._covers)
end

function SeasonCoverByNavManager:CoverFlag()
  return self._flag
end

function SeasonCoverByNavManager:AddCover(transform, areaName)
  if transform and areaName then
    local cov = SeasonCoverByNav:New(transform, areaName)
    table.insert(self._covers, cov)
  end
end

function SeasonCoverByNavManager:_TryCleanCover()
end
