_class("UIBuildRaiseFishData", Object)
UIBuildRaiseFishData = UIBuildRaiseFishData

function UIBuildRaiseFishData:Constructor(id, instanceId, count)
  self._id = id
  self._instanceId = instanceId
  local itemCfg = Cfg.cfg_item[self._id]
  local fishCfg = Cfg.cfg_item_homeland_fish[self._id]
  self._icon = itemCfg.Icon
  self._name = StringTable.Get(itemCfg.Name)
  self._color = itemCfg.Color
  self._sort = fishCfg.Sort
  if count == nil then
    self._count = 1
  else
    self._count = count
  end
end

function UIBuildRaiseFishData:Clone()
  return UIBuildRaiseFishData:New(self._id, self._instanceId, self._count)
end

function UIBuildRaiseFishData:GetCount()
  return self._count
end

function UIBuildRaiseFishData:SetCount(count)
  self._count = count
end

function UIBuildRaiseFishData:MinusCount()
  self._count = self._count - 1
end

function UIBuildRaiseFishData:AddCount()
  self._count = self._count + 1
end

function UIBuildRaiseFishData:GetId()
  return self._id
end

function UIBuildRaiseFishData:GetInstanceId()
  return self._instanceId
end

function UIBuildRaiseFishData:SetInstanceId(instanceId)
  self._instanceId = instanceId
end

function UIBuildRaiseFishData:GetIcon()
  return self._icon
end

function UIBuildRaiseFishData:GetColor()
  return self._color
end

function UIBuildRaiseFishData:GetSortPriority()
  return self._sort
end

_class("UIBuildRaiseFishDatas", Object)
UIBuildRaiseFishDatas = UIBuildRaiseFishDatas

