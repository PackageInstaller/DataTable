local CommentUiUtils = {}

function CommentUiUtils:RefreshCommentPlayerBaseInfo(targetUI, commentMO)
  local commentId = commentMO:GetCommentId()
  self:SetText(targetUI.Text_Name, LT.Text(commentMO:GetPlayerName()))
  local relation = commentMO:GetRelation()
  self:SetActive(targetUI.Image_Love, relation == SocialDefine.SocialRelationType.MyFans)
  self:SetActive(targetUI.Image_Mutual, relation == SocialDefine.SocialRelationType.Cor)
  self:SetText(targetUI.Text_Like_Count, commentMO:GetLikeCount())
  
  local function _RefreshLikeState()
    local isLiked = CommentModel.Instance:IsLiked(commentId, commentMO:GetUid())
    local btnState = isLiked and CommonDefine.Z1ButtonState.High or CommonDefine.Z1ButtonState.Normal
    self:SetButtonState(targetUI.UI_Common_Btn_like, btnState)
  end
  
  _RefreshLikeState()
  self:AddButtonClickListener(targetUI.UI_Common_Btn_like, function()
    if commentMO.uid == PlayerDataUtils.GetPlayerUid() then
      Alert.ShowStr(LT.Text("PvpCollectCommentLikeForbid"))
      return
    end
    local isLiked = CommentModel.Instance:IsLiked(commentId, commentMO:GetUid())
    if isLiked then
      CommentController.Instance:ReqUnlikeComment(commentId, commentMO:GetUid(), function()
        self:SetActive(targetUI.UI_Vx_Glow, false)
      end)
    else
      CommentController.Instance:ReqLikeComment(commentId, commentMO:GetUid(), function()
        self:SetActive(targetUI.UI_Vx_Glow, true)
      end)
    end
  end)
end

function CommentUiUtils.GetPublishTimeStr(createTs)
  createTs = math.floor(createTs)
  local deltaSeconds = TimeUtils.GetServerTime() - createTs
  local showTime = ""
  if deltaSeconds < 60 then
    showTime = LT.Text("PvpCommentTimeLessThan1Min")
  elseif deltaSeconds < 3600 then
    local minutes = math.floor(deltaSeconds / 60)
    showTime = LT.Textf("PvpCommentTimeLessThan1Hour", minutes)
  elseif deltaSeconds < 86400 then
    local hours = math.floor(deltaSeconds / 3600)
    showTime = LT.Textf("PvpCommentTimeLessThan1Day", hours)
  elseif deltaSeconds < 2592000 then
    local daysAgo = math.floor(deltaSeconds / 86400)
    showTime = LT.Textf("PvpCommentTimeLessThan1Month", daysAgo)
  elseif deltaSeconds < 31536000 then
    local monthsAgo = math.floor(deltaSeconds / 2592000)
    showTime = LT.Textf("PvpCommentTimeLessThan1Year", monthsAgo)
  else
    local yearsAgo = math.floor(deltaSeconds / 31536000)
    showTime = LT.Textf("PvpCommentTimeMoreThan1Year", yearsAgo)
  end
  return showTime
end

return CommentUiUtils
