_class("BezierTool", Object)
BezierTool = BezierTool

function BezierTool.BezierCurve1(p0, p1, t)
  local p = Vector3.zero
  p = BezierTool.Vector3Mul(p0, 1 - t) + BezierTool.Vector3Mul(p1, t)
  return p
end

function BezierTool.BezierCurve2(p0, p1, p2, t)
  local p = Vector3.zero
  local t1 = (1 - t) * (1 - t)
  local t2 = 2 * t * (1 - t)
  local t3 = t * t
  p = BezierTool.Vector3Mul(p0, t1) + BezierTool.Vector3Mul(p1, t2) + BezierTool.Vector3Mul(p2, t3)
  return p
end

function BezierTool.BezierCurve3(p0, p1, p2, p3, t)
  local p = Vector3.zero
  local t1 = (1 - t) * (1 - t) * (1 - t)
  local t2 = 3 * t * (1 - t) * (1 - t)
  local t3 = 3 * t * t * (1 - t)
  local t4 = t * t * t
  p = BezierTool.Vector3Mul(p0, t1) + BezierTool.Vector3Mul(p1, t2) + BezierTool.Vector3Mul(p2, t3) + BezierTool.Vector3Mul(p3, t4)
  return p
end

function BezierTool.Vector3Mul(v3, n)
  return Vector3(v3.x * n, v3.y * n, v3.z)
end
