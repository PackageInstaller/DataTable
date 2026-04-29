_class("UIStageChapter", UICustomWidget)
UIStageChapter = UIStageChapter

function UIStageChapter:OnShow()
  self._txtTitleIdx = self:GetUIComponent("UILocalizationText", "txtTitleIdx")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._chapterName = self:GetUIComponent("UILocalizationText", "chapterName")
end

function UIStageChapter:Flush(titleIdx, title, desc, chapterName, isBetween)
  titleIdx = titleIdx or ""
  title = title or ""
  self._txtTitleIdx:SetText(titleIdx .. title)
  desc = desc or ""
  self._txtDesc:SetText(desc)
  local showChapterName = chapterName or ""
  self._chapterName:SetText(showChapterName)
  if isBetween then
    self._chapterName.color = Color(0.611764705882353, 0.45098039215686275, 0.7254901960784313, 1)
    self._txtTitleIdx.color = Color(0.6392156862745098, 0.6196078431372549, 0.6666666666666666, 1)
    self._txtDesc.color = Color(0.5254901960784314, 0.5254901960784314, 0.5254901960784314, 1)
  end
end
