local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local UICompPvpCollectionCommentPage, Super = NewViewComponent("UICompPvpCollectionCommentPage")

function UICompPvpCollectionCommentPage:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Panel_Collection_CommentResource(uiNode)
  self:_InitViewData()
end

function UICompPvpCollectionCommentPage:_CheckAndShowFirstLoadTip()
  if 0 == #self._commentUidList then
    self:SetActive(self.ui.Group_Null_Black, true)
    if self.ui.Text_C_NoTask then
      self:SetText(self.ui.Text_C_NoTask, LT.Text("RankDataFirstLoadTip"))
    end
    if self.ui.Text_Time then
      self.ui.Text_Time:SetActive(false)
    end
  end
end

function UICompPvpCollectionCommentPage:OnBuildComponent()
  self:_CreateTableView()
end

function UICompPvpCollectionCommentPage:OnEnterComponent()
  self.binder:UpdateLocalizedTextAndResouce(self.ui.UI_Pvp_Item_Collection_Comment)
  self:LoadAllLangFont(self.ui.Text_Comment)
  self._commentTmpComp = self.ui.Text_Comment:GetComponent(typeof(TextMeshProUGUI))
  self:_CheckAndShowFirstLoadTip()
  self:_RefreshView()
end

function UICompPvpCollectionCommentPage:_RequsetCommentData()
  self._isRequesting = true
  local targetCommentId = self:_GetTargetCommentId()
  CommentController.Instance:ReqViewComments(targetCommentId, self._commentPage, self._commentPageSize, self._commentSortMode, function()
    self._isRequesting = false
    if self.ui.Text_C_NoTask then
      self:SetText(self.ui.Text_C_NoTask, "")
    end
    if self.ui.Text_Time then
      self.ui.Text_Time:SetActive(true)
    end
    self:_UpdateCommentInfoList()
    self:_RefreshView()
  end)
end

function UICompPvpCollectionCommentPage:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Filter, System.fn(self, self._OnClickBtnFilter))
  self:AddButtonClickListener(self.ui.Btn_Comment, System.fn(self, self._OnClickBtnComment))
  self:_BindEvent()
end

function UICompPvpCollectionCommentPage:_BindEvent()
  self:BindEvent(EventMgr.Instance.PvpCollectionSelect, System.fn(self, self._OnPvpCollectionSelect))
  self:BindEvent(EventMgr.Instance.PvpCollectionPublishComment, System.fn(self, self._OnPvpCollectionPublishComment))
  self:BindEvent(EventMgr.Instance.PvpCollectionDeleteComment, System.fn(self, self._OnPvpCollectionDeleteComment))
  self:BindEvent(EventMgr.Instance.PvpCollectionEditComment, System.fn(self, self._OnPvpCollectionEditComment))
  self:BindEvent(EventMgr.Instance.PvpCollectionClickComment, System.fn(self, self._OnPvpCollectionClickComment))
  self:BindEvent(EventMgr.Instance.PvpCollectionPageChanged, System.fn(self, self._OnPvpCollectionPageChanged))
end

function UICompPvpCollectionCommentPage:_OnPvpCollectionPageChanged(page)
  if page == CommonDefine.PVPCollectionDetailTab.Comment then
    self:_InitViewData()
    self:_CheckAndShowFirstLoadTip()
    self:_RequsetCommentData()
    self:_UpdateCommentInfoList()
    self:_RefreshView()
  end
end

function UICompPvpCollectionCommentPage:_OnPvpCollectionClickComment(commentMO)
  self:_OnClickExpandComment(commentMO)
end

function UICompPvpCollectionCommentPage:_OnClickMask()
  self:_RefreshCommentDetail(false)
end

function UICompPvpCollectionCommentPage:_OnPvpCollectionSelect()
  self:_InitViewData()
  self:_CheckAndShowFirstLoadTip()
  self:_RequsetCommentData()
  self:_UpdateCommentInfoList()
  self:_RefreshView()
end

function UICompPvpCollectionCommentPage:_OnPvpCollectionDeleteComment(targetCommentId)
  if self:_GetTargetCommentId() ~= targetCommentId then
    return
  end
  self._commentCfgs[targetCommentId][PlayerDataUtils.GetPlayerUid()] = nil
  self:_UpdateCommentInfoList()
  self:_RefreshBtnState()
  self:_RefreshEmptyState()
  self:_RefreshTableView()
end

function UICompPvpCollectionCommentPage:_OnPvpCollectionPublishComment(targetCommentId)
  if self:_GetTargetCommentId() ~= targetCommentId then
    return
  end
  self:_UpdateCommentInfoList()
  self:_RefreshBtnState()
  self:_RefreshEmptyState()
  self:_RefreshTableView()
