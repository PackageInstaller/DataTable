_class("ComponentSimulationOperationConfig", Object)
ComponentSimulationOperationConfig = ComponentSimulationOperationConfig

function ComponentSimulationOperationConfig:Constructor()
  self._allBuildingInfos = {}
  self._count = 0
  local allData = Cfg.cfg_component_simulation_operation()
  for k, v in pairs(allData) do
    local info = ComponentSimulationBuildingInfo:New(v)
    local bID = info.BuildingID
    if not self._allBuildingInfos[bID] then
      self._allBuildingInfos[bID] = {}
      self._count = self._count + 1
    end
    self._allBuildingInfos[bID][info.Level] = info
  end
end

function ComponentSimulationOperationConfig:GetBuildingCount()
  return self._count
end

function ComponentSimulationOperationConfig:GetBuildingAllLvInfo(buildingID)
  return self._allBuildingInfos[buildingID]
end

_class("ComponentSimulationBuildingInfo", Object)
ComponentSimulationBuildingInfo = ComponentSimulationBuildingInfo

function ComponentSimulationBuildingInfo:Constructor(data)
  self.ComponentID = data.ComponentID
  self.BuildingID = data.ArchitectureId
  self.Level = data.Level
  self.UpgradeCost = data.UpgradeCost
  self.PreCondition = data.PreCondition or {}
  self.DefaultNum = data.DefaultNum
  self.LimitNum = data.LimitNum
  self.StoryList = data.StoryList or {}
  self.Rate = data.Rate
  self.Rewards = self:SortReward(data.Rewards)
  self.Name = data.Name
  self.MapName = data.MapName
  self.Des = data.Des
  self.Icon = data.Icon
  self.Pic = data.Pic
  self.MapPos = self:TableToVector2(data.MapPos)
  self.BubbleNodePos = self:TableToVector2(data.BubbleNodePos)
  self.NamePos = self:TableToVector2(data.NamePos)
  self.BubbleReverse = data.BubbleReverse
end

function ComponentSimulationBuildingInfo:TableToVector2(tableValue)
  if not tableValue then
    return nil
  end
  local v = Vector2:New()
  v.x = tonumber(tableValue[1])
  v.y = tonumber(tableValue[2])
  return v
end

function ComponentSimulationBuildingInfo:SortReward(data)
  local newList = {}
  if not data then
    return newList
  end
  for key, v in pairs(data) do
    local id = v[1]
    if id == RoleAssetID.RoleAssetSimulationOperationCoin then
      table.insert(newList, v)
    end
  end
  for key, v in pairs(data) do
    local id = v[1]
    if id ~= RoleAssetID.RoleAssetSimulationOperationCoin then
      table.insert(newList, v)
    end
  end
  return newList
end
