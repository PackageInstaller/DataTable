local MainCopyAchievePanel, Super = System.NewClass("MainCopyAchievePanel", UIBasePanel)
MainCopyAchievePanel.uiResCls = UI_Chapter_Popup_AchievementResource

function MainCopyAchievePanel:ctor(achieveList, stageId, fromStage)
  Super.ctor(self)
  self.achieveList = achieveList
  self.stageId = stageId
  self.fromStage = fromStage
end

function MainCopyAchievePanel:OnBind(binder)
  local model = binder:createModel(MainCopyModel)
  local stageData = MainCopyDataUtils.GetStageData(self.stageId)
  local commonPopupTipsData = {
    sizeType = CommonDefine.PopupTipsType.S,
    textTitleCN = nil,
    clickFunc = System.fn(self, self.Close)
  }
  binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_S, commonPopupTipsData))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  for i = 1, 3 do
    local id = self.achieveList and self.achieveList[i]
    local uiNode = self.ui["UI_Task_Item_Achievement_List" .. i]
    if id then
      uiNode:SetActive(true)
      local itemData = {
        stageId = self.stageId,
        index = i,
        taskId = id,
        achieveState = model:GetAchieveState(stageData, id),
        fromStage = self.fromStage
      }
      binder:BindComponent(MainCopyAchieveItem(uiNode, itemData))
    else
      uiNode:SetActive(false)
    end
  end
end

function MainCopyAchievePanel:OnTodoFunc()
end

return MainCopyAchievePanel