function UIBuildRaiseFishDatas:Constructor()
  local raiseFishIds = HomelandWishingConst.GetRaiseFishList()
  self._originalRaiseFish = {}
  for i = 1, #raiseFishIds do
    self._originalRaiseFish[#self._originalRaiseFish + 1] = UIBuildRaiseFishData:New(raiseFishIds[i].ID, raiseFishIds[i].InstanceId, 1)
  end
  self._raiseFish = self._originalRaiseFish
  self._remainFish = {}
  local remainFishList = HomelandWishingConst.GetRemainFishList()
  for i = 1, #remainFishList do
    local data = UIBuildRaiseFishData:New(remainFishList[i].ID, remainFishList[i].InstanceId, remainFishList[i].Count)
    self._remainFish[#self._remainFish + 1] = data
  end
  self._aquariumFish = {}
  local aquariumFishList = HomelandWishingConst.GetAquariumFishList()
  for buildPstId, fishs in pairs(aquariumFishList) do
    if not self._aquariumFish[buildPstId] then
      self._aquariumFish[buildPstId] = {}
    end
    for i = 1, #fishs do
      local data = UIBuildRaiseFishData:New(fishs[i].ID, fishs[i].InstanceId, fishs[i].Count)
      self._aquariumFish[buildPstId][#self._aquariumFish[buildPstId] + 1] = data
    end
  end
  self:Sort()
end

function UIBuildRaiseFishDatas:GetRaiseFish()
  return self._raiseFish
end

function UIBuildRaiseFishDatas:GetRemainFish()
  return self._remainFish
end

function UIBuildRaiseFishDatas:RaiseFish(raiseFishData)
  local fishData = raiseFishData:Clone()
  fishData:SetInstanceId(HomelandWishingConst.GenFishInstanceId())
  HomelandWishingConst.RaiseFish(fishData:GetId(), fishData:GetInstanceId())
  for i = 1, #self._remainFish do
    local data = self._remainFish[i]
    if data == raiseFishData then
      data:MinusCount()
      if data:GetCount() <= 0 then
        table.remove(self._remainFish, i)
      end
      break
    end
  end
  self._raiseFish[#self._raiseFish + 1] = fishData
  self:Sort()
  return fishData
end

function UIBuildRaiseFishDatas:UnRaiseFish(raiseFishData)
  HomelandWishingConst.UnRaiseFish(raiseFishData:GetId(), raiseFishData:GetInstanceId())
  for i = 1, #self._raiseFish do
    local data = self._raiseFish[i]
    if data == raiseFishData then
      table.remove(self._raiseFish, i)
      break
    end
  end
  for i = 1, #self._remainFish do
    local data = self._remainFish[i]
    if data:GetId() == raiseFishData:GetId() then
      data:AddCount()
      self:Sort()
      return
    end
  end
  raiseFishData:SetCount(1)
  self._remainFish[#self._remainFish + 1] = raiseFishData
  self:Sort()
end

function UIBuildRaiseFishDatas:GetRaiseFishCount()
  return #self._raiseFish
end

function UIBuildRaiseFishDatas:Sort()
  table.sort(self._raiseFish, function(a, b)
    local priorityA = a:GetSortPriority()
    local priorityB = b:GetSortPriority()
    if priorityA ~= priorityB then
      return priorityA < priorityB
    end
    if a:GetColor() ~= b:GetColor() then
      return a:GetColor() > b:GetColor()
    end
    return a:GetId() < b:GetId()
  end)
  table.sort(self._remainFish, function(a, b)
    local a1 = a
    local b1 = b
    local priorityA = a1:GetSortPriority()
    local priorityB = b1:GetSortPriority()
    if priorityA ~= priorityB then
      return priorityA < priorityB
    end
    if a1:GetColor() ~= b1:GetColor() then
      return a1:GetColor() > b1:GetColor()
    end
    return a1:GetId() < b1:GetId()
  end)
  for buildPstId, fishs in pairs(self._aquariumFish) do
    table.sort(fishs, function(a, b)
      local priorityA = a:GetSortPriority()
      local priorityB = b:GetSortPriority()
      if priorityA ~= priorityB then
        return priorityA < priorityB
      end
      if a:GetColor() ~= b:GetColor() then
        return a:GetColor() > b:GetColor()
      end
      return a:GetId() < b:GetId()
    end)
  end
end

function UIBuildRaiseFishDatas:GetAquariumFish()
  return self._aquariumFish
end

function UIBuildRaiseFishDatas:GetCurAquariumFish(buildPstID)
  local curAquariumFish = self._aquariumFish[buildPstID] or {}
  return curAquariumFish
end

function UIBuildRaiseFishDatas:GetCurAquariumFishCount(buildPstID)
  local curAquariumFish = self:GetCurAquariumFish(buildPstID)
  return #curAquariumFish
end

function UIBuildRaiseFishDatas:AddAquariumFish(buildPstID, raiseFishData)
  local fishData = raiseFishData:Clone()
  fishData:SetInstanceId(HomelandWishingConst.GenAquariumFishInstanceId(buildPstID))
  HomelandWishingConst.AddAquariumFish(buildPstID, fishData:GetId(), fishData:GetInstanceId())
  for i = 1, #self._remainFish do
    local data = self._remainFish[i]
    if data == raiseFishData then
      data:MinusCount()
      if data:GetCount() <= 0 then
        table.remove(self._remainFish, i)
      end
      break
    end
  end
  if not self._aquariumFish[buildPstID] then
    self._aquariumFish[buildPstID] = {}
  end
  self._aquariumFish[buildPstID][#self._aquariumFish[buildPstID] + 1] = fishData
  self:Sort()
  return fishData
end

function UIBuildRaiseFishDatas:RemoeAquariumFish(buildPstID, raiseFishData)
  HomelandWishingConst.RemoveAquariumFish(buildPstID, raiseFishData:GetId(), raiseFishData:GetInstanceId())
  for i = 1, #self._aquariumFish[buildPstID] do
    local data = self._aquariumFish[buildPstID][i]
    if data == raiseFishData then
      table.remove(self._aquariumFish[buildPstID], i)
      break
    end
  end
  for i = 1, #self._remainFish do
    local data = self._remainFish[i]
    if data:GetId() == raiseFishData:GetId() then
      data:AddCount()
      self:Sort()
      return
    end
  end
  raiseFishData:SetCount(1)
  self._remainFish[#self._remainFish + 1] = raiseFishData
  self:Sort()
end
