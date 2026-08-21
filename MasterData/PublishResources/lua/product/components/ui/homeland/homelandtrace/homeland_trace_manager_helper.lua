_class("HomelandTraceManagerHelper", Object)
HomelandTraceManagerHelper = HomelandTraceManagerHelper
local SreenDirection = {
  Up = 1,
  Dowmn = 2,
  Lift = 3,
  Right = 4
}

function HomelandTraceManagerHelper:Constructor()
  self._traceConfig = Cfg.cfg_homeland_trace({})
  self._screenhfWidth = UnityEngine.Screen.width / 2
  self._screenhfHeight = UnityEngine.Screen.height / 2
  local xr = UnityEngine.Screen.width - 400.0
  local xy = UnityEngine.Screen.height - 400.0
  local aspect = self._screenhfWidth / self._screenhfHeight
  self._ellipseAxlex = xr / 2
  self._ellipseAxley = xy / 2
end

function HomelandTraceManagerHelper:Dispose()
  self._traceConfig = nil
end

function HomelandTraceManagerHelper:GetTraceInfo(id)
  return self._traceConfig[id]
end

function HomelandTraceManagerHelper:WorldToScreenPoint(camera, pos)
  if camera ~= nil and pos ~= nil then
    return camera:WorldToScreenPoint(pos)
  end
  return Vector2.zero
end

function HomelandTraceManagerHelper:ScreenPointToLocalPointInRectangle(rect, camera, pos)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, pos, camera, nil)
  return res, pos
end

function HomelandTraceManagerHelper:CheckInScreen(vec2)
  return vec2.x > 0 and vec2.x < UnityEngine.Screen.width and 0 < vec2.y and vec2.y < UnityEngine.Screen.height
end

function HomelandTraceManagerHelper:CheckInEllipse(x, y)
  local ori = Vector2(self._screenhfWidth, self._screenhfHeight)
  local xredis = self._ellipseAxlex
  local yredis = self._ellipseAxley
  x = x - ori.x
  y = y - ori.y
  return x * x / (xredis * xredis) + y * y / (yredis * yredis)
end

function HomelandTraceManagerHelper:CheckIntersect(lineStartPoint, lineEndPoint)
  local offset = Vector2(self._screenhfWidth, self._screenhfHeight)
  local crossPoint1, crossPoint2
  lineEndPoint = lineEndPoint - offset
  lineStartPoint = Vector2(0, 0)
  local k, c
  k = (lineEndPoint.y - lineStartPoint.y) / (lineEndPoint.x - lineStartPoint.x)
  c = lineStartPoint.y - k * lineStartPoint.x
  local xredis = self._ellipseAxlex
  local yredis = self._ellipseAxley
  local media = 2 * xredis * xredis * k * c * (2 * xredis * xredis * k * c) - 4 * (yredis * yredis + k * k * xredis * xredis) * xredis * xredis * (c * c - yredis * yredis)
  if 0 < media then
    crossPoint1 = Vector2(0, 0)
    crossPoint2 = Vector2(0, 0)
    crossPoint1.x = (-2 * xredis * xredis * k * c + math.sqrt(media)) / (2 * (yredis * yredis + k * k * xredis * xredis))
    crossPoint1.y = k * crossPoint1.x + c
    crossPoint2.x = (-2 * xredis * xredis * k * c - math.sqrt(media)) / (2 * (yredis * yredis + k * k * xredis * xredis))
    crossPoint2.y = k * crossPoint2.x + c
    crossPoint1 = crossPoint1 + offset
    crossPoint2 = crossPoint2 + offset
  else
    if media == 0 then
      crossPoint1 = Vector2(0, 0)
      crossPoint1.x = (-2 * xredis * xredis * k * c + math.sqrt(media)) / (2 * (yredis * yredis + k * k * xredis * xredis))
      crossPoint1.y = k * crossPoint1.x + c
      crossPoint1 = crossPoint1 + offset
    else
    end
  end
  return crossPoint1, crossPoint2, k
end

function HomelandTraceManagerHelper:CheckInLine(checkPoint, startPoint, endPoint)
  if not checkPoint then
    return
  end
  local vec1 = endPoint - checkPoint
  local vec2 = checkPoint - startPoint
  return Vector2.Dot(vec1, vec2) > 0
end

function HomelandTraceManagerHelper:GetDistance(form, to)
  if form and to then
    return Vector3.Distance(form, to)
  end
end
