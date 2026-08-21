_class("FishingGameOrder", Object)
FishingGameOrder = FishingGameOrder

function FishingGameOrder:Constructor(...)
  local param = {
    ...
  }
  self.orderCount = param[1]
  self.finishTime = param[2]
  self.detailInfo = {}
end

function FishingGameOrder:Clear()
  self.orderCount = 0
  self.finishTime = 0
end

_class("FishingGameFishGroup", Object)
FishingGameFishGroup = FishingGameFishGroup

function FishingGameFishGroup:Constructor(...)
  local param = {
    ...
  }
  self.fishId = param[1]
  self.fishMin = param[2]
  self.fishMax = param[3]
  self.fishCfg = param[4]
  self.currentCount = 0
  self.maxAndMinInterval = self.fishMax - self.fishMin
  self.isFull = false
end

_class("FishingGameLevelInfo", Object)
FishingGameLevelInfo = FishingGameLevelInfo

function FishingGameLevelInfo:Constructor(...)
  local param = {
    ...
  }
  self.fishInfo = param[1]
  self.orderInfo = param[2]
  self.totalFish = param[3]
  self.totalObstacle = param[4]
  self.supplyInterval = param[5]
  self.normalFishInfo = {}
  self:CheckTotalFish()
  self:CalNormalFish()
  self.fishTypeCount = table.count(self.normalFishInfo)
  self.currentTotalFish = self.totalFish
  self.orderDetailInfo = self:GenerateOrderInfo(self.orderInfo)
  self.allFishInfo = self:GenerateFishInfo()
end

function FishingGameLevelInfo:CheckTotalFish()
  local total = 0
  for i = 1, table.count(self.fishInfo) do
    total = total + self.fishInfo[i][3]
  end
  if total < self.totalFish then
    self.totalFish = total
  end
end

function FishingGameLevelInfo:GenerateFishInfo()
  local allfishGroupList = {}
  local genCount = 0
  for i = 1, table.count(self.fishInfo) do
    local fishId = self.fishInfo[i][1]
    local fishGroup = FishingGameFishGroup:New(fishId, self.fishInfo[i][2], self.fishInfo[i][3], Cfg.cfg_fishing_fish({
      ID = self.fishInfo[i][1]
    })[1])
    for j = 1, fishGroup.fishMin do
      fishGroup.currentCount = fishGroup.currentCount + 1
      genCount = genCount + 1
      if genCount > self.totalFish then
        break
      end
    end
    allfishGroupList[fishId] = fishGroup
  end
  if genCount < self.totalFish then
    while genCount < self.totalFish do
      local notFullFishType = {}
      for k, v in pairs(allfishGroupList) do
        local fishGroup = v
        if fishGroup.currentCount < fishGroup.fishMax then
          notFullFishType[#notFullFishType + 1] = fishGroup.fishId
        end
      end
      if #notFullFishType == 0 then
        break
      end
      local r = math.random(1, #notFullFishType)
      genCount = genCount + 1
      allfishGroupList[notFullFishType[r]].currentCount = allfishGroupList[notFullFishType[r]].currentCount + 1
    end
  end
  return allfishGroupList
end

function FishingGameLevelInfo:CatchFish(fishId)
  for k, v in pairs(self.allFishInfo) do
    if k == fishId then
      v.currentCount = v.currentCount - 1
      self.currentTotalFish = self.currentTotalFish - 1
      break
    end
  end
end

function FishingGameLevelInfo:GenerateFish()
  local currentTotal = 0
  for k, v in pairs(self.allFishInfo) do
    currentTotal = currentTotal + v.currentCount
    if v.currentCount < v.fishMin then
      v.currentCount = v.currentCount + 1
      self.currentTotalFish = self.currentTotalFish + 1
      return k
    end
  end
  if currentTotal >= self.totalFish then
    return -1
  end
  local notFullFishType = {}
  for k, v in pairs(self.allFishInfo) do
    if v.currentCount < v.fishMax then
      notFullFishType[#notFullFishType + 1] = k
    end
  end
  local r = math.random(1, #notFullFishType)
  self.allFishInfo[notFullFishType[r]].currentCount = self.allFishInfo[notFullFishType[r]].currentCount + 1
  self.currentTotalFish = self.currentTotalFish + 1
  return notFullFishType[r]
end

function FishingGameLevelInfo:CalNormalFish()
  local normalFishTypeCount = 0
  for _, v in pairs(self.fishInfo) do
    if v[1] ~= FishingFishType.Octopus and v[1] ~= FishingFishType.Puffer then
      normalFishTypeCount = normalFishTypeCount + 1
      self.normalFishInfo[normalFishTypeCount] = v
    end
  end
end

function FishingGameLevelInfo:GenerateOrderInfo(orderInfo)
  local orderDetailList = {}
  local orderCount = table.count(orderInfo)
  if 0 < orderCount then
    for i = 1, orderCount do
      local orderBaseInfo = orderInfo[i]
      orderDetailList[i] = FishingGameOrder:New(orderBaseInfo[1], orderBaseInfo[2])
      local orderFishList = {}
      local typeFishCountList = {}
      local lastFishIndex = 0
      for j = 1, orderBaseInfo[1] do
        local currentFishIndex = Mathf.Random(1, self.fishTypeCount)
        while currentFishIndex == lastFishIndex or typeFishCountList[currentFishIndex] == 2 do
          currentFishIndex = Mathf.Random(1, self.fishTypeCount)
        end
        lastFishIndex = currentFishIndex
        orderFishList[j] = self.normalFishInfo[currentFishIndex][1]
        if typeFishCountList[orderFishList[j]] then
          typeFishCountList[orderFishList[j]] = typeFishCountList[orderFishList[j]] + 1
        else
          typeFishCountList[orderFishList[j]] = 1
        end
      end
      orderDetailList[i].detailInfo = orderFishList
    end
  end
  return orderDetailList
end

function FishingGameLevelInfo:PoolIsFull()
  return self.currentTotalFish >= self.totalFish
end

function FishingGameLevelInfo:PoolIsEmpty()
  return self.currentTotalFish == 0
end

local FishingGameState = {
  Start = 1,
  Playing = 2,
  Pause = 3,
  Skill = 4,
  SkillAnim = 5,
  Over = 6
}
_enum("FishingGameState", FishingGameState)
local FishingGameRewardState = {
  HasReceive = 1,
  NotReceive = 2,
  NotReach = 3
}
_enum("FishingGameRewardState", FishingGameRewardState)
local FishingFishState = {
  Swimming = 1,
  Rotate = 2,
  Die = 3,
  Born = 4
}
_enum("FishingFishState", FishingFishState)
local FishingFishType = {
  Other = 1,
  Puffer = 6,
  Octopus = 7
}
_enum("FishingFishType", FishingFishType)
