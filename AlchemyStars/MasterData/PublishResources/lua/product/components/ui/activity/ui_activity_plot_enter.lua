_class("UIActivityPlotEnter", UIController)
UIActivityPlotEnter = UIActivityPlotEnter

function UIActivityPlotEnter:OnShow(uiParam)
  local titleId = uiParam[1]
  local titleName = uiParam[2]
  self._story = uiParam[3]
  self._callback = uiParam[4]
  local txtStageIdx = self:GetUIComponent("UILocalizationText", "txtStageIdx")
  local txtStageName = self:GetUIComponent("RollingText", "txtStageName")
  txtStageIdx.text = titleId or ""
  txtStageName:RefreshText(titleName or "")
end

function UIActivityPlotEnter:OnHide()
end

function UIActivityPlotEnter:EnterPlot()
  if not self._story then
    Log.error("### [UIActivityPlotEnter] no story")
    return
  end
  self:ShowDialog("UIStoryController", self._story, self._callback)
  self:CloseDialog()
end

function UIActivityPlotEnter:imgBGOnClick(go)
  self:EnterPlot()
end

function UIActivityPlotEnter:btnEnterOnClick(go)
  self:EnterPlot()
end

function UIActivityPlotEnter:bgOnClick(go)
  self:CloseDialog()
end
