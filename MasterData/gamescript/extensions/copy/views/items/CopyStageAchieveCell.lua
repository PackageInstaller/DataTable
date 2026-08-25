local CopyStageAchieveCell, Super = NewViewComponent("CopyStageAchieveCell")

function CopyStageAchieveCell:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Chapter_Item_StageAchieveResource(uiNode)
  self.stageData = data
  self.stageCfg = DT.Stage[self.stageData.stageID]
  self.achieveGoList = {}
end

function CopyStageAchieveCell:OnEnterComponent()
  local stageNumber = CopyDataUtils.GetStageNameNumber(self.stageCfg.ID)
  local stageName = LT.Text(self.stageCfg.Name)
  if not CopyDataUtils.CheckStageIsInOpenTime(self.stageData.stageID) then
    stageName = StrUtils.GetConfuseText(self.ui.Text_Overview, stageName)
  end
  local desc = string.format("%s %s", stageNumber, stageName)
  self:SetText(self.ui.Text_Overview, desc)
  local nodeTransform = self.ui.uiNode.transform
  local achieveGoCount = #self.achieveGoList
  local LevelAchieveCount = table.length(self.stageCfg.LevelAchieve)
  if achieveGoCount > LevelAchieveCount then
    for i = LevelAchieveCount + 1, achieveGoCount do
      local achieveLevelGo = self.achieveGoList[i]
      self:SetCanvasGroup(achieveLevelGo, 0)
    end
  end
  local rect = self.ui.UI_Chapter_Item_Success_List:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local heigth = rect.sizeDelta.y
  for idx, taskId in pairs(self.stageCfg.LevelAchieve) do
    local achieveLevelGo = self.achieveGoList[idx]
    if not achieveLevelGo then
      achieveLevelGo = GameObject.Instantiate(self.ui.UI_Chapter_Item_Success_List, self.ui.Content.transform)
      table.insert(self.achieveGoList, achieveLevelGo)
      local posY = (idx - 1) * heigth * -1
      achieveLevelGo.transform.anchoredPosition = CS.UnityEngine.Vector2(0, posY)
    else
      self:SetCanvasGroup(achieveLevelGo, 1)
    end
    self:AddViewComponentOnce(achieveLevelGo, CopyStageAchieveLevelCell, self.stageData, taskId)
  end
end

function CopyStageAchieveCell:OnExitComponent()
  Super.OnExitComponent(self)
end

function CopyStageAchieveCell:RefreshData(stageData)
  self.stageData = stageData
  self.stageCfg = DT.Stage[self.stageData.stageID]
  self:OnEnterComponent()
end

return CopyStageAchieveCell