end

function UICompPvpCollectionCommentPage:_OnPvpCollectionEditComment(targetCommentId)
  if self:_GetTargetCommentId() ~= targetCommentId then
    return
  end
  self:_UpdateCommentInfoList()
  self:_RefreshBtnState()
  self:_RefreshEmptyState()
  self:_RefreshTableView()
  local myCommentMO = self:_GetMyCommentMO()
  if myCommentMO then
    self:_RefreshCommentDetail(true, myCommentMO)
  end
end

function UICompPvpCollectionCommentPage:_OnClickBtnFilter()
  TrinketFilterController.Instance:OpenCommonFilterView(self.ui.CommentFilterPos.transform.position, self._commentSortMode, {
    {
      type = CommentDefine.CommentSortMode.Recommend,
      name = LT.Text("PvpCollectCommentSortModeRecommend")
    },
    {
      type = CommentDefine.CommentSortMode.PublishTime,
      name = LT.Text("PvpCollectCommentSortModePublishTime")
    }
  }, function(type)
    self:_SetCommentSortMode(type)
  end)
end

function UICompPvpCollectionCommentPage:_OnClickBtnComment()
  local targetCommentId = self:_GetTargetCommentId()
  local isCommented = CommentModel.Instance:IsCommented(targetCommentId)
  if isCommented then
    local playerUid = PlayerDataUtils.GetPlayerUid()
    local targetCommentMO = self:_GetMyCommentMO()
    if not targetCommentMO then
      CommentController.Instance:ReqViewCommentOfUid(targetCommentId, playerUid, function()
        targetCommentMO = CommentModel.Instance:GetCommentMO(targetCommentId, playerUid)
        if targetCommentMO then
          self:_RefreshCommentDetail(true, targetCommentMO)
        end
      end)
    else
      self:_RefreshCommentDetail(true, targetCommentMO)
    end
  else
    local viewData = {
      commentId = targetCommentId,
      clickCb = function(targetConent, callback)
        CommentController.Instance:ReqPublishComment(targetCommentId, targetConent, callback)
      end
    }
    CommentController.Instance:OpenCommentEditView(viewData)
  end
end

function UICompPvpCollectionCommentPage:_OnClickExpandComment(commentMO)
  self:_RefreshCommentDetail(true, commentMO)
end

function UICompPvpCollectionCommentPage:_InitViewData()
  self._isRequesting = false
  self._commentSortMode = CommentDefine.CommentSortMode.Recommend
  self._commentPage = 1
  self._commentPageSize = 10
  self._commentUidList = {}
  self:_UpdateCommentInfoList()
end

function UICompPvpCollectionCommentPage:_NextPage()
  local targetCommentId = self:_GetTargetCommentId()
  local targetTotalCount = CommentModel.Instance:GetCommentTotalCount(targetCommentId)
  if targetTotalCount <= #self._commentUidList then
    return
  end
  if self._isRequesting then
    return
  end
  self._commentPage = self._commentPage + 1
  self:_RequsetCommentData()
end

function UICompPvpCollectionCommentPage:_GetMyCommentMO()
  local targetCommentId = self:_GetTargetCommentId()
  local playerUid = PlayerDataUtils.GetPlayerUid()
  do return CommentModel.Instance.GetCommentMO, CommentModel.Instance, targetCommentId end
  return CommentModel.Instance.GetCommentMO, CommentModel.Instance, targetCommentId, playerUid
end

function UICompPvpCollectionCommentPage:_UpdateCommentInfoList()
  local targetCommentId = self:_GetTargetCommentId()
  self._commentUidList = CommentModel.Instance:GetCommentSequence(targetCommentId, self._commentSortMode)
end

function UICompPvpCollectionCommentPage:_SetCommentPage(page)
  self._commentPage = page
end

function UICompPvpCollectionCommentPage:_SetCommentSortMode(mode)
  self:_InitViewData()
  self._commentSortMode = mode
  self:_RequsetCommentData()
  self:_UpdateCommentInfoList()
  self:_RefreshView()
end

function UICompPvpCollectionCommentPage:_GetTargetCommentId()
  do return PvpCollectionModel.Instance.GetSelectCollectionTid end
  return PvpCollectionModel.Instance.GetSelectCollectionTid, PvpCollectionModel.Instance
end

function UICompPvpCollectionCommentPage:_RefreshView()
  self:_RefreshAwakerName()
  self:_RefreshBtnState()
  self:_RefreshEmptyState()
  self:_RefreshTableView()
end

