_class("RotateBodyAreaResult", Object)
RotateBodyAreaResult = RotateBodyAreaResult

function RotateBodyAreaResult:Constructor(area)
  self._newArea = area
end

function RotateBodyAreaResult:GetBodyArea()
  return self._newArea
end
