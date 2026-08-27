local ActivitySpring24TreasureData = class("ActivitySpring24TreasureData")

function ActivitySpring24TreasureData:InitTreasureData(cfg, actData)
  self.gotRewardDic = {}
  self.treasureCfg = cfg
  self.actData = actData
end

function ActivitySpring24TreasureData:UpdateTreasureData(msg)
  self.appearNum = msg.appear
  for i = 1, self.appearNum do
    self.gotRewardDic[i] = msg.hunted & 1 << i == 1 << i
  end
end

function ActivitySpring24TreasureData:GetNowMaxRewardNum()
  return self.appearNum or 0
end

function ActivitySpring24TreasureData:GetMaxRewardNum()
  return ConfigData.activity_treasurehunt_main[self.actData:GetActId()].total_limit
end

function ActivitySpring24TreasureData:GetNowDigRewardNum()
  local num = 0
  for i, bool in pairs(self.gotRewardDic) do
    if bool then
      num = num + 1
    end
  end
  return num
end

function ActivitySpring24TreasureData:IsActSpring24TreasureDigAll()
  local isDigAll = self:GetMaxRewardNum() <= self:GetNowDigRewardNum()
  return isDigAll
end

function ActivitySpring24TreasureData:IsNowActSpring24TreasureDigAll()
  local isDigAll = self:GetNowMaxRewardNum() <= self:GetNowDigRewardNum()
  return isDigAll
end

function ActivitySpring24TreasureData:GetJackPotRewardList()
  local rewardIds = {}
  local rewardNums = {}
  local rewardGots = {}
  for i = 1, self:GetMaxRewardNum() do
    local cfg = self.treasureCfg[i]
    for k, id in pairs(cfg.rewardIds) do
      if cfg.is_jackpot ~= false then
        table.insert(rewardIds, id)
        table.insert(rewardNums, cfg.rewardNums[k])
        table.insert(rewardGots, self:CheckRewardDug(i))
      end
    end
  end
  return rewardIds, rewardNums, rewardGots
end

function ActivitySpring24TreasureData:CheckRewardDug(id)
  return self.gotRewardDic[id] or false
end

function ActivitySpring24TreasureData:CheckRewardShow(id)
  local isAppear = id <= self:GetNowMaxRewardNum()
  return isAppear
end

function ActivitySpring24TreasureData:TransEntObjId2TreasureId(objId)
  return ConfigData.activity_treasurehunt_treasure_detail.lobbyObj2Id[self.actData:GetActId()][objId]
end

function ActivitySpring24TreasureData:GetEntObjIdIsShow(objId)
  local id = self:TransEntObjId2TreasureId(objId)
  local isShow = self:CheckRewardShow(id) and not self:CheckRewardDug(id)
  return isShow
end

return ActivitySpring24TreasureData
