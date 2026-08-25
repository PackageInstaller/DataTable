local SocialController = NewClass("SocialController", BaseController)

function SocialController:OnInit()
end

function SocialController:OnReset()
  self.rankStartIndexMap = {}
end

function SocialController:ReqAttentionPlayer(uid, callback)
  SocialDataUtils.ReqOnSocialAttention(uid, callback)
end

function SocialController:ReqCancelAttentionPlayer(uid, callback)
  SocialDataUtils.ReqOnSocialCancelAttention(uid, callback)
end

function SocialController:ReqCancelAttentionPlayer(uid, callback)
  SocialDataUtils.ReqOnSocialCancelAttention(uid, callback)
end

function SocialController:ReqLikePlayer(uid, callback)
  SocialDataUtils.ReqOnSocialGood(uid, 1, SocialDefine.GoodReason.Social, callback)
end

function SocialController:ReqSocialRankData(rankType, startIndex, count, callback, onFail)
  local key = RankDataUtils.GetRankKey(rankType)
  startIndex = startIndex or self.rankStartIndexMap[key] or 1
  count = count or SocialExtModel.Instance:GetRankReqInterval()
  RankController.Instance:QueryRankData(rankType, nil, startIndex, count, callback, nil, onFail)
end

function SocialController:OpenAbyssRankView(activityTid)
  UIManager.Instance:Reopen(Urls.AbyssRankView, activityTid)
end

return SocialController
