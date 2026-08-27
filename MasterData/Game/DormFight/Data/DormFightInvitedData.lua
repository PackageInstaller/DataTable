local DormFightInvitedData = class("FormationData")

function DormFightInvitedData:ctor(msg, userInfoData)
  self.inviteExpiredTimeStamp = msg.expiredTm
  self.otherUserInfoData = userInfoData
  self.duelId = msg.duelId
  self.roomType = msg.roomType
  self.isRefuse = false
  self.isCancel = false
end

function DormFightInvitedData:IsRefuse()
  return self.isRefuse
end

function DormFightInvitedData:IsCancel()
  return self.isCancel
end

function DormFightInvitedData:IsExpiredTime()
  return PlayerDataCenter.timestamp > self.inviteExpiredTimeStamp
end

function DormFightInvitedData:IsLegal()
  if self:IsRefuse() then
    return false
  end
  if self:IsCancel() then
    return false
  end
  if self:IsExpiredTime() then
    return false
  end
  return true
end

return DormFightInvitedData
