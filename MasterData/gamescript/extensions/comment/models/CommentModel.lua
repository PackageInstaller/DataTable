local CommentModel = NewClass("CommentModel", BaseModel)

function CommentModel:OnInit()
  self._commentMODict = {}
  self._commentTotalCountDict = {}
  self._commentRecordDict = {}
  self._commentLikeRecordDict = {}
  self._isCommentManager = false
  self._commentSequenceDict = {}
end

function CommentModel:OnReset()
  self:OnInit()
end

function CommentModel:UpdateBySvrData(commentId, sortMode, svrData)
  for _, commentSvrData in ipairs(svrData.items) do
    self:UpdateCommentMO(commentId, commentSvrData)
  end
  if not self._commentSequenceDict[commentId] then
    self._commentSequenceDict[commentId] = {}
  end
  if not self._commentSequenceDict[commentId][sortMode] then
    self._commentSequenceDict[commentId][sortMode] = {}
  end
  local startIdx = (svrData.page - 1) * svrData.page_size + 1
  local endIdx = startIdx + svrData.page_size - 1
  local svrSeekIdx = 1
  for targetIdx = startIdx, endIdx do
    local targetUid = svrData.items[svrSeekIdx] and svrData.items[svrSeekIdx].uid
    self._commentSequenceDict[commentId][sortMode][targetIdx] = targetUid
    svrSeekIdx = svrSeekIdx + 1
  end
  self:SetCommentTotalCount(commentId, svrData.total_hint)
end

function CommentModel:_InsertCommentSequence(commentId, targetIdx, uid)
  if not self._commentSequenceDict[commentId] then
    self._commentSequenceDict[commentId] = {}
  end
  local targetTbl = self._commentSequenceDict[commentId]
  if next(targetTbl) == nil then
    for _, sortMode in pairs(CommentDefine.CommentSortMode) do
      targetTbl[sortMode] = {}
    end
  end
  for _, sequence in pairs(targetTbl) do
    table.insert(sequence, targetIdx, uid)
  end
end

function CommentModel:_AddCommentMO(commentId, commentMO)
  if not commentId or not commentMO then
    return
  end
  if not self._commentMODict[commentId] then
    self._commentMODict[commentId] = {}
  end
  self._commentMODict[commentId][commentMO.uid] = commentMO
end

function CommentModel:DelCommentMO(commentId, playerUid)
  local commentMO = self:GetCommentMO(commentId, playerUid)
  if commentMO then
    self._commentMODict[commentId][playerUid] = nil
  end
  for _, sequence in pairs(self._commentSequenceDict[commentId] or {}) do
    for i, uid in ipairs(sequence) do
      if uid == playerUid then
        table.remove(sequence, i)
        break
      end
    end
  end
end

function CommentModel:UpdateCommentMO(commentId, commentSvrData)
  if not commentId or not commentSvrData then
    return
  end
  local commentMO = self:GetCommentMO(commentId, commentSvrData.uid)
  if not commentMO then
    commentMO = self:CreateCommentMO(commentId, commentSvrData)
    self:_AddCommentMO(commentId, commentMO)
  end
  commentMO:UpdateData(commentId, commentSvrData)
end

function CommentModel:CreateCommentMO(commentId, commentSvrData)
  local commentMO = CommentBaseMO()
  commentMO:UpdateData(commentId, commentSvrData)
  return commentMO
end

function CommentModel:SetIsCommentManager(isCommentManager)
  self._isCommentManager = isCommentManager
end

function CommentModel:SetCommentTotalCount(commentId, totalCount)
  self._commentTotalCountDict[commentId] = totalCount
end

function CommentModel:SetCommentRecord(commentId, ts)
  self._commentRecordDict[commentId] = ts
end

function CommentModel:SetCommentLiked(commentId, playerUid, ts)
  local key = string.format("%s_%s", commentId, playerUid)
  self._commentLikeRecordDict[key] = ts
end

function CommentModel:SetCommentRecordDict(svrData)
  self._commentRecordDict = svrData
end

function CommentModel:SetCommentLikeRecordDict(svrData)
  self._commentLikeRecordDict = svrData
end

function CommentModel:GetCommentTotalCount(commentId)
  return self._commentTotalCountDict[commentId] or 0
end

function CommentModel:GetIsCommentManager()
  return self._isCommentManager
end

function CommentModel:GetCommentMO(commentId, playerUid)
  return self._commentMODict[commentId] and self._commentMODict[commentId][playerUid]
end

function CommentModel:GetCommentSequence(commentId, sortMode)
  local targetList = self._commentSequenceDict[commentId] and self._commentSequenceDict[commentId][sortMode] or {}
  local keys = {}
  for key in pairs(targetList) do
    table.insert(keys, key)
  end
  table.sort(keys)
  local rst = {}
  for i, key in ipairs(keys) do
    rst[i] = targetList[key]
  end
  return rst
end

function CommentModel:GetCommentLimitCharNum()
  do return DT.GetOriginalConstant end
  return DT.GetOriginalConstant, "CardReviewWordLimit"
end

function CommentModel:IsCommented(commentId)
  return self._commentRecordDict[commentId]
end

function CommentModel:IsLiked(commentId, playerUid)
  if playerUid == PlayerDataUtils.GetPlayerUid() then
    return false
  end
  local key = string.format("%s_%s", commentId, playerUid)
  return self._commentLikeRecordDict[key]
end

return CommentModel
