local CommentController = NewClass("CommentController", BaseController)

function CommentController:OnInit()
end

function CommentController:OnReset()
end

function CommentController:OpenCommentEditView(viewData)
  UIManager.Instance:Reopen(Urls.CommentEditView, viewData)
end

function CommentController:OpenCommentListView(viewData)
  UIManager.Instance:Reopen(Urls.CommentListView, viewData)
end

function CommentController:ReqOnOpen()
  ProtoManager.Instance:ReqServer("CommentRequest", "OnOpen", function(data)
    Logger.Info("========== ReqOnOpen Successful ==========\n", table.tostring(data or {}))
    CommentModel.Instance:SetCommentRecordDict(data.commented_card_ids)
    CommentModel.Instance:SetCommentLikeRecordDict(data.liked_comments)
    CommentModel.Instance:SetIsCommentManager(data.is_comment_manager)
  end, function(data)
    Logger.Info("========== ReqOnOpen Failed ==========\n", table.tostring(data or {}))
  end)
end

function CommentController:ReqViewCommentOfUid(pvpCollectTid, playerUid, callback)
  ProtoManager.Instance:ReqServer("CommentRequest", "ViewCommentOfUid", function(data)
    Logger.Info("========== ReqViewCommentOfUid Successfull ==========\n", table.tostring(data or {}))
    if data.ok ~= nil and data.ok == false then
      Alert.ShowStr(LT.Text("CommentDataNull"))
      return
    end
    CommentModel.Instance:UpdateCommentMO(pvpCollectTid, data.comment)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== ReqViewCommentOfUid Failed ==========\n", table.tostring(data or {}))
  end, pvpCollectTid, playerUid)
end

