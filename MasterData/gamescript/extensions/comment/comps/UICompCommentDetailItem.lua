local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local UICompCommentDetailItem, Super = NewViewComponent("UICompCommentDetailItem")

function UICompCommentDetailItem:ctor(uiNode, view, commentMO, extraParam)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Tip_CommentResource(uiNode)
  self._commentMO = commentMO
  self._maskClickCb = extraParam.maskClickCb
  self._isPvp = extraParam.isPvp
end

function UICompCommentDetailItem:OnBuildComponent()
end

function UICompCommentDetailItem:OnEnterComponent()
  self:LoadAllLangFont(self.ui.Text_Comment)
  self:LoadAllLangFont(self.ui.Text_View_Comment)
  self._commentTmpComp = self.ui.Text_Comment:GetComponent(typeof(TextMeshProUGUI))
  self._viewCommentTmpComp = self.ui.Text_View_Comment:GetComponent(typeof(TextMeshProUGUI))
  self:SetText(self.ui.Text_Btn_Hide, LT.Text("CommonItemHide"))
  self:_RefreshView()
end

function UICompCommentDetailItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Edit, System.fn(self, self._OnClickEdit))
  self:AddButtonClickListener(self.ui.Btn_Remove, System.fn(self, self._OnClickRemove))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._OnClickMask))
  self:AddButtonClickListener(self.ui.Btn_Copy, System.fn(self, self._OnClickCopy))
  self:AddButtonClickListener(self.ui.Btn_Head, System.fn(self, self._OnClickHead))
  self:AddButtonClickListener(self.ui.Btn_GmHide, System.fn(self, self._OnClickGmHide))
  self:BindEvent(EventMgr.Instance.PvpCollectionLikeComment, System.fn(self, self._OnPvpCollectionLikeComment))
  self:BindEvent(EventMgr.Instance.PvpCollectionUnlikeComment, System.fn(self, self._OnPvpCollectionUnlikeComment))
  self:BindEvent(EventMgr.Instance.SocialAttention, System.fn(self, self._OnSocialAttention))
end

function UICompCommentDetailItem:_OnSocialAttention(targetUid, newRelation)
  if not self._commentMO then
    return
  end
  if targetUid ~= self._commentMO:GetUid() then
    return
  end
  self._commentMO:SetRelation(newRelation)
  self:_RefreshPlayerBaseInfo()
end

function UICompCommentDetailItem:_OnClickGmHide()
  if CommentModel.Instance:GetIsCommentManager() then
    Alert.Show("PvpHideCommentConfirm", function()
      local targetCommentId = self._commentMO:GetCommentId()
      CommentController.Instance:ReqGmUnhideComment(targetCommentId, self._commentMO:GetUid())
    end, function()
    end)
  end
end

function UICompCommentDetailItem:_OnPvpCollectionLikeComment()
  self:_RefreshPlayerBaseInfo()
end

function UICompCommentDetailItem:_OnPvpCollectionUnlikeComment()
  self:_RefreshPlayerBaseInfo()
end

function UICompCommentDetailItem:_OnClickCopy()
  local content = self._commentMO:GetContent()
  StrUtils.CopyToClipboard(content)
  Alert.Show(10746)
end

function UICompCommentDetailItem:_OnClickHead()
  SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, self._commentMO:GetUid())
end

function UICompCommentDetailItem:_OnClickMask()
  if self._maskClickCb then
    self._maskClickCb()
  end
end

function UICompCommentDetailItem:_OnClickEdit()
  if not self._commentMO:IsCanEdit() then
    Alert.ShowStr(LT.Text("PvpCollectCommentEditTimeOutTips"))
    return
  end
  local targetCommentId = self._commentMO:GetCommentId()
  local viewData = {
    commentId = targetCommentId,
    clickCb = function(targetConent, callback)
      CommentController.Instance:ReqEditComment(targetCommentId, targetConent, callback)
    end
  }
  CommentController.Instance:OpenCommentEditView(viewData)
end

function UICompCommentDetailItem:_OnClickRemove()
  local targetCommentId = self._commentMO:GetCommentId()
  Alert.Show("PvpCollectionCommentDeleteTips", nil, function()
    CommentController.Instance:ReqDeleteComment(targetCommentId, System.fn(self, self._OnClickMask))
  end)
end

function UICompCommentDetailItem:_IsMyComment()
  return self._commentMO:GetUid() == PlayerDataUtils.GetPlayerUid()
end

function UICompCommentDetailItem:_RefreshView()
  self:SetActive(self.ui.UI_Vx_Glow, false)
  self:_RefreshBtnState()
  self:_RefreshPublishTime()
  self:SetImage(self.ui.Image_Head, self._commentMO:GetPlayerIcon())
  self:_RefreshProficiency()
  self:SetActive(self.ui.Text_Comment, true)
  self:SetText(self.ui.Text_Comment, LT.Text(self._commentMO:GetContent()), nil, nil, {banKeywordBtn = true})
  self._commentTmpComp:ForceMeshUpdate()
  local lineCount = self._commentTmpComp.textInfo.lineCount
  if lineCount >= 9 then
    self:SetActive(self.ui.Text_Comment, false)
    self:SetActive(self.ui.CommentView, true)
    self:SetText(self.ui.Text_View_Comment, LT.Text(self._commentMO:GetContent()), nil, nil, {banKeywordBtn = true})
    CS.Framework.TransformUtil.SetHeight(self.ui.Content.transform, self._commentTmpComp.textBounds.size.y)
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Content.transform, 0, 0)
  else
    self:SetActive(self.ui.Text_Comment, true)
    self:SetActive(self.ui.CommentView, false)
  end
  self:_RefreshPlayerBaseInfo()
end

function UICompCommentDetailItem:_RefreshProficiency()
  if not self._isPvp then
    self:SetActive(self.ui.Text_C_Proficiency, false)
    return
  end
  self:SetActive(self.ui.Text_C_Proficiency, true)
  self:SetText(self.ui.Text_Proficiency, self._commentMO:GetCardStarCount())
end

function UICompCommentDetailItem:_RefreshBtnState()
  local isMyComment = self:_IsMyComment()
  local needShowHideBtn = CommentModel.Instance:GetIsCommentManager()
  self:SetActive(self.ui.Btn_Copy, true)
  self:SetActive(self.ui.Btn_Remove, isMyComment)
  self:SetActive(self.ui.Btn_GmHide, needShowHideBtn)
  self:SetActive(self.ui.Btn_Edit, false)
end

function UICompCommentDetailItem:_RefreshPublishTime()
  local createTs = self._commentMO:GetCreateTs()
  local createStr = CommentUiUtils.GetPublishTimeStr(createTs)
  createStr = LT.Textf("PvpCollectCommentPublishTime", createStr)
  local showStr = createStr
  self:SetText(self.ui.Text_Time, showStr)
end

function UICompCommentDetailItem:_RefreshPlayerBaseInfo()
  CommentUiUtils.RefreshCommentPlayerBaseInfo(self, self.ui, self._commentMO)
end

return UICompCommentDetailItem
