_class("AircraftBoard", Object)
AircraftBoard = AircraftBoard

function AircraftBoard:Constructor(go, floor, os)
  self._gameObject = go
  self._floor = floor
  local points = UnityEngine.GameObject.Find("BoardPoints").transform:GetChild(floor - 1)
  self._pointHolder = AircraftPointHolder:New(points, self._floor, self._floor .. "层甲板漫游点")
  local gatherPoints = UnityEngine.GameObject.Find("BoardGatherPoints").transform:GetChild(floor - 1)
  self._gatherPointHolder = AircraftPointHolder:New(gatherPoints, self._floor, self._floor .. "层甲板社交聚集点")
  local randomPoints = UnityEngine.GameObject.Find("BoardRandomStoryPoints").transform:GetChild(floor - 1)
  self._randomStoryPointHolder = AircraftStoryPointHolder:New(randomPoints, self._floor)
  local navmeshObj = go
  local moduleNavMesh = navmeshObj:GetComponent("NavMeshSurface")
  if moduleNavMesh == nil then
    Log.fatal("找不到导航组件")
    return
  end
  moduleNavMesh.defaultArea = self._floor + 2
  moduleNavMesh:BuildNavMesh()
  for i = 0, navmeshObj.transform.childCount - 1 do
    navmeshObj.transform:GetChild(i).gameObject:SetActive(false)
  end
  navmeshObj = os
  local moduleNavMesh = navmeshObj:GetComponent("NavMeshSurface")
  if moduleNavMesh == nil then
    Log.fatal("找不到导航组件")
    return
  end
  moduleNavMesh.defaultArea = self._floor + 2
  moduleNavMesh:BuildNavMesh()
  for i = 0, navmeshObj.transform.childCount - 1 do
    navmeshObj.transform:GetChild(i).gameObject:SetActive(false)
  end
end

function AircraftBoard:PointHolder()
  return self._pointHolder
end

function AircraftBoard:RandomPoints()
  return self._randomStoryPointRoot, self._floor
end

function AircraftBoard:GatherPointHolder()
  return self._gatherPointHolder
end

function AircraftBoard:RandomStoryPointHolder()
  return self._randomStoryPointHolder
end

function AircraftBoard:ReleaseAllPoints()
  self._pointHolder:ReleaseAll()
  self._gatherPointHolder:ReleaseAll()
end
