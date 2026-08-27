local CheckerUserChannel = {}
local UserChannelIdEnum = {
  UserChannelIdNone = 0,
  Gw = 3,
  Bili = 4
}

function CheckerUserChannel.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckerUserChannel.ParamsCheck(param)
  return PlayerDataCenter.channelId == param[2]
end

function CheckerUserChannel.GetUnlockInfo(param)
  return PlayerDataCenter.channelId == param[2]
end

return CheckerUserChannel
