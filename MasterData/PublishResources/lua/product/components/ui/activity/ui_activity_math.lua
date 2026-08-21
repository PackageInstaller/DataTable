_class("UIActivityMath", Object)
UIActivityMath = UIActivityMath

function UIActivityMath:Constructor()
end

function UIActivityMath.IsInRect(p, rect)
  return p.x >= rect.xMin and p.x <= rect.xMax and p.y >= rect.yMin and p.y <= rect.yMax
end

function UIActivityMath.IsIntersection_V2(a, b, c, d)
  return UIActivityMath.IsIntersection(Vector3(a.x, 0, a.y), Vector3(b.x, 0, b.y), Vector3(c.x, 0, c.y), Vector3(d.x, 0, d.y))
end

function UIActivityMath.IsIntersection(a, b, c, d)
  local c1 = Vector3.Cross(d - c, a - c)
  local c2 = Vector3.Cross(d - c, b - c)
  local crossA = Mathf.Sign(Vector3.Cross(d - c, a - c).y)
  local crossB = Mathf.Sign(Vector3.Cross(d - c, b - c).y)
  if Mathf.Approximately(crossA, crossB) then
    return false
  end
  local crossC = Mathf.Sign(Vector3.Cross(b - a, c - a).y)
  local crossD = Mathf.Sign(Vector3.Cross(b - a, d - a).y)
  if Mathf.Approximately(crossC, crossD) then
    return false
  end
  return true
end

function UIActivityMath.Cross(p1, p2, p3, p4)
  return (p2.x - p1.x) * (p4.y - p3.y) - (p2.y - p1.y) * (p4.x - p3.x)
end

function UIActivityMath.Area(p1, p2, p3)
  return UIActivityMath.Cross(p1, p2, p1, p3)
end

function UIActivityMath.fArea(p1, p2, p3)
  return Mathf.Abs(UIActivityMath.Area(p1, p2, p3))
end

function UIActivityMath.Inter(p1, p2, p3, p4)
  local s1 = UIActivityMath.fArea(p1, p2, p3)
  local s2 = UIActivityMath.fArea(p1, p2, p4)
  return Vector2((p4.x * s1 + p3.x * s2) / (s1 + s2), (p4.y * s1 + p3.y * s2) / (s1 + s2))
end
