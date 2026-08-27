local ActCommonRewardBpData = class("ActCommonRewardBp")

function ActCommonRewardBpData:ctor(activityBase, tokenId)
  self._actFrameId = activityBase:GetActFrameId()
  self._activityBase = activityBase
  self._rewardCfg = ConfigData.activity_general_act_bp[self._actFrameId]
  self.tokenId = tokenId
  local count = #self._rewardCfg
  self._maxLevel = count
  self._cycleExp = self._rewardCfg[count].need_exp
  self._level = 1
  self._exp = 0
  self.rewardLv = 0
end

function ActCommonRewardBpData:UpdateCommonRewardBp(elem)
  if elem.actLongId ~= self._actFrameId then
    return
  end
  self._level = elem.level
  self._exp = elem.exp
  self.rewardLv = elem.rewardLv
  local bonusUI = UIManager:GetWindow(UIWindowTypeID.CommonActRewardBp)
  if bonusUI ~= nil then
    bonusUI:RefreshActivityCommonRewardBp()
  end
end

function ActCommonRewardBpData:GetActFrameId()
  return self._actFrameId
end

function ActCommonRewardBpData:GetIsHaveCirReward()
  return false
end

function ActCommonRewardBpData:GetCirRewardData()
  return nil
end

function ActCommonRewardBpData:GetRewardBpTokenItemId()
  return self.tokenId
end

function ActCommonRewardBpData:GetCommonRewardCurLv()
  if self._level > self._maxLevel then
    return self._maxLevel
  end
  return self._level
end

function ActCommonRewardBpData:GetCommonRewardLvLimit()
  return self._maxLevel
end

function ActCommonRewardBpData:GetCommonRewardAllExp()
  local num = 0
  for i = 1, self._level - 1 do
    num = num + self._rewardCfg[i].need_token
  end
  num = num + self._exp
  return num
end

function ActCommonRewardBpData:GetCommonRewardCurExp()
  return self._exp
end

function ActCommonRewardBpData:GetCommonRewardCurExpLimit()
  local cfg = self._rewardCfg[self:GetCommonRewardCurLv()]
  if cfg == nil then
    return 0
  end
  return cfg.need_token
end

function ActCommonRewardBpData:GetCommonRewardBpCfg()
  return self._rewardCfg
end

function ActCommonRewardBpData:GetCommonRewardCycleExpLimit()
  return self._cycleExp
end

function ActCommonRewardBpData:IsCommonRewardLevelCanPick(level)
  if level <= self.rewardLv then
    return false
  end
  return level <= self._level
end

function ActCommonRewardBpData:IsCommonRewardLevelReceived(level)
  return level <= self.rewardLv
end

function ActCommonRewardBpData:IsCommonRewardCycleCanPick()
  if self._level < self._maxLevel then
    return false
  end
  return false
end

function ActCommonRewardBpData:HasCommonRewardExpCanReceive()
  if self._level > self.rewardLv then
    return true
  end
  return self:IsCommonRewardCycleCanPick()
end

function ActCommonRewardBpData:ReqCommonRewardExpReceive(level, callback)
  if not self:IsCommonRewardLevelCanPick(level) then
    return
  end
  local netCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  netCtrl:CS_Activity_General_Bp_Reward(self:GetActFrameId(), nil, callback)
end

function ActCommonRewardBpData:ReqSeasonRewardExpCycle(callback)
end

function ActCommonRewardBpData:ReqCommonRewardAllExp(callback)
  if not self:HasCommonRewardExpCanReceive() then
    return
  end
  local netCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  netCtrl:CS_Activity_General_Bp_Reward(self:GetActFrameId(), nil, callback)
end

function ActCommonRewardBpData:SetAvgJumpFunc(callback)
  self.avgJumpFunc = callback
end

function ActCommonRewardBpData:GetAvgJumpFunc()
  return self.avgJumpFunc
end

return ActCommonRewardBpData
