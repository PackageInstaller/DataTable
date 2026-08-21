_class("UIN16SubjectTestDetailController", UIController)
UIN16SubjectTestDetailController = UIN16SubjectTestDetailController

function UIN16SubjectTestDetailController:OnShow(uiParams)
  self._levelData = uiParams[1]
  self._tittleLabel = self:GetUIComponent("UILocalizedTMP", "Tittle")
  self._titleBg = self:GetUIComponent("UILocalizationText", "TitleBg")
  self._title1 = self:GetUIComponent("UILocalizationText", "Title1")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._historyCountLabel = self:GetUIComponent("UILocalizationText", "HistoryCount")
  self._gradeLabel = self:GetUIComponent("UILocalizedTMP", "Grade")
  self._tittleLabel:SetText(self._levelData:GetLevelName())
  self._titleBg:SetText(self._levelData:GetLevelName())
  self._title1:SetText(self._levelData:GetLevelName())
  self._desLabel:SetText(self._levelData:GetDes())
  local historyCount = self._levelData:GetHistoryRecord()
  if historyCount <= 0 then
    self._historyCountLabel:SetText("--")
  else
    self._historyCountLabel:SetText(StringTable.Get("str_activity_n16_test_level_subject_count", historyCount))
  end
  local gradeStr = self._levelData:GetGradeLevelStr()
  self._gradeLabel:SetText(gradeStr)
  self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("uieff_n16_ingame_evaluate.mat", LoadType.Mat)
  self._EMIMat = self._EMIMatResRequest.Obj
  local mat = self._gradeLabel.fontMaterial
  self._gradeLabel.fontMaterial = self._EMIMat
  self._gradeLabel.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
  self._EMIMatResRequest1 = ResourceManager:GetInstance():SyncLoadAsset("uieff_n16_ingame_detial.mat", LoadType.Mat)
  self._EMIMat1 = self._EMIMatResRequest1.Obj
  self._tittleLabel.fontMaterial = self._EMIMat1
  self._tittleLabel.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN16SubjectTestDetailController:OnHide()
  self._EMIMatResRequest = nil
  self._EMIMat = nil
  self._EMIMatResRequest1 = nil
  self._EMIMat1 = nil
end

function UIN16SubjectTestDetailController:BtnStartTestOnClick()
  local grade = self._levelData:GetLeveGrade()
  self:ShowDialog("UIN16AnswerController", grade)
  self:CloseDialog()
end

function UIN16SubjectTestDetailController:MaskOnClick()
  self:CloseDialog()
end
