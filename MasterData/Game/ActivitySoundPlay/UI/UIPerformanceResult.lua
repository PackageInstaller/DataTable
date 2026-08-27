local base = UIBaseWindow
local UIPerformanceResult = class("UIPerformanceResult", base)

function UIPerformanceResult:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Restart, self, self.OnClickRePlay)
  local topStatusData = UIUtil.CreateNewTopStatusData(self)
  topStatusData:SetTopStatusVisible(false)
  topStatusData:PushTopStatusDataToBackStack(true)
end

function UIPerformanceResult:InitPerformanceResult(resultData)
  self.resultData = resultData
  local name = LanguageUtil.GetLocaleText(resultData.rhythmCfg.rhythm_des)
  self:RefreshMusicName(name)
  local difficulty = resultData.rhythmCfg.difficulty
  self:RefreshDiff(difficulty)
  self:RefreshSkillScore(resultData)
end

function UIPerformanceResult:RefreshMusicName(name)
  self.ui.tex_Name.text = name
end

function UIPerformanceResult:RefreshDiff(difficulty)
  self.ui.tex_Diff:SetIndex(difficulty)
end

function UIPerformanceResult:RefreshSkillScore(resultData)
  self.ui.tex_Score:SetIndex(0, tostring(resultData.totalScore))
  self.ui.tex_Hit:SetIndex(0, tostring(resultData.goodStrickCount), tostring(resultData.totalNoteCount))
  self.ui.tex_Combo:SetIndex(0, tostring(resultData.maxCombo), tostring(resultData.totalNoteCount))
  self:RefreshNewRecord(resultData.isNewRecord)
  self:RefreshFullCombo(resultData.isFullCombo)
end

function UIPerformanceResult:RefreshNewRecord(isNewRecord)
  self.ui.obj_NewRecord:SetActive(isNewRecord)
end

function UIPerformanceResult:RefreshFullCombo(isFullCombo)
  self.ui.obj_FullCombo:SetActive(isFullCombo)
end

function UIPerformanceResult:OnClickBack()
  self:Delete()
  local playWindow = UIManager:GetWindow(UIWindowTypeID.PerformancePlay)
  if playWindow ~= nil then
    playWindow:Delete()
  end
  UIUtil.PopFromBackStackByUiTab(self)
end

function UIPerformanceResult:OnClickRePlay()
  self:Delete()
  local playWindow = UIManager:GetWindow(UIWindowTypeID.PerformancePlay)
  if playWindow ~= nil then
    playWindow:ReStartSoundPlay()
  end
  UIUtil.PopFromBackStackByUiTab(self)
end

function UIPerformanceResult:OnDelete()
end

return UIPerformanceResult
