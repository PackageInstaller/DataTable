local BpPage = CommonDefine.BpPage
local BIG_REWARD_INTERVAL = DT.GetConstant("BPBigRewardInterval")
local BIG_LEVEL_INTERVAL = DT.GetConstant("BPBigRewardInterval")
local BpRewardModel = NewClass("BpRewardModel", BaseModel)

function BpRewardModel:OnInit()
  self.showRewardItemNum = 6
  self.curRewardListIdx = 1
  self.nextLargeRewardLevel = 5
  self.isRewardList2Tail = false
  self.bpRwardList = self:GetBpRewardList()
end

function BpRewardModel:OnReset()
end

function BpRewardModel:SetIsRewardList2Tail(boolVal)
  if not (not self.isRewardList2Tail or boolVal) or not self.isRewardList2Tail and boolVal then
    self.isRewardList2Tail = boolVal
    self:LocalNotify(NotifyId.OnBpRewardListToTail, boolVal)
  end
end

function BpRewardModel:SetCurRewardListIdx(numVal)
  if not numVal then
    return
  end
  if numVal < self.curRewardListIdx - self.showRewardItemNum + 1 then
    self.curRewardListIdx = numVal + self.showRewardItemNum
    return
  end
  self.curRewardListIdx = numVal
  self:SetNextLargeRewardLevel(math.ceil(numVal / BIG_REWARD_INTERVAL) * BIG_REWARD_INTERVAL)
end

function BpRewardModel:SetNextLargeRewardLevel(numVal)
  if not numVal then
    return
  end
  self.nextLargeRewardLevel = numVal
  self:LocalNotify(NotifyId.OnBpChangePreviewReward)
end

function BpRewardModel:GetBpRewardList()
  local rst = {}
  for _, rewardData in pairs(BattlePassDataUtils.GetRewardList()) do
    local level = rewardData.unlockLevel
    if 0 ~= level then
      if not rst[level] then
        rst[level] = {}
      end
      if rewardData.bpRewardType == CommonDefine.BpPrivilegeLevel.Ordinary then
        table.insert(rst[level], 1, rewardData)
      else
        table.insert(rst[level], rewardData)
      end
    end
  end
  return rst
end

return BpRewardModel
