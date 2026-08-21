_class("UISeasonPlotEnter", UIController)
UISeasonPlotEnter = UISeasonPlotEnter

function UISeasonPlotEnter:OnShow(uiParam)
  local titleId = uiParam[1]
  local titleName = uiParam[2]
  self._story = uiParam[3]
  self._callback = uiParam[4]
  local txtStageIdx = self:GetUIComponent("UILocalizationText", "txtStageIdx")
  local txtStageName = self:GetUIComponent("RollingText", "txtStageName")
  txtStageIdx.text = titleId or ""
  txtStageName:RefreshText(titleName or "")
end

function UISeasonPlotEnter:OnHide()
end

function UISeasonPlotEnter:EnterPlot()
  if not self._story then
    Log.error("### [UISeasonPlotEnter] no story")
    return
  end
  UISeasonHelper.PlayStoryInSeasonScence(self._story, self._callback)
  self:CloseDialog()
end

function UISeasonPlotEnter:ImgBGOnClick(go)
  self:EnterPlot()
end

function UISeasonPlotEnter:BtnEnterOnClick(go)
  self:EnterPlot()
end

function UISeasonPlotEnter:BgOnClick(go)
  self:CloseDialog()
end
