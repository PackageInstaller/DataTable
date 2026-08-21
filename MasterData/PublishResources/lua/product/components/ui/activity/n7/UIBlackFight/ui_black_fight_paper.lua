_class("UIBlackFightPaper", UIController)
UIBlackFightPaper = UIBlackFightPaper

function UIBlackFightPaper:Constructor()
  local mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = mCampaign:GetN7BlackFightData()
end

function UIBlackFightPaper:LoadDataOnEnter(TT, res, uiParams)
end

function UIBlackFightPaper:OnShow(uiParams)
  self.btnPrev = self:GetGameObject("btnPrev")
  self.btnNext = self:GetGameObject("btnNext")
  self.txtPage = self:GetUIComponent("UILocalizationText", "txtPage")
  self.svRect = self:GetUIComponent("RectTransform", "sv")
  self.svHelper = H3DScrollViewHelper:New(self, "sv", "UIBlackFightPaperItem", function(index, uiWidget)
    local blackFightPaperItem = uiWidget
    blackFightPaperItem:Flush(self.data.papers[index])
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
    self.curIdx = self.data.curOverviewPaper.idx or 1
  end
  self.tempIndex = self.curIdx
  self.preIndex = 0
  self.svHelper:Init(self.totalCount, self.curIdx, Vector2(self.svRect.rect.width, self.svRect.rect.height))
  self:Flush()
  self:FlushPage(self.tempIndex)
end

function UIBlackFightPaper:OnHide()
end

function UIBlackFightPaper:Flush()
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

function UIBlackFightPaper:FlushPage(cur)
  local str = cur .. "/" .. self.totalCount
  self.txtPage:SetText(StringTable.Get("str_n7_black_fight_page", str))
  if self.preIndex ~= cur then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N7ReadPaper)
    self.preIndex = cur
  end
end

function UIBlackFightPaper:bgOnClick(go)
  self:CloseDialog()
end

function UIBlackFightPaper:btnPrevOnClick(go)
  self:CoOnClick(false)
end

function UIBlackFightPaper:btnNextOnClick(go)
  self:CoOnClick(true)
end

function UIBlackFightPaper:CoOnClick(isNext)
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
      local key = "UIBlackFightPaperbtnOnClick"
      self:Lock(key)
      self.svHelper:MovePanelToIndex(self.tempIndex)
      self:FlushPage(self.tempIndex)
      YIELD(TT, 836)
      self:UnLock(key)
    end, self)
  end
end
