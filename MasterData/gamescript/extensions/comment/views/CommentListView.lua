local CommentListView, Super = NewClass("CommentListView", BaseView)
CommentListView.uiResCls = UI_Collection_Panel_CommentResource

function CommentListView:ctor(viewData)
  Super.ctor(self)
  self:_InitViewData(viewData)
end

function CommentListView:OnEnterView()
  self:AddViewComponentOnce(self.ui.UI_Pvp_Panel_Collection_Comment, UICompCollectionHallCommentPage, self._viewData)
  self:AddViewComponentOnce(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function CommentListView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Image_Ray, System.fn(self, self.Close))
end

function CommentListView:_InitViewData(viewData)
  self._viewData = viewData
  self._commentId = viewData.commentId
end

function CommentListView:_RefreshView()
end

return CommentListView
