local ContentMinHeight = 119.54
local CommentEditView, Super = NewClass("CommentEditView", BaseView)
CommentEditView.uiResCls = UI_Social_Popup_IntroductionResource

function CommentEditView:ctor(viewData)
  Super.ctor(self)
  self:_InitViewData(viewData)
end

function CommentEditView:OnBuildView()
end

function CommentEditView:OnEnterView()
  local targetCommentMO = CommentModel.Instance:GetCommentMO(self._commentId, PlayerDataUtils.GetPlayerUid())
  if targetCommentMO then
    self:SetInputText(self.ui.InputField_Account, targetCommentMO:GetContent())
  end
  self:_RefreshView()
end

function CommentEditView:OnEnterViewFinished()
end

function CommentEditView:RegisterEvents()
  self:AddInputValueChangeListener(self.ui.InputField_Account, System.fn(self, self._OnListInputValueChange))
end

function CommentEditView:_OnListInputValueChange()
  self:_RefreshLimitTextInfo()
end

function CommentEditView:_OnClickConfirm()
  if self:_IsCommentOverLength() then
    Alert.ShowStr(LT.Textf("PvpCollectCommentEditLabel", self._maxCommentLength))
    return
  end
  if self:GetInputText(self.ui.InputField_Account) == "" then
    Alert.Show("PublishEmptyCommentTips")
    return
  end
  local targetConent = self:GetInputText(self.ui.InputField_Account)
  if self._clickCb then
    self._clickCb(targetConent, System.fn(self, self.Close))
  end
end

function CommentEditView:_InitViewData(viewData)
  self._commentId = viewData.commentId
  self._clickCb = viewData.clickCb
  self._maxCommentLength = CommentModel.Instance:GetCommentLimitCharNum()
  self._textCurHeight = ContentMinHeight
end

function CommentEditView:_IsCommentOverLength()
  local targetContent = self:GetInputText(self.ui.InputField_Account)
  local lengCur = StrUtils.GetCharLen(targetContent)
  return lengCur > self._maxCommentLength
end

function CommentEditView:_RefreshView()
  self:SetActive(self.ui.Text_C_Placeholder, false)
  self:SetActive(self.ui.Text_Label, true)
  self:SetActive(self.ui.Text_Num_Limit, true)
  self:SetText(self.ui.Text_Label, LT.Textf("PvpCollectCommentEditLabel", self._maxCommentLength))
  self:_RefreshLimitTextInfo()
  self:_RefreshPopupTipsComp()
end

function CommentEditView:_RefreshLimitTextInfo()
  local targetContent = self:GetInputText(self.ui.InputField_Account)
  local lengCur = StrUtils.GetCharLen(targetContent)
  if self:_IsCommentOverLength() then
    local colorRed = ColorCfgUtils.GetCfgField("Dark", "TextRed")
    lengCur = string.color(lengCur, colorRed)
  end
  self:SetText(self.ui.Text_Num_Limit, LT.Textf("Mail_Number", lengCur, self._maxCommentLength))
  self:SetText(self.ui.Text_Tmp, targetContent)
  if "" == targetContent then
    CS.Framework.TransformUtil.SetHeight(self.ui.Content.transform, ContentMinHeight)
  else
    FrameWaiter.OnNextFrame(function()
      local targetHeight = math.max(ContentMinHeight, self.ui.Text_Tmp.transform.sizeDelta.y)
      if targetHeight ~= self._textCurHeight then
        CS.Framework.TransformUtil.SetHeight(self.ui.Content.transform, targetHeight)
        if targetHeight > self._textCurHeight then
          CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Content.transform, 0, targetHeight - ContentMinHeight)
        end
        self._textCurHeight = targetHeight
      end
    end, 1)
  end
end

function CommentEditView:_RefreshPopupTipsComp()
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self._OnClickConfirm),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.Close),
    stateFunc = function()
      return CommonDefine.BtnType.High
    end
  }
  local viewData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    textTitleCN = LT.Text("PvpCollectEditCommentViewTitle"),
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    banMaskClick = true
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_Confirm_S, CompPublicPopupConfirmTips, viewData)
end

return CommentEditView
