local CopyChapterMvcItem, Super = NewViewComponent("CopyChapterMvcItem")

function CopyChapterMvcItem:ctor(uiNode, view, stageId, isForbidClick)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Btn_StageChapterResource(uiNode)
  self.stageId = stageId
  self.isForbidClick = isForbidClick
end

function CopyChapterMvcItem:RegisterEvents()
  if not self.isForbidClick then
    self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
  end
end

function CopyChapterMvcItem:OnEnterComponent()
  local stageChapter = CopyDataUtils.GetStageChapter(self.stageId)
  if not stageChapter then
    self:SetActive(self.ui.uiNode, false)
  else
    self:SetActive(self.ui.uiNode, true)
    local text, index = CopyDataUtils.GetStageChapterTextAndIdx(self.stageId)
    self:SetText(self.ui.Text_ChapterName, LT.Text(text))
    if index then
      for i = 1, 5 do
        if self.ui["Image_Bg" .. i] then
          self:SetActive(self.ui["Image_Bg" .. i], index == i)
        end
      end
    end
  end
  self:CheckIsHide()
end

function CopyChapterMvcItem:CheckIsHide()
  local stageCfg = CopyDataUtils.GetStageCfg(self.stageId)
  if stageCfg and stageCfg.MapType == cd.StageMapType.Story then
    self:SetActive(self.ui.uiNode, false)
  else
    self:SetActive(self.ui.uiNode, true)
  end
end

function CopyChapterMvcItem:OnBtnClick()
  if UIManager.Instance:GetWindow(Urls.CopyChapterDetailView) then
    UIManager.Instance:CloseByUrl(Urls.CopyChapterDetailView)
    return
  end
  UIManager.Instance:Reopen(Urls.CopyChapterDetailView, self.stageId)
end

return CopyChapterMvcItem
