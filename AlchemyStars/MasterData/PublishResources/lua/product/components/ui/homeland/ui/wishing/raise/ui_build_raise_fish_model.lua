_class("UIBuildRaiseFishModel", Object)
UIBuildRaiseFishModel = UIBuildRaiseFishModel

function UIBuildRaiseFishModel:Constructor(buildTran, id, instanceId)
  self._id = id
  self._instaceId = instanceId
  local fishCfg = Cfg.cfg_item_homeland_fish[id]
  local prefabName = fishCfg.Model .. ".prefab"
  self._req = ResourceManager:GetInstance():SyncLoadAsset(prefabName, LoadType.GameObject)
  if not self._req then
    BuildError("找不到鱼模型:" .. prefabName)
    return
  end
  self._fishingAreaPointList = self:GetFishingAreaPolygon(buildTran)
  self._go = self._req.Obj
  self._go:SetActive(true)
  self._transform = self._req.Obj.transform
  local root = buildTran:Find("FishRoot")
  self._transform:SetParent(root)
  self._transform.localPosition = self:CalcInitPos(buildTran)
  self._transform.localRotation = Quaternion.identity
  self._dir = self:CalcInitDir()
  self._moveSpeed = fishCfg.MoveSpeed / 1000
  self._idleSpeed = fishCfg.MoveSpeed / 5000
  self._speed = self._moveSpeed
  self._buildCenter = root.position
  self._buildRadius = 2.5
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
    self:UpdateFish()
  end)
  self._lastChangeDirTime = GameGlobal:GetInstance():GetCurrentTime()
  self._changeDirInternal = Mathf.Random(1000, 3000)
  self._targetDir = Vector3.zero
  self._changingDir = false
  self._changeDirLen = 300
  self._changeDirStartTime = nil
  self._changeDirRange = {-10, 10}
  self._fishState = 1
  self._moveStartTime = GameGlobal:GetInstance():GetCurrentTime()
  self._moveTimeRange = {5000, 10000}
  self._moveLen = Mathf.Random(self._moveTimeRange[1], self._moveTimeRange[2])
  self._moveChangeDirInternalRange = {1000, 3000}
  local moveChangeDirInternal = Mathf.Random(self._moveChangeDirInternalRange[1], self._moveChangeDirInternalRange[2])
  self._moveChangeDirLenRange = {300, 400}
  local moveChangeDirLen = Mathf.Random(self._moveChangeDirLenRange[1], self._moveChangeDirLenRange[2])
  self._moveChangeDirRange = {-10, 10}
  self._idleStartTime = 0
  self._idleTimeRange = {1000, 5000}
  self._idleLen = Mathf.Random(self._idleTimeRange[1], self._idleTimeRange[2])
  self._idleChangeDirInternalRange = {1500, 3000}
  local idleChangeDirInternal = Mathf.Random(self._idleChangeDirInternalRange[1], self._idleChangeDirInternalRange[2])
  self._idleChangeDirLenRange = {500, 1000}
  local idleChangeDirLen = Mathf.Random(self._idleChangeDirLenRange[1], self._idleChangeDirLenRange[2])
  self._idleChangeDirRange = {-5, 5}
  self._changeDirLen = moveChangeDirLen
  self._changeDirInternal = moveChangeDirInternal
  self._changeDirRange = self._moveChangeDirRange
end

