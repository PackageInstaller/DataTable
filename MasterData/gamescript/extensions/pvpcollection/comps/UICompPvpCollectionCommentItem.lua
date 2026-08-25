local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local UICompPvpCollectionCommentItem, Super = NewViewComponent("UICompPvpCollectionCommentItem")

function UICompPvpCollectionCommentItem:ctor(uiNode, view, viewData)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Item_Collection_CommentResource(uiNode)
  self._commentId = viewData.commentId
  self._commentUid = viewData.commentUid
  self._index = viewData.index
end

function UICompPvpCollectionCommentItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnBtnClick))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_like, System.fn(self, self._OnClickLike))
  self:BindEvent(EventMgr.Instance.PvpCollectionHideComment, System.fn(self, self._OnPvpCollectionHideComment))
  self:BindEvent(EventMgr.Instance.PvpCollectionUnHideComment, System.fn(self, self._OnPvpCollectionUnHideComment))
  self:BindEvent(EventMgr.Instance.PvpCollectionLikeComment, System.fn(self, self._OnPvpCollectionLikeComment))
  self:BindEvent(EventMgr.Instance.PvpCollectionUnlikeComment, System.fn(self, self._OnPvpCollectionUnlikeComment))
  self:BindEvent(EventMgr.Instance.SocialAttention, System.fn(self, self._OnSocialAttention))
end

function UICompPvpCollectionCommentItem:_OnSocialAttention(targetUid, newRelation)
  if targetUid ~= self._commentUid then
    return
  end
  self._commentMO:SetRelation(newRelation)
  self:_RefreshView()
end

function UICompPvpCollectionCommentItem:_OnPvpCollectionLikeComment(_, uid)
  if uid ~= self._commentUid then
    return
  end
  self:_UpdateViewData()
  self:_RefreshView()
end

function UICompPvpCollectionCommentItem:_OnPvpCollectionUnlikeComment(_, uid)
  if uid ~= self._commentUid then
    return
  end
  self:_UpdateViewData()
  self:_RefreshView()
end

function UICompPvpCollectionCommentItem:_OnPvpCollectionUnHideComment()
  self:_UpdateViewData()
  self:_RefreshView()
end

function UICompPvpCollectionCommentItem:_OnPvpCollectionHideComment()
  self:_UpdateViewData()
  self:_RefreshView()
end

function UICompPvpCollectionCommentItem:_OnClickLike()
  if self._commentMO:GetUid() == PlayerDataUtils.GetPlayerUid() then
    Alert.ShowStr(LT.Text("PvpCollectCommentLikeForbid"))
    return
  end
  local commentId = self._commentMO:GetCommentId()
  local isLiked = CommentModel.Instance:IsLiked(commentId, self._commentMO:GetUid())
  if isLiked then
    CommentController.Instance:ReqUnlikeComment(commentId, self._commentMO:GetUid(), function()
      self:SetActive(self.ui.UI_Vx_Glow, false)
      self:_UpdateViewData()
      self:_RefreshView()
    end)
  else
    CommentController.Instance:ReqLikeComment(commentId, self._commentMO:GetUid(), function()
      self:SetActive(self.ui.UI_Vx_Glow, true)
      self:_UpdateViewData()
      self:_RefreshView()
    end)
  end
end

function UICompPvpCollectionCommentItem:OnEnterComponent()
  self:LoadAllLangFont(self.ui.Text_Name)
  self:LoadAllLangFont(self.ui.Text_Comment)
  self._commentTmpComp = self.ui.Text_Comment:GetComponent(typeof(TextMeshProUGUI))
  self:SetText(self.ui.Text_Hide, LT.Text("CommonItemHide"))
  self:SetActive(self.ui.UI_Vx_Glow, false)
  self:_UpdateViewData()
  self:_RefreshView()
end

function UICompPvpCollectionCommentItem:_UpdateViewData()
  self._commentMO = CommentModel.Instance:GetCommentMO(self._commentId, self._commentUid)
end

function UICompPvpCollectionCommentItem:_RefreshView()
  if not self._commentMO then
    return
  end
  local commentId = self._commentMO:GetCommentId()
  self:SetActive(self.ui.Group_Bg_1, 0 ~= self._index % 2)
  self:SetActive(self.ui.Group_Bg_2, 0 == self._index % 2)
  local content = self:_GetContent()
  self:SetText(self.ui.Text_Comment, content)
  local isNeedLayoutAdjust = self._commentMO:IsNeedLayoutAdjust()
  self:SetActive(self.ui.Layout_Adjust, isNeedLayoutAdjust)
  self:SetText(self.ui.Text_Name, self._commentMO:GetPlayerName())
  local relation = self._commentMO:GetRelation()
  self:SetActive(self.ui.Image_Love, relation == SocialDefine.SocialRelationType.MyFans)
  self:SetActive(self.ui.Image_Mutual, relation == SocialDefine.SocialRelationType.Cor)
  self:SetText(self.ui.Text_Like_Count, self._commentMO:GetLikeCount())
  local isLiked = CommentModel.Instance:IsLiked(commentId, self._commentMO:GetUid())
  local btnState = isLiked and CommonDefine.Z1ButtonState.High or CommonDefine.Z1ButtonState.Normal
  self:SetButtonState(self.ui.UI_Common_Btn_like, btnState)
  self:SetActive(self.ui.Group_Hide, self._commentMO:GetIsHide() and CommentModel.Instance:GetIsCommentManager())
end

function UICompPvpCollectionCommentItem.CalContent(obj, tmp, content)
  obj:SetText(tmp.gameObject, content)
  tmp:ForceMeshUpdate()
  if not tmp.textInfo then
    return content
  end
  if tmp.textInfo.lineCount <= 3 then
    return content
  end
  local textInfo = tmp.textInfo
  local firstLineStartIndex = textInfo.lineInfo[0].firstCharacterIndex
  local thirdLineEndIndex = textInfo.lineInfo[2].lastCharacterIndex
  local rst = UIUtils.SubStringUTF8(tmp.text, firstLineStartIndex, thirdLineEndIndex - firstLineStartIndex + 1)
  return StrUtils.Utf8SafeSub(rst, 1, #rst - 3) .. "..."
end

function UICompPvpCollectionCommentItem:_GetContent()
  local targetContent = self._commentMO:GetShowContent()
  if string.isempty(targetContent) then
    local content = self._commentMO:GetContent()
    targetContent = UICompPvpCollectionCommentItem.CalContent(self, self._commentTmpComp, content)
  end
  return targetContent
end

function UICompPvpCollectionCommentItem:_OnBtnClick()
  EventMgr.Instance.PvpCollectionClickComment:Dispatch(self._commentMO)
end

return UICompPvpCollectionCommentItem