function UICompPvpCollectionCommentPage:_RefreshCommentDetail(visible, commentMO)
  self:SetActive(self.ui.UI_Pvp_Tip_Comment, visible)
  if visible and commentMO then
    self:AddViewComponentOnce(self.ui.UI_Pvp_Tip_Comment, UICompCommentDetailItem, commentMO, {
      maskClickCb = System.fn(self, self._OnClickMask),
      isPvp = true
    })
  end
end

function UICompPvpCollectionCommentPage:_RefreshAwakerName()
  local targetCommentId = self:_GetTargetCommentId()
  self:SetText(self.ui.Text_Name_Role, LT.Text(PvpCollectCfgUtils.GetCollectionName(targetCommentId)))
end

function UICompPvpCollectionCommentPage:_RefreshBtnState()
  local targetCommentId = self:_GetTargetCommentId()
  local isCommented = CommentModel.Instance:IsCommented(targetCommentId)
  local btnText = isCommented and LT.Text("PvpCollectCommentBtnMine") or LT.Text("PvpCollectCommentBtnPublish")
  self:SetButtonText(self.ui.Btn_Comment, btnText)
end

function UICompPvpCollectionCommentPage:_RefreshTableView()
  self.tableView:ReloadData()
end

function UICompPvpCollectionCommentPage:_RefreshEmptyState()
  if self._isRequesting then
    return
  end
  local isEmpty = 0 == #self._commentUidList
  self:SetActive(self.ui.Group_Null_Black, isEmpty)
  if isEmpty and self.ui.Text_C_NoTask then
    self:SetText(self.ui.Text_C_NoTask, LT.Text("CommentDataNull"))
  end
end

function UICompPvpCollectionCommentPage:_CreateTableView()
  local sizeDelta = self.ui.UI_Pvp_Item_Collection_Comment.transform.sizeDelta
  local w = sizeDelta.x
  self._commentCfgs = {}
  self.tableView = self:CreateTableview(self.ui.ScrollView_Comment, function()
    return #self._commentUidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Pvp_Item_Collection_Comment)
    self:_FillCommentCell(cell.gameObject, index)
    return cell
  end, function(_, index)
    local commentUid = self._commentUidList[index]
    local commentMO = CommentModel.Instance:GetCommentMO(self:_GetTargetCommentId(), commentUid)
    local targetCommentId = self:_GetTargetCommentId()
    self._commentCfgs[targetCommentId] = self._commentCfgs[targetCommentId] or {}
    local commentCfg = self._commentCfgs[targetCommentId][commentUid]
    if commentCfg and commentCfg.rawContent ~= commentMO:GetContent() then
      commentCfg = nil
    end
    local showContent, height, isNeedLayoutAdjust
    if not commentCfg then
      local content = commentMO:GetContent()
      showContent = commentMO:GetShowContent()
      if string.isempty(showContent) then
        showContent = UICompPvpCollectionCommentItem.CalContent(self, self._commentTmpComp, content)
      end
      self:SetText(self.ui.Text_Comment, showContent)
      self._commentTmpComp:ForceMeshUpdate()
      local preferredHeight = self._commentTmpComp.preferredHeight
      local boundSizeY = self._commentTmpComp.textBounds.size.y
      local isPreferredHeightValid = preferredHeight > 0
      local isTextBoundsSizeYValid = boundSizeY > 0
      isNeedLayoutAdjust = math.floor(preferredHeight + 0.5) ~= math.floor(boundSizeY + 0.5)
      isNeedLayoutAdjust = isPreferredHeightValid and isTextBoundsSizeYValid and isNeedLayoutAdjust
      local adjSize = isNeedLayoutAdjust and 45 or 0
      height = 78 + preferredHeight + adjSize
      commentCfg = {}
      commentCfg.height = height
      commentCfg.showContent = showContent
      commentCfg.rawContent = content
      commentCfg.isNeedLayoutAdjust = isNeedLayoutAdjust
      self._commentCfgs[targetCommentId][commentUid] = commentCfg
    end
    commentMO:SetShowContent(commentCfg.showContent)
    commentMO:SetNeedLayoutAdjust(commentCfg.isNeedLayoutAdjust)
    return w, commentCfg.height
  end)
  
  function self.tableView.onScrollValueChanged(_, vector2)
    if vector2.y < 0 then
      self:_NextPage()
    end
  end
end

function UICompPvpCollectionCommentPage:_FillCommentCell(cellGO, index)
  local commentUid = self._commentUidList[index]
  local viewData = {
    commentId = self:_GetTargetCommentId(),
    commentUid = commentUid,
    index = index
  }
  self:AddViewComponentOnce(cellGO.gameObject, UICompPvpCollectionCommentItem, viewData)
end

return UICompPvpCollectionCommentPage