function CommentController:ReqViewComments(pvpCollectTid, page, pageSize, sortMode, callback)
  ProtoManager.Instance:ReqServer("CommentRequest", "ViewComments", function(data)
    Logger.Info("========== ReqViewComments Successful ==========\n", table.tostring(data or {}))
    CommentModel.Instance:UpdateBySvrData(pvpCollectTid, sortMode, data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== ReqViewComments Failed ==========\n", table.tostring(data or {}))
  end, pvpCollectTid, page, pageSize, sortMode)
end

function CommentController:ReqPublishComment(pvpCollectTid, content, callback)
  ProtoManager.Instance:ReqServer("CommentRequest", "PublishComment", function(data)
    Logger.Info("========== ReqPublishComment Successful ==========\n", table.tostring(data or {}))
    local svrData = {
      likeCount = 0,
      createTs = TimeUtils.GetServerTime(),
      updateTs = TimeUtils.GetServerTime(),
      content = content,
      uid = PlayerDataUtils.GetPlayerUid(),
      playerIcon = PlayerDataUtils.GetAvatarIconTid(),
      playerName = PlayerDataUtils.GetName(),
      cardStarCount = PVPCollectionDataUtils.GetCollectionWinTimes(pvpCollectTid)
    }
    CommentModel.Instance:UpdateCommentMO(pvpCollectTid, svrData)
    CommentModel.Instance:_InsertCommentSequence(pvpCollectTid, 1, PlayerDataUtils.GetPlayerUid())
    CommentModel.Instance:SetCommentRecord(pvpCollectTid, TimeUtils.GetServerTime())
    if callback then
      callback()
    end
    EventMgr.Instance.PvpCollectionPublishComment:Dispatch(pvpCollectTid)
  end, function(data)
    Logger.Info("========== ReqPublishComment Failed ==========\n", table.tostring(data or {}))
  end, pvpCollectTid, content)
end

function CommentController:ReqEditComment(pvpCollectTid, content, callback)
  ProtoManager.Instance:ReqServer("CommentRequest", "EditComment", function(data)
    Logger.Info("========== ReqEditComment Successful ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
    local targetCommentMO = CommentModel.Instance:GetCommentMO(pvpCollectTid, PlayerDataUtils.GetPlayerUid())
    if targetCommentMO then
      targetCommentMO:SetContent(content)
      targetCommentMO:SetUpdateTs(TimeUtils.GetServerTime())
      EventMgr.Instance.PvpCollectionEditComment:Dispatch(pvpCollectTid)
    end
  end, function(data)
    Logger.Info("========== ReqEditComment Failed ==========\n", table.tostring(data or {}))
  end, pvpCollectTid, content)
end

function CommentController:ReqDeleteComment(pvpCollectTid, callback)
  ProtoManager.Instance:ReqServer("CommentRequest", "DeleteComment", function(data)
    Logger.Info("========== ReqDeleteComment Successful ==========\n", table.tostring(data or {}))
    CommentModel.Instance:SetCommentRecord(pvpCollectTid, nil)
    CommentModel.Instance:DelCommentMO(pvpCollectTid, PlayerDataUtils.GetPlayerUid())
    if callback then
      callback()
    end
    EventMgr.Instance.PvpCollectionDeleteComment:Dispatch(pvpCollectTid)
  end, function(data)
    Logger.Info("========== ReqDeleteComment Failed ==========\n", table.tostring(data or {}))
  end, pvpCollectTid)
end

function CommentController:ReqLikeComment(pvpCollectTid, playerUid, callback)
  ProtoManager.Instance:ReqServer("CommentRequest", "LikeComment", function(data)
    Logger.Info("========== ReqLikeComment Successful ==========\n", table.tostring(data or {}))
    local targetCommentMO = CommentModel.Instance:GetCommentMO(pvpCollectTid, playerUid)
    if targetCommentMO then
      targetCommentMO:SetLikeCount(targetCommentMO:GetLikeCount() + 1)
    end
    CommentModel.Instance:SetCommentLiked(pvpCollectTid, playerUid, TimeUtils.GetServerTime())
    if callback then
      callback()
    end
    EventMgr.Instance.PvpCollectionLikeComment:Dispatch(pvpCollectTid, playerUid)
  end, function(data)
    Logger.Info("========== ReqLikeComment Failed ==========\n", table.tostring(data or {}))
  end, pvpCollectTid, playerUid)
end

function CommentController:ReqUnlikeComment(pvpCollectTid, playerUid, callback)
  ProtoManager.Instance:ReqServer("CommentRequest", "UnlikeComment", function(data)
    Logger.Info("========== ReqUnlikeComment Successful ==========\n", table.tostring(data or {}))
    local targetCommentMO = CommentModel.Instance:GetCommentMO(pvpCollectTid, playerUid)
    if targetCommentMO then
      targetCommentMO:SetLikeCount(targetCommentMO:GetLikeCount() - 1)
    end
    CommentModel.Instance:SetCommentLiked(pvpCollectTid, playerUid, nil)
    if callback then
      callback()
    end
    EventMgr.Instance.PvpCollectionUnlikeComment:Dispatch(pvpCollectTid, playerUid)
  end, function(data)
    Logger.Info("========== ReqUnlikeComment Failed ==========\n", table.tostring(data or {}))
  end, pvpCollectTid, playerUid)
end

function CommentController:ReqGmHideComment(pvpCollectTid, playerUid, callback)
  ProtoManager.Instance:ReqServer("CommentRequest", "GmHideComment", function(data)
    Logger.Info("========== ReqGmHideComment Successful ==========\n", table.tostring(data or {}))
    local targetCommentMO = CommentModel.Instance:GetCommentMO(pvpCollectTid, playerUid)
    if targetCommentMO then
      targetCommentMO:SetIsHide(true)
    end
    if callback then
      callback()
    end
    EventMgr.Instance.PvpCollectionHideComment:Dispatch(pvpCollectTid, playerUid)
  end, function(data)
    Logger.Info("========== ReqGmHideComment Failed ==========\n", table.tostring(data or {}))
  end, pvpCollectTid, playerUid)
end

function CommentController:ReqGmUnhideComment(pvpCollectTid, playerUid, callback)
  ProtoManager.Instance:ReqServer("CommentRequest", "GmUnhideComment", function(data)
    Logger.Info("========== ReqGmUnhideComment Successful ==========\n", table.tostring(data or {}))
    local targetCommentMO = CommentModel.Instance:GetCommentMO(pvpCollectTid, playerUid)
    if targetCommentMO then
      targetCommentMO:SetIsHide(false)
    end
    if callback then
      callback()
    end
    EventMgr.Instance.PvpCollectionUnHideComment:Dispatch(pvpCollectTid, playerUid)
  end, function(data)
    Logger.Info("========== ReqGmUnhideComment Failed ==========\n", table.tostring(data or {}))
  end, pvpCollectTid, playerUid)
end

return CommentController
