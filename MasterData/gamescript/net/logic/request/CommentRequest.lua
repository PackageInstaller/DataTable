local ProtoBase = require("Net.Base.ProtoBase")
local NetworkMgr = require("Network.NetworkMgr")
local CommentRequest, Super = System.NewClass("CommentRequest", ProtoBase)

function CommentRequest:OnOpen()
  Logger.Proto("CommentRequest:OnOpen ")
  local errcode, data = NetworkMgr.Instance.Comment:OnOpen()
  return errcode, data
end

function CommentRequest:ViewCommentOfUid(pvpCollectTid, playerUid)
  Logger.Proto("CommentRequest:ViewCommentOfUid ", pvpCollectTid, playerUid)
  local errcode, data = NetworkMgr.Instance.Comment:ViewCommentOfUid(pvpCollectTid, playerUid)
  return errcode, data
end

function CommentRequest:ViewComments(pvpCollectTid, page, pageSize, sortMode)
  Logger.Proto("CommentRequest:ViewComments ", pvpCollectTid, page, pageSize, sortMode)
  local errcode, data = NetworkMgr.Instance.Comment:ViewComments(pvpCollectTid, page, pageSize, sortMode)
  return errcode, data
end

function CommentRequest:PublishComment(pvpCollectTid, content)
  Logger.Proto("CommentRequest:PublishComment ", pvpCollectTid, content)
  local errcode, data = NetworkMgr.Instance.Comment:PublishComment(pvpCollectTid, content)
  return errcode, data
end

function CommentRequest:EditComment(pvpCollectTid, content)
  Logger.Proto("CommentRequest:EditComment ", pvpCollectTid, content)
  local errcode, data = NetworkMgr.Instance.Comment:EditComment(pvpCollectTid, content)
  return errcode, data
end

function CommentRequest:DeleteComment(pvpCollectTid)
  Logger.Proto("CommentRequest:DeleteComment ", pvpCollectTid)
  local errcode, data = NetworkMgr.Instance.Comment:DeleteComment(pvpCollectTid)
  return errcode, data
end

function CommentRequest:LikeComment(pvpCollectTid, playerUid)
  Logger.Proto("CommentRequest:LikeComment ", pvpCollectTid, playerUid)
  local errcode, data = NetworkMgr.Instance.Comment:LikeComment(pvpCollectTid, playerUid)
  return errcode, data
end

function CommentRequest:UnlikeComment(pvpCollectTid, playerUid)
  Logger.Proto("CommentRequest:UnlikeComment ", pvpCollectTid, playerUid)
  local errcode, data = NetworkMgr.Instance.Comment:UnlikeComment(pvpCollectTid, playerUid)
  return errcode, data
end

function CommentRequest:GmHideComment(pvpCollectTid, playerUid)
  Logger.Proto("CommentRequest:GmHideComment ", pvpCollectTid, playerUid)
  local errcode, data = NetworkMgr.Instance.Comment:GmHideComment(pvpCollectTid, playerUid)
  return errcode, data
end

function CommentRequest:GmUnhideComment(pvpCollectTid, playerUid)
  Logger.Proto("CommentRequest:GmUnhideComment ", pvpCollectTid, playerUid)
  local errcode, data = NetworkMgr.Instance.Comment:GmUnhideComment(pvpCollectTid, playerUid)
  return errcode, data
end

return CommentRequest
