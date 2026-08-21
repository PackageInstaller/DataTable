_class("SeasonNavManager", Object)
SeasonNavManager = SeasonNavManager

function SeasonNavManager:Constructor()
  self._allNavTransPoint = {}
  self._useLineValueWhenNonePass = false
  self._transCostBias = 0.02
  self._navAreaMask = 1
  self._player = nil
  self._offMeshLinksData = {}
  self._moreIslandSeason = {
    [8006] = true
  }
end

function SeasonNavManager:HasMoreAsland(seasonId)
  return self._moreIslandSeason[seasonId]
end

function SeasonNavManager:SetPlayer(player)
  self._player = player
end

function SeasonNavManager:SetAreaMask(mask)
  if mask ~= self._navAreaMask then
    self._navAreaMask = mask
    if self._player then
      self._player:SetNavAreaMask(mask)
    end
  end
end

function SeasonNavManager:GetAreaMask()
  return self._navAreaMask
end

function SeasonNavManager:Clear()
  self._allNavTransPoint = {}
  self._navAreaMask = 1
end

function SeasonNavManager:AddTransPoint(zoneId, eventPoint)
  local point = SeasonNavTransPoint:New(zoneId, eventPoint)
  table.insert(self._allNavTransPoint, point)
end

function SeasonNavManager:FindOtherIslandPath(startZone, startPos, endZone, endPos, areaMask)
  self._areaMask = areaMask
  self.startTransPoint = self:FindBestTransPoint(startZone, startPos)
  self.endTransPoint = self:FindBestTransPoint(endZone, endPos)
  return self.startTransPoint, self.endTransPoint
end

function SeasonNavManager:FindBestTransPoint(zoneId, pos)
  local point
  local minCost = 1000000
  for k, subPoint in pairs(self._allNavTransPoint) do
    if subPoint:GetZoneID() == zoneId then
      local cost = self:_CalCost(pos, subPoint:GetNavPosition())
      cost = cost or 1000
      if minCost > cost then
        minCost = cost
        point = subPoint
      end
    end
  end
  return point
end

function SeasonNavManager:FindTrasnsPath(originPostion, targetPosition, areaMask)
  self._areaMask = areaMask
  local len = #self._allNavTransPoint
  if len < 2 then
    return
  end
  local hasMoreIsland
  local seasonId = GameGlobal.GetUIModule(SeasonModule):GetSeasonID()
  hasMoreIsland = self:HasMoreAsland(seasonId)
  self.minCost = self:_CalCost(originPostion, targetPosition)
  if not self.minCost then
    return
  end
  self.startTransPoint = nil
  self.endTransPoint = nil
  for i = 1, len - 1 do
    local firstPoint = self._allNavTransPoint[i]
    if firstPoint:IsUnLock() then
      for j = i + 1, len do
        local secondPint = self._allNavTransPoint[j]
        if secondPint:IsUnLock() then
          local checkZone = true
          if hasMoreIsland then
            checkZone = firstPoint:GetZoneID() == secondPint:GetZoneID()
          end
          if checkZone then
            self:CheckTransPath(originPostion, firstPoint, secondPint, targetPosition)
            self:CheckTransPath(originPostion, secondPint, firstPoint, targetPosition)
          end
        end
      end
    end
  end
  return self.startTransPoint, self.endTransPoint
end

function SeasonNavManager:CheckTransPath(originPos, startTransPoint, endTransPoint, targetPos)
  local pos = startTransPoint:GetPosition()
  pos.y = 0
  local c1 = self:_CalCost(originPos, pos)
  if not c1 then
    return
  end
  pos = endTransPoint:GetPosition()
  pos.y = 0
  local c2 = self:_CalCost(pos, targetPos)
  if not c2 then
    return
  end
  local sum = c1 + c2
  if sum < self.minCost then
    Log.info("seaonNav SeasonNavManager cost replace old ", self.minCost, " new ", sum)
    self.minCost = sum
    self.startTransPoint = startTransPoint
    self.endTransPoint = endTransPoint
  end
end

function SeasonNavManager:_CalCost(originPostion, targetPosition)
  if not originPostion or not targetPosition then
    Log.error("SeasonNavManager:_CalCost ")
    return
  end
  local path1 = UnityEngine.AI.NavMeshPath:New()
  local mask = self._areaMask
  local pass1 = UnityEngine.AI.NavMesh.CalculatePath(originPostion, targetPosition, mask, path1)
  local path2 = UnityEngine.AI.NavMeshPath:New()
  local pass2 = UnityEngine.AI.NavMesh.CalculatePath(targetPosition, originPostion, mask, path2)
  if not pass1 and not pass2 then
    if self._useLineValueWhenNonePass then
      local approxCost = originPostion.x * originPostion.x + targetPosition.z * targetPosition.z
      return approxCost
    end
    return
  end
  local cost1 = 10000
  local cost2 = 10000
  if pass1 then
    cost1 = self:_CalcCostByPath(path1)
  end
  if pass2 then
    cost2 = self:_CalcCostByPath(path2)
  end
  return math.min(cost1, cost2)
end

function SeasonNavManager:_CalcCostByPath(path)
  local corners = path.corners
  local len = corners.Length
  local cost = 0
  for i = 0, len - 2 do
    local p1 = corners[i]
    local p2 = corners[i + 1]
    p1.y = 0
    p2.y = 0
    cost = cost + Vector3.Distance(p1, p2)
  end
  return cost
end

function SeasonNavManager:InitOffMeshLinkData()
  self._offMeshLinksData = {}
  local seasonId = GameGlobal.GetUIModule(SeasonModule):GetSeasonID()
  local cfgs = Cfg.cfg_season_map_nav_link({SeasonID = seasonId})
  if not cfgs then
    return
  end
  for _, cfg in pairs(cfgs) do
    self._offMeshLinksData[cfg.Name] = cfg
  end
end

function SeasonNavManager:GetOffMeshLinkData(name)
  return self._offMeshLinksData[name]
end
