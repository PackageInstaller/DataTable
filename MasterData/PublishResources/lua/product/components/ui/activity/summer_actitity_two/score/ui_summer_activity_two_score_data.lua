local UISummerActivityTwoScoreRewardStatus = {
  UnComplete = 1,
  HasGet = 2,
  UnGet = 3
}
_enum("UISummerActivityTwoScoreRewardStatus", UISummerActivityTwoScoreRewardStatus)
local UISummerActivityTwoScoreType = {
  Shui = 1,
  Huo = 2,
  Sen = 3,
  Lei = 4,
  Total = 5
}
_enum("UISummerActivityTwoScoreType", UISummerActivityTwoScoreType)
_class("UISummerActivityTwoScoreRewardData", Object)
UISummerActivityTwoScoreRewardData = UISummerActivityTwoScoreRewardData

function UISummerActivityTwoScoreRewardData:Constructor(data)
  self._reachScoreValue = data.progress
  self._status = data.status
  self._rewards = data.rewards
  self._type = data.type
end

function UISummerActivityTwoScoreRewardData:GetScoreValue()
  return self._reachScoreValue
end

function UISummerActivityTwoScoreRewardData:GetStatus()
  return self._status
end

function UISummerActivityTwoScoreRewardData:SetStatus(status)
  self._status = status
end

function UISummerActivityTwoScoreRewardData:GetRewards()
  return self._rewards
end

function UISummerActivityTwoScoreRewardData:GetType()
  return self._type
end

function UISummerActivityTwoScoreRewardData:GetPriority()
  local priority = self._reachScoreValue
  local weight = 1000000
  if self._status == UISummerActivityTwoScoreRewardStatus.UnComplete then
    priority = priority + 2 * weight
  elseif self._status == UISummerActivityTwoScoreRewardStatus.HasGet then
    priority = priority + 3 * weight
  elseif self._status == UISummerActivityTwoScoreRewardStatus.UnGet then
    priority = priority + weight
  end
  return priority
end

_class("UISummerActivityTwoScoreData", Object)
UISummerActivityTwoScoreData = UISummerActivityTwoScoreData

function UISummerActivityTwoScoreData:Constructor(progressComponentInfo)
  self._rewardDatas = {}
  local progressRewards = progressComponentInfo.m_progress_rewards
  local currentProgress = progressComponentInfo.m_current_progress
  local receivedProgress = progressComponentInfo.m_received_progress
  for k, v in pairs(progressRewards) do
    local progress = k
    local rewards = v
    local data = {}
    data.progress = progress
    data.rewards = rewards
    local status
    if currentProgress >= progress then
      status = UISummerActivityTwoScoreRewardStatus.UnGet
      for i = 1, #receivedProgress do
        if progress == receivedProgress[i] then
          status = UISummerActivityTwoScoreRewardStatus.HasGet
          break
        end
      end
    else
      status = UISummerActivityTwoScoreRewardStatus.UnComplete
    end
    data.status = status
    self._rewardDatas[#self._rewardDatas + 1] = UISummerActivityTwoScoreRewardData:New(data)
  end
  self._totalScore = currentProgress
  self._typeToIconImg = {
    [UISummerActivityTwoScoreType.Shui] = "toptoon_3000205",
    [UISummerActivityTwoScoreType.Huo] = "toptoon_3000206",
    [UISummerActivityTwoScoreType.Sen] = "toptoon_3000207",
    [UISummerActivityTwoScoreType.Lei] = "toptoon_3000208",
    [UISummerActivityTwoScoreType.Total] = {
      "toptoon_3000205",
      "toptoon_3000206",
      "toptoon_3000207",
      "toptoon_3000208"
    }
  }
  self._typeToName = {
    [UISummerActivityTwoScoreType.Shui] = StringTable.Get("str_summer_activity_two_score_type_name_shui"),
    [UISummerActivityTwoScoreType.Huo] = StringTable.Get("str_summer_activity_two_score_type_name_huo"),
    [UISummerActivityTwoScoreType.Sen] = StringTable.Get("str_summer_activity_two_score_type_name_sen"),
    [UISummerActivityTwoScoreType.Lei] = StringTable.Get("str_summer_activity_two_score_type_name_lei"),
    [UISummerActivityTwoScoreType.Total] = StringTable.Get("str_summer_activity_two_score_type_name_total")
  }
end

function UISummerActivityTwoScoreData:GetRewardDatas()
  return self._rewardDatas
end

function UISummerActivityTwoScoreData:GetTotalScore()
  return self._totalScore
end

function UISummerActivityTwoScoreData:HasCanGetReward()
  for i = 1, #self._rewardDatas do
    local rewardData = self._rewardDatas[i]
    if rewardData:GetStatus() == UISummerActivityTwoScoreRewardStatus.UnGet then
      return true
    end
  end
  return false
end
