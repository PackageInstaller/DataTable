local TalentStageChapterlView, Super = NewClass("TalentStageChapterlView", BaseView)
TalentStageChapterlView.uiResCls = UI_Chapter_Popup_StageChapterResource

function TalentStageChapterlView:ctor(stageChapter)
  Super.ctor(self)
  self.stageChapter = stageChapter
  local _, seasonIndex = table.unpack(DT.GetOriginalConstant(stageChapter) or {})
  self.seasonIndex = seasonIndex
end

function TalentStageChapterlView:RegisterNotifications()
end

function TalentStageChapterlView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function TalentStageChapterlView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_C_Title, LT.Text("SeasonName_" .. self.seasonIndex))
  self:SetText(self.ui.Text_Detail, LT.Text("SeasonDesc_" .. self.seasonIndex))
  self:SetActive(self.ui.Group_Relic, false)
  local pos = self.ui.UI_Common_StageChapter.transform.localPosition
  pos.x = 0
  self.ui.UI_Common_StageChapter.transform.localPosition = pos
  local chapterUI = UI_Common_Btn_StageChapterResource(self.ui.UI_Common_StageChapter)
  local list = DT.GetOriginalConstant(self.stageChapter)
  local text, index = table.unpack(list)
  self:SetText(chapterUI.Text_ChapterName, text)
  if index then
    for i = 1, 5 do
      if chapterUI["Image_Bg" .. i] then
        self:SetActive(chapterUI["Image_Bg" .. i], index == i)
      end
    end
  end
end

return TalentStageChapterlView