function UIBuildRaiseFishModel:CalcInitPos(buildTran)
  local fishingAreaObj = buildTran:Find("FishingArea")
  local pointPosList = {}
  for i = 0, fishingAreaObj.childCount - 1 do
    local childTransform = fishingAreaObj:GetChild(i)
    pointPosList[#pointPosList + 1] = childTransform.localPosition
  end
  local count = #pointPosList
  local randomIndex = Mathf.Random(1, count)
  local pointPos = pointPosList[randomIndex]
  local dir = pointPos.normalized
  local magnitude = math.floor(pointPos.magnitude)
  local randomLen = Mathf.Random(0, magnitude)
  local randomPos = pointPos + -dir * randomLen
  local inFishingArea = self:IsFishInArea(randomPos, pointPosList)
  if not inFishingArea then
    randomPos = Vector3(0, 0, 0)
  end
  return randomPos
end

function UIBuildRaiseFishModel:CalcInitDir()
  local targetDir = Vector3(Mathf.Random(5, 10) / 10, 0, Mathf.Random(5, 10) / 10).normalized
  local dirX = targetDir.x
  local dirZ = targetDir.z
  local randomDelta = Mathf.Random(-10, 10)
  local xOrz = Mathf.Random(0, 1)
  if 0 < xOrz then
    dirX = dirX + randomDelta
  else
    dirZ = dirZ + randomDelta
  end
  return Vector3(dirX, 0, dirZ).normalized
end

function UIBuildRaiseFishModel:UpdateFish()
  if self._fishState == 1 then
    self:CheckMoveToIdle()
  elseif self._fishState == 2 then
    self:CheckIdleToMove()
  end
  self:Move()
end

function UIBuildRaiseFishModel:CheckMoveToIdle()
  local currentTime = GameGlobal:GetInstance():GetCurrentTime()
  local curDelta = currentTime - self._moveStartTime
  if curDelta > self._moveLen then
    self._fishState = 2
    self._speed = self._idleSpeed
    self._idleLen = Mathf.Random(self._idleTimeRange[1], self._idleTimeRange[2])
    self._idleStartTime = currentTime
    local idleChangeDirLen = Mathf.Random(self._idleChangeDirLenRange[1], self._idleChangeDirLenRange[2])
    local idleChangeDirInternal = Mathf.Random(self._idleChangeDirInternalRange[1], self._idleChangeDirInternalRange[2])
    self._changeDirLen = idleChangeDirLen
    self._changeDirInternal = idleChangeDirInternal
    self._changeDirRange = self._idleChangeDirRange
  end
end

function UIBuildRaiseFishModel:CheckIdleToMove()
  local currentTime = GameGlobal:GetInstance():GetCurrentTime()
  local curDelta = currentTime - self._idleStartTime
  if curDelta > self._idleLen then
    self._fishState = 1
    self._speed = self._moveSpeed
    self._moveLen = Mathf.Random(self._moveTimeRange[1], self._moveTimeRange[2])
    self._moveStartTime = currentTime
    local moveChangeDirLen = Mathf.Random(self._moveChangeDirLenRange[1], self._moveChangeDirLenRange[2])
    local moveChangeDirInternal = Mathf.Random(self._moveChangeDirInternalRange[1], self._moveChangeDirInternalRange[2])
    self._changeDirLen = moveChangeDirLen
    self._changeDirInternal = moveChangeDirInternal
    self._changeDirRange = self._moveChangeDirRange
  end
end

function UIBuildRaiseFishModel:Move()
  if self._changingDir then
    self:DoChangeDir()
  else
    self:RandomMoveDir()
  end
  local nextPos = self._transform.position + self._dir * self._speed * UnityEngine.Time.deltaTime
  local inFishingArea = self:IsFishInArea(nextPos, self._fishingAreaPointList)
  if not inFishingArea then
    self._dir = (self._buildCenter - self._transform.position).normalized
    local dirX = self._dir.x
    local dirZ = self._dir.z
    local randomDelta = Mathf.Random(-10, 10)
    local delta = randomDelta / 500
    local xOrz = Mathf.Random(0, 1)
    if 0 < xOrz then
      dirX = dirX + delta
    else
      dirZ = dirZ + delta
    end
    self._dir = Vector3(dirX, 0, dirZ).normalized
    self._changingDir = false
    self._lastChangeDirTime = GameGlobal:GetInstance():GetCurrentTime()
  else
    self._transform.position = nextPos
    self._transform.rotation = Quaternion.LookRotation(self._dir)
  end
end

function UIBuildRaiseFishModel:CheckFishCollider()
  local meshExtents = GameObjectHelper.FindFirstSkinedMeshRenderBoundsExtent(self._transform.gameObject)
  local rightOrigin = self._transform.position + Vector3(0, meshExtents.y, 0)
  local leftOrigin = self._transform.position - Vector3(0, meshExtents.y, 0)
  local distance = meshExtents.x + 0.1
  local rightCastRes = self:FishRayCast(rightOrigin, self._transform.forward, distance)
  local leftCastRes = self:FishRayCast(leftOrigin, self._transform.forward, distance)
  if rightCastRes or leftCastRes then
    return true
  end
  return false
end

function UIBuildRaiseFishModel:FishRayCast(origin, forward, distance)
  local layMask = 2 ^ LayerMask.NameToLayer("Scene")
  local castRes, hitInfo = UnityEngine.Physics.Raycast(origin, forward, nil, distance, layMask)
  if castRes ~= true or hitInfo then
  end
  return castRes, hitInfo
end

function UIBuildRaiseFishModel:RandomMoveDir()
  local currentTime = GameGlobal:GetInstance():GetCurrentTime()
  local curDelta = currentTime - self._lastChangeDirTime
  if curDelta > self._changeDirInternal then
    self._lastChangeDirTime = currentTime
    local dirX = self._dir.x
    local dirZ = self._dir.z
    local delataValue = Mathf.Random(self._changeDirRange[1], self._changeDirRange[2])
    if Mathf.Abs(delataValue) > 0 then
      delataValue = delataValue / 20
    end
    local xOrz = Mathf.Random(0, 1)
    if 0.5 < xOrz then
      dirX = dirX + delataValue
    else
      dirZ = dirZ + delataValue
    end
    self._targetDir = Vector3(dirX, 0, dirZ).normalized
    self._changingDir = true
    self._changeDirStartTime = currentTime
  end
end

function UIBuildRaiseFishModel:DoChangeDir()
  local dotVal = Vector3.Angle(self._dir, self._targetDir)
  if dotVal < 0.01 then
    self._changingDir = false
    return
  end
  local currentTime = GameGlobal:GetInstance():GetCurrentTime()
  local curDelta = currentTime - self._changeDirStartTime
  local dirRes = Vector3.Slerp(self._dir, self._targetDir, curDelta / self._changeDirLen)
  self._dir = dirRes
end

function UIBuildRaiseFishModel:Destroy()
  self._go = nil
  self._transform = nil
  if self._req then
    self._req:Dispose()
  end
  self._req = nil
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIBuildRaiseFishModel:GetFishingAreaPolygon(buildTran)
  local fishingAreaObj = buildTran:Find("FishingArea")
  local areaNode = {}
  for i = 0, fishingAreaObj.childCount - 1 do
    local childTransform = fishingAreaObj:GetChild(i)
    areaNode[#areaNode + 1] = childTransform.position
  end
  return areaNode
end

function UIBuildRaiseFishModel:IsFishInArea(fishPos, areaPointList)
  local crossNum = 0
  local areaPointCount = #areaPointList
  for i = 1, areaPointCount do
    local v1 = areaPointList[i]
    local nextIndex = i + 1
    if areaPointCount < nextIndex then
      nextIndex = 1
    end
    local v2 = areaPointList[nextIndex]
    if v2 == nil then
      Log.fatal("next index :", nextIndex, " i:", i)
    end
    local underZ = v1.z <= fishPos.z and v2.z > fishPos.z or v1.z > fishPos.z and v2.z <= fishPos.z
    if underZ then
      local intersectX = v1.x + (fishPos.z - v1.z) / (v2.z - v1.z) * (v2.x - v1.x)
      if intersectX > fishPos.x then
        crossNum = crossNum + 1
      end
    end
  end
  if crossNum % 2 == 0 then
    return false
  else
    return true
  end
end
