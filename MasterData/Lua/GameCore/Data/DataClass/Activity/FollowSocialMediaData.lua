local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local FollowSocialMediaData = class("FollowSocialMediaData", ActivityDataBase)

function FollowSocialMediaData:Init()
  self.tbRewardData = {}
end

function FollowSocialMediaData:RefreshFollowSocialMediaActData(actId, msgData)
  self:Init()
  local tbData = UTILS.ParseByteString(msgData.State)
  local tbActive = self:GetBitsAsBooleanArray(tbData)
  for i, v in ipairs(tbActive) do
    if v then
      self.tbRewardData[i] = true
    end
  end
end

function FollowSocialMediaData:GetAllRewardData()
  return self.tbRewardData
end

function FollowSocialMediaData:GetRewardData(nConfigId)
  return self.tbRewardData[nConfigId] or false
end

function FollowSocialMediaData:SetRewardData(nConfigId, bGet)
  self.tbRewardData[nConfigId] = bGet
end

function FollowSocialMediaData:SendRewardReceive(nConfigId, callback)
  local function backCallback(_, msgData)
    self:SetRewardData(nConfigId, true)
    
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_share_reward_receive_req, {
    ActivityId = self.nActId,
    ChannelId = nConfigId
  }, nil, backCallback)
end

function FollowSocialMediaData:GetBitsAsBooleanArray(byteArray)
  local bits = {}
  local totalBits = #byteArray * 8
  for i = 1, totalBits do
    bits[i] = false
  end
  for i = #byteArray, 1, -1 do
    local value = byteArray[i]
    local byteOffset = #byteArray - i
    local baseBitIndex = byteOffset * 8
    for bitPos = 0, 7 do
      local mask = 2 ^ bitPos
      bits[baseBitIndex + bitPos + 1] = value & mask ~= 0
    end
  end
  return bits
end

function FollowSocialMediaData:CheckActShow()
  if NovaAPI.IsReviewServerEnv() then
    return false
  end
  if self.actCfg.PreLimit == GameEnum.activityPreLimit.WorldClass then
    local nCurWorldClass = PlayerData.Base:GetWorldClass()
    local nNeedWorldClass = tonumber(self.actCfg.LimitParam)
    if nCurWorldClass < nNeedWorldClass then
      return false
    end
  elseif self.actCfg.PreLimit == GameEnum.activityPreLimit.questLimit then
    local nStoryId = tonumber(self.actCfg.LimitParam)
    local bReaded = PlayerData.Avg:IsStoryReaded(nStoryId)
    if not bReaded then
      return false
    end
  end
  if self.actCfg.EndType == GameEnum.activityEndType.NoLimit then
    return not self.bBanner and self:CheckActivityOpen()
  else
    return self:CheckActivityOpen()
  end
end

function FollowSocialMediaData:CheckShowBanner()
  if NovaAPI.IsReviewServerEnv() then
    return false
  end
  return self:CheckActPlay() and self.actCfg.BannerRes ~= "" and self.bBanner == false
end

return FollowSocialMediaData
