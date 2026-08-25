local CommentBaseMO = NewClass("CommentBaseMO")

function CommentBaseMO:ctor()
  self.commentId = 0
  self.uid = 0
  self.playerName = ""
  self.likeCount = 0
  self.content = ""
  self.showContent = ""
  self.createTs = 0
  self.relation = 0
  self.cardStarCount = 0
  self.playerIcon = 0
  self.playerAvatarFrame = 0
  self.updateTs = 0
  self.isHide = false
  self.isNeedLayoutAdjust = false
end

function CommentBaseMO:UpdateData(commentId, data)
  self:SetCommentId(commentId)
  self:SetUid(data.uid)
  self:SetPlayerName(data.playerName)
  self:SetLikeCount(data.likeCount)
  self:SetContent(data.content)
  self:SetShowContent("")
  self:SetCreateTs(data.createTs)
  self:SetRelation(data.relation)
  self:SetCardStarCount(data.cardStarCount)
  self:SetPlayerIcon(data.playerIcon)
  self:SetPlayerAvatarFrame(data.playerAvatarFrame)
  self:SetUpdateTs(data.updateTs)
  self:SetIsHide(data.hidden)
end

function CommentBaseMO:SetCommentId(commentId)
  if nil == commentId then
    return
  end
  self.commentId = commentId
end

function CommentBaseMO:SetUid(uid)
  if nil == uid then
    return
  end
  self.uid = uid
end

function CommentBaseMO:SetPlayerName(name)
  if nil == name then
    return
  end
  self.playerName = name
end

function CommentBaseMO:SetLikeCount(num)
  self.likeCount = num or 0
end

function CommentBaseMO:SetContent(content)
  if nil == content then
    return
  end
  self.content = content
end

function CommentBaseMO:SetCreateTs(ts)
  if nil == ts then
    return
  end
  self.createTs = ts
end

function CommentBaseMO:SetRelation(relation)
  if nil == relation then
    return
  end
  self.relation = relation
end

function CommentBaseMO:SetCardStarCount(num)
  if nil == num then
    return
  end
  self.cardStarCount = num
end

function CommentBaseMO:SetPlayerIcon(tid)
  if nil == tid then
    return
  end
  self.playerIcon = tid
end

function CommentBaseMO:SetPlayerAvatarFrame(tid)
  if nil == tid then
    return
  end
  self.playerAvatarFrame = tid
end

function CommentBaseMO:SetUpdateTs(ts)
  if nil == ts then
    return
  end
  self.updateTs = ts
end

function CommentBaseMO:SetIsHide(boolVal)
  self.isHide = boolVal
end

function CommentBaseMO:GetCommentId()
  return self.commentId
end

function CommentBaseMO:GetUid()
  return self.uid
end

function CommentBaseMO:GetPlayerName()
  return self.playerName
end

function CommentBaseMO:GetLikeCount()
  return self.likeCount and math.max(self.likeCount, 0) or 0
end

function CommentBaseMO:GetContent()
  return self.content
end

function CommentBaseMO:SetShowContent(showContent)
  self.showContent = showContent
end

function CommentBaseMO:GetShowContent()
  return self.showContent
end

function CommentBaseMO:GetCreateTs()
  return self.createTs
end

function CommentBaseMO:GetRelation()
  return self.relation
end

function CommentBaseMO:GetCardStarCount()
  return self.cardStarCount
end

function CommentBaseMO:GetPlayerIcon()
  do return ItemDataUtils.GetAvatarIcon end
  return ItemDataUtils.GetAvatarIcon, self.playerIcon
end

function CommentBaseMO:GetPlayerAvatarFrame()
  return self.playerAvatarFrame
end

function CommentBaseMO:GetUpdateTs()
  return self.updateTs
end

function CommentBaseMO:GetIsHide()
  return self.isHide
end

function CommentBaseMO:SetNeedLayoutAdjust(isNeedLayoutAdjust)
  self.isNeedLayoutAdjust = isNeedLayoutAdjust
end

function CommentBaseMO:IsNeedLayoutAdjust()
  return self.isNeedLayoutAdjust
end

function CommentBaseMO:IsCanEdit()
  local createTs = self:GetCreateTs()
  local diffTs = TimeUtils.GetServerTime() - createTs
  if diffTs > 2592000 then
    return false
  end
  return true
end

return CommentBaseMO
