_class("AircrafBuildNeedMat", Object)
AircrafBuildNeedMat = AircrafBuildNeedMat

function AircrafBuildNeedMat:Constructor()
  self._matID = 0
  self._count = 0
end

function AircrafBuildNeedMat:Init(matID, count)
  self._matID = matID
  self._count = count
end
