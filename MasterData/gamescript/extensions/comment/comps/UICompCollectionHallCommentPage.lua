local UICompCollectionHallCommentPage, Super = NewViewComponent("UICompCollectionHallCommentPage", UICompPvpCollectionCommentPage)

function UICompCollectionHallCommentPage:ctor(uiNode, view, viewData)
  self.viewData = viewData
  Super.ctor(self, uiNode, view)
end

function UICompCollectionHallCommentPage:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_RequsetCommentData()
end

function UICompCollectionHallCommentPage:_GetTargetCommentId()
  return self.viewData and self.viewData.commentId
end

function UICompCollectionHallCommentPage:_RefreshCommentDetail(visible, commentMO)
  self:SetActive(self.ui.UI_Pvp_Tip_Comment, visible)
  if visible then
    self:AddViewComponentOnce(self.ui.UI_Pvp_Tip_Comment, UICompCommentDetailItem, commentMO, {
      maskClickCb = System.fn(self, self._OnClickMask)
    })
  end
end

return UICompCollectionHallCommentPage
