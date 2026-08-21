_class("UIBlackFightPaperReview", UIController)
UIBlackFightPaperReview = UIBlackFightPaperReview

function UIBlackFightPaperReview:Constructor()
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = mCampaign:GetN7DataReview()
end

function UIBlackFightPaperReview:OnShow(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end, nil, nil, false)
  self.btnPrev = self:GetGameObject("BtnPrev")
  self.btnNext = self:GetGameObject("BtnNext")
  self.txtPage = self:GetUIComponent("UILocalizationText", "txtPage")
  self.svRect = self:GetUIComponent("RectTransform", "sv")
  self.svHelper = H3DScrollViewHelper:New(self, "sv", "UIBlackFightPaperItemReview", function(index, uiWidget)
    uiWidget:Flush(self.data.papers[index])
    return uiWidget
  end, nil, nil)
  self.svHelper:SetEndSnappingCallback(function(index, item)
    self.curIdx = self.tempIndex
    self:Flush()
  end)
  self.totalCount = table.count(self.data.papers)
  local existNotReadPaper, paper = self.data:ExistNotReadPaper()
  if existNotReadPaper then
    self.curIdx = paper.idx
  else
    self.curIdx = 1
  end
  self.tempIndex = self.curIdx
  self.preIndex = 0
  self.svHelper:Init(self.totalCount, self.curIdx, Vector2(self.svRect.rect.width, self.svRect.rect.height))
  self:Flush()
  self:FlushPage(self.tempIndex)
end

function UIBlackFightPaperReview:OnHide()
end

function UIBlackFightPaperReview:Flush()
  self.data:ReadPaper(self.curIdx)
  if self.curIdx == 1 then
    self.btnPrev:SetActive(false)
    self.btnNext:SetActive(true)
  elseif self.curIdx == self.totalCount then
    self.btnPrev:SetActive(true)
    self.btnNext:SetActive(false)
  else
    self.btnPrev:SetActive(true)
    self.btnNext:SetActive(true)
  end
end

function UIBlackFightPaperReview:FlushPage(cur)
  local str = cur .. "/" .. self.totalCount
  self.txtPage:SetText(StringTable.Get("str_n7_black_fight_page", str))
  if self.preIndex ~= cur then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N7ReadPaper)
    self.preIndex = cur
  end
end

function UIBlackFightPaperReview:BtnPrevOnClick(go)
  self:CoOnClick(false)
end

function UIBlackFightPaperReview:BtnNextOnClick(go)
  self:CoOnClick(true)
end

function UIBlackFightPaperReview:CoOnClick(isNext)
  local canPage = false
  if isNext then
    if self.curIdx < self.totalCount then
      canPage = true
      self.tempIndex = self.curIdx + 1
    end
  elseif self.curIdx > 1 then
    canPage = true
    self.tempIndex = self.curIdx - 1
  end
  if canPage then
    self:StartTask(function(TT)
      local key = "UIBlackFightPaperReviewCoOnClick"
      self:Lock(key)
      self.svHelper:MovePanelToIndex(self.tempIndex)
      self:FlushPage(self.tempIndex)
      YIELD(TT, 836)
      self:UnLock(key)
    end, self)
  end
end
