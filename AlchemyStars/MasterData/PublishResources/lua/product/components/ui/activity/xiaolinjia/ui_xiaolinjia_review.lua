_class("UIXiaoLinJiaReview", UIController)
UIXiaoLinJiaReview = UIXiaoLinJiaReview

function UIXiaoLinJiaReview:OnShow(uiParams)
  self._dialogReviewScrollView = self:GetUIComponent("UIDynamicScrollView", "sv")
  self.anim = self:GetUIComponent("Animation", "anim")
  self.curSession = uiParams[1]
  self.dialogList = uiParams[2]
  self.recordPos = uiParams[3]
  self.callback = uiParams[4]
  self.record = {}
  self:Flush()
end

function UIXiaoLinJiaReview:OnHide()
end

function UIXiaoLinJiaReview:Flush()
  local startSession = self.recordPos
  while startSession ~= self.curSession do
    table.insert(self.record, self.dialogList[startSession])
    if self.dialogList[startSession].Jump then
      startSession = self.dialogList[startSession]
    else
      startSession = startSession + 1
    end
  end
  self._dialogReviewScrollView:InitListView(0, function(scrollview, index)
    return self:_OnGetReviewDialogItem(scrollview, index)
  end)
  self._dialogReviewScrollView:SetListItemCount(#self.record, true)
  self._dialogReviewScrollView:MovePanelToItemIndex(#self.record - 1, 0)
end

function UIXiaoLinJiaReview:_OnGetReviewDialogItem(scrollview, index)
  local item = scrollview:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIXiaoLinJiaReviewItem", 1)
  end
  local luaIndex = index + 1
  if luaIndex <= #self.record then
    local rowList = rowPool:GetAllSpawnList()
    local itemWidget = rowList[1]
    local speakerIdx = self.record[luaIndex].Speaker
    local icon = self.record[luaIndex].FaceIcon[speakerIdx]
    local content = self.record[luaIndex].Content
    itemWidget:Flush(speakerIdx, icon, content)
    UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
    return item
  else
    return nil
  end
end

function UIXiaoLinJiaReview:ImgCloseOnClick(go)
  self:Lock("UIXiaoLinJiaReview_Close")
  self.anim:Play("uieffanim_UIXiaoLinJiaReview_out")
  self:StartTask(function(TT)
    YIELD(TT, 333)
    self:CloseDialog()
    self.callback()
    self:UnLock("UIXiaoLinJiaReview_Close")
  end)
end
