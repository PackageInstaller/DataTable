local MainCopySurveyPanel, Super = System.NewClass("MainCopySurveyPanel", UIBasePanel)
MainCopySurveyPanel.uiResCls = UI_Card_Panel_SurveyResource

function MainCopySurveyPanel:ctor(stageId)
  Super.ctor(self)
  self.stageId = stageId
end

function MainCopySurveyPanel:OnBind(binder)
  local model = binder:createModel(MainCopyModel)
  local stageCfg = model:GetStageCfg(self.stageId)
  local stageData = MainCopyDataUtils.GetStageData(self.stageId)
  binder:BindButtonClick(self.ui.Image_Icon, System.fn(self, self.Close))
  local starData = {
    title = LT.Textf("MainLines_ThreeStarCondition", model:GetStarCount(stageData), model:GetCfgStarCount(self.stageId)),
    itemList = {}
  }
  for _, taskId in ipairs(stageCfg.PerfectCondition or {}) do
    local taskCfg = DT.Task[taskId]
    if taskCfg then
      local isGot = 1 == stageData.starInfo[taskId]
      local rewards = {}
      for itemTid, itemCount in table.iteraDouble(taskCfg.CompleteAward or {}) do
        table.insert(rewards, {
          itemTid = itemTid,
          itemCount = itemCount,
          isGot = isGot
        })
      end
      table.insert(starData.itemList, {
        title = taskCfg.Desc,
        isGot = isGot,
        rewards = rewards
      })
    end
  end
  binder:BindUIBehavior(self.ui.UI_Battle_Popup_Condition_1, starData)
  local achieveData = {
    title = LT.Textf("MainLines_AchieveCondition", model:GetAchieveCount(stageData), model:GetCfgAchieveCount(self.stageId)),
    itemList = {}
  }
  for _, taskId in ipairs(stageCfg.LevelAchieve or {}) do
    local taskCfg = DT.Task[taskId]
    if taskCfg then
      local isGot = 1 == stageData.achivement[taskId]
      local rewards = {}
      for itemTid, itemCount in table.iteraDouble(taskCfg.CompleteAward or {}) do
        table.insert(rewards, {
          itemTid = itemTid,
          itemCount = itemCount,
          isGot = isGot
        })
      end
      table.insert(achieveData.itemList, {
        title = taskCfg.Desc,
        isGot = isGot,
        rewards = rewards
      })
    end
  end
  binder:BindUIBehavior(self.ui.UI_Battle_Popup_Condition_2, achieveData)
  local hideAwardNodeList = MainCopyDataUtils.GetHideAwardNodeList(self.stageId)
  if #hideAwardNodeList > 0 then
    self.ui.UI_Battle_Popup_Condition_3:SetActive(true)
    local itemList = {}
    local rewards = {}
    for itemTid, itemCount in pairs(stageCfg.HideRewards or {}) do
      if itemTid and itemCount and itemTid > 0 and itemCount > 0 then
        table.insert(rewards, {
          itemTid = itemTid,
          itemCount = itemCount,
          isGot = 1 == stageData.hiddenAward
        })
      end
    end
    if #rewards > 0 then
      local nodeCfg = hideAwardNodeList[1]
      local effectId = nodeCfg and nodeCfg.Effect and nodeCfg.Effect[1]
      local effectCfg = effectId and DT.Event[effectId] or {}
      table.insert(itemList, {
        title = effectCfg.Desc,
        isGot = 1 == stageData.hiddenAward,
        rewards = rewards
      })
    end
    local hideAwardInfo = {
      title = LT.Textf("MainLines_HideCondition", stageData.hiddenAward, #hideAwardNodeList),
      itemList = itemList
    }
    binder:BindUIBehavior(self.ui.UI_Battle_Popup_Condition_3, hideAwardInfo)
  else
    self.ui.UI_Battle_Popup_Condition_3:SetActive(false)
  end
end

function MainCopySurveyPanel:OnTodoFunc()
end

return MainCopySurveyPanel
