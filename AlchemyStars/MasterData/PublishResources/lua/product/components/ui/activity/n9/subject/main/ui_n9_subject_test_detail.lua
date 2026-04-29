_class("UIN9SubjectTestDetailController", UIController)
UIN9SubjectTestDetailController = UIN9SubjectTestDetailController

function UIN9SubjectTestDetailController:OnShow(uiParams)
  self._levelData = uiParams[1]
  self._tittleLabel = self:GetUIComponent("UILocalizationText", "Tittle")
  self._tittleBgLabel = self:GetUIComponent("UILocalizationText", "TitleBg")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._historyCountLabel = self:GetUIComponent("UILocalizationText", "HistoryCount")
  self._gradeLabel = self:GetUIComponent("UILocalizedTMP", "Grade")
  self._tittleLabel:SetText(self._levelData:GetLevelName())
  self._tittleBgLabel:SetText(self._levelData:GetLevelName())
  self._desLabel:SetText(self._levelData:GetDes())
  local historyCount = self._levelData:GetHistoryRecord()
  if historyCount <= 0 then
    self._historyCountLabel:SetText("--")
  else
    self._historyCountLabel:SetText(StringTable.Get("str_activity_n9_test_level_subject_count", historyCount))
  end
  local gradeStr = self._levelData:GetGradeLevelStr()
  self._gradeLabel:SetText(gradeStr)
  self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("uieff_n9_subject_grade_name.mat", LoadType.Mat)
  self._EMIMat = self._EMIMatResRequest.Obj
  local mat = self._gradeLabel.fontMaterial
  self._gradeLabel.fontMaterial = self._EMIMat
  self._gradeLabel.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN9SubjectTestDetailController:OnHide()
  self._EMIMatResRequest = nil
  self._EMIMat = nil
end

function UIN9SubjectTestDetailController:BtnStartTestOnClick()
  local grade = self._levelData:GetLeveGrade()
  self:ShowDialog("UIN9AnswerController", grade)
  self:CloseDialog()
end

function UIN9SubjectTestDetailController:MaskOnClick()
  self:CloseDialog()
end
