local VideoPositionAdj = NewClass("VideoPositionAdj")
local mainCam = CS.UnityEngine.Camera.main

function VideoPositionAdj:ctor(container)
  self.container = container
end

function VideoPositionAdj:LateUpdate()
  local zPos = mainCam.nearClipPlane + 0.01
  local cameraWorldPos = mainCam.cameraToWorldMatrix:GetColumn(3)
  local worldForward = -mainCam.cameraToWorldMatrix:GetColumn(2)
  local posx = cameraWorldPos.x + worldForward.x * zPos
  local posy = cameraWorldPos.y + worldForward.y * zPos
  local posz = cameraWorldPos.z + worldForward.z * zPos
  local ex, ey, ez = CS.Framework.TransformUtil.GetEulerAngles(mainCam.transform, nil, nil, nil)
  local sx, sy, sz = CS.Framework.TransformUtil.GetLocalScale(mainCam.transform, nil, nil, nil)
  CS.Framework.TransformUtil.SetPos(self.container.transform, posx, posy, posz)
  CS.Framework.TransformUtil.SetEulerAngles(self.container.transform, ex, ey, ez)
  local scale = math.tan(mainCam.fieldOfView * math.pi / 180 * 0.5) * zPos * 2.0
  local signX = self:_Sign(sx)
  local signY = self:_Sign(sy)
  local signZ = self:_Sign(sz)
  local aspect = 2.1666666666666665
  local scaleX = math.max(aspect, mainCam.aspect) * scale
  CS.Framework.TransformUtil.SetLocalScale(self.container.transform, scaleX * signX, scale * signY, signZ)
end

function VideoPositionAdj:_Sign(val)
  if val > 0 then
    return 1
  elseif val < 0 then
    return -1
  end
  return 0
end

return VideoPositionAdj
