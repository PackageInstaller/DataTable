local StageStarDetailPanel, Super = System.NewClass("StageStarDetailPanel", UIBasePanel)
StageStarDetailPanel.uiResCls = UI_Chapter_Popup_YuanxingResource

function StageStarDetailPanel:ctor(data)
  Super.ctor(self)
  self.data = data
end

function StageStarDetailPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.btn_close, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  local info = self.data
  local stageCfg = DT.Stage[info.stageTid]
  for index, taskId in ipairs(stageCfg.PerfectCondition or {}) do
    local uiNode = self.ui["Yuanxing" .. index]
    local taskCfg = DT.Task[taskId]
    uiNode:SetActive(nil ~= taskCfg)
    if taskCfg then
      local isGot = index <= info.star
      local uiRes = UI_Chapter_Item_Yuanxing_ListResource(uiNode)
      binder:CheckUpdatePanelResource(uiNode, DataCenter.gameData.CurrTextLanguage)
      uiRes.Image_Icon:SetActive(isGot)
      local grayColorCfg = DT.ColorConfig.Gray
      binder:SetTextColorByHtml(uiRes.Text, isGot and "#ffffff" or grayColorCfg.Dark)
      binder:SetText(uiRes.Text, taskCfg.Desc)
    end
  end
  if stageCfg.PerfectCondition == nil then
    Logger.Warn("StageCfg PerfectCondition没配置, StageTid为", info.stageTid)
  end
end

return StageStarDetailPanel
