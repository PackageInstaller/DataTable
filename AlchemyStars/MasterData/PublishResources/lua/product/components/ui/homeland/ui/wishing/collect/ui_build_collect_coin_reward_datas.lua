_class("UIBuildCollectCoinRewardData", Object)
UIBuildCollectCoinRewardData = UIBuildCollectCoinRewardData

function UIBuildCollectCoinRewardData:Constructor(cfg)
  self._wishingCointCount = cfg.WishingCoinCount
  self._rewards = cfg.Reward
  self:RefreshStatus()
end

function UIBuildCollectCoinRewardData:RefreshStatus()
  local collectCount = HomelandWishingConst.GetCollectCoinCounts()
  self._isComplete = collectCount >= self._wishingCointCount
end

function UIBuildCollectCoinRewardData:GetRewards()
  return self._rewards
end

function UIBuildCollectCoinRewardData:GetWishingCoinCount()
  return self._wishingCointCount
end

function UIBuildCollectCoinRewardData:IsComplete()
  return self._isComplete
end

function UIBuildCollectCoinRewardData:GetSortPriority()
  local priority = 0
  if self._isComplete then
    priority = priority + 1000000
  end
  return priority + self._wishingCointCount
end

_class("UIBuildCollectCoinRewardDatas", Object)
UIBuildCollectCoinRewardDatas = UIBuildCollectCoinRewardDatas

function UIBuildCollectCoinRewardDatas:Constructor()
  self._datas = {}
  local cfgs = Cfg.cfg_homeland_wishing_reward({})
  for _, v in pairs(cfgs) do
    self._datas[#self._datas + 1] = UIBuildCollectCoinRewardData:New(v)
  end
  self:Sort()
end

function UIBuildCollectCoinRewardDatas:GetCollectCoinRewardDatas()
  return self._datas
end

function UIBuildCollectCoinRewardDatas:Sort()
  table.sort(self._datas, function(a, b)
    return a:GetSortPriority() < b:GetSortPriority()
  end)
end

function UIBuildCollectCoinRewardDatas:GetCurrentTask()
  if #self._datas <= 0 then
    return nil
  end
  if self._datas[1]:IsComplete() then
    return nil
  end
  return self._datas[1]
end

function UIBuildCollectCoinRewardDatas:Refresh()
  for i = 1, #self._datas do
    self._datas[i]:RefreshStatus()
  end
  self:Sort()
end
