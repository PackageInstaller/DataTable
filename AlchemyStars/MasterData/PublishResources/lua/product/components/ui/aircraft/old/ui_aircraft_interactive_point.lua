_class("UIAircraftInteractivePoint", Object)
UIAircraftInteractivePoint = UIAircraftInteractivePoint

function UIAircraftInteractivePoint:Constructor(pos, targetPos, faceIDList)
  self._pos = pos
  self._targetPos = targetPos
  self._forward = nil
  if targetPos then
    self._forward = targetPos - pos
  end
  self._faceIDList = faceIDList
  self._index = 0
end

function UIAircraftInteractivePoint:GetPos()
  return self._pos
end

function UIAircraftInteractivePoint:GetForward()
  return self._forward
end

function UIAircraftInteractivePoint:GetFaceIDList()
  return self._faceIDList
end

function UIAircraftInteractivePoint:SetIndex(index)
  self._index = index
end

function UIAircraftInteractivePoint:GetIndex()
  return self._index
end
