local DungeonSchoolTowerStarPanel, Super = System.NewClass("DungeonSchoolTowerStarPanel", UIBasePanel)
DungeonSchoolTowerStarPanel.uiResCls = UI_Chapter_Popup_YuanxingResource

function DungeonSchoolTowerStarPanel:ctor(stageId, starProgress)
  Super.ctor(self)
  self.stageId = stageId
  self.starProgress = starProgress
end

function DungeonSchoolTowerStarPanel:OnBind(binder)
  local model = binder:createModel(MainCopyModel)
  local stageCfg = model:GetStageCfg(self.stageId)
  binder:BindButtonClick(self.ui.btn_close, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  for index, taskId in ipairs(stageCfg.PerfectCondition or {}) do
    local uiNode = self.ui["Yuanxing" .. index]
    local taskCfg = DT.Task[taskId]
    uiNode:SetActive(nil ~= taskCfg)
    if taskCfg then
      local isGot = index <= self.starProgress
      local rewards = {}
      for itemTid, itemCount in table.iteraDouble(taskCfg.CompleteAward or {}) do
        table.insert(rewards, {
          itemTid = itemTid,
          itemCount = itemCount,
          isGot = isGot
        })
      end
      local uiRes = UI_Chapter_Item_Yuanxing_ListResource(uiNode)
      binder:CheckUpdatePanelResource(uiNode, DataCenter.gameData.CurrTextLanguage)
      uiRes.Image_Icon:SetActive(isGot)
      local grayColorCfg = DT.ColorConfig.Gray
      binder:SetTextColorByHtml(uiRes.Text, isGot and "#ffffff" or grayColorCfg.Dark)
      binder:SetText(uiRes.Text, taskCfg.Desc)
    end
  end
end

return DungeonSchoolTowerStarPanel
