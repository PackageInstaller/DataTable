_class("SeasonShowByNavManager", Object)
SeasonShowByNavManager = SeasonShowByNavManager

function SeasonShowByNavManager:Constructor()
  self._flag = "_navshow"
  self._showFlag = "show"
  self._hideFlag = "hide"
end

function SeasonShowByNavManager:OnInit(seasonID)
  self._covers = {}
  self.showListByArea = {}
  self.hideListByArea = {}
end

function SeasonShowByNavManager:Update(deltaTime)
end

function SeasonShowByNavManager:OnShowCheck(areaName)
  for k, listGo in pairs(self.showListByArea) do
    local visible = k == areaName
    for _, go in pairs(listGo) do
      go:SetActive(visible)
    end
  end
  for k, listgo in pairs(self.hideListByArea) do
    local visible = k ~= areaName
    for _, go in pairs(listgo) do
      go:SetActive(visible)
    end
  end
end

function SeasonShowByNavManager:Dispose()
  table.clear(self.showListByArea)
  table.clear(self.hideListByArea)
end

function SeasonShowByNavManager:CoverFlag()
  return self._flag
end

function SeasonShowByNavManager:AddCover(transform, areaName, showOrHide)
  if showOrHide == self._showFlag then
    local listGo = self.showListByArea[areaName]
    if not listGo then
      listGo = {}
      self.showListByArea[areaName] = listGo
    end
    table.insert(listGo, transform.gameObject)
  elseif showOrHide == self._hideFlag then
    local listGo = self.hideListByArea[areaName]
    if not listGo then
      listGo = {}
      self.hideListByArea[areaName] = listGo
    end
    table.insert(listGo, transform.gameObject)
  end
end

function SeasonShowByNavManager:_TryCleanCover()
end
