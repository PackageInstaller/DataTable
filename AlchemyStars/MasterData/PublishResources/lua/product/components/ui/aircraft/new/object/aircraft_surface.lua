_class("AircraftSurface", Object)
AircraftSurface = AircraftSurface

function AircraftSurface:Constructor(cfg, tiles)
  self._width = cfg.Width
  self._height = cfg.Height
  self._id = cfg.ID
  self._gridType = cfg.GridType
  local M = 99999999
  local xMin, yMin = M, M
  local xMax, yMax = -M, -M
  local Max = math.max
  local Min = math.min
  for x, ts in pairs(tiles) do
    for y, _ in pairs(ts) do
      xMin = Min(x, xMin)
      xMax = Max(x, xMax)
      yMin = Min(y, yMin)
      yMax = Max(y, yMax)
    end
  end
  xMin = xMin - 1
  yMin = yMin - 1
  local width = xMax - xMin
  local height = yMax - yMin
  local go = GameObjectHelper.CreateEmpty(tostring(self._id), nil)
  go.layer = AircraftLayer.Surface
  go.transform.position = cfg.Position:Clone()
  go.transform.eulerAngles = cfg.Rotation:Clone()
  local collider = go:AddComponent(typeof(UnityEngine.BoxCollider))
  self._colliderSize = Vector3(width * GridHelper.SIZE, 0.01, height * GridHelper.SIZE)
  self._colliderCenter = Vector3(xMin * GridHelper.SIZE, -0.005, yMin * GridHelper.SIZE) + Vector3(width * GridHelper.SIZE / 2, 0, height * GridHelper.SIZE / 2)
  collider.size = self._colliderSize
  collider.center = self._colliderCenter
  self._go = go
  self._transform = go.transform
  self._pos = cfg.Position:Clone()
  self._right = go.transform.right:Clone()
  self._forward = go.transform.forward:Clone()
  self._up = go.transform.up:Clone()
  self._rot = go.transform.rotation
  self._tiles = tiles
end

function AircraftSurface:Dispose()
  if self._meshCreater then
    self._meshCreater:Destroy()
  end
  if self._matReq then
    self._matReq:Dispose()
  end
end

function AircraftSurface:ColliderSize()
  return self._colliderSize
end

function AircraftSurface:ColliderCenter()
  return self._colliderCenter
end

function AircraftSurface:Width()
  return self._width
end

function AircraftSurface:Height()
  return self._height
end

function AircraftSurface:ID()
  return self._id
end

function AircraftSurface:WorldPosition()
  return self._pos
end

function AircraftSurface:WorldRotation()
  return self._rot
end

function AircraftSurface:Right()
  return self._right
end

function AircraftSurface:Forward()
  return self._forward
end

function AircraftSurface:Up()
  return self._up
end

function AircraftSurface:WorldToLocalPosition(pos)
  return self._transform:InverseTransformPoint(pos)
end

function AircraftSurface:GridType()
  return self._gridType
end

function AircraftSurface:Tiles()
  return self._tiles
end

function AircraftSurface:Show()
  if not self._hasMesh then
    self._hasMesh = true
    self._matReq = ResourceManager:GetInstance():SyncLoadAsset("AircraftTileMat.mat", LoadType.Mat)
    self._meshCreater = SurfaceCreater:New(self._go.transform, GridHelper.SIZE, self._matReq.Obj)
    for x, ts in pairs(self._tiles) do
      for y, _ in pairs(ts) do
        self._meshCreater:Push(x, y)
      end
    end
    self._meshCreater:Create()
  end
  self._go:SetActive(true)
end

function AircraftSurface:Hide()
  self._go:SetActive(false)
end

function AircraftSurface:CreateDragPlane(point)
  if self._dragPlane == nil then
    local go = GameObjectHelper.CreateEmpty("DragPlane", nil)
    local collider = go:AddComponent(typeof(UnityEngine.BoxCollider))
    collider.center = self._colliderCenter
    collider.size = self._colliderSize
    local t = go.transform
    t:SetParent(self._transform)
    t.localPosition = Vector3.zero
    t.localRotation = Quaternion.identity
    go.layer = AircraftLayer.DragLayer
    self._dragPlane = go
  end
  local localPos = self._transform:InverseTransformPoint(point)
  self._dragPlane.transform.localPosition = Vector3.zero + Vector3(0, localPos.y, 0)
end

function AircraftSurface:CheckDragPlane(go)
  return self._dragPlane == go
end

function AircraftSurface:CheckSurface(go)
  return self._go == go
end

function AircraftSurface:PlaneLocalPos(point)
  local localPos = self._dragPlane.transform:InverseTransformPoint(point)
  return GridHelper.LocalPos2GridPos(localPos)
end
