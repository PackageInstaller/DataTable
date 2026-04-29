_class("HomelandNavmeshTool", Singleton)
HomelandNavmeshTool = HomelandNavmeshTool

function HomelandNavmeshTool:GetRandomPositionCircle(sRadius, center)
  for i = 1, 10 do
    local radius = UnityEngine.Random.Range(0, sRadius)
    local radian = UnityEngine.Random.Range(0, 360) * Mathf.Deg2Rad
    local x = Mathf.Cos(radian) * radius + center.x
    local y = center.y
    local z = Mathf.Sin(radian) * radius + center.z
    local hit, navMeshHit = UnityEngine.AI.NavMesh.SamplePosition(Vector3(x, y, z), nil, 100, 1)
    if hit then
      return navMeshHit.position
    end
  end
  return center
end

function HomelandNavmeshTool:GetRandomPositionRing(sRadius, bRadius, center)
  local radius = UnityEngine.Random.Range(sRadius, bRadius)
  local radian = UnityEngine.Random.Range(0, 360) * Mathf.Deg2Rad
  local x = Mathf.Cos(radian) * radius + center.x
  local y = center.y
  local z = Mathf.Sin(radian) * radius + center.z
  local hit, navMeshHit = UnityEngine.AI.NavMesh.SamplePosition(Vector3(x, y, z), nil, 100, 1)
  if hit then
    return navMeshHit.position
  end
  return center
end

function HomelandNavmeshTool:GetRandomPositionMap()
  local triangulation = UnityEngine.AI.NavMesh.CalculateTriangulation()
  local t = math.random(0, triangulation.indices.Length - 3)
  local point = Vector3.Lerp(triangulation.vertices[triangulation.indices[t]], triangulation.vertices[triangulation.indices[t + 1]], math.random())
  point = Vector3.Lerp(point, triangulation.vertices[triangulation.indices[t + 2]], math.random())
  return point
end

function HomelandNavmeshTool:PositionReachable(position)
  return UnityEngine.AI.NavMesh.SamplePosition(position, nil, 100, 1)
end

function HomelandNavmeshTool:PositionConnected(sourcePosition, targetPosition)
  if EDITOR then
    UnityEngine.Debug.DrawLine(sourcePosition, targetPosition, Color.yellow, 60)
  end
  local path = UnityEngine.AI.NavMeshPath:New()
  local connected = UnityEngine.AI.NavMesh.CalculatePath(sourcePosition, targetPosition, 1, path)
  if EDITOR and connected then
    for i = 0, path.corners.Length - 2 do
      UnityEngine.Debug.DrawLine(path.corners[i], path.corners[i + 1], Color.red, 60)
    end
  end
  return connected and path.status == UnityEngine.AI.NavMeshPathStatus.PathComplete
end

function HomelandNavmeshTool:GetReachablePosition(position)
  local hit, navMeshHit = UnityEngine.AI.NavMesh.SamplePosition(position, nil, 100, 1)
  if hit then
    return navMeshHit.position
  else
    return position
  end
end
